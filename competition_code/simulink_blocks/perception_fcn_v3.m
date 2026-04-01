function [light_color, sign_type, sign_size, lane_offset, lane_heading, lane_detected] = perception_fcn(rgb_image)
%#codegen
% Combined perception for Simulink. Fully codegen-compatible.
%
% YOLO: YOLOv8 dlnetwork models (run12, well-trained)
%       Alternates between lights and signs each frame to halve latency.
% Lane: existing lane_net CNN + yellow line gate (unchanged)

persistent yolo_lights_net yolo_signs_net
persistent lane_net e_lat_mu e_lat_sig e_psi_mu e_psi_sig
persistent frame_count
persistent last_light last_sign last_sign_size

if isempty(yolo_lights_net)
    yolo_lights_net = coder.loadDeepLearningNetwork('yolo_lights_dlnet.mat');
end
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
    last_light = int32(0);
    last_sign = int32(0);
    last_sign_size = single(0);
end

frame_count = frame_count + int32(1);

% ==================== YOLOv8 DETECTION (alternating) ====================
CONF_THRESH = single(0.30);

% Preprocess once (shared by whichever model runs)
img_yolo = single(imresize(rgb_image, [640, 640])) / single(255.0);
dl_in = dlarray(img_yolo, 'SSCB');

% Alternate: even frames = lights, odd frames = signs
if mod(frame_count, int32(2)) == int32(0)
    % --- Traffic lights ---
    dl_out = predict(yolo_lights_net, dl_in);
    raw = extractdata(dl_out);
    raw = squeeze(raw);
    if size(raw, 1) > size(raw, 2)
        raw = raw';
    end

    % Track max confidence PER CLASS across all predictions
    % cls 1=red, 2=yellow, 3=green
    max_red   = single(0);
    max_yel   = single(0);
    max_green = single(0);
    n_preds = int32(size(raw, 2));
    for i = 1:n_preds
        c1 = raw(5, i);  % red score
        c2 = raw(6, i);  % yellow score
        c3 = raw(7, i);  % green score
        if c1 > max_red;   max_red   = c1; end
        if c2 > max_yel;   max_yel   = c2; end
        if c3 > max_green; max_green = c3; end
    end

    % Priority logic: active (ON) light is bright, scores much higher
    % than dim OFF housings. Compare per-class max scores.
    LIGHT_CONF = single(0.3);
    best_cls = int32(0);

    % Find the dominant class (highest max score)
    dominant_conf = max_red;
    dominant_cls = int32(1);
    if max_yel > dominant_conf
        dominant_conf = max_yel;
        dominant_cls = int32(2);
    end
    if max_green > dominant_conf
        dominant_conf = max_green;
        dominant_cls = int32(3);
    end

    % Asymmetric margin logic:
    %   Red:    NO margin required — always report if dominant (missing red = disaster)
    %   Yellow: NO margin required — always report if dominant
    %   Green:  strict margin — must clearly beat red (false green = running red)
    if dominant_conf > LIGHT_CONF
        if dominant_cls == int32(1)
            % Red is dominant: always report (cost of false red = brief wait)
            best_cls = int32(1);
        elseif dominant_cls == int32(2)
            % Yellow is dominant: always report
            best_cls = int32(2);
        elseif dominant_cls == int32(3)
            % Green: strict margin (cost of false green = running red)
            if max_green > max_red + single(0.1)
                best_cls = int32(3);
            end
        end
    end
    last_light = best_cls;

    % Keep previous sign result
    light_color = last_light;
    sign_type   = last_sign;
    sign_size   = last_sign_size;
else
    % --- Road signs ---
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

    % Keep previous light result
    light_color = last_light;
    sign_type   = last_sign;
    sign_size   = last_sign_size;
end

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
