function [light_color, sign_type, sign_size, lane_offset, lane_heading, lane_detected] = perception_fcn(rgb_image)
%#codegen
% Combined perception function for Simulink MATLAB Function block.
%
% YOLO: Uses YOLOv8 models from run12 via coder.extrinsic
%   (trained on thousands of labeled frames, mAP50=0.807/0.987)
% Lane: Keeps existing lane_net CNN + yellow line gate (unchanged)
%
% Input:  rgb_image [480x640x3 uint8] - RGB from frontCSICamera
%
% Outputs:
%   light_color   [int32]  - 0=none, 1=red, 2=yellow, 3=green
%   sign_type     [int32]  - 0=none, 1=stop, 2=yield, 3=roundabout
%   sign_size     [single] - apparent sign area in pixels (w*h)
%   lane_offset   [single] - lateral offset (meters, clamped)
%   lane_heading  [single] - heading error (radians, clamped)
%   lane_detected [int32]  - 1 if yellow lane lines found, 0 otherwise

persistent lane_net
persistent e_lat_mu e_lat_sig e_psi_mu e_psi_sig

if isempty(lane_net)
    lane_net = coder.loadDeepLearningNetwork('lane_net.mat');
    params = coder.load('lane_norm_params.mat');
    e_lat_mu  = single(params.e_lat_mean);
    e_lat_sig = single(params.e_lat_std);
    e_psi_mu  = single(params.e_psi_mean);
    e_psi_sig = single(params.e_psi_std);
end

% ==================== YOLO DETECTION (YOLOv8 via coder.extrinsic) ====================
coder.extrinsic('yolov8_detect_lights');
coder.extrinsic('yolov8_detect_signs');

light_color = int32(0);
sign_type   = int32(0);
sign_size   = single(0);

% --- Traffic lights ---
yolo_color = int32(0);
yolo_lconf = 0.0;
yolo_lbbox = zeros(1, 4);
[yolo_color, yolo_lconf, yolo_lbbox] = yolov8_detect_lights(rgb_image); %#ok<ASGLU>
light_color = yolo_color;

% --- Road signs ---
yolo_type  = int32(0);
yolo_sconf = 0.0;
yolo_sbbox = zeros(1, 4);
[yolo_type, yolo_sconf, yolo_sbbox] = yolov8_detect_signs(rgb_image); %#ok<ASGLU>
sign_type = yolo_type;
if yolo_type > 0
    % sign_size = bounding box area (w * h), same units as original
    sign_size = single(yolo_sbbox(3) * yolo_sbbox(4));
end

% ==================== LANE CNN (unchanged from original) ====================
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

% ==================== YELLOW LINE GATE (unchanged from original) ====================
yellow_count = int32(0);
for row = int32(350):int32(20):int32(470)
    for col = int32(10):int32(10):int32(400)
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
