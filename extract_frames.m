%% extract_frames.m
% Run after data collection to save individual frames as images

save_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\raw_frames';
if ~exist(save_dir, 'dir'), mkdir(save_dir); end

% Load captured data
cam = load('camera_data.mat');
pose = load('pose_data.mat');

% Get field names (To File uses signal names)
cam_fields = fieldnames(cam);
pose_fields = fieldnames(pose);

cam_data = cam.(cam_fields{1});
pose_data = pose.(pose_fields{1});

fprintf('Captured %d frames\n', size(cam_data, 4));

for i = 1:size(cam_data, 4)
    frame = uint8(cam_data(:,:,:,i));
    fname = fullfile(save_dir, sprintf('frame_%05d.png', i));
    imwrite(frame, fname);
end

fprintf('Saved %d frames to %s\n', size(cam_data, 4), save_dir);

% Save pose data as CSV for reference
% [time, x, y, heading]
writematrix(pose_data', fullfile(save_dir, 'pose_log.csv'));
fprintf('Saved pose log\n');
