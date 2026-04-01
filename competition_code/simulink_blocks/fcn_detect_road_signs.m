function [sign_type, sign_conf, sign_dist] = fcn_detect_road_signs(image)
%#codegen
% MATLAB Function Block: Road Sign Detection
% Uses YOLOv8 via coder.extrinsic with HSV fallback.
%
% Input:  image [480x640x3 uint8] - RGB from CSI front camera
% Output: sign_type [int32] - 0=none, 1=stop, 2=yield, 3=roundabout
%         sign_conf [double] - 0 to 1
%         sign_dist [double] - estimated distance in meters

    sign_type = int32(0);
    sign_conf = 0.0;
    sign_dist = double(inf);

    % Declare extrinsic (runs on host MATLAB, not compiled)
    coder.extrinsic('yolov8_detect_signs');

    yolo_type = int32(0);
    yolo_conf = 0.0;
    yolo_bbox = zeros(1, 4);

    try
        [yolo_type, yolo_conf, yolo_bbox] = yolov8_detect_signs(image);
    catch
        yolo_type = int32(0);
        yolo_conf = 0.0;
    end

    if yolo_type > 0
        sign_type = yolo_type;
        sign_conf = yolo_conf;
        apparent_size = sqrt(max(yolo_bbox(3) * yolo_bbox(4), 1));
        sign_dist = 0.3 * 50 / apparent_size;
    end
end
