%% extract_autonomous_data.m
% Run AFTER stopping the self-driving model to extract and organize
% all logged sensor data for training.
%
% To File blocks write .mat files directly to the run directory during
% the simulation — most data is already on disk when you stop.
% This script loads those files, extracts camera frames, and builds
% the frame_metadata.csv with synced pose timestamps.

fprintf('========================================\n');
fprintf(' Extracting Autonomous Run Data\n');
fprintf('========================================\n\n');

%% Determine output directory — always create a NEW run folder
base_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data';
runs = dir(fullfile(base_dir, 'run*'));
runs = runs([runs.isdir]);
max_num = 0;
for i = 1:length(runs)
    tok = regexp(runs(i).name, 'run(\d+)', 'tokens');
    if ~isempty(tok), max_num = max(max_num, str2double(tok{1}{1})); end
end
next_num = max_num + 1;
data_run_dir = fullfile(base_dir, sprintf('run%d', next_num));
mkdir(data_run_dir);
fprintf('Saving to: %s\n\n', data_run_dir);

frames_dir = fullfile(data_run_dir, 'frames');
if ~exist(frames_dir, 'dir'), mkdir(frames_dir); end

%% ===== 1. CHECK TO FILE OUTPUTS =====
% To File blocks write .mat files with array format: row 1 = time, rows 2+ = data
% List expected files and check which exist
to_file_signals = {
    'pose_log.mat',      'pose',       'Pose [x,y,heading]'
    'speed_log.mat',     'speed',      'Speed (m/s)'
    'steering_log.mat',  'steering',   'Steering (rad)'
    'motor_log.mat',     'motor',      'Motor (%)'
    'path_xy_log.mat',   'path_xy',    'Path XY (m,m)'
    'desired_xy_log.mat','desired_xy', 'Desired XY (m,m)'
    'dist_path_log.mat', 'dist_path',  'Cross-track error (m)'
    'light_log.mat',     'light',      'Traffic light'
    'stop_sign_log.mat', 'stop_sign',  'Stop sign'
    'lane_off_log.mat',  'lane_off',   'Lane offset'
    'lane_det_log.mat',  'lane_det',   'Lane detected'
};

pose_time = []; pose_data = [];

fprintf('--- To File Logged Data ---\n');
for i = 1:size(to_file_signals, 1)
    fname = to_file_signals{i, 1};
    varname = to_file_signals{i, 2};
    desc = to_file_signals{i, 3};
    fpath = fullfile(data_run_dir, fname);

    if isfile(fpath)
        d = load(fpath);
        fnames = fieldnames(d);
        if ~isempty(fnames)
            val = d.(fnames{1});
            % To File Array format: row 1 = time, rows 2+ = signal data (all double)
            if isnumeric(val) && size(val, 1) >= 2
                n_samples = size(val, 2);
                duration = val(1, end) - val(1, 1);
                fprintf('  [OK] %-20s %d samples, %.1f sec — %s\n', fname, n_samples, duration, desc);
                if strcmp(varname, 'pose')
                    pose_time = val(1, :)';
                    pose_data = val(2:end, :)';  % [N x 3]
                end
            elseif isa(val, 'timeseries')
                n_samples = length(val.Time);
                duration = val.Time(end) - val.Time(1);
                fprintf('  [OK] %-20s %d samples, %.1f sec — %s\n', fname, n_samples, duration, desc);
                if strcmp(varname, 'pose')
                    pose_time = val.Time;
                    pose_data = val.Data;
                end
            else
                fprintf('  [??] %-20s unknown format: %s\n', fname, class(val));
            end
        else
            fprintf('  [??] %-20s file exists but empty\n', fname);
        end
    else
        fprintf('  [--] %-20s not found\n', fname);
    end
end

%% ===== 2. LIDAR DATA (To Workspace — buffer limited) =====
fprintf('\n--- LIDAR Data (To Workspace) ---\n');
lidar_save = struct();
lidar_found = false;
lidar_vars = {'lidar_dist_log', 'lidar_head_log'};
for i = 1:length(lidar_vars)
    vname = lidar_vars{i};
    if evalin('base', sprintf('exist(''%s'',''var'')', vname))
        lidar_save.(vname) = evalin('base', vname);
        fprintf('  Found: %s\n', vname);
        lidar_found = true;
    else
        fprintf('  NOT FOUND: %s (buffer may have been too small)\n', vname);
    end
end
if lidar_found
    save(fullfile(data_run_dir, 'lidar_log.mat'), '-struct', 'lidar_save');
    fprintf('  Saved lidar_log.mat\n');
end

%% ===== 3. CAMERA FRAMES =====
fprintf('\n--- Camera Frames ---\n');
frame_count = 0;
frame_times = [];

avi_candidates = {
    fullfile('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data', 'camera_feed.avi'), ...
    fullfile(data_run_dir, 'camera_feed.avi')
};
for c = 1:length(avi_candidates)
    if isfile(avi_candidates{c})
        fprintf('  Extracting from: %s\n', avi_candidates{c});
        v = VideoReader(avi_candidates{c});
        frame_times = [];
        while hasFrame(v)
            frame_count = frame_count + 1;
            img = readFrame(v);
            imwrite(img, fullfile(frames_dir, sprintf('frame_%05d.png', frame_count)));
            frame_times(frame_count) = v.CurrentTime;
        end
        % Copy to run dir
        if ~strcmp(avi_candidates{c}, fullfile(data_run_dir, 'camera_feed.avi'))
            copyfile(avi_candidates{c}, fullfile(data_run_dir, 'camera_feed.avi'));
        end
        fprintf('  Extracted %d frames\n', frame_count);
        delete(v);  % release file handle
        clear v;
        break;
    end
end

if frame_count == 0
    fprintf('  No camera_feed.avi found.\n');
end

%% ===== 4. FRAME METADATA CSV =====
if frame_count > 0 && ~isempty(pose_time)
    fprintf('\n--- Frame Metadata ---\n');
    fid = fopen(fullfile(data_run_dir, 'frame_metadata.csv'), 'w');
    fprintf(fid, 'frame,time,x,y,heading,filename\n');
    for i = 1:frame_count
        t = frame_times(i);
        [~, pidx] = min(abs(pose_time - t));
        p = pose_data(pidx, :);
        fname = sprintf('frame_%05d.png', i);
        fprintf(fid, '%d,%.4f,%.4f,%.4f,%.4f,%s\n', i, t, p(1), p(2), p(3), fname);
    end
    fclose(fid);
    fprintf('  Saved frame_metadata.csv (%d entries)\n', frame_count);
end

%% ===== 5. RUN SUMMARY =====
has_pose = ~isempty(pose_time);
has_speed = isfile(fullfile(data_run_dir, 'speed_log.mat'));
has_control = isfile(fullfile(data_run_dir, 'steering_log.mat'));
has_percep = isfile(fullfile(data_run_dir, 'light_log.mat'));
has_path = isfile(fullfile(data_run_dir, 'path_xy_log.mat'));

fid = fopen(fullfile(data_run_dir, 'run_summary.txt'), 'w');
fprintf(fid, 'Autonomous Data Collection Run\n');
fprintf(fid, 'Date: %s\n', datestr(now));
fprintf(fid, 'Directory: %s\n\n', data_run_dir);
fprintf(fid, 'Pose data:       %s\n', yn(has_pose));
fprintf(fid, 'Speed data:      %s\n', yn(has_speed));
fprintf(fid, 'Control data:    %s\n', yn(has_control));
fprintf(fid, 'LIDAR data:      %s\n', yn(lidar_found));
fprintf(fid, 'Perception data: %s\n', yn(has_percep));
fprintf(fid, 'Path data:       %s\n', yn(has_path));
fprintf(fid, 'Camera frames:   %d\n', frame_count);
if has_pose
    fprintf(fid, 'Duration:        %.1f sec\n', pose_time(end)-pose_time(1));
end
fclose(fid);

%% ===== SUMMARY =====
fprintf('\n========================================\n');
fprintf(' Extraction Complete\n');
fprintf('========================================\n');
fprintf('  Directory: %s\n', data_run_dir);
fprintf('  Pose:        %s\n', yn(has_pose));
fprintf('  Speed:       %s\n', yn(has_speed));
fprintf('  Control:     %s\n', yn(has_control));
fprintf('  LIDAR:       %s\n', yn(lidar_found));
fprintf('  Perception:  %s\n', yn(has_percep));
fprintf('  Path:        %s\n', yn(has_path));
fprintf('  Frames:      %d\n', frame_count);
if has_pose
    fprintf('  Duration:    %.1f sec\n', pose_time(end)-pose_time(1));
end

if has_pose
    fprintf('\n  Trajectory plot...\n');
    figure('Name', 'Run Trajectory', 'NumberTitle', 'off');
    plot(pose_data(:,1), pose_data(:,2), 'b-', 'LineWidth', 1.5);
    hold on; axis equal; grid on;
    plot(pose_data(1,1), pose_data(1,2), 'go', 'MarkerSize', 12, 'LineWidth', 2);
    plot(pose_data(end,1), pose_data(end,2), 'rx', 'MarkerSize', 12, 'LineWidth', 2);
    legend('Trajectory', 'Start', 'End');
    xlabel('X (m)'); ylabel('Y (m)');
    title(sprintf('Run Trajectory (%.1f sec)', pose_time(end)-pose_time(1)));
end

fprintf('\n  For next run: re-run add_data_logging, then Monitor & Tune again.\n');

function s = yn(val)
    if val, s = 'YES'; else, s = 'NO'; end
end
