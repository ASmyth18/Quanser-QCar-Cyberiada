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

%% Load enhanced parameters
fprintf('Loading enhanced competition parameters...\n');
run(fullfile(comp_root, 'setup', 'Setup_Params_Enhanced.m'));

%% Load SDCS Path 7 and extract one-way mission path
fprintf('\nExtracting one-way mission path from SDCS Path 7...\n');
sdcs = load('SDCS_Paths_7.mat', 'path_x7', 'path_y7');
raw_x = sdcs.path_x7;
raw_y = sdcs.path_y7;
n_raw = length(raw_x);
fprintf('  Path 7 loaded: %d points\n', n_raw);

%% Find key location indices on Path 7
d_hub  = sqrt((raw_x - TAXI_HUB_POS(1)).^2 + (raw_y - TAXI_HUB_POS(2)).^2);
d_pick = sqrt((raw_x - PICKUP_POS(1)).^2  + (raw_y - PICKUP_POS(2)).^2);
d_drop = sqrt((raw_x - DROPOFF_POS(1)).^2 + (raw_y - DROPOFF_POS(2)).^2);
[hub_gap, i_hub]   = min(d_hub);
[pick_gap, i_pick] = min(d_pick);
[drop_gap, i_drop] = min(d_drop);

fprintf('  Hub:     idx %d (gap: %.3f m)\n', i_hub, hub_gap);
fprintf('  Pickup:  idx %d (gap: %.3f m)\n', i_pick, pick_gap);
fprintf('  Dropoff: idx %d (gap: %.3f m)\n', i_drop, drop_gap);

%% Extract 3 legs (one-way, no self-crossing)
% Path 7 order: Hub(41) -> Pickup(1597) -> Dropoff(2049) -> wraps to Hub
% Leg 1: Hub -> Pickup
leg1_x = raw_x(i_hub:i_pick);
leg1_y = raw_y(i_hub:i_pick);
% Leg 2: Pickup -> Dropoff
leg2_x = raw_x(i_pick:i_drop);
leg2_y = raw_y(i_pick:i_drop);
% Leg 3: Dropoff -> Hub (wrap around end of path)
leg3_x = [raw_x(i_drop:end); raw_x(1:i_hub)];
leg3_y = [raw_y(i_drop:end); raw_y(1:i_hub)];

fprintf('  Leg 1 (Hub->Pickup):    %d pts\n', length(leg1_x));
fprintf('  Leg 2 (Pickup->Dropoff): %d pts\n', length(leg2_x));
fprintf('  Leg 3 (Dropoff->Hub):   %d pts\n', length(leg3_x));

%% Concatenate into single one-way mission path
path_x4 = [leg1_x; leg2_x; leg3_x];
path_y4 = [leg1_y; leg2_y; leg3_y];
n_pts = length(path_x4);

% Recalculate key indices on the mission path
idx_pickup  = length(leg1_x);
idx_dropoff = length(leg1_x) + length(leg2_x);

fprintf('\npath_x4/path_y4 overwritten: %d points (SDCS Path 7, WORLD frame)\n', n_pts);
fprintf('  x range: [%.3f, %.3f]\n', min(path_x4), max(path_x4));
fprintf('  y range: [%.3f, %.3f]\n', min(path_y4), max(path_y4));

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
fprintf(' path_x4/path_y4 = SDCS Path 7 (%d pts, WORLD frame)\n', n_pts);
fprintf(' Route: Hub(1) -> Pickup(%d) -> Dropoff(%d) -> Hub(%d)\n', ...
    idx_pickup, idx_dropoff, n_pts);
fprintf(' Monitor & Tune: VIRTUAL_self_driving_stack_v2.slx\n');
fprintf('========================================\n');
