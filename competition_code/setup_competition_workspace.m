%% setup_competition_workspace.m
% Prepares the MATLAB workspace for running the competition Simulink model.
%
% Run this in MATLAB Instance 2 AFTER:
%   1. Instance 1: Setup_Real_Scenario.m is running (scene + traffic lights)
%   2. Instance 2: Setup_QCar2_Params.m has been run
%
% This script:
%   - Loads enhanced competition parameters
%   - Uses SDCS Path 7 (covers all roads including interior)
%   - Reorders path to start from Taxi Hub
%   - Overwrites path_x4/path_y4 for the Simulink pathPlanner
%   - Leaves QcarKF_X0 = [0;0;0] (LIDAR scan match handles localization)

fprintf('========================================\n');
fprintf(' Setting up Competition Workspace\n');
fprintf('========================================\n\n');

%% Add competition code to path
comp_root = 'C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code';
addpath(genpath(comp_root));

% Add YOLOv8 model files
run_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\run12';
addpath(run_dir);

%% Load enhanced parameters
fprintf('Loading enhanced competition parameters...\n');
run(fullfile(comp_root, 'setup', 'Setup_Params_Enhanced.m'));

%% Load hand-drawn mission path (spline-smoothed, 5cm spacing)
fprintf('\nLoading hand-drawn mission path...\n');
manual_mat = fullfile(comp_root, 'manual_path.mat');
fprintf('  Looking for: %s\n', manual_mat);
fprintf('  Exists: %d\n', isfile(manual_mat));
if isfile(manual_mat)
    % Load raw data (5mm spacing from manual_waypoint_editor)
    data = load(manual_mat, 'path_x4', 'path_y4', 'idx_pickup', 'idx_dropoff');
    fprintf('  Loaded manual_path.mat: %d raw points\n', length(data.path_x4));

    % Force column vectors
    raw_x = double(data.path_x4(:));
    raw_y = double(data.path_y4(:));
    raw_pickup  = double(data.idx_pickup);
    raw_dropoff = double(data.idx_dropoff);

    % Resample to 5cm spacing (pathPlanner lookahead is calibrated for this)
    % Take every 10th point (5mm * 10 = 5cm), always keep first and last
    step = 10;
    idx_all = [1:step:length(raw_x), length(raw_x)];
    idx_all = unique(idx_all);  % remove duplicate if last is already included
    path_x4 = raw_x(idx_all);
    path_y4 = raw_y(idx_all);

    % Recalculate pickup/dropoff indices in the resampled path
    [~, idx_pickup]  = min(abs(idx_all - raw_pickup));
    [~, idx_dropoff] = min(abs(idx_all - raw_dropoff));
    n_pts = length(path_x4);
    fprintf('  Resampled: %d points at ~5cm spacing (WORLD frame)\n', n_pts);
else
    % Fallback to SDCS Path 7 if manual path not found
    fprintf('  manual_path.mat not found — falling back to SDCS Path 7\n');
    sdcs = load('SDCS_Paths_7.mat', 'path_x7', 'path_y7');
    raw_x = sdcs.path_x7;
    raw_y = sdcs.path_y7;
    d_hub  = sqrt((raw_x - TAXI_HUB_POS(1)).^2 + (raw_y - TAXI_HUB_POS(2)).^2);
    d_pick = sqrt((raw_x - PICKUP_POS(1)).^2  + (raw_y - PICKUP_POS(2)).^2);
    d_drop = sqrt((raw_x - DROPOFF_POS(1)).^2 + (raw_y - DROPOFF_POS(2)).^2);
    [~, i_hub]  = min(d_hub);
    [~, i_pick] = min(d_pick);
    [~, i_drop] = min(d_drop);
    leg1_x = raw_x(i_hub:i_pick);   leg1_y = raw_y(i_hub:i_pick);
    leg2_x = raw_x(i_pick:i_drop);  leg2_y = raw_y(i_pick:i_drop);
    leg3_x = [raw_x(i_drop:end); raw_x(1:i_hub)];
    leg3_y = [raw_y(i_drop:end); raw_y(1:i_hub)];
    path_x4 = [leg1_x; leg2_x; leg3_x];
    path_y4 = [leg1_y; leg2_y; leg3_y];
    idx_pickup  = length(leg1_x);
    idx_dropoff = length(leg1_x) + length(leg2_x);
    n_pts = length(path_x4);
    fprintf('  SDCS Path 7 loaded: %d points\n', n_pts);
end

fprintf('  x range: [%.3f, %.3f]\n', min(path_x4), max(path_x4));
fprintf('  y range: [%.3f, %.3f]\n', min(path_y4), max(path_y4));

%% Compute curvature-based velocity profile
fprintf('\nComputing curvature-based velocity profile...\n');
V_MAX = 0.4;   % cruise speed (m/s)
V_MIN = 0.15;  % minimum curve speed (m/s)
A_MAX = 0.5;   % max accel/decel (m/s^2)
[v_profile, path_curvature] = compute_velocity_profile(path_x4, path_y4, V_MAX, V_MIN, A_MAX);

%% EKF initial state: leave at default [0;0;0]
fprintf('\nQcarKF_X0: [0, 0, 0] (default - LIDAR handles localization)\n');

%% Store mission data
mission_data.idx_pickup  = idx_pickup;
mission_data.idx_dropoff = idx_dropoff;
mission_data.n_total     = n_pts;
mission_data.pickup_pos  = PICKUP_POS;
mission_data.dropoff_pos = DROPOFF_POS;
mission_data.hub_pos     = TAXI_HUB_POS;

%% Plot the mission route
figure('Name', 'Competition Mission Route (Path 7)', 'NumberTitle', 'off');
hold on;

% Color the three legs differently
leg1_idx = 1:idx_pickup;
leg2_idx = idx_pickup:idx_dropoff;
leg3_idx = idx_dropoff:n_pts;

plot(path_x4(leg1_idx), path_y4(leg1_idx), 'g-', 'LineWidth', 2.5, 'DisplayName', 'Leg 1: Hub->Pickup');
plot(path_x4(leg2_idx), path_y4(leg2_idx), 'b-', 'LineWidth', 2.5, 'DisplayName', 'Leg 2: Pickup->Dropoff');
plot(path_x4(leg3_idx), path_y4(leg3_idx), 'm-', 'LineWidth', 2.5, 'DisplayName', 'Leg 3: Dropoff->Hub');

% Overlay velocity profile as color (red = slow, green = fast)
scatter(path_x4, path_y4, 5, v_profile, 'filled', 'HandleVisibility', 'off');
colormap(gca, flipud(autumn));
cb = colorbar; ylabel(cb, 'Speed (m/s)');
caxis([V_MIN V_MAX]);

% Key locations
plot(TAXI_HUB_POS(1), TAXI_HUB_POS(2), 'mp', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Taxi Hub');
plot(PICKUP_POS(1), PICKUP_POS(2), 'g^', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Pickup');
plot(DROPOFF_POS(1), DROPOFF_POS(2), 'rs', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Dropoff');

% Path start/end markers
plot(path_x4(1), path_y4(1), 'k>', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', 'Start');
plot(path_x4(end), path_y4(end), 'k<', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', 'End');

% Direction arrows
arrow_step = max(1, round(n_pts / 40));
for i = 1:arrow_step:n_pts-1
    dx = path_x4(i+1) - path_x4(i);
    dy = path_y4(i+1) - path_y4(i);
    quiver(path_x4(i), path_y4(i), dx*5, dy*5, 0, 'k', ...
        'LineWidth', 0.5, 'MaxHeadSize', 3, 'HandleVisibility', 'off');
end

legend('Location', 'eastoutside');
xlabel('X (m) - World Frame');
ylabel('Y (m) - World Frame');
title('Mission Route: Hub -> Pickup -> Dropoff -> Hub');
axis equal; grid on;
hold off;

fprintf('\n========================================\n');
fprintf(' Workspace ready!\n');
fprintf(' path_x4/path_y4 = Manual path (%d pts, WORLD frame)\n', n_pts);
fprintf(' Route: Hub(1) -> Pickup(%d) -> Dropoff(%d) -> Hub(%d)\n', ...
    idx_pickup, idx_dropoff, n_pts);
fprintf(' v_profile = Curvature-based velocity profile (%.2f - %.2f m/s)\n', min(v_profile), max(v_profile));
fprintf(' Monitor & Tune: VIRTUAL_self_driving_stack_v2.slx\n');
fprintf('========================================\n');


%% ===== Helper: pchip spline smoothing =====
function smooth = smooth_path_for_pp(waypoints, spacing)
    n = size(waypoints, 1);
    if n < 2, smooth = waypoints; return; end

    % Remove duplicate consecutive points
    keep = true(n, 1);
    for i = 2:n
        if norm(waypoints(i,:) - waypoints(i-1,:)) < 1e-6
            keep(i) = false;
        end
    end
    waypoints = waypoints(keep, :);
    n = size(waypoints, 1);
    if n < 3
        smooth = waypoints;
        return;
    end

    % Cumulative arc length
    cum_dist = zeros(n, 1);
    for i = 2:n
        cum_dist(i) = cum_dist(i-1) + norm(waypoints(i,:) - waypoints(i-1,:));
    end
    total_len = cum_dist(end);
    if total_len < 1e-6, smooth = waypoints; return; end

    % Resample with pchip spline
    n_out = max(3, round(total_len / spacing) + 1);
    t_out = linspace(0, total_len, n_out)';
    x_smooth = pchip(cum_dist, waypoints(:,1), t_out);
    y_smooth = pchip(cum_dist, waypoints(:,2), t_out);
    smooth = [x_smooth, y_smooth];
    smooth(1, :)   = waypoints(1, :);
    smooth(end, :) = waypoints(end, :);
end
