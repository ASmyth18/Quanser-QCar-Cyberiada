%% verify_path_alignment.m
% Check whether SDCS paths align with the actual map landmarks.
% Plots paths + traffic lights + stop signs + crosswalks to see if they match.

sdcs_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources';
data = load(fullfile(sdcs_dir, 'SDCS_Paths_7.mat'));

%% Known landmark positions from Setup_Real_Scenario.m (WORLD coordinates)
% Traffic lights
tlights = [0.6, 1.55; -0.6, 1.28; -0.37, 0.3; 0.75, 0.48];

% Stop signs
stops = [-1.5, 3.6; -1.5, 2.2; 2.41, 0.206; 1.766, 1.697];

% Roundabout signs
roundabout = [2.392, 2.522; 0.698, 2.483; 0.007, 3.973];

% Crosswalks
crosswalks = [-1.87, 0.195; -0.5, 0.95; 0.15, 0.32; 0.75, 0.95; 0.13, 1.57; 1.45, 0.95];

% Yield signs
yields = [0.0, -1.3; 2.4, 3.2; 1.1, 2.8; 0.49, 3.8];

% Calibration position
cal_pos = [0, 2.13];

% Taxi hub
hub = [-1.205, -0.83];

% Floor placement
floor_pos = [0.13, 1.67];
floor_rot = -90; % degrees

%% Figure 1: Raw paths + landmarks (both in world coords)
figure('Name', 'Path-Landmark Alignment Check', 'NumberTitle', 'off', ...
    'Position', [50, 50, 900, 900]);
hold on;

% Plot all 7 paths
colors = {'r', [1 0.5 0], 'y', 'g', 'c', 'b', 'm'};
path_names = {'path_x', 'path_x2', 'path_x3', 'path_x4', 'path_x5', 'path_x6', 'path_x7'};
path_ynames = {'path_y', 'path_y2', 'path_y3', 'path_y4', 'path_y5', 'path_y6', 'path_y7'};

for i = 1:7
    px = data.(path_names{i});
    py = data.(path_ynames{i});
    plot(px, py, '-', 'Color', colors{i}, 'LineWidth', 1, ...
        'DisplayName', sprintf('Path %d (%d pts)', i, length(px)));
end

% Plot landmarks
plot(tlights(:,1), tlights(:,2), 'rs', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Traffic Lights');
plot(stops(:,1), stops(:,2), 'r^', 'MarkerSize', 12, 'LineWidth', 3, 'DisplayName', 'Stop Signs');
plot(roundabout(:,1), roundabout(:,2), 'bo', 'MarkerSize', 12, 'LineWidth', 3, 'DisplayName', 'Roundabout Signs');
plot(crosswalks(:,1), crosswalks(:,2), 'kx', 'MarkerSize', 12, 'LineWidth', 3, 'DisplayName', 'Crosswalks');
plot(yields(:,1), yields(:,2), 'md', 'MarkerSize', 12, 'LineWidth', 3, 'DisplayName', 'Yield Signs');
plot(cal_pos(1), cal_pos(2), 'gp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Calibration');
plot(hub(1), hub(2), 'mp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Taxi Hub');

% Floor center
plot(floor_pos(1), floor_pos(2), 'k+', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Floor Center');

legend('Location', 'eastoutside', 'FontSize', 7);
xlabel('X (m) - World');
ylabel('Y (m) - World');
title('SDCS Paths vs Map Landmarks (Raw World Coordinates)');
axis equal; grid on;
hold off;

%% Check: do paths pass near landmarks?
fprintf('=== PATH-LANDMARK PROXIMITY CHECK ===\n\n');

% For each traffic light, find the closest point on any path
fprintf('Traffic lights - closest path point:\n');
for j = 1:size(tlights, 1)
    best_dist = inf;
    best_path = 0;
    for i = 1:7
        px = data.(path_names{i});
        py = data.(path_ynames{i});
        d = sqrt((px - tlights(j,1)).^2 + (py - tlights(j,2)).^2);
        [md, ~] = min(d);
        if md < best_dist
            best_dist = md;
            best_path = i;
        end
    end
    fprintf('  TL%d (%.2f, %.2f): nearest path %d at %.3f m %s\n', ...
        j, tlights(j,1), tlights(j,2), best_path, best_dist, ...
        ternary(best_dist < 0.3, '[OK]', '[FAR]'));
end

fprintf('\nStop signs - closest path point:\n');
for j = 1:size(stops, 1)
    best_dist = inf;
    best_path = 0;
    for i = 1:7
        px = data.(path_names{i});
        py = data.(path_ynames{i});
        d = sqrt((px - stops(j,1)).^2 + (py - stops(j,2)).^2);
        [md, ~] = min(d);
        if md < best_dist
            best_dist = md;
            best_path = i;
        end
    end
    fprintf('  SS%d (%.2f, %.2f): nearest path %d at %.3f m %s\n', ...
        j, stops(j,1), stops(j,2), best_path, best_dist, ...
        ternary(best_dist < 0.3, '[OK]', '[FAR]'));
end

fprintf('\nCrosswalks - closest path point:\n');
for j = 1:size(crosswalks, 1)
    best_dist = inf;
    best_path = 0;
    for i = 1:7
        px = data.(path_names{i});
        py = data.(path_ynames{i});
        d = sqrt((px - crosswalks(j,1)).^2 + (py - crosswalks(j,2)).^2);
        [md, ~] = min(d);
        if md < best_dist
            best_dist = md;
            best_path = i;
        end
    end
    fprintf('  CW%d (%.2f, %.2f): nearest path %d at %.3f m %s\n', ...
        j, crosswalks(j,1), crosswalks(j,2), best_path, best_dist, ...
        ternary(best_dist < 0.3, '[OK]', '[FAR]'));
end

fprintf('\nCalibration (%.2f, %.2f):\n', cal_pos(1), cal_pos(2));
for i = 1:7
    px = data.(path_names{i});
    py = data.(path_ynames{i});
    d = sqrt((px - cal_pos(1)).^2 + (py - cal_pos(2)).^2);
    [md, ~] = min(d);
    fprintf('  Path %d: %.3f m\n', i, md);
end

fprintf('\nHub (%.2f, %.2f):\n', hub(1), hub(2));
for i = 1:7
    px = data.(path_names{i});
    py = data.(path_ynames{i});
    d = sqrt((px - hub(1)).^2 + (py - hub(2)).^2);
    [md, ~] = min(d);
    fprintf('  Path %d: %.3f m\n', i, md);
end

fprintf('\n=== DONE ===\n');

function s = ternary(cond, a, b)
    if cond; s = a; else; s = b; end
end
