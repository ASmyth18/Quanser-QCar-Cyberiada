function [light_color, sign_type, sign_size, lane_offset, lane_heading, lane_detected] = perception_fcn(rgb_image)
%#codegen
% Combined perception for Simulink. Fully codegen-compatible.
%
% Traffic lights: MobileNetV2 classifier (tiny, runs every frame at 30fps)
%   - Input: upper 60% of image, resized to 224x224
%   - Output: 4 classes [none=0, red=1, yellow=2, green=3]
%   - 2.2M params (vs YOLOv8's 25.8M) = much faster
%   - Simple ONNX graph = clean MATLAB import, no custom layers
%
% Signs: YOLOv8 dlnetwork (runs every 3rd frame)
% Lane:  existing lane_net CNN + yellow line gate (every frame)

persistent light_cls_net yolo_signs_net
persistent lane_net e_lat_mu e_lat_sig e_psi_mu e_psi_sig
persistent frame_count
persistent last_sign last_sign_size

if isempty(light_cls_net)
    light_cls_net = coder.loadDeepLearningNetwork('light_classifier_dlnet.mat');
end
if isempty(yolo_signs_net)
    yolo_signs_net = coder.loadDeepLearningNetwork('yolo_signs_dlnet.mat');
end
if isempty(lane_net)
    lane_net = coder.loadDeepLearningNetwork('lane_net.mat');
    params = coder.load('lane_norm_params.mat');
    e_lat_mu  = single(params.e_lat_mean);
    e_lat_sig = single(params.e_lat_std);
    e_psi_mu  = single(params.e_psi_mean);
    e_psi_sig = single(params.e_psi_std);
end
if isempty(frame_count)
    frame_count = int32(0);
    last_sign = int32(0);
    last_sign_size = single(0);
end

frame_count = frame_count + int32(1);

% ==================== TRAFFIC LIGHT: MobileNetV2 CLASSIFIER ====================
% Crop upper 60% of image (rows 1-288 of 480), resize to 224x224
% ImageNet normalization: (pixel/255 - mean) / std
upper_crop = rgb_image(1:288, :, :);
img_cls = single(imresize(upper_crop, [224, 224])) / single(255.0);

% ImageNet normalization (must match training preprocessing)
img_cls(:,:,1) = (img_cls(:,:,1) - single(0.485)) / single(0.229);
img_cls(:,:,2) = (img_cls(:,:,2) - single(0.456)) / single(0.224);
img_cls(:,:,3) = (img_cls(:,:,3) - single(0.406)) / single(0.225);

dl_cls = dlarray(img_cls, 'SSCB');
dl_out = predict(light_cls_net, dl_cls);
scores = extractdata(dl_out);
scores = scores(:);  % ensure column vector [4x1]: none, red, yellow, green

% Find class with highest score
best_score = scores(1);
best_cls = int32(0);  % none
if scores(2) > best_score
    best_score = scores(2);
    best_cls = int32(1);  % red
end
if scores(3) > best_score
    best_score = scores(3);
    best_cls = int32(2);  % yellow
end
if scores(4) > best_score
    best_cls = int32(3);  % green
end

light_color = best_cls;

% ==================== ROAD SIGNS: YOLOv8 (every 3rd frame) ====================
if mod(frame_count, int32(3)) == int32(0)
    img_yolo = single(imresize(rgb_image, [640, 640])) / single(255.0);
    dl_in = dlarray(img_yolo, 'SSCB');

    dl_out_s = predict(yolo_signs_net, dl_in);
    raw = extractdata(dl_out_s);
    raw = squeeze(raw);
    if size(raw, 1) > size(raw, 2)
        raw = raw';
    end

    best_conf = single(0);
    best_cls_s = int32(0);
    best_w = single(0);
    best_h = single(0);
    CONF_THRESH = single(0.30);
    SCALE_X = single(640.0 / 640.0);
    SCALE_Y = single(480.0 / 640.0);

    n_preds = int32(size(raw, 2));
    for i = 1:n_preds
        c1 = raw(5, i);
        c2 = raw(6, i);
        c3 = raw(7, i);
        mc = c1; bc = int32(1);
        if c2 > mc; mc = c2; bc = int32(2); end
        if c3 > mc; mc = c3; bc = int32(3); end
        if mc > CONF_THRESH && mc > best_conf
            best_conf = mc;
            best_cls_s = bc;
            best_w = raw(3, i) * SCALE_X;
            best_h = raw(4, i) * SCALE_Y;
        end
    end
    last_sign = best_cls_s;
    if best_cls_s > int32(0)
        last_sign_size = best_w * best_h;
    else
        last_sign_size = single(0);
    end
end

sign_type = last_sign;
sign_size = last_sign_size;

% ==================== LANE CNN (unchanged) ====================
cropped = single(rgb_image(241:480, :, :));
lane_input = (cropped(1:2:240, 1:2:640, :) + cropped(2:2:240, 2:2:640, :) + ...
              cropped(1:2:240, 2:2:640, :) + cropped(2:2:240, 1:2:640, :)) / single(4.0);

lane_pred = predict(lane_net, lane_input);

lane_offset  = single(lane_pred(1)) * e_lat_sig + e_lat_mu;
lane_heading = single(lane_pred(2)) * e_psi_sig + e_psi_mu;

MAX_E_LAT = single(0.3);
MAX_E_PSI = single(0.8);
if lane_offset > MAX_E_LAT
    lane_offset = MAX_E_LAT;
elseif lane_offset < -MAX_E_LAT
    lane_offset = -MAX_E_LAT;
end
if lane_heading > MAX_E_PSI
    lane_heading = MAX_E_PSI;
elseif lane_heading < -MAX_E_PSI
    lane_heading = -MAX_E_PSI;
end

% ==================== YELLOW LINE GATE (unchanged) ====================
yellow_count = int32(0);
for row = int32(350):int32(20):int32(470)
    for col = int32(10):int32(10):int32(630)
        r = single(rgb_image(row, col, 1));
        g = single(rgb_image(row, col, 2));
        b = single(rgb_image(row, col, 3));
        if r > single(180) && g > single(180) && b < single(210) && (r - b) > single(30)
            yellow_count = yellow_count + int32(1);
        end
    end
end

MIN_YELLOW = int32(5);
if yellow_count >= MIN_YELLOW
    lane_detected = int32(1);
else
    lane_detected = int32(0);
end

end
