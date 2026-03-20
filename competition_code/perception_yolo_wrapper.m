function result = perception_yolo_wrapper(rgb_image)
% Wrapper for YOLO perception - called via coder.extrinsic
persistent detector
if isempty(detector)
    data = load('trained_yolo_detector.mat');
    detector = data.trainedDetector;
end

[bboxes, scores, labels] = detect(detector, rgb_image, 'Threshold', 0.4);

light_color = 0;
sign_type = 0;
sign_size = single(0);
best_light_conf = 0;
best_sign_conf = 0;

for i = 1:size(bboxes, 1)
    lbl = string(labels(i));
    conf = scores(i);
    area = bboxes(i,3) * bboxes(i,4);

    if lbl == "red_light" && conf > best_light_conf
        light_color = 1;
        best_light_conf = conf;
    elseif lbl == "yellow_light" && conf > best_light_conf
        light_color = 2;
        best_light_conf = conf;
    elseif lbl == "green_light" && conf > best_light_conf
        light_color = 3;
        best_light_conf = conf;
    end

    if lbl == "stop_sign" && conf > best_sign_conf
        sign_type = 1;
        sign_size = area;
        best_sign_conf = conf;
    elseif lbl == "yield_sign" && conf > best_sign_conf
        sign_type = 2;
        sign_size = area;
        best_sign_conf = conf;
    elseif lbl == "roundabout" && conf > best_sign_conf
        sign_type = 3;
        sign_size = area;
        best_sign_conf = conf;
    end
end

result = single([light_color, sign_type, sign_size]);
end
