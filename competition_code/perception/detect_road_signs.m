function [sign_type, confidence, distance_est, bbox] = detect_road_signs(image, params)
%DETECT_ROAD_SIGNS Detect stop, yield, and roundabout signs.
%
%   [sign_type, confidence, distance_est, bbox] = detect_road_signs(image, params)
%
%   Combines detection of all three road sign types using HSV color
%   segmentation and shape analysis. Returns the highest-confidence
%   detection.
%
%   Inputs:
%     image  - H x W x 3 uint8 BGR image from QCar2 CSI front camera
%     params - struct with detection parameters
%
%   Outputs:
%     sign_type    - int32: 0=none, 1=stop, 2=yield, 3=roundabout
%     confidence   - 0-1 confidence score
%     distance_est - estimated distance in meters
%     bbox         - [x, y, w, h] bounding box (zeros if none)
%
%   Compatible with Simulink MATLAB Function blocks (code generation).

    sign_type = int32(0);
    confidence = 0.0;
    distance_est = inf;
    bbox = zeros(1, 4);

    if isempty(image)
        return;
    end

    [img_h, img_w, ~] = size(image);

    % Convert BGR to RGB then HSV
    rgb_img = image(:,:,[3,2,1]);
    hsv_img = rgb2hsv(rgb_img);

    H = hsv_img(:,:,1) * 180;  % 0-180 (OpenCV convention)
    S = hsv_img(:,:,2) * 255;  % 0-255
    V = hsv_img(:,:,3) * 255;  % 0-255

    % ===== 1. STOP SIGN: Red octagon =====
    % Red hue wraps around 0/180
    stop_mask1 = (H >= params.SS_RED_H_LOW1) & (H <= params.SS_RED_H_HIGH1) & ...
                 (S >= params.SS_RED_S_LOW)  & (S <= params.SS_RED_S_HIGH) & ...
                 (V >= params.SS_RED_V_LOW)  & (V <= params.SS_RED_V_HIGH);
    stop_mask2 = (H >= params.SS_RED_H_LOW2) & (H <= params.SS_RED_H_HIGH2) & ...
                 (S >= params.SS_RED_S_LOW)  & (S <= params.SS_RED_S_HIGH) & ...
                 (V >= params.SS_RED_V_LOW)  & (V <= params.SS_RED_V_HIGH);
    stop_mask = stop_mask1 | stop_mask2;

    % ===== 2. YIELD SIGN: Red border, white center, inverted triangle =====
    % Same red hue range but different shape
    yield_mask = stop_mask;  % Same red detection, distinguish by shape later

    % ===== 3. ROUNDABOUT SIGN: Yellow diamond =====
    round_mask = (H >= params.RS_YEL_H_LOW) & (H <= params.RS_YEL_H_HIGH) & ...
                 (S >= params.RS_YEL_S_LOW) & (S <= params.RS_YEL_S_HIGH) & ...
                 (V >= params.RS_YEL_V_LOW) & (V <= params.RS_YEL_V_HIGH);

    % Morphological cleanup
    se = strel('disk', 2);
    red_clean = imclose(stop_mask, se);
    red_clean = imopen(red_clean, se);
    yel_clean = imclose(round_mask, se);
    yel_clean = imopen(yel_clean, se);

    % ===== Analyze RED blobs (stop sign vs yield sign) =====
    best_stop_conf = 0; best_stop_bbox = zeros(1,4); best_stop_area = 0;
    best_yield_conf = 0; best_yield_bbox = zeros(1,4); best_yield_area = 0;

    stats_red = regionprops(red_clean, 'Area', 'BoundingBox', 'Solidity', 'Extent');

    for i = 1:length(stats_red)
        s = stats_red(i);
        if s.Area < params.SS_MIN_AREA || s.Area > 8000
            continue;
        end

        bb = s.BoundingBox;
        aspect = bb(3) / max(bb(4), 1);

        % Check if the center of this blob has white pixels (yield sign indicator)
        % Yield signs have red border + white center
        cy = round(bb(2) + bb(4)/2);
        cx = round(bb(1) + bb(3)/2);
        % Sample center region
        cr = max(1, round(bb(4)/4));
        cc = max(1, round(bb(3)/4));
        cy1 = max(1, cy - cr); cy2 = min(img_h, cy + cr);
        cx1 = max(1, cx - cc); cx2 = min(img_w, cx + cc);
        center_S = S(cy1:cy2, cx1:cx2);
        center_V = V(cy1:cy2, cx1:cx2);
        white_center = mean(center_S(:)) < 60 && mean(center_V(:)) > 150;

        % STOP SIGN scoring: octagonal (solidity ~0.83), roughly square
        solidity_score = 1 - abs(s.Solidity - 0.83) * 2;
        solidity_score = max(0, solidity_score);
        aspect_score = 1 - abs(aspect - 1.0);
        aspect_score = max(0, aspect_score);
        area_score = min(1.0, s.Area / 2000);

        stop_score = 0.3 * solidity_score + 0.3 * aspect_score + 0.4 * area_score;

        % YIELD SIGN scoring: inverted triangle, wider at top
        % Yield signs have lower solidity (~0.5 for triangle)
        % and white center region
        yield_tri_score = 1 - abs(s.Solidity - 0.5) * 2;
        yield_tri_score = max(0, yield_tri_score);
        yield_aspect_score = max(0, 1 - abs(aspect - 1.2));  % slightly wider than tall
        white_score = 0;
        if white_center
            white_score = 0.5;
        end

        yield_score = 0.2 * yield_tri_score + 0.2 * yield_aspect_score + ...
                      0.3 * white_score + 0.3 * area_score;

        % Assign to best
        if stop_score > best_stop_conf && ~white_center
            best_stop_conf = stop_score;
            best_stop_bbox = bb;
            best_stop_area = s.Area;
        end

        if yield_score > best_yield_conf && white_center
            best_yield_conf = yield_score;
            best_yield_bbox = bb;
            best_yield_area = s.Area;
        end
    end

    % ===== Analyze YELLOW blobs (roundabout sign) =====
    best_round_conf = 0; best_round_bbox = zeros(1,4); best_round_area = 0;

    stats_yel = regionprops(yel_clean, 'Area', 'BoundingBox', 'Solidity', 'Extent');

    for i = 1:length(stats_yel)
        s = stats_yel(i);
        if s.Area < 80 || s.Area > 8000
            continue;
        end

        bb = s.BoundingBox;
        aspect = bb(3) / max(bb(4), 1);

        % Diamond shape: aspect ratio ~1.0, high solidity
        aspect_score = max(0, 1 - abs(aspect - 1.0) * 2);
        solidity_score = max(0, s.Solidity - 0.4);  % diamonds have decent solidity
        area_score = min(1.0, s.Area / 1500);

        % Reject very elongated shapes (center lines)
        if aspect < 0.5 || aspect > 2.0
            continue;
        end

        round_score = 0.3 * aspect_score + 0.3 * solidity_score + 0.4 * area_score;

        if round_score > best_round_conf
            best_round_conf = round_score;
            best_round_bbox = bb;
            best_round_area = s.Area;
        end
    end

    % ===== Choose best overall detection =====
    confs = [best_stop_conf, best_yield_conf, best_round_conf];
    [max_conf, max_idx] = max(confs);

    if max_conf > 0.25
        sign_type = int32(max_idx);  % 1=stop, 2=yield, 3=roundabout
        confidence = max_conf;

        switch max_idx
            case 1
                bbox = best_stop_bbox;
                apparent_size = sqrt(best_stop_area);
            case 2
                bbox = best_yield_bbox;
                apparent_size = sqrt(best_yield_area);
            case 3
                bbox = best_round_bbox;
                apparent_size = sqrt(best_round_area);
            otherwise
                apparent_size = 1;
        end

        % Distance estimation (calibrated for 1/10 scale signs)
        % At 0.3m distance, stop sign appears ~50px wide
        ref_size = 50;
        ref_dist = 0.3;
        distance_est = ref_dist * ref_size / max(apparent_size, 1);
    end
end
