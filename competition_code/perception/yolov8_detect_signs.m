function [sign_type, confidence, bbox] = yolov8_detect_signs(image)
%YOLOV8_DETECT_SIGNS Detect road signs using YOLOv8 model.
%
%   Called via coder.extrinsic from Simulink MATLAB Function blocks.
%   NOT codegen-compatible (uses dlarray). Runs on host MATLAB.
%
%   YOLOv8 classes: 1=stop_sign, 2=yield_sign, 3=roundabout_sign
%
%   Inputs:
%     image - H x W x 3 uint8 RGB image
%
%   Outputs:
%     sign_type  - int32: 0=none, 1=stop, 2=yield, 3=roundabout
%     confidence - 0-1 confidence score
%     bbox       - [x, y, w, h] bounding box (zeros if none)

    sign_type = int32(0);
    confidence = 0.0;
    bbox = zeros(1, 4);

    % Persistent storage for model params (load once)
    persistent params_signs yolo_loaded
    if isempty(yolo_loaded)
        run_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\run12';
        addpath(run_dir);
        fprintf('[YOLOv8] Loading road sign model...\n');
        S = load(fullfile(run_dir, 'yoloSignsParams.mat'));
        fns = fieldnames(S);
        params_signs = S.(fns{1});
        yolo_loaded = true;
        fprintf('[YOLOv8] Road sign model loaded.\n');
    end

    % Run inference
    INPUT_SIZE = 640;
    CONF_THRESHOLD = 0.30;
    NMS_IOU_THRESHOLD = 0.45;

    dets = run_yolov8_inference(image, @yoloSigns, params_signs, ...
        INPUT_SIZE, CONF_THRESHOLD, NMS_IOU_THRESHOLD);

    if isempty(dets)
        return;
    end

    % Find highest confidence detection
    [best_conf, best_idx] = max(dets(:, 5));
    cls_id = dets(best_idx, 6);  % 1=stop, 2=yield, 3=roundabout

    sign_type = int32(cls_id);
    confidence = best_conf;

    % Convert x1,y1,x2,y2 to x,y,w,h
    x1 = dets(best_idx, 1);
    y1 = dets(best_idx, 2);
    x2 = dets(best_idx, 3);
    y2 = dets(best_idx, 4);
    bbox = [x1, y1, x2-x1, y2-y1];
end
