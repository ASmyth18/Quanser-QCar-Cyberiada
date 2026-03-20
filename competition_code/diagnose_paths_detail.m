%% diagnose_paths_detail.m
% Detailed inspection of SDCS paths and our extracted segments.
% Shows which path and direction was chosen, and overlays on LIDAR.

fprintf('=== DETAILED PATH INSPECTION ===\n\n');

sdcs_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources';
data = load(fullfile(sdcs_dir, 'SDCS_Paths_7.mat'));

% Key locations in WORLD coordinates
hub_w     = [-1.205, -0.83];
pickup_w  = [0.125, 4.395];
dropoff_w = [-0.905, 0.800];
cal_origin = [0, 2.0];

% Load all 7 paths
path_names  = {'path_x', 'path_x2', 'path_x3', 'path_x4', 'path_x5', 'path_x6', 'path_x7'};
path_ynames = {'path_y', 'path_y2', 'path_y3', 'path_y4', 'path_y5', 'path_y6', 'path_y7'};

paths = {};
for i = 1:length(path_names)
    if isfield(data, path_names{i}) && isfield(data, path_ynames{i})
        paths{i} = [data.(path_names{i}), data.(path_ynames{i})];
    else
        paths{i} = [];
    end
end

%% Plot ALL paths in EKF frame with key locations
figure('Name', 'All 7 SDCS Paths (EKF)', 'NumberTitle', 'off');
hold on;
colors = lines(7);
for i = 1:length(paths)
    if ~isempty(paths{i})
        p = paths{i} - cal_origin;
        plot(p(:,1), p(:,2), '-', 'LineWidth', 1.5, 'Color', colors(i,:), ...
            'DisplayName', sprintf('Path %d (%d pts)', i, size(p,1)));
        % Mark start with a number
        text(p(1,1), p(1,2), sprintf('%d', i), 'FontSize', 12, 'FontWeight', 'bold', 'Color', colors(i,:));
    end
end

% Plot LIDAR scan
if exist('range_qcar2', 'var') && exist('angles_qcar2', 'var')
    [lx, ly] = pol2cart(-angles_qcar2 - qcar2_lidar_to_map_rotation, range_qcar2);
    plot(lx, ly, 'k.', 'MarkerSize', 1, 'DisplayName', 'LIDAR walls');
end

% Key locations in EKF
plot(hub_w(1)-cal_origin(1), hub_w(2)-cal_origin(2), 'mp', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Hub');
plot(pickup_w(1)-cal_origin(1), pickup_w(2)-cal_origin(2), 'g^', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Pickup');
plot(dropoff_w(1)-cal_origin(1), dropoff_w(2)-cal_origin(2), 'rs', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Dropoff');

legend('Location', 'best');
title('All 7 SDCS Paths + Key Locations (EKF Frame)');
xlabel('X (m)'); ylabel('Y (m)');
axis equal; grid on;
hold off;

%% For each path, show distance from hub, pickup, dropoff
fprintf('--- DISTANCE FROM KEY LOCATIONS TO EACH PATH ---\n');
for i = 1:length(paths)
    if isempty(paths{i}), continue; end
    p = paths{i};  % world coords

    d_hub = min(sqrt((p(:,1)-hub_w(1)).^2 + (p(:,2)-hub_w(2)).^2));
    d_pick = min(sqrt((p(:,1)-pickup_w(1)).^2 + (p(:,2)-pickup_w(2)).^2));
    d_drop = min(sqrt((p(:,1)-dropoff_w(1)).^2 + (p(:,2)-dropoff_w(2)).^2));

    fprintf('  Path %d: Hub=%.3fm, Pickup=%.3fm, Dropoff=%.3fm  (%d pts, x=[%.2f,%.2f], y=[%.2f,%.2f])\n', ...
        i, d_hub, d_pick, d_drop, size(p,1), ...
        min(p(:,1)), max(p(:,1)), min(p(:,2)), max(p(:,2)));
end

%% Show our extracted segments
fprintf('\n--- OUR EXTRACTED MISSION LEGS ---\n');
[leg1, leg2, leg3] = build_mission_from_sdcs(cal_origin);

% Convert to EKF for display
leg1_ekf = leg1 - cal_origin;
leg2_ekf = leg2 - cal_origin;
leg3_ekf = leg3 - cal_origin;

fprintf('Leg 1 start (EKF): [%.3f, %.3f], end: [%.3f, %.3f]\n', ...
    leg1_ekf(1,1), leg1_ekf(1,2), leg1_ekf(end,1), leg1_ekf(end,2));
fprintf('Leg 2 start (EKF): [%.3f, %.3f], end: [%.3f, %.3f]\n', ...
    leg2_ekf(1,1), leg2_ekf(1,2), leg2_ekf(end,1), leg2_ekf(end,2));
fprintf('Leg 3 start (EKF): [%.3f, %.3f], end: [%.3f, %.3f]\n', ...
    leg3_ekf(1,1), leg3_ekf(1,2), leg3_ekf(end,1), leg3_ekf(end,2));

fprintf('\nHub EKF:     [%.3f, %.3f]\n', hub_w(1)-cal_origin(1), hub_w(2)-cal_origin(2));
fprintf('Pickup EKF:  [%.3f, %.3f]\n', pickup_w(1)-cal_origin(1), pickup_w(2)-cal_origin(2));
fprintf('Dropoff EKF: [%.3f, %.3f]\n', dropoff_w(1)-cal_origin(1), dropoff_w(2)-cal_origin(2));

%% Plot extracted legs on top of the correct SDCS path
figure('Name', 'Extracted Legs on SDCS Paths', 'NumberTitle', 'off');
hold on;

% Show all paths faintly
for i = 1:length(paths)
    if ~isempty(paths{i})
        p = paths{i} - cal_origin;
        plot(p(:,1), p(:,2), '-', 'LineWidth', 0.5, 'Color', [0.5 0.5 0.5]);
    end
end

% LIDAR scan
if exist('range_qcar2', 'var') && exist('angles_qcar2', 'var')
    [lx, ly] = pol2cart(-angles_qcar2 - qcar2_lidar_to_map_rotation, range_qcar2);
    plot(lx, ly, 'k.', 'MarkerSize', 1);
end

% Our legs (thick)
plot(leg1_ekf(:,1), leg1_ekf(:,2), 'g-', 'LineWidth', 3, 'DisplayName', 'Leg 1: Hub->Pickup');
plot(leg2_ekf(:,1), leg2_ekf(:,2), 'b-', 'LineWidth', 3, 'DisplayName', 'Leg 2: Pickup->Dropoff');
plot(leg3_ekf(:,1), leg3_ekf(:,2), 'm-', 'LineWidth', 3, 'DisplayName', 'Leg 3: Dropoff->Hub');

% Start/end of each leg
plot(leg1_ekf(1,1), leg1_ekf(1,2), 'go', 'MarkerSize', 12, 'LineWidth', 3);
plot(leg1_ekf(end,1), leg1_ekf(end,2), 'gx', 'MarkerSize', 12, 'LineWidth', 3);
plot(leg2_ekf(1,1), leg2_ekf(1,2), 'bo', 'MarkerSize', 12, 'LineWidth', 3);
plot(leg2_ekf(end,1), leg2_ekf(end,2), 'bx', 'MarkerSize', 12, 'LineWidth', 3);
plot(leg3_ekf(1,1), leg3_ekf(1,2), 'mo', 'MarkerSize', 12, 'LineWidth', 3);
plot(leg3_ekf(end,1), leg3_ekf(end,2), 'mx', 'MarkerSize', 12, 'LineWidth', 3);

% Key locations
plot(hub_w(1)-cal_origin(1), hub_w(2)-cal_origin(2), 'mp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Hub');
plot(pickup_w(1)-cal_origin(1), pickup_w(2)-cal_origin(2), 'g^', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Pickup');
plot(dropoff_w(1)-cal_origin(1), dropoff_w(2)-cal_origin(2), 'rs', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Dropoff');

legend('Location', 'best');
title('Extracted Mission Legs on SDCS Road Map (EKF Frame)');
xlabel('X (m)'); ylabel('Y (m)');
axis equal; grid on;
hold off;

fprintf('\n=== INSPECTION COMPLETE ===\n');
