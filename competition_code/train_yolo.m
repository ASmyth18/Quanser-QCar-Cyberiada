%% Train YOLOv4-tiny for sign and traffic light detection
% Requires: Deep Learning Toolbox, Computer Vision Toolbox

%% 1. Load ground truth and convert to training table
load('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\gTruth_propagated.mat', 'gTruth_propagated');

trainingData = objectDetectorTrainingData(gTruth_propagated);
fprintf('Total labeled frames: %d\n', height(trainingData));

% Remove rows with no labels (all empty)
labelCols = trainingData(:, 2:end);
hasLabels = false(height(labelCols), 1);
for i = 1:height(labelCols)
    for j = 1:width(labelCols)
        boxes = labelCols{i, j}{1};
        if ~isempty(boxes) && size(boxes, 1) > 0
            hasLabels(i) = true;
            break;
        end
    end
end
trainingData = trainingData(hasLabels, :);
fprintf('Frames with labels: %d\n', height(trainingData));

%% 2. Define classes
classNames = {'stop_sign', 'red_light', 'green_light', 'yellow_light', 'yield_sign', 'roundabout'};

%% 3. Split into training (80%) and validation (20%)
rng(42);
idx = randperm(height(trainingData));
splitIdx = round(0.8 * length(idx));
trainIdx = idx(1:splitIdx);
valIdx = idx(splitIdx+1:end);

trainData = trainingData(trainIdx, :);
valData = trainingData(valIdx, :);
fprintf('Training: %d, Validation: %d\n', height(trainData), height(valData));

%% 4. Estimate anchor boxes
inputSize = [480 640 3];  % Match CSI camera resolution
numAnchors = 6;  % tiny-yolov4 uses 6 anchors (3 per detection head)

% Collect all bounding boxes for anchor estimation
allBoxes = [];
for i = 1:height(trainData)
    for j = 2:width(trainData)
        boxes = trainData{i, j}{1};
        if ~isempty(boxes) && size(boxes, 1) > 0
            allBoxes = [allBoxes; boxes]; %#ok<AGROW>
        end
    end
end

if size(allBoxes, 1) >= numAnchors
    % Use kmeans on width/height to estimate anchors
    boxWH = allBoxes(:, 3:4);  % width and height columns
    [~, centroids] = kmeans(boxWH, numAnchors, 'Replicates', 5);
    anchorBoxes = round(centroids);
    % Sort by area
    [~, sortIdx] = sort(anchorBoxes(:,1) .* anchorBoxes(:,2));
    anchorBoxes = anchorBoxes(sortIdx, :);
    fprintf('Estimated anchor boxes:\n');
    disp(anchorBoxes);
else
    warning('Not enough boxes for anchor estimation, using defaults');
    anchorBoxes = [10 14; 23 27; 37 58; 81 82; 135 169; 344 319];
end

%% 5. Create YOLOv4-tiny detector
% Split anchors into 2 groups: small (head 1) and large (head 2)
anchorBoxesCell = {anchorBoxes(1:3, :); anchorBoxes(4:6, :)};
detector = yolov4ObjectDetector('tiny-yolov4-coco', classNames, anchorBoxesCell, 'InputSize', inputSize);

%% 6. Create checkpoint directory
if ~exist('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\checkpoints', 'dir')
    mkdir('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\checkpoints');
end

%% 7. Convert tables to datastores
trainDS = boxLabelDatastore(trainData(:, 2:end));
trainImDS = imageDatastore(trainData{:, 1});
trainCombinedDS = combine(trainImDS, trainDS);

valDS = boxLabelDatastore(valData(:, 2:end));
valImDS = imageDatastore(valData{:, 1});
valCombinedDS = combine(valImDS, valDS);

%% 8. Training options
options = trainingOptions('adam', ...
    'InitialLearnRate', 1e-3, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 30, ...
    'MaxEpochs', 80, ...
    'MiniBatchSize', 8, ...
    'ValidationData', valCombinedDS, ...
    'ValidationFrequency', 50, ...
    'Shuffle', 'every-epoch', ...
    'ResetInputNormalization', false, ...
    'Verbose', true, ...
    'VerboseFrequency', 20, ...
    'Plots', 'training-progress', ...
    'ExecutionEnvironment', 'auto', ...
    'CheckpointPath', 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\checkpoints');

%% 9. Train
fprintf('Starting training...\n');
[trainedDetector, info] = trainYOLOv4ObjectDetector(trainCombinedDS, detector, options);

%% 9. Save trained detector
save('C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code\trained_yolo_detector.mat', 'trainedDetector');
fprintf('Detector saved to trained_yolo_detector.mat\n');

%% 10. Quick evaluation on validation set
fprintf('\nEvaluating on validation set...\n');
results = detect(trainedDetector, valData, 'Threshold', 0.4);
metrics = evaluateObjectDetection(results, valData, classNames);
fprintf('\nAverage Precision per class:\n');
disp(metrics);

%% 11. Test on a sample image
figure;
sampleIdx = randi(height(valData));
img = imread(valData{sampleIdx, 1}{1});
[bboxes, scores, labels] = detect(trainedDetector, img, 'Threshold', 0.4);
if ~isempty(bboxes)
    detImg = insertObjectAnnotation(img, 'rectangle', bboxes, ...
        cellstr(labels) + " " + string(round(scores, 2)));
    imshow(detImg);
    title('Sample Detection');
else
    imshow(img);
    title('No detections');
end
