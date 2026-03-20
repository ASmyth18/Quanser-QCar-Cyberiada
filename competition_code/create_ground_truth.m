%% Create groundTruth object with auto-labeled stop signs
% Load the auto-detected stop sign bounding boxes
load('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\stop_sign_detections.mat', 'stopBoxes', 'files');

framesDir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\frame';
numFrames = length(files);

%% Build file list
filePaths = cell(numFrames, 1);
for i = 1:numFrames
    filePaths{i} = fullfile(framesDir, files(i).name);
end

%% Define label classes
% 6 classes: stop_sign (pre-filled), red_light, green_light, yellow_light, yield_sign, roundabout
labelNames = {'stop_sign', 'red_light', 'green_light', 'yellow_light', 'yield_sign', 'roundabout'};
labelTypes = [labelType.Rectangle, labelType.Rectangle, labelType.Rectangle, ...
              labelType.Rectangle, labelType.Rectangle, labelType.Rectangle];

ldc = labelDefinitionCreator();
for k = 1:length(labelNames)
    addLabel(ldc, labelNames{k}, labelTypes(k));
end
labelDefs = create(ldc);

%% Build label data table
% Each column is a cell array - each cell contains Mx4 bounding boxes [x y w h]
stop_sign_col   = cell(numFrames, 1);
red_light_col   = cell(numFrames, 1);
green_light_col = cell(numFrames, 1);
yellow_light_col = cell(numFrames, 1);
yield_sign_col  = cell(numFrames, 1);
roundabout_col  = cell(numFrames, 1);

for i = 1:numFrames
    % Pre-fill stop signs from YOLO detections
    if ~isempty(stopBoxes{i}) && size(stopBoxes{i}, 1) > 0
        stop_sign_col{i} = stopBoxes{i};
    else
        stop_sign_col{i} = zeros(0, 4);
    end

    % Empty for all other classes (you'll fill these in Image Labeler)
    red_light_col{i}    = zeros(0, 4);
    green_light_col{i}  = zeros(0, 4);
    yellow_light_col{i} = zeros(0, 4);
    yield_sign_col{i}   = zeros(0, 4);
    roundabout_col{i}   = zeros(0, 4);
end

labelData = table(stop_sign_col, red_light_col, green_light_col, yellow_light_col, ...
                  yield_sign_col, roundabout_col, ...
                  'VariableNames', labelNames);

%% Create groundTruth object
dataSource = groundTruthDataSource(filePaths);
gTruth = groundTruth(dataSource, labelDefs, labelData);

%% Save and display
save('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\gTruth_auto.mat', 'gTruth');
fprintf('groundTruth created with %d frames\n', numFrames);
fprintf('Stop signs pre-labeled in %d frames\n', sum(cellfun(@(x) size(x,1) > 0, stop_sign_col)));
fprintf('\nOpen in Image Labeler with:\n');
fprintf('  imageLabeler(gTruth)\n');
fprintf('\nThen use Automate > Temporal Interpolation to speed up labeling the other classes.\n');
