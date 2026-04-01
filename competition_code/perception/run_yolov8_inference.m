function dets = run_yolov8_inference(img_original, net_func, net_params, input_size, conf_thresh, nms_thresh)
%RUN_YOLOV8_INFERENCE Run YOLOv8 inference using importONNXFunction output.
%
%   dets = run_yolov8_inference(img_original, net_func, net_params, input_size, conf_thresh, nms_thresh)
%
%   Inputs:
%     img_original - H x W x 3 uint8 RGB image (virtual camera outputs RGB)
%     net_func     - function handle (@yoloLights or @yoloSigns)
%     net_params   - ONNXParameters struct
%     input_size   - 640 (YOLOv8 input resolution)
%     conf_thresh  - confidence threshold (e.g. 0.30)
%     nms_thresh   - NMS IoU threshold (e.g. 0.45)
%
%   Returns: Nx6 matrix [x1, y1, x2, y2, confidence, class_id]
%            Empty if no detections.
%
%   NOT codegen-compatible (uses dlarray). Called via coder.extrinsic.

    [orig_h, orig_w, ~] = size(img_original);

    % Preprocess: input is already RGB, resize, normalize to [0,1]
    img_resized = imresize(img_original, [input_size, input_size]);
    img_single = single(img_resized) / 255.0;

    % Create dlarray: SSCB = height x width x channels x batch
    img_input = dlarray(img_single, 'SSCB');

    % Forward pass
    output = net_func(img_input, net_params, 'Training', false);

    % Extract raw output
    out = extractdata(output);
    out = squeeze(out);

    % Ensure shape is (4+nc, 8400)
    if size(out, 1) > size(out, 2)
        out = out';
    end

    % Decode boxes
    cx = out(1, :);
    cy = out(2, :);
    bw = out(3, :);
    bh = out(4, :);

    % Class confidences
    class_confs = out(5:end, :);
    [max_conf, best_cls] = max(class_confs, [], 1);

    % Filter by confidence
    keep = max_conf > conf_thresh;
    if ~any(keep)
        dets = [];
        return;
    end

    cx = cx(keep); cy = cy(keep);
    bw = bw(keep); bh = bh(keep);
    max_conf = max_conf(keep);
    best_cls = best_cls(keep);

    % Convert to x1,y1,x2,y2 and scale to original image
    scale_x = orig_w / input_size;
    scale_y = orig_h / input_size;
    x1 = (cx - bw/2) * scale_x;
    y1 = (cy - bh/2) * scale_y;
    x2 = (cx + bw/2) * scale_x;
    y2 = (cy + bh/2) * scale_y;

    x1 = max(0, x1); y1 = max(0, y1);
    x2 = min(orig_w, x2); y2 = min(orig_h, y2);

    boxes = [x1(:), y1(:), x2(:), y2(:), max_conf(:), best_cls(:)];

    % NMS per class
    dets = [];
    for c = unique(best_cls)
        cls_mask = boxes(:, 6) == c;
        cls_boxes = boxes(cls_mask, :);

        [~, order] = sort(cls_boxes(:, 5), 'descend');
        cls_boxes = cls_boxes(order, :);

        selected = [];
        while ~isempty(cls_boxes)
            selected = [selected; cls_boxes(1, :)]; %#ok<AGROW>
            if size(cls_boxes, 1) == 1, break; end

            ious = compute_iou_nms(cls_boxes(1, 1:4), cls_boxes(2:end, 1:4));
            cls_boxes = cls_boxes([false; ious < nms_thresh], :);
        end
        dets = [dets; selected]; %#ok<AGROW>
    end
end


function ious = compute_iou_nms(box, boxes)
    ix1 = max(box(1), boxes(:,1));
    iy1 = max(box(2), boxes(:,2));
    ix2 = min(box(3), boxes(:,3));
    iy2 = min(box(4), boxes(:,4));

    iw = max(0, ix2 - ix1);
    ih = max(0, iy2 - iy1);
    inter = iw .* ih;

    area1 = (box(3)-box(1)) * (box(4)-box(2));
    area2 = (boxes(:,3)-boxes(:,1)) .* (boxes(:,4)-boxes(:,2));
    ious = inter ./ (area1 + area2 - inter + 1e-6);
end
