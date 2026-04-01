%% generate_ml_feed.m
% Post-hoc ML detection visualization from saved camera_feed.avi
% Runs YOLO lights + signs on each frame and draws bounding boxes.
% Run AFTER extract_autonomous_data.m

fprintf('========================================\n');
fprintf(' Generating ML Detection Feed (post-hoc)\n');
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

%% Load models
fprintf('Loading models...\n');
run_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\run12';
addpath(run_dir);

% MobileNetV2 light classifier
light_cls = load(fullfile(run_dir, 'light_classifier_dlnet.mat'));
fn = fieldnames(light_cls);
light_net = light_cls.(fn{1});
fprintf('  Light classifier loaded\n');

% YOLO signs detector
signs_data = load(fullfile(run_dir, 'yolo_signs_dlnet.mat'));
fn = fieldnames(signs_data);
signs_net = signs_data.(fn{1});
fprintf('  Signs detector loaded\n');

%% Find camera video
cam_file = fullfile(data_run_dir, 'camera_feed.avi');
if ~isfile(cam_file)
    cam_file = fullfile(base_dir, 'camera_feed.avi');
end
if ~isfile(cam_file)
    error('camera_feed.avi not found');
end
fprintf('Input: %s\n', cam_file);

vr = VideoReader(cam_file);

%% Setup output
output_file = fullfile(data_run_dir, 'ml_feed.avi');
vw = VideoWriter(output_file, 'Motion JPEG AVI');
vw.FrameRate = vr.FrameRate;
vw.Quality = 90;
open(vw);

%% Color maps
light_names = {'none', 'RED', 'YELLOW', 'GREEN'};
light_colors = [128 128 128; 255 0 0; 255 255 0; 0 255 0];
sign_names = {'STOP', 'YIELD', 'ROUNDABOUT'};
sign_colors = [255 0 0; 255 165 0; 0 100 255];

CONF_THRESH = 0.30;

%% Process frames
frame_count = 0;
fprintf('Processing frames...\n');
while hasFrame(vr)
    img = readFrame(vr);
    annotated = img;
    frame_count = frame_count + 1;

    % --- Traffic light classifier (every frame) ---
    upper_crop = img(1:288, :, :);
    img_cls = single(imresize(upper_crop, [224, 224])) / 255.0;
    img_cls(:,:,1) = (img_cls(:,:,1) - 0.485) / 0.229;
    img_cls(:,:,2) = (img_cls(:,:,2) - 0.456) / 0.224;
    img_cls(:,:,3) = (img_cls(:,:,3) - 0.406) / 0.225;
    dl_cls = dlarray(single(img_cls), 'SSCB');
    dl_out = predict(light_net, dl_cls);
    scores = extractdata(dl_out);
    scores = scores(:);
    [best_score, best_idx] = max(scores);
    light_class = best_idx;  % 1=none, 2=red, 3=yellow, 4=green

    % Light classification: no visual overlay (signs-only display)

    % --- YOLO signs (every 3rd frame for speed) ---
    if mod(frame_count, 3) == 0
        img_yolo = single(imresize(img, [640, 640])) / 255.0;
        dl_in = dlarray(img_yolo, 'SSCB');
        dl_out_s = predict(signs_net, dl_in);
        raw = extractdata(dl_out_s);
        raw = squeeze(raw);
        if size(raw, 1) > size(raw, 2)
            raw = raw';
        end

        % Scale factors (640 -> original resolution)
        sx = 640.0 / 640.0;
        sy = 480.0 / 640.0;

        n_preds = size(raw, 2);
        for i = 1:n_preds
            cx_det = raw(1, i) * sx;
            cy_det = raw(2, i) * sy;
            w_det  = raw(3, i) * sx;
            h_det  = raw(4, i) * sy;

            % Class scores
            c1 = raw(5, i); c2 = raw(6, i); c3 = raw(7, i);
            [mc, bc] = max([c1, c2, c3]);

            if mc > CONF_THRESH
                % Bounding box [x1, y1, w, h]
                x1 = max(1, round(cx_det - w_det/2));
                y1 = max(1, round(cy_det - h_det/2));
                bw = round(w_det);
                bh = round(h_det);

                sc = sign_colors(bc, :);
                annotated = insertShape(annotated, 'Rectangle', ...
                    [x1, y1, bw, bh], ...
                    'Color', sc, 'LineWidth', 2);
                annotated = insertText(annotated, [x1, max(1, y1-18)], ...
                    sprintf('%s %.0f%%', sign_names{bc}, mc*100), ...
                    'FontSize', 12, 'TextColor', 'white', ...
                    'BoxColor', sc, 'BoxOpacity', 0.6);
            end
        end
    end

    writeVideo(vw, annotated);
    if mod(frame_count, 300) == 0
        fprintf('  %d frames processed\n', frame_count);
    end
end

close(vw);
fprintf('\nDone! %d frames processed\n', frame_count);
fprintf('Saved: %s\n', output_file);
