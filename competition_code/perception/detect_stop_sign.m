function [detected, distance_est, confidence] = detect_stop_sign(image, params)
%DETECT_STOP_SIGN Detect stop signs from a front-facing camera image.
%
%   [detected, distance_est, confidence] = detect_stop_sign(image, params)
%
%   Uses red color segmentation and shape analysis to detect octagonal
%   stop signs in the camera view.
%
%   Inputs:
%     image  - H x W x 3 uint8 BGR image from QCar2 CSI front camera
%     params - struct with SS_* fields from Setup_Params_Enhanced
%
%   Outputs:
%     detected     - logical, true if stop sign detected
%     distance_est - estimated distance in meters (rough, based on size)
%     confidence   - 0-1 confidence score

    detected = false;
    distance_est = inf;
    confidence = 0.0;

    if isempty(image)
        return;
    end

    [img_h, img_w, ~] = size(image);

    % Convert BGR to RGB then HSV
    rgb_img = image(:,:,[3,2,1]);
    hsv_img = rgb2hsv(rgb_img);

    H = hsv_img(:,:,1) * 180;
    S = hsv_img(:,:,2) * 255;
    V = hsv_img(:,:,3) * 255;

    % Red color detection (two hue ranges)
    red_mask1 = (H >= params.SS_RED_H_LOW1) & (H <= params.SS_RED_H_HIGH1) & ...
                (S >= params.SS_RED_S_LOW) & (S <= params.SS_RED_S_HIGH) & ...
                (V >= params.SS_RED_V_LOW) & (V <= params.SS_RED_V_HIGH);
    red_mask2 = (H >= params.SS_RED_H_LOW2) & (H <= params.SS_RED_H_HIGH2) & ...
                (S >= params.SS_RED_S_LOW) & (S <= params.SS_RED_S_HIGH) & ...
                (V >= params.SS_RED_V_LOW) & (V <= params.SS_RED_V_HIGH);
    red_mask = red_mask1 | red_mask2;

    % Morphological cleanup
    se = strel('disk', 2);
    red_mask = imclose(red_mask, se);
    red_mask = imopen(red_mask, se);

    % Analyze blobs
    stats = regionprops(red_mask, 'Area', 'BoundingBox', 'Solidity', 'Extent');

    if isempty(stats)
        return;
    end

    % Filter by minimum area
    valid_idx = find([stats.Area] >= params.SS_MIN_AREA);

    if isempty(valid_idx)
        return;
    end

    % Score each candidate
    best_score = 0;
    best_idx = 0;

    for i = 1:length(valid_idx)
        s = stats(valid_idx(i));
        bb = s.BoundingBox;

        % Stop signs are roughly square (aspect ratio close to 1)
        aspect_ratio = bb(3) / max(bb(4), 1);

        % Octagonal shapes have solidity around 0.83
        % (octagon area / bounding box area = ~0.828)
        solidity_score = 1 - abs(s.Solidity - 0.83) * 2;
        solidity_score = max(0, solidity_score);

        aspect_score = 1 - abs(aspect_ratio - 1.0);
        aspect_score = max(0, aspect_score);

        % Prefer larger (closer) signs
        area_score = min(1.0, s.Area / 2000);

        score = 0.3 * solidity_score + 0.3 * aspect_score + 0.4 * area_score;

        if score > best_score
            best_score = score;
            best_idx = valid_idx(i);
        end
    end

    if best_score > 0.25
        detected = true;
        confidence = best_score;
        best = stats(best_idx);

        % Rough distance estimation based on apparent size
        % Actual stop sign at 1/10 scale is ~3cm. At 0.3m distance,
        % it appears roughly 50px wide in 820px image.
        apparent_size = sqrt(best.Area);
        % Calibration: reference_size_px at reference_distance_m
        ref_size = 50;    % pixels at reference distance
        ref_dist = 0.3;   % meters
        distance_est = ref_dist * ref_size / max(apparent_size, 1);
    end
end
