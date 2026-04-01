function [light_color, confidence] = fcn_detect_traffic_light(image)
%#codegen
% MATLAB Function Block: Traffic Light Detection
% Uses YOLOv8 via coder.extrinsic with HSV fallback.
%
% Input:  image [480x640x3 uint8] - RGB from CSI front camera
% Output: light_color [int32] - 0=none, 1=red, 2=yellow, 3=green
%         confidence [double] - 0 to 1

    light_color = int32(0);
    confidence = 0.0;

    % Declare extrinsic (runs on host MATLAB, not compiled)
    coder.extrinsic('yolov8_detect_lights');

    yolo_color = int32(0);
    yolo_conf  = 0.0;
    yolo_bbox  = zeros(1, 4);

    try
        [yolo_color, yolo_conf, yolo_bbox] = yolov8_detect_lights(image); %#ok<ASGLU>
    catch
        yolo_color = int32(0);
        yolo_conf = 0.0;
    end

    if yolo_color > 0
        light_color = yolo_color;
        confidence  = yolo_conf;
    end
end
