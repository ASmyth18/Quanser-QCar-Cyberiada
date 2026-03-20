%% extract_training_data.m
% Run this AFTER stopping the data collection model.
% Extracts camera frames and metadata from workspace variables.

%% Configuration
output_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data';
frames_dir = fullfile(output_dir, 'frames');
labels_dir = fullfile(output_dir, 'labels');

if ~exist(frames_dir, 'dir'), mkdir(frames_dir); end
if ~exist(labels_dir, 'dir'), mkdir(labels_dir); end

%% Check workspace variables exist
if ~exist('camera_frames', 'var')
    error('camera_frames not found in workspace. Did you run the data collection model?');
end
if ~exist('pose_data', 'var')
    error('pose_data not found in workspace. Did you run the data collection model?');
end

%% Extract camera frames
fprintf('Extracting camera frames...\n');

% Get timeseries data
if isa(camera_frames, 'timeseries')
    frames = camera_frames.Data;
    frame_times = camera_frames.Time;
elseif isstruct(camera_frames) && isfield(camera_frames, 'signals')
    frames = camera_frames.signals.values;
    frame_times = camera_frames.time;
else
    error('Unexpected camera_frames format. Check To Workspace save format.');
end

num_frames = size(frames, 4);  % [H x W x 3 x N] for timeseries
if num_frames == 0
    % Try [N x H x W x 3] format
    num_frames = size(frames, 1);
end

fprintf('Found %d frames over %.1f seconds\n', num_frames, frame_times(end) - frame_times(1));

%% Extract pose at each frame time
if isa(pose_data, 'timeseries')
    pose_times = pose_data.Time;
    poses = pose_data.Data;
else
    pose_times = pose_data.time;
    poses = pose_data.signals.values;
end

%% Save individual frames and metadata
metadata = struct('frame', {}, 'time', {}, 'x', {}, 'y', {}, 'heading', {}, 'filename', {});

fprintf('Saving frames to: %s\n', frames_dir);
for i = 1:num_frames
    % Extract single frame
    if ndims(frames) == 4
        if size(frames, 4) == num_frames
            img = frames(:, :, :, i);  % [H x W x 3 x N]
        else
            img = squeeze(frames(i, :, :, :));  % [N x H x W x 3]
        end
    else
        img = squeeze(frames(i, :, :, :));
    end

    % Convert to uint8 if needed
    if ~isa(img, 'uint8')
        if max(img(:)) <= 1
            img = uint8(img * 255);
        else
            img = uint8(img);
        end
    end

    % Find closest pose
    t = frame_times(i);
    [~, pidx] = min(abs(pose_times - t));
    if ndims(poses) == 2
        pose = poses(pidx, :);
    else
        pose = squeeze(poses(pidx, :));
    end

    % Save frame
    fname = sprintf('frame_%05d.png', i);
    imwrite(img, fullfile(frames_dir, fname));

    % Store metadata
    metadata(i).frame = i;
    metadata(i).time = t;
    metadata(i).x = pose(1);
    metadata(i).y = pose(2);
    metadata(i).heading = pose(3);
    metadata(i).filename = fname;

    if mod(i, 100) == 0
        fprintf('  Saved %d / %d frames\n', i, num_frames);
    end
end

%% Save metadata table
meta_table = struct2table(metadata);
writetable(meta_table, fullfile(output_dir, 'frame_metadata.csv'));

%% Save steering data if available
if exist('steering_data', 'var')
    if isa(steering_data, 'timeseries')
        steer_table = table(steering_data.Time, steering_data.Data, ...
            'VariableNames', {'time', 'steering'});
    else
        steer_table = table(steering_data.time, steering_data.signals.values, ...
            'VariableNames', {'time', 'steering'});
    end
    writetable(steer_table, fullfile(output_dir, 'steering_data.csv'));
    fprintf('Saved steering data (%d samples)\n', height(steer_table));
end

fprintf('\nDone! Extracted %d frames.\n', num_frames);
fprintf('Frames: %s\n', frames_dir);
fprintf('Metadata: %s\n', fullfile(output_dir, 'frame_metadata.csv'));
fprintf('\nNext steps:\n');
fprintf('  1. Open Image Labeler: imageLabeler\n');
fprintf('  2. Load frames from: %s\n', frames_dir);
fprintf('  3. Create labels: traffic_light, stop_sign, yield_sign, roundabout_sign\n');
fprintf('  4. Draw bounding boxes around objects\n');
fprintf('  5. Export labels as groundTruth for YOLO training\n');
