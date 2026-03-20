function [lane_center_offset, lane_heading_error, lane_detected] = ...
    detect_lanes(image, params)
%DETECT_LANES Detect lane lines and compute lateral offset.
%
%   [lane_center_offset, lane_heading_error, lane_detected] = ...
%       detect_lanes(image, params)
%
%   Processes a front camera image to detect yellow lane markings using
%   HSV color segmentation, then computes the lateral offset of the car
%   from the lane center.
%
%   Inputs:
%     image  - H x W x 3 uint8 BGR image from QCar2 CSI front camera
%     params - struct with LANE_* fields from Setup_Params_Enhanced
%
%   Outputs:
%     lane_center_offset - lateral offset from lane center in pixels
%                          (negative = car is left of center)
%     lane_heading_error - heading error in radians (angle of lane line)
%     lane_detected      - logical, true if lane lines were found

    lane_center_offset = 0;
    lane_heading_error = 0;
    lane_detected = false;

    if isempty(image)
        return;
    end

    [img_h, img_w, ~] = size(image);

    % Extract ROI (lower portion of image where lanes are visible)
    roi = params.LANE_ROI;
    y1 = max(1, roi(1)); y2 = min(img_h, roi(2));
    x1 = max(1, roi(3)); x2 = min(img_w, roi(4));
    roi_img = image(y1:y2, x1:x2, :);
    roi_w = x2 - x1 + 1;
    roi_h = y2 - y1 + 1;

    % Convert BGR to RGB then HSV
    rgb_img = roi_img(:,:,[3,2,1]);
    hsv_img = rgb2hsv(rgb_img);

    H = hsv_img(:,:,1) * 180;
    S = hsv_img(:,:,2) * 255;
    V = hsv_img(:,:,3) * 255;

    % Detect yellow lane lines
    yel_mask = (H >= params.LANE_YEL_H_LOW) & (H <= params.LANE_YEL_H_HIGH) & ...
               (S >= params.LANE_YEL_S_LOW) & (S <= params.LANE_YEL_S_HIGH) & ...
               (V >= params.LANE_YEL_V_LOW) & (V <= params.LANE_YEL_V_HIGH);

    % Detect white lane lines
    wht_mask = (S >= params.LANE_WHT_S_LOW) & (S <= params.LANE_WHT_S_HIGH) & ...
               (V >= params.LANE_WHT_V_LOW) & (V <= params.LANE_WHT_V_HIGH);

    % Combine lane masks
    lane_mask = yel_mask | wht_mask;

    % Morphological cleanup
    se = strel('line', 5, 90);
    lane_mask = imclose(lane_mask, se);

    % Find lane line positions using column projection
    % (average across rows for each column)
    col_sum = sum(lane_mask, 1);

    % Threshold to find lane columns
    col_thresh = roi_h * 0.05;  % at least 5% of rows must be lane
    lane_cols = find(col_sum > col_thresh);

    if length(lane_cols) < 5
        return;
    end

    lane_detected = true;

    % Find left and right lane boundaries by looking for gaps
    image_center = roi_w / 2;

    % Find clusters of lane columns (left lane and right lane)
    col_diff = diff(lane_cols);
    gap_idx = find(col_diff > roi_w * 0.1);  % gaps > 10% of width

    if ~isempty(gap_idx)
        % Multiple lane line clusters found
        % Left lane = cluster closest to left side
        % Right lane = cluster closest to right side
        left_cols = lane_cols(1:gap_idx(1));
        right_cols = lane_cols(gap_idx(end)+1:end);

        left_center = mean(left_cols);
        right_center = mean(right_cols);

        % Lane center is midpoint between left and right lines
        lane_center = (left_center + right_center) / 2;
    else
        % Single lane line detected - estimate offset from that
        lane_center = mean(lane_cols);
    end

    % Compute offset from image center (pixels)
    lane_center_offset = lane_center - image_center;

    % Estimate heading error using top and bottom halves of ROI
    top_half = lane_mask(1:floor(roi_h/2), :);
    bot_half = lane_mask(floor(roi_h/2)+1:end, :);

    top_sum = sum(top_half, 1);
    bot_sum = sum(bot_half, 1);

    top_thresh = floor(roi_h/2) * 0.03;
    bot_thresh = (roi_h - floor(roi_h/2)) * 0.03;

    top_cols = find(top_sum > top_thresh);
    bot_cols = find(bot_sum > bot_thresh);

    if ~isempty(top_cols) && ~isempty(bot_cols)
        top_center = mean(top_cols);
        bot_center = mean(bot_cols);

        % Heading error: positive if lane curves right
        dx = top_center - bot_center;
        dy = roi_h / 2;
        lane_heading_error = atan2(dx, dy);
    end
end
