classdef SignTracker < vision.labeler.AutomationAlgorithm
    % SignTracker Tracks labeled bounding boxes across frames using KLT point tracking.
    % Use this in Image Labeler's Automate tab to propagate labels forward.
    %
    % 1. Label a keyframe with bounding boxes
    % 2. Click Automate, select SignTracker
    % 3. Click Run - it tracks boxes forward through subsequent frames

    properties(Constant)
        % Name displayed in Image Labeler
        Name = 'Sign & Light Tracker';
        Description = 'Tracks signs and traffic lights across frames using KLT point tracking.';

        % Support rectangle labels
        UserDirections = [...
            "Label objects in the first frame (or any keyframe).", ...
            "Click Run to track labels forward.", ...
            "Review and correct tracked labels.", ...
            "Accept results when satisfied."];
    end

    properties
        PointTrackers   % Cell array of KLT trackers, one per label
        BBoxes          % Current bounding boxes
        LabelNames      % Names of labels being tracked
        ValidFlags      % Track which boxes are still valid
    end

    methods
        function isValid = checkSetup(~, ~)
            isValid = true;
        end

        function setup(algo, ~)
            % Called once before automation begins
            algo.PointTrackers = {};
            algo.BBoxes = [];
            algo.LabelNames = {};
            algo.ValidFlags = [];
        end

        function autoLabels = run(algo, I)
            % Called for each frame
            autoLabels = {};

            Igray = im2gray(I);

            % Get all current labels from the previous frame
            currentLabels = algo.BBoxes;

            if isempty(algo.PointTrackers)
                % First frame - initialize trackers from existing labels
                selectedLabels = algo.SelectedLabelDefinitions;

                for i = 1:height(selectedLabels)
                    lName = selectedLabels.Name{i};

                    % Check if this label has annotations in current frame
                    if isprop(algo, 'CurrentLabel') || true
                        try
                            bboxes = algo.queryLabel(lName);
                        catch
                            continue;
                        end

                        if isempty(bboxes)
                            continue;
                        end

                        for j = 1:size(bboxes, 1)
                            bbox = bboxes(j, :);

                            % Create KLT point tracker
                            tracker = vision.PointTracker('MaxBidirectionalError', 2, ...
                                'NumPyramidLevels', 3, ...
                                'BlockSize', [31 31]);

                            % Detect points inside bounding box
                            roi = bbox;
                            points = detectMinEigenFeatures(Igray, 'ROI', roi, 'MinQuality', 0.01);

                            if points.Count >= 4
                                points = points.Location;
                                initialize(tracker, points, Igray);

                                idx = length(algo.PointTrackers) + 1;
                                algo.PointTrackers{idx} = tracker;
                                algo.BBoxes(idx, :) = bbox;
                                algo.LabelNames{idx} = lName;
                                algo.ValidFlags(idx) = true;
                            end
                        end
                    end
                end
            else
                % Subsequent frames - track existing points
                for i = 1:length(algo.PointTrackers)
                    if ~algo.ValidFlags(i)
                        continue;
                    end

                    tracker = algo.PointTrackers{i};
                    [points, validity] = tracker(Igray);

                    validPoints = points(validity, :);

                    if size(validPoints, 1) < 4
                        % Lost tracking
                        algo.ValidFlags(i) = false;
                        continue;
                    end

                    % Compute new bounding box from tracked points
                    xmin = min(validPoints(:, 1));
                    ymin = min(validPoints(:, 2));
                    xmax = max(validPoints(:, 1));
                    ymax = max(validPoints(:, 2));

                    % Add small padding
                    pad = 3;
                    xmin = max(1, xmin - pad);
                    ymin = max(1, ymin - pad);
                    xmax = min(size(I, 2), xmax + pad);
                    ymax = min(size(I, 1), ymax + pad);

                    newBBox = [xmin, ymin, xmax - xmin, ymax - ymin];

                    % Sanity check - box shouldn't change size too drastically
                    oldArea = algo.BBoxes(i, 3) * algo.BBoxes(i, 4);
                    newArea = newBBox(3) * newBBox(4);

                    if newArea < oldArea * 0.3 || newArea > oldArea * 3.0
                        algo.ValidFlags(i) = false;
                        continue;
                    end

                    algo.BBoxes(i, :) = newBBox;
                end
            end

            % Build output labels
            selectedLabels = algo.SelectedLabelDefinitions;
            for i = 1:height(selectedLabels)
                lName = selectedLabels.Name{i};

                % Collect all valid boxes for this label
                boxes = [];
                for j = 1:length(algo.LabelNames)
                    if algo.ValidFlags(j) && strcmp(algo.LabelNames{j}, lName)
                        boxes = [boxes; algo.BBoxes(j, :)]; %#ok<AGROW>
                    end
                end

                if ~isempty(boxes)
                    autoLabels{end+1} = struct('Name', lName, 'Type', labelType.Rectangle, 'Position', boxes); %#ok<AGROW>
                end
            end
        end

        function terminate(algo)
            % Cleanup
            for i = 1:length(algo.PointTrackers)
                if algo.ValidFlags(i)
                    release(algo.PointTrackers{i});
                end
            end
            algo.PointTrackers = {};
            algo.BBoxes = [];
            algo.LabelNames = {};
            algo.ValidFlags = [];
        end
    end
end
