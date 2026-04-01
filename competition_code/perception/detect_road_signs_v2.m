function [sign_type, confidence, distance_est, bbox] = detect_road_signs_v2(image, params)
%DETECT_ROAD_SIGNS_V2 Detect road signs using YOLOv8 + HSV fallback.
%
%   [sign_type, confidence, distance_est, bbox] = detect_road_signs_v2(image, params)
%
%   Uses YOLOv8 deep learning model as primary detector (via coder.extrinsic,
%   runs on host MATLAB). Falls back to HSV color segmentation if YOLOv8
%   is unavailable or fails.
%
%   Inputs:
%     image  - H x W x 3 uint8 RGB image (virtual camera outputs RGB)
%     params - struct with detection parameters
%
%   Outputs:
%     sign_type    - int32: 0=none, 1=stop, 2=yield, 3=roundabout
%     confidence   - 0-1 confidence score
%     distance_est - estimated distance in meters
%     bbox         - [x, y, w, h] bounding box (zeros if none)
%
%   Compatible with Simulink MATLAB Function blocks.

    sign_type = int32(0);
    confidence = 0.0;
    distance_est = inf;
    bbox = zeros(1, 4);

    if isempty(image)
        return;
    end

    % Try YOLOv8 first (runs on host MATLAB via coder.extrinsic)
    yolo_type = int32(0);
    yolo_conf = 0.0;
    yolo_bbox = zeros(1, 4);
    yolo_ok = false;

    coder.extrinsic('yolov8_detect_signs');
    try
        [yolo_type, yolo_conf, yolo_bbox] = yolov8_detect_signs(image);
        if yolo_type > 0
            yolo_ok = true;
        end
    catch
        yolo_ok = false;
    end

    if yolo_ok
        sign_type = yolo_type;
        confidence = yolo_conf;
        bbox = yolo_bbox;
        apparent_size = sqrt(yolo_bbox(3) * yolo_bbox(4));
        distance_est = 0.3 * 50 / max(apparent_size, 1);
        return;
    end

    % === HSV FALLBACK ===
    [img_h, img_w, ~] = size(image);

    % Input is already RGB
    hsv_img = rgb2hsv(image);
    H = hsv_img(:,:,1) * 180;
    S = hsv_img(:,:,2) * 255;
    V = hsv_img(:,:,3) * 255;

    % Red detection (stop + yield)
    red_mask = ((H >= params.SS_RED_H_LOW1) & (H <= params.SS_RED_H_HIGH1) | ...
                (H >= params.SS_RED_H_LOW2) & (H <= params.SS_RED_H_HIGH2)) & ...
               (S >= params.SS_RED_S_LOW) & (S <= params.SS_RED_S_HIGH) & ...
               (V >= params.SS_RED_V_LOW) & (V <= params.SS_RED_V_HIGH);

    % Yellow detection (roundabout)
    yel_mask = (H >= params.RS_YEL_H_LOW) & (H <= params.RS_YEL_H_HIGH) & ...
               (S >= params.RS_YEL_S_LOW) & (S <= params.RS_YEL_S_HIGH) & ...
               (V >= params.RS_YEL_V_LOW) & (V <= params.RS_YEL_V_HIGH);

    se = strel('disk', 2);
    red_clean = imopen(imclose(red_mask, se), se);
    yel_clean = imopen(imclose(yel_mask, se), se);

    % Analyze red blobs
    best_stop = 0; best_stop_bb = zeros(1,4); best_stop_a = 0;
    best_yield = 0; best_yield_bb = zeros(1,4); best_yield_a = 0;
    stats_r = regionprops(red_clean, 'Area', 'BoundingBox', 'Solidity');
    for i = 1:length(stats_r)
        s = stats_r(i);
        if s.Area < params.SS_MIN_AREA || s.Area > 8000, continue; end
        bb = s.BoundingBox;
        aspect = bb(3)/max(bb(4),1);
        area_sc = min(1, s.Area/2000);
        % Stop: octagon
        stop_sc = 0.3*max(0,1-abs(s.Solidity-0.83)*2) + 0.3*max(0,1-abs(aspect-1)) + 0.4*area_sc;
        % Yield: triangle with white center
        cy=round(bb(2)+bb(4)/2); cx=round(bb(1)+bb(3)/2);
        cr=max(1,round(bb(4)/4)); cc=max(1,round(bb(3)/4));
        cS = S(max(1,cy-cr):min(img_h,cy+cr), max(1,cx-cc):min(img_w,cx+cc));
        cV = V(max(1,cy-cr):min(img_h,cy+cr), max(1,cx-cc):min(img_w,cx+cc));
        wc = mean(cS(:))<60 && mean(cV(:))>150;
        ws = 0; if wc, ws=0.5; end
        yield_sc = 0.2*max(0,1-abs(s.Solidity-0.5)*2) + 0.2*max(0,1-abs(aspect-1.2)) + 0.3*ws + 0.3*area_sc;
        if stop_sc > best_stop && ~wc, best_stop=stop_sc; best_stop_bb=bb; best_stop_a=s.Area; end
        if yield_sc > best_yield && wc, best_yield=yield_sc; best_yield_bb=bb; best_yield_a=s.Area; end
    end

    % Analyze yellow blobs (roundabout)
    best_round = 0; best_round_bb = zeros(1,4); best_round_a = 0;
    stats_y = regionprops(yel_clean, 'Area', 'BoundingBox', 'Solidity', 'Eccentricity');
    for i = 1:length(stats_y)
        s = stats_y(i);
        if s.Area < 80 || s.Area > 8000, continue; end
        bb = s.BoundingBox;
        aspect = bb(3)/max(bb(4),1);
        if aspect<0.6 || aspect>1.6, continue; end
        if s.Solidity<0.4, continue; end
        if isfield(s,'Eccentricity') && s.Eccentricity>0.85, continue; end
        round_sc = 0.3*max(0,1-abs(aspect-1)*2) + 0.3*max(0,s.Solidity-0.4) + 0.4*min(1,s.Area/1500);
        if round_sc > best_round, best_round=round_sc; best_round_bb=bb; best_round_a=s.Area; end
    end

    confs = [best_stop, best_yield, best_round];
    [mc, mi] = max(confs);
    if mc > 0.25
        sign_type = int32(mi);
        confidence = mc;
        areas = [best_stop_a, best_yield_a, best_round_a];
        bbs = [best_stop_bb; best_yield_bb; best_round_bb];
        bbox = bbs(mi,:);
        distance_est = 0.3 * 50 / max(sqrt(areas(mi)), 1);
    end
end
