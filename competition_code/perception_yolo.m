function [light_color, sign_type, sign_size] = perception_yolo(rgb_image)
%#codegen
% YOLO-based perception for traffic signs and lights
% Outputs:
%   light_color: 0=none, 1=red, 2=yellow, 3=green
%   sign_type:   0=none, 1=stop, 2=yield, 3=roundabout
%   sign_size:   bounding box area of detected sign (0 if none)

persistent net
if isempty(net)
    net = coder.loadDeepLearningNetwork('yolo_net.mat');
end

% Anchors (from training)
% Head 1 (15x20, stride 32): small anchors
anchors1 = single([9 13; 13 27; 23 23]);
% Head 2 (30x40, stride 16): larger anchors
anchors2 = single([23 38; 39 61; 54 81]);

CONF_THRESH = single(0.4);
NUM_CLASSES = int32(6);
% Class indices: 1=stop_sign, 2=red_light, 3=green_light, 4=yellow_light, 5=yield_sign, 6=roundabout

% Preprocess: normalize to [0,1]
img = single(rgb_image) / single(255.0);

% Forward pass - returns [H x W x 33] for each head
[dlOut1, dlOut2] = predict(net, dlarray(img, 'SSCB'));

out1 = extractdata(dlOut1);  % 15x20x33
out2 = extractdata(dlOut2);  % 30x40x33

% Decode both heads
% [x, y, w, h, conf, class_id] per detection
all_dets = zeros(100, 6, 'single');
num_dets = int32(0);

% Decode head 1: 15x20, stride 32
[all_dets, num_dets] = decode_head(out1, anchors1, int32(32), int32(15), int32(20), ...
    NUM_CLASSES, CONF_THRESH, all_dets, num_dets);

% Decode head 2: 30x40, stride 16
[all_dets, num_dets] = decode_head(out2, anchors2, int32(16), int32(30), int32(40), ...
    NUM_CLASSES, CONF_THRESH, all_dets, num_dets);

% Parse detections into outputs
light_color = int32(0);
sign_type = int32(0);
sign_size = single(0);

best_light_conf = single(0);
best_sign_conf = single(0);

for i = 1:num_dets
    conf = all_dets(i, 5);
    cls = int32(all_dets(i, 6));
    box_area = all_dets(i, 3) * all_dets(i, 4);

    % Traffic lights: red=2, green=3, yellow=4
    if cls == 2 && conf > best_light_conf
        light_color = int32(1); % red
        best_light_conf = conf;
    elseif cls == 4 && conf > best_light_conf
        light_color = int32(2); % yellow
        best_light_conf = conf;
    elseif cls == 3 && conf > best_light_conf
        light_color = int32(3); % green
        best_light_conf = conf;
    end

    % Signs: stop=1, yield=5, roundabout=6
    if cls == 1 && conf > best_sign_conf
        sign_type = int32(1); % stop
        sign_size = box_area;
        best_sign_conf = conf;
    elseif cls == 5 && conf > best_sign_conf
        sign_type = int32(2); % yield
        sign_size = box_area;
        best_sign_conf = conf;
    elseif cls == 6 && conf > best_sign_conf
        sign_type = int32(3); % roundabout
        sign_size = box_area;
        best_sign_conf = conf;
    end
end

end

function [all_dets, num_dets] = decode_head(feat, anchors, stride, grid_h, grid_w, ...
    num_classes, conf_thresh, all_dets, num_dets)
%#codegen
% Decode a single YOLO head output

num_anchors = int32(3);
chan_per_anchor = int32(5) + num_classes;  % 11
max_dets = int32(100);

for row = 1:grid_h
    for col = 1:grid_w
        for a = 1:num_anchors
            if num_dets >= max_dets
                return;
            end

            offset = (a - int32(1)) * chan_per_anchor;

            % Raw predictions
            tx = feat(row, col, offset + 1);
            ty = feat(row, col, offset + 2);
            tw = feat(row, col, offset + 3);
            th = feat(row, col, offset + 4);
            obj = sigmoid_s(feat(row, col, offset + 5));

            if obj < single(0.1)
                continue;
            end

            % Find best class
            best_cls = int32(1);
            best_cls_score = single(-1e6);
            for c = 1:num_classes
                score = feat(row, col, offset + 5 + c);
                if score > best_cls_score
                    best_cls_score = score;
                    best_cls = int32(c);
                end
            end

            cls_prob = sigmoid_s(best_cls_score);
            conf = obj * cls_prob;

            if conf < conf_thresh
                continue;
            end

            % Decode box coordinates
            bx = (sigmoid_s(tx) + single(col - 1)) * single(stride);
            by = (sigmoid_s(ty) + single(row - 1)) * single(stride);
            bw = exp(tw) * single(anchors(a, 1));
            bh = exp(th) * single(anchors(a, 2));

            % Store detection
            num_dets = num_dets + int32(1);
            all_dets(num_dets, 1) = bx - bw / single(2);  % x
            all_dets(num_dets, 2) = by - bh / single(2);  % y
            all_dets(num_dets, 3) = bw;                     % width
            all_dets(num_dets, 4) = bh;                     % height
            all_dets(num_dets, 5) = conf;                   % confidence
            all_dets(num_dets, 6) = single(best_cls);       % class id
        end
    end
end

end

function y = sigmoid_s(x)
%#codegen
y = single(1) / (single(1) + exp(-x));
end
