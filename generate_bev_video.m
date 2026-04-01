%% generate_bev_video.m
% Post-hoc BEV generation from saved camera_feed.avi
% Run AFTER extract_autonomous_data.m

fprintf('========================================\n');
fprintf(' Generating BEV Video (post-hoc)\n');
fprintf('========================================\n\n');

%% Find latest run directory
base_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data';
runs = dir(fullfile(base_dir, 'run*'));
runs = runs([runs.isdir]);
run_nums = zeros(length(runs), 1);
for i = 1:length(runs)
    tok = regexp(runs(i).name, 'run(\d+)', 'tokens');
    if ~isempty(tok), run_nums(i) = str2double(tok{1}{1}); end
end
[~, latest] = max(run_nums);
data_run_dir = fullfile(base_dir, runs(latest).name);
fprintf('Run directory: %s\n', data_run_dir);

%% Load BEV calibration
cal = load('C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code\bev_calibration.mat');
fprintf('BEV calibration loaded: %dx%d output\n', cal.BEV_H, cal.BEV_W);

%% Find camera video
cam_file = fullfile(data_run_dir, 'camera_feed.avi');
if ~isfile(cam_file)
    % Check root training_data folder
    cam_file = fullfile(base_dir, 'camera_feed.avi');
end
if ~isfile(cam_file)
    error('camera_feed.avi not found');
end
fprintf('Input: %s\n', cam_file);

vr = VideoReader(cam_file);

%% Setup output
output_file = fullfile(data_run_dir, 'bev_feed.avi');
vw = VideoWriter(output_file, 'Motion JPEG AVI');
vw.FrameRate = vr.FrameRate;
vw.Quality = 90;
open(vw);

%% Process frames
frame_count = 0;
fprintf('Processing frames...\n');
while hasFrame(vr)
    img = readFrame(vr);
    bev = imwarp(img, cal.tform_fwd, 'OutputView', imref2d([cal.BEV_H, cal.BEV_W]));
    writeVideo(vw, bev);
    frame_count = frame_count + 1;
    if mod(frame_count, 300) == 0
        fprintf('  %d frames processed\n', frame_count);
    end
end

close(vw);
fprintf('\nDone! %d frames processed\n', frame_count);
fprintf('Saved: %s\n', output_file);
