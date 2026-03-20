function [light_color, confidence, bbox] = detect_traffic_light(image, params)
%DETECT_TRAFFIC_LIGHT Detect traffic light color from a camera image.
%
%   [light_color, confidence, bbox] = detect_traffic_light(image, params)
%
%   Detects and classifies traffic light state from a front-facing camera
%   image using HSV color segmentation and morphological analysis.
%
%   Inputs:
%     image  - H x W x 3 uint8 BGR image from QCar2 CSI front camera
%     params - struct with detection parameters (from Setup_Params_Enhanced)
%              Required fields: TL_ROI, TL_*_H_LOW/HIGH, TL_*_S_LOW/HIGH,
%              TL_*_V_LOW/HIGH, TL_MIN_AREA, TL_MAX_AREA
%
%   Outputs:
%     light_color - 0: none detected, 1: red, 2: yellow, 3: green
%     confidence  - 0-1 confidence score
%     bbox        - [x, y, w, h] bounding box of detected light (0s if none)
%
%   Compatible with Simulink MATLAB Function blocks (code generation).

    light_color = int32(0);
    confidence  = 0.0;
    bbox = zeros(1, 4);

    if isempty(image)
        return;
    end

    [img_h, img_w, ~] = size(image);

    % Extract ROI
    roi = params.TL_ROI;
    y1 = max(1, roi(1)); y2 = min(img_h, roi(2));
    x1 = max(1, roi(3)); x2 = min(img_w, roi(4));
    roi_img = image(y1:y2, x1:x2, :);

    % Convert BGR to RGB then to HSV
    rgb_img = roi_img(:,:,[3,2,1]);  % BGR -> RGB
    hsv_img = rgb2hsv(rgb_img);

    % Scale HSV to OpenCV-compatible ranges (H:0-180, S:0-255, V:0-255)
    H = hsv_img(:,:,1) * 180;
    S = hsv_img(:,:,2) * 255;
    V = hsv_img(:,:,3) * 255;

    % Detect RED (two hue ranges since red wraps around 0/180)
    red_mask1 = (H >= params.TL_RED_H_LOW1) & (H <= params.TL_RED_H_HIGH1) & ...
                (S >= params.TL_RED_S_LOW) & (S <= params.TL_RED_S_HIGH) & ...
                (V >= params.TL_RED_V_LOW) & (V <= params.TL_RED_V_HIGH);
    red_mask2 = (H >= params.TL_RED_H_LOW2) & (H <= params.TL_RED_H_HIGH2) & ...
                (S >= params.TL_RED_S_LOW) & (S <= params.TL_RED_S_HIGH) & ...
                (V >= params.TL_RED_V_LOW) & (V <= params.TL_RED_V_HIGH);
    red_mask = red_mask1 | red_mask2;

    % Detect YELLOW
    yel_mask = (H >= params.TL_YEL_H_LOW) & (H <= params.TL_YEL_H_HIGH) & ...
               (S >= params.TL_YEL_S_LOW) & (S <= params.TL_YEL_S_HIGH) & ...
               (V >= params.TL_YEL_V_LOW) & (V <= params.TL_YEL_V_HIGH);

    % Detect GREEN
    grn_mask = (H >= params.TL_GRN_H_LOW) & (H <= params.TL_GRN_H_HIGH) & ...
               (S >= params.TL_GRN_S_LOW) & (S <= params.TL_GRN_S_HIGH) & ...
               (V >= params.TL_GRN_V_LOW) & (V <= params.TL_GRN_V_HIGH);

    % Morphological cleanup
    se = strel('disk', 3);
    red_mask = imopen(red_mask, se);
    yel_mask = imopen(yel_mask, se);
    grn_mask = imopen(grn_mask, se);

    % Analyze each color mask
    [red_area, red_conf, red_bbox] = analyze_color_blob(red_mask, params.TL_MIN_AREA, params.TL_MAX_AREA);
    [yel_area, yel_conf, yel_bbox] = analyze_color_blob(yel_mask, params.TL_MIN_AREA, params.TL_MAX_AREA);
    [grn_area, grn_conf, grn_bbox] = analyze_color_blob(grn_mask, params.TL_MIN_AREA, params.TL_MAX_AREA);

    % Choose the color with highest confidence
    colors = [red_conf, yel_conf, grn_conf];
    areas  = [red_area, yel_area, grn_area];
    bboxes = [red_bbox; yel_bbox; grn_bbox];

    [max_conf, max_idx] = max(colors);

    if max_conf > 0.3
        light_color = int32(max_idx);  % 1=red, 2=yellow, 3=green
        confidence  = max_conf;
        % Adjust bbox back to full image coordinates
        bbox = bboxes(max_idx, :);
        bbox(1) = bbox(1) + x1 - 1;
        bbox(2) = bbox(2) + y1 - 1;
    end
end


function [area, conf, bbox] = analyze_color_blob(mask, min_area, max_area)
%ANALYZE_COLOR_BLOB Find the largest valid blob in a binary mask.
    area = 0;
    conf = 0.0;
    bbox = zeros(1, 4);

    stats = regionprops(mask, 'Area', 'BoundingBox', 'Circularity');

    if isempty(stats)
        return;
    end

    % Filter by area
    valid = ([stats.Area] >= min_area) & ([stats.Area] <= max_area);
    stats = stats(valid);

    if isempty(stats)
        return;
    end

    % Find largest blob
    [max_area_val, idx] = max([stats.Area]);
    best = stats(idx);

    area = best.Area;
    bbox = best.BoundingBox;

    % Confidence based on area and circularity
    % Traffic lights are roughly circular
    circularity = 0.5; % default
    if isfield(best, 'Circularity') && ~isnan(best.Circularity)
        circularity = best.Circularity;
    end

    % Normalize confidence: larger area + more circular = higher confidence
    area_score = min(1.0, area / max_area);
    circ_score = min(1.0, circularity);
    conf = 0.6 * area_score + 0.4 * circ_score;
end
