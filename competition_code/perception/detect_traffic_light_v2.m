function [light_color, confidence, bbox] = detect_traffic_light_v2(image, params)
%DETECT_TRAFFIC_LIGHT_V2 Detect traffic light using YOLOv8 + HSV fallback.
%
%   [light_color, confidence, bbox] = detect_traffic_light_v2(image, params)
%
%   Uses YOLOv8 deep learning model as primary detector (via coder.extrinsic,
%   runs on host MATLAB). Falls back to HSV color segmentation if YOLOv8
%   is unavailable or fails.
%
%   Inputs:
%     image  - H x W x 3 uint8 RGB image (virtual camera outputs RGB)
%     params - struct with detection parameters (from Setup_Params_Enhanced)
%
%   Outputs:
%     light_color - int32: 0=none, 1=red, 2=yellow, 3=green
%     confidence  - 0-1 confidence score
%     bbox        - [x, y, w, h] bounding box of detected light (0s if none)
%
%   Compatible with Simulink MATLAB Function blocks.

    light_color = int32(0);
    confidence  = 0.0;
    bbox = zeros(1, 4);

    if isempty(image)
        return;
    end

    % Try YOLOv8 first (runs on host MATLAB via coder.extrinsic)
    yolo_color = int32(0);
    yolo_conf  = 0.0;
    yolo_bbox  = zeros(1, 4);
    yolo_ok = false;

    coder.extrinsic('yolov8_detect_lights');
    try
        [yolo_color, yolo_conf, yolo_bbox] = yolov8_detect_lights(image);
        if yolo_color > 0
            yolo_ok = true;
        end
    catch
        yolo_ok = false;
    end

    if yolo_ok
        light_color = yolo_color;
        confidence  = yolo_conf;
        bbox        = yolo_bbox;
        return;
    end

    % === HSV FALLBACK ===
    [img_h, img_w, ~] = size(image);

    roi = params.TL_ROI;
    y1 = max(1, roi(1)); y2 = min(img_h, roi(2));
    x1 = max(1, roi(3)); x2 = min(img_w, roi(4));
    roi_img = image(y1:y2, x1:x2, :);

    % Input is already RGB
    hsv_img = rgb2hsv(roi_img);

    H = hsv_img(:,:,1) * 180;
    S = hsv_img(:,:,2) * 255;
    V = hsv_img(:,:,3) * 255;

    % RED
    red_mask = ((H >= params.TL_RED_H_LOW1) & (H <= params.TL_RED_H_HIGH1) | ...
                (H >= params.TL_RED_H_LOW2) & (H <= params.TL_RED_H_HIGH2)) & ...
               (S >= params.TL_RED_S_LOW) & (S <= params.TL_RED_S_HIGH) & ...
               (V >= params.TL_RED_V_LOW) & (V <= params.TL_RED_V_HIGH);

    % YELLOW
    yel_mask = (H >= params.TL_YEL_H_LOW) & (H <= params.TL_YEL_H_HIGH) & ...
               (S >= params.TL_YEL_S_LOW) & (S <= params.TL_YEL_S_HIGH) & ...
               (V >= params.TL_YEL_V_LOW) & (V <= params.TL_YEL_V_HIGH);

    % GREEN
    grn_mask = (H >= params.TL_GRN_H_LOW) & (H <= params.TL_GRN_H_HIGH) & ...
               (S >= params.TL_GRN_S_LOW) & (S <= params.TL_GRN_S_HIGH) & ...
               (V >= params.TL_GRN_V_LOW) & (V <= params.TL_GRN_V_HIGH);

    se = strel('disk', 2);
    red_mask = imopen(red_mask, se);
    yel_mask = imopen(yel_mask, se);
    grn_mask = imopen(grn_mask, se);

    [~, red_conf, red_bbox] = analyze_blob(red_mask, params.TL_MIN_AREA, params.TL_MAX_AREA);
    [~, yel_conf, yel_bbox] = analyze_blob(yel_mask, params.TL_MIN_AREA, params.TL_MAX_AREA);
    [~, grn_conf, grn_bbox] = analyze_blob(grn_mask, params.TL_MIN_AREA, params.TL_MAX_AREA);

    colors = [red_conf, yel_conf, grn_conf];
    bboxes = [red_bbox; yel_bbox; grn_bbox];
    [max_conf, max_idx] = max(colors);

    if max_conf > 0.25
        light_color = int32(max_idx);
        confidence  = max_conf;
        bbox = bboxes(max_idx, :);
        bbox(1) = bbox(1) + x1 - 1;
        bbox(2) = bbox(2) + y1 - 1;
    end
end

function [area, conf, bbox] = analyze_blob(mask, min_area, max_area)
    area = 0; conf = 0.0; bbox = zeros(1, 4);
    stats = regionprops(mask, 'Area', 'BoundingBox', 'Circularity');
    if isempty(stats), return; end
    valid = ([stats.Area] >= min_area) & ([stats.Area] <= max_area);
    stats = stats(valid);
    if isempty(stats), return; end
    [~, idx] = max([stats.Area]);
    best = stats(idx);
    area = best.Area; bbox = best.BoundingBox;
    circ = 0.5;
    if isfield(best, 'Circularity') && ~isnan(best.Circularity), circ = best.Circularity; end
    conf = 0.6 * min(1, area/max_area) + 0.4 * min(1, circ);
end
