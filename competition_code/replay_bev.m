%% replay_bev.m
% Creates an animated Bird's Eye View replay from logged run data.
% Run AFTER extract_autonomous_data.m (needs pose_log.mat in run dir).
%
% Produces: bev_replay.avi in the run directory

fprintf('========================================\n');
fprintf(' BEV Replay Generator\n');
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

%% Load pose data
pose_file = fullfile(data_run_dir, 'pose_log.mat');
if ~isfile(pose_file)
    error('pose_log.mat not found in %s', data_run_dir);
end
d = load(pose_file);
fn = fieldnames(d);
val = d.(fn{1});
if isnumeric(val) && size(val, 1) >= 2
    pose_time = val(1, :)';
    pose_data = val(2:end, :)';  % [N x 3]: x, y, heading
else
    error('Unexpected pose_log format');
end
fprintf('Pose: %d samples, %.1f sec\n', length(pose_time), pose_time(end)-pose_time(1));

%% Load light data (optional)
light_time = []; light_data = [];
light_file = fullfile(data_run_dir, 'light_log.mat');
if isfile(light_file)
    d = load(light_file);
    fn = fieldnames(d);
    val = d.(fn{1});
    if isnumeric(val) && size(val, 1) >= 2
        light_time = val(1, :)';
        light_data = val(2, :)';
    end
    fprintf('Light: %d samples\n', length(light_time));
end

%% Load speed data (optional)
speed_time = []; speed_data = [];
speed_file = fullfile(data_run_dir, 'speed_log.mat');
if isfile(speed_file)
    d = load(speed_file);
    fn = fieldnames(d);
    val = d.(fn{1});
    if isnumeric(val) && size(val, 1) >= 2
        speed_time = val(1, :)';
        speed_data = val(2, :)';
    end
    fprintf('Speed: %d samples\n', length(speed_time));
end

%% Load path data
comp_root = 'C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code';
path_mat = fullfile(comp_root, 'manual_path.mat');
if isfile(path_mat)
    pd = load(path_mat, 'path_x4', 'path_y4');
    map_x = pd.path_x4;
    map_y = pd.path_y4;
else
    map_x = []; map_y = [];
end

%% Key locations
HUB     = [-1.205, -0.83];
PICKUP  = [0.125, 4.395];
DROPOFF = [-0.905, 0.800];
LIGHTS  = [0.6, 1.55; -0.6, 1.28; -0.37, 0.3; 0.75, 0.48];

%% Create figure
fig = figure('Name', 'BEV Replay', 'NumberTitle', 'off', ...
    'Position', [100, 100, 800, 800], 'Color', [0.15 0.15 0.15]);
ax = axes('Parent', fig);
hold(ax, 'on');
axis(ax, 'equal');
set(ax, 'Color', [0.2 0.2 0.2], 'XColor', 'w', 'YColor', 'w');
xlabel(ax, 'X (m)', 'Color', 'w');
ylabel(ax, 'Y (m)', 'Color', 'w');
xlim(ax, [-2.5, 3.0]);
ylim(ax, [-2.0, 5.5]);
grid(ax, 'on');
set(ax, 'GridColor', [0.4 0.4 0.4]);

% Draw path
if ~isempty(map_x)
    plot(ax, map_x, map_y, '-', 'Color', [0.4 0.4 0.4], 'LineWidth', 1.5);
end

% Key locations
plot(ax, HUB(1), HUB(2), 'p', 'Color', [1 0 1], 'MarkerSize', 18, 'LineWidth', 2);
plot(ax, PICKUP(1), PICKUP(2), '^', 'Color', [0 1 0], 'MarkerSize', 15, 'LineWidth', 2);
plot(ax, DROPOFF(1), DROPOFF(2), 's', 'Color', [1 0.5 0], 'MarkerSize', 15, 'LineWidth', 2);

% Traffic lights
for k = 1:4
    plot(ax, LIGHTS(k,1), LIGHTS(k,2), 'o', 'Color', [1 1 0], 'MarkerSize', 8, 'LineWidth', 2);
end

% Trail (history)
trail = plot(ax, NaN, NaN, '-', 'Color', [0.2 0.8 1.0], 'LineWidth', 2);

% Car marker
car_marker = plot(ax, NaN, NaN, 'o', 'Color', [0 1 0], ...
    'MarkerSize', 12, 'LineWidth', 3, 'MarkerFaceColor', [0 0.8 0]);

% Heading arrow
car_arrow = quiver(ax, 0, 0, 0, 0, 0, 'Color', [1 1 1], 'LineWidth', 2, ...
    'MaxHeadSize', 2, 'AutoScale', 'off');

% Info text
info_text = text(ax, -2.3, 5.2, '', 'Color', 'w', 'FontSize', 12, ...
    'FontWeight', 'bold', 'FontName', 'Consolas');
light_text = text(ax, -2.3, 4.8, '', 'Color', 'w', 'FontSize', 11, ...
    'FontName', 'Consolas');

title_h = title(ax, 'BEV Replay', 'Color', 'w', 'FontSize', 14);

%% Setup video writer
output_avi = fullfile(data_run_dir, 'bev_replay.avi');
vw = VideoWriter(output_avi, 'Motion JPEG AVI');
vw.FrameRate = 30;
vw.Quality = 90;
open(vw);

%% Animate
FPS = 30;
dt = 1 / FPS;
t_start = pose_time(1);
t_end = pose_time(end);
t_vec = t_start:dt:t_end;

trail_x = [];
trail_y = [];
trail_skip = 3;  % only add trail point every N frames

fprintf('Rendering %d frames...\n', length(t_vec));
for fi = 1:length(t_vec)
    t = t_vec(fi);

    % Interpolate pose
    idx = find(pose_time <= t, 1, 'last');
    if isempty(idx), idx = 1; end
    cx = pose_data(idx, 1);
    cy = pose_data(idx, 2);
    ch = pose_data(idx, 3);

    % Update trail
    if mod(fi, trail_skip) == 0
        trail_x(end+1) = cx; %#ok<AGROW>
        trail_y(end+1) = cy; %#ok<AGROW>
    end
    set(trail, 'XData', trail_x, 'YData', trail_y);

    % Update car
    set(car_marker, 'XData', cx, 'YData', cy);
    set(car_arrow, 'XData', cx, 'YData', cy, ...
        'UData', 0.3*cos(ch), 'VData', 0.3*sin(ch));

    % Speed info
    spd = 0;
    if ~isempty(speed_time)
        sidx = find(speed_time <= t, 1, 'last');
        if ~isempty(sidx), spd = abs(speed_data(sidx)); end
    end

    % Light info
    light_str = 'Light: --';
    light_col = [1 1 1];
    if ~isempty(light_time)
        lidx = find(light_time <= t, 1, 'last');
        if ~isempty(lidx)
            lv = round(light_data(lidx));
            if lv == 1
                light_str = 'Light: RED';    light_col = [1 0 0];
            elseif lv == 2
                light_str = 'Light: YELLOW'; light_col = [1 1 0];
            elseif lv == 3
                light_str = 'Light: GREEN';  light_col = [0 1 0];
            else
                light_str = 'Light: none';   light_col = [0.6 0.6 0.6];
            end
        end
    end

    % Update text
    elapsed = t - t_start;
    set(info_text, 'String', sprintf('t=%.1fs  v=%.2f m/s  (%.1f,%.1f)', ...
        elapsed, spd, cx, cy));
    set(light_text, 'String', light_str, 'Color', light_col);
    set(title_h, 'String', sprintf('BEV Replay — %.1fs / %.1fs', elapsed, t_end-t_start));

    % Capture frame
    drawnow limitrate;
    frame = getframe(fig);
    writeVideo(vw, frame);

    if mod(fi, 300) == 0
        fprintf('  Frame %d / %d (%.0f%%)\n', fi, length(t_vec), 100*fi/length(t_vec));
    end
end

close(vw);
fprintf('\nSaved: %s\n', output_avi);
fprintf('Done!\n');
