%% Propagate labels using KLT point tracking
% Usage:
%   1. Open imageLabeler(gTruth) and label keyframes every ~30-50 frames
%   2. Export to workspace as gTruth
%   3. Run this script to fill in the gaps
%   4. Reload: imageLabeler(gTruth_propagated) to review

load('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\gTruth_auto.mat', 'gTruth');

labelData = gTruth.LabelData;
labelNames = labelData.Properties.VariableNames;
numFrames = height(labelData);
filePaths = gTruth.DataSource.Source;

fprintf('Loaded %d frames with %d label classes\n', numFrames, length(labelNames));

%% Find keyframes (frames that have at least one label)
keyframes = false(numFrames, 1);
for i = 1:numFrames
    for k = 1:length(labelNames)
        boxes = labelData{i, k}{1};
        if ~isempty(boxes) && size(boxes, 1) > 0
            keyframes(i) = true;
            break;
        end
    end
end
fprintf('Found %d keyframes out of %d total frames\n', sum(keyframes), numFrames);

%% Forward propagation: track from each keyframe until next keyframe or tracking loss
fprintf('Propagating labels forward...\n');

for k = 1:length(labelNames)
    lName = labelNames{k};
    fprintf('  Processing: %s\n', lName);

    i = 1;
    while i <= numFrames
        boxes = labelData{i, k}{1};

        if isempty(boxes) || size(boxes, 1) == 0
            i = i + 1;
            continue;
        end

        % Found a keyframe with boxes for this label
        % Initialize trackers for each box
        img = imread(filePaths{i});
        Igray = im2gray(img);

        numBoxes = size(boxes, 1);
        trackers = cell(numBoxes, 1);
        currentBoxes = boxes;
        valid = true(numBoxes, 1);

        for b = 1:numBoxes
            tracker = vision.PointTracker('MaxBidirectionalError', 2, ...
                'NumPyramidLevels', 3, ...
                'BlockSize', [31 31]);

            roi = round(currentBoxes(b, :));
            roi(1) = max(1, roi(1));
            roi(2) = max(1, roi(2));
            roi(3) = max(5, min(roi(3), size(img,2) - roi(1)));
            roi(4) = max(5, min(roi(4), size(img,1) - roi(2)));

            points = detectMinEigenFeatures(Igray, 'ROI', roi, 'MinQuality', 0.005);

            if points.Count >= 4
                initialize(tracker, points.Location, Igray);
                trackers{b} = tracker;
            else
                valid(b) = false;
            end
        end

        % Track forward until next keyframe or all trackers lost
        j = i + 1;
        while j <= numFrames && any(valid)
            % Check if next frame is already a keyframe for this label
            existingBoxes = labelData{j, k}{1};
            if ~isempty(existingBoxes) && size(existingBoxes, 1) > 0
                break; % Don't overwrite existing labels
            end

            img = imread(filePaths{j});
            Igray = im2gray(img);

            newBoxes = zeros(0, 4);
            for b = 1:numBoxes
                if ~valid(b)
                    continue;
                end

                [points, validity] = trackers{b}(Igray);
                validPoints = points(validity, :);

                if size(validPoints, 1) < 4
                    valid(b) = false;
                    continue;
                end

                xmin = min(validPoints(:, 1));
                ymin = min(validPoints(:, 2));
                xmax = max(validPoints(:, 1));
                ymax = max(validPoints(:, 2));

                pad = 3;
                xmin = max(1, xmin - pad);
                ymin = max(1, ymin - pad);
                xmax = min(size(img, 2), xmax + pad);
                ymax = min(size(img, 1), ymax + pad);

                newBox = [xmin, ymin, xmax - xmin, ymax - ymin];

                % Sanity: area shouldn't change too much
                oldArea = currentBoxes(b, 3) * currentBoxes(b, 4);
                newArea = newBox(3) * newBox(4);
                if newArea < oldArea * 0.2 || newArea > oldArea * 5.0
                    valid(b) = false;
                    continue;
                end

                newBoxes = [newBoxes; newBox]; %#ok<AGROW>
                currentBoxes(b, :) = newBox;
            end

            if ~isempty(newBoxes)
                labelData{j, k} = {newBoxes};
            end

            j = j + 1;
        end

        % Release trackers
        for b = 1:numBoxes
            if ~isempty(trackers{b})
                release(trackers{b});
            end
        end

        i = j; % Jump to where we stopped
    end
end

%% Create new groundTruth with propagated labels
gTruth_propagated = groundTruth(gTruth.DataSource, gTruth.LabelDefinitions, labelData);
save('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\gTruth_propagated.mat', 'gTruth_propagated');

% Count filled frames
filledFrames = 0;
for i = 1:numFrames
    for k = 1:length(labelNames)
        boxes = labelData{i, k}{1};
        if ~isempty(boxes) && size(boxes, 1) > 0
            filledFrames = filledFrames + 1;
            break;
        end
    end
end
fprintf('\nDone! Frames with labels: %d (was %d keyframes)\n', filledFrames, sum(keyframes));
fprintf('Open in Image Labeler to review:\n');
fprintf('  load(''C:\\Users\\adams\\Desktop\\Qunaser_Main_Project\\training_data\\gTruth_propagated.mat'')\n');
fprintf('  imageLabeler(gTruth_propagated)\n');
