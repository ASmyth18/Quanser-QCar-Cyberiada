framesDir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\frame';
files = dir(fullfile(framesDir, '*.png'));
detector = yolov4ObjectDetector('tiny-yolov4-coco');

stopBoxes = cell(length(files), 1);

for i = 1:length(files)
    img = imread(fullfile(framesDir, files(i).name));
    [bboxes, scores, labels] = detect(detector, img, 'Threshold', 0.3);
    
    % Keep only stop signs
    isStop = labels == 'stop sign';
    if any(isStop)
        stopBoxes{i} = bboxes(isStop, :);
    else
        stopBoxes{i} = zeros(0, 4);
    end
    
    if mod(i, 100) == 0
        fprintf('Processed %d / %d\n', i, length(files));
    end
end

save(fullfile(framesDir, '..', 'stop_sign_detections.mat'), 'stopBoxes', 'files');
fprintf('Done. Found stop signs in %d frames\n', sum(cellfun(@(x) size(x,1) > 0, stopBoxes)));
