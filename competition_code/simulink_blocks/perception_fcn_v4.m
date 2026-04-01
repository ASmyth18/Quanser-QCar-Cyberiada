function [light_color, sign_type, sign_size, lane_offset, lane_heading, lane_detected] = perception_fcn(rgb_image)
%#codegen
% Combined perception for Simulink. Fully codegen-compatible.
%
% Traffic lights: RGB color thresholding (runs EVERY frame at 30fps)
%   - Fast (<1ms), reliable, no neural network needed
%   - Scans upper portion of image for red/yellow/green circles
%   - Much more responsive than YOLO at 15fps
%
% Signs: YOLOv8 dlnetwork (runs every 3rd frame)
% Lane:  existing lane_net CNN + yellow line gate (every frame)

persistent yolo_signs_net
persistent lane_net e_lat_mu e_lat_sig e_psi_mu e_psi_sig
persistent frame_count
persistent last_sign last_sign_size

if isempty(yolo_signs_net)
    yolo_signs_net = coder.loadDeepLearningNetwork('yolo_signs_dlnet.mat');
end
if isempty(lane_net)
    lane_net = coder.loadDeepLearningNetwork('lane_net.mat');
    params = coder.load('lane_norm_params.mat');
    e_lat_mu  = single(params.e_lat_mean);
    e_lat_sig = single(params.e_lat_std);
    e_psi_mu  = single(params.e_psi_mean);
    e_psi_sig = single(params.e_psi_std);
end
if isempty(frame_count)
    frame_count = int32(0);
    last_sign = int32(0);
    last_sign_size = single(0);
end

frame_count = frame_count + int32(1);

% ==================== TRAFFIC LIGHT: RGB THRESHOLDING ====================
% Scan the upper portion of the image (rows 1-240) where traffic lights
% appear. Count pixels matching red, yellow, and green thresholds.
% The color with the most matching pixels above a minimum threshold wins.
%
% This runs EVERY frame (30fps) — no alternating needed since it's fast.

red_count   = int32(0);
yel_count   = int32(0);
green_count = int32(0);

% Scan upper region where traffic lights appear
% Extended to row 280 to catch lights when closer to intersection
% Subsample for speed: every 4th row, every 4th column
for row = int32(20):int32(4):int32(280)
    for col = int32(60):int32(4):int32(580)
        r = single(rgb_image(row, col, 1));
        g = single(rgb_image(row, col, 2));
        b = single(rgb_image(row, col, 3));

        % Use RELATIVE color comparisons (robust to brightness variation)
        % RED light: R is dominant, clearly above G and B
        if r > single(150) && r > g + single(50) && r > b + single(50)
            red_count = red_count + int32(1);
        end

        % GREEN light: G is dominant channel
        % Broadened: simulator green can be cyan-ish (G high, B moderate)
        if g > single(100) && g > r + single(20) && g > b - single(30)
            green_count = green_count + int32(1);
        end

        % YELLOW light: R and G both high, B is low
        if r > single(150) && g > single(120) && b < single(100) && r > b + single(60)
            yel_count = yel_count + int32(1);
        end
    end
end

% Minimum pixel count to consider a detection valid
MIN_PIXELS = int32(3);

% Determine light color: pick the one with most pixels above threshold
light_color = int32(0);  % 0=none, 1=red, 2=yellow, 3=green
best_count = MIN_PIXELS;

if red_count > best_count
    best_count = red_count;
    light_color = int32(1);
end
if green_count > best_count
    best_count = green_count;
    light_color = int32(3);
end
if yel_count > best_count
    light_color = int32(2);
end

% Safety: if red has ANY significant pixels and green also detected,
% report red (conservative — never miss a red)
if red_count >= MIN_PIXELS && green_count >= MIN_PIXELS
    if red_count > green_count
        light_color = int32(1);
    end
end

% ==================== ROAD SIGNS: YOLOv8 (every 3rd frame) ====================
% YOLO is heavy, so run it less frequently. Signs don't change as fast
% as traffic lights, so 10fps is plenty.

if mod(frame_count, int32(3)) == int32(0)
    img_yolo = single(imresize(rgb_image, [640, 640])) / single(255.0);
    dl_in = dlarray(img_yolo, 'SSCB');

    dl_out = predict(yolo_signs_net, dl_in);
    raw = extractdata(dl_out);
    raw = squeeze(raw);
    if size(raw, 1) > size(raw, 2)
        raw = raw';
    end

    best_conf = single(0);
    best_cls = int32(0);
    best_w = single(0);
    best_h = single(0);
    CONF_THRESH = single(0.30);
    SCALE_X = single(640.0 / 640.0);
    SCALE_Y = single(480.0 / 640.0);

    n_preds = int32(size(raw, 2));
    for i = 1:n_preds
        c1 = raw(5, i);
        c2 = raw(6, i);
        c3 = raw(7, i);
        mc = c1; bc = int32(1);
        if c2 > mc; mc = c2; bc = int32(2); end
        if c3 > mc; mc = c3; bc = int32(3); end
        if mc > CONF_THRESH && mc > best_conf
            best_conf = mc;
            best_cls = bc;
            best_w = raw(3, i) * SCALE_X;
            best_h = raw(4, i) * SCALE_Y;
        end
    end
    last_sign = best_cls;
    if best_cls > int32(0)
        last_sign_size = best_w * best_h;
    else
        last_sign_size = single(0);
    end
end

sign_type = last_sign;
sign_size = last_sign_size;

% ==================== LANE CNN (unchanged) ====================
cropped = single(rgb_image(241:480, :, :));
lane_input = (cropped(1:2:240, 1:2:640, :) + cropped(2:2:240, 2:2:640, :) + ...
              cropped(1:2:240, 2:2:640, :) + cropped(2:2:240, 1:2:640, :)) / single(4.0);

lane_pred = predict(lane_net, lane_input);

lane_offset  = single(lane_pred(1)) * e_lat_sig + e_lat_mu;
lane_heading = single(lane_pred(2)) * e_psi_sig + e_psi_mu;

MAX_E_LAT = single(0.3);
MAX_E_PSI = single(0.8);
if lane_offset > MAX_E_LAT
    lane_offset = MAX_E_LAT;
elseif lane_offset < -MAX_E_LAT
    lane_offset = -MAX_E_LAT;
end
if lane_heading > MAX_E_PSI
    lane_heading = MAX_E_PSI;
elseif lane_heading < -MAX_E_PSI
    lane_heading = -MAX_E_PSI;
end

% ==================== YELLOW LINE GATE (unchanged) ====================
yellow_count = int32(0);
for row = int32(350):int32(20):int32(470)
    for col = int32(10):int32(10):int32(630)
        r = single(rgb_image(row, col, 1));
        g = single(rgb_image(row, col, 2));
        b = single(rgb_image(row, col, 3));
        if r > single(180) && g > single(180) && b < single(210) && (r - b) > single(30)
            yellow_count = yellow_count + int32(1);
        end
    end
end

MIN_YELLOW = int32(5);
if yellow_count >= MIN_YELLOW
    lane_detected = int32(1);
else
    lane_detected = int32(0);
end

end
