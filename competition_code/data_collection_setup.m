%% data_collection_setup.m
% Run this AFTER Setup_QCar2_Params and setup_competition_workspace
% but BEFORE Monitor & Tune

% Create output folder
save_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\raw_frames';
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

% Frame counter in base workspace
assignin('base', 'frame_count', 0);
assignin('base', 'save_dir', save_dir);
assignin('base', 'capture_active', true);

fprintf('Data collection setup complete.\n');
fprintf('Frames will be saved to: %s\n', save_dir);
fprintf('Start Monitor & Tune to begin capturing.\n');


v = VideoReader('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\camera_feed.avi');
i = 0;
while hasFrame(v)
    i = i + 1;
    frame = readFrame(v);
    imwrite(frame, sprintf('training_data\\frames\\frame_%05d.png', i));
end
