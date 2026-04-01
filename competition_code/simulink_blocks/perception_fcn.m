function [light_color, sign_type, sign_size, lane_offset, lane_heading, lane_detected] = ...
    perception_fcn(rgb_image)
%#codegen
% Combined perception function for Simulink.
% Uses YOLOv8 for traffic lights and road signs via coder.extrinsic.
% Uses HSV for lane detection (fast, codegen-compatible).
%
% Input:  rgb_image [480x640x3 uint8] - RGB from frontCSICamera
%
% Outputs:
%   light_color   [int32]  - 0=none, 1=red, 2=yellow, 3=green
%   sign_type     [int32]  - 0=none, 1=stop, 2=yield, 3=roundabout
%   sign_size     [double] - apparent sign size in pixels (for distance est)
%   lane_offset   [double] - lateral offset from lane center (pixels)
%   lane_heading  [double] - heading error relative to lane (radians)
%   lane_detected [logical]- true if lane lines found

    % Initialize outputs
    light_color   = int32(0);
    sign_type     = int32(0);
    sign_size     = 0.0;
    lane_offset   = 0.0;
    lane_heading  = 0.0;
    lane_detected = false;

    if isempty(rgb_image)
        return;
    end

    % === TRAFFIC LIGHT DETECTION (YOLOv8) ===
    coder.extrinsic('yolov8_detect_lights');
    yolo_color = int32(0);
    yolo_conf  = 0.0;
    yolo_bbox  = zeros(1, 4);
    try
        [yolo_color, yolo_conf, yolo_bbox] = yolov8_detect_lights(rgb_image); %#ok<ASGLU>
    catch
        yolo_color = int32(0);
    end
    light_color = yolo_color;

    % === ROAD SIGN DETECTION (YOLOv8) ===
    coder.extrinsic('yolov8_detect_signs');
    yolo_type = int32(0);
    yolo_sconf = 0.0;
    yolo_sbbox = zeros(1, 4);
    try
        [yolo_type, yolo_sconf, yolo_sbbox] = yolov8_detect_signs(rgb_image); %#ok<ASGLU>
    catch
        yolo_type = int32(0);
    end
    sign_type = yolo_type;
    if yolo_type > 0
        sign_size = sqrt(max(yolo_sbbox(3) * yolo_sbbox(4), 1));
    end

    % === LANE DETECTION (HSV - fast, codegen-compatible) ===
    [img_h, img_w, ~] = size(rgb_image);

    % ROI: lower portion of image
    roi_y1 = max(1, round(img_h * 0.73));  % ~350 for 480
    roi_y2 = img_h;
    roi_x1 = max(1, round(img_w * 0.08));  % ~50 for 640
    roi_x2 = min(img_w, round(img_w * 0.92)); % ~590 for 640
    roi = rgb_image(roi_y1:roi_y2, roi_x1:roi_x2, :);

    hsv_roi = rgb2hsv(roi);
    H = hsv_roi(:,:,1) * 180;
    S = hsv_roi(:,:,2) * 255;
    V = hsv_roi(:,:,3) * 255;

    % Yellow lane lines
    yel_mask = (H >= 15) & (H <= 40) & (S >= 80) & (V >= 100);
    % White lane lines
    wht_mask = (S <= 50) & (V >= 200);
    lane_mask = yel_mask | wht_mask;

    % Column projection
    col_sum = sum(lane_mask, 1);
    roi_w = size(lane_mask, 2);
    center = roi_w / 2;

    % Find left and right lane edges
    left_lane = 0;
    right_lane = roi_w;
    threshold = size(lane_mask, 1) * 0.1;  % 10% of ROI height

    for c = round(center):-1:1
        if col_sum(c) > threshold
            left_lane = c;
            break;
        end
    end
    for c = round(center):roi_w
        if col_sum(c) > threshold
            right_lane = c;
            break;
        end
    end

    if left_lane > 0 || right_lane < roi_w
        lane_center = (left_lane + right_lane) / 2;
        lane_offset = lane_center - center;
        lane_detected = true;

        % Estimate heading from top/bottom halves
        half_h = round(size(lane_mask, 1) / 2);
        top_sum = sum(lane_mask(1:half_h, :), 1);
        bot_sum = sum(lane_mask(half_h+1:end, :), 1);
        [~, top_peak] = max(top_sum);
        [~, bot_peak] = max(bot_sum);
        lane_heading = atan2(double(top_peak - bot_peak), double(half_h)) * 0.5;
    end
end
