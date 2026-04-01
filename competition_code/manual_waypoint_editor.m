%% manual_waypoint_editor.m
% Place waypoints by reading coordinates from the QLabs Coordinate Helper,
% then visualize the path as spline lines drawn on the road in QLabs.
%
% Hub, Pickup, and Dropoff are shown as reference spheres only —
% they are NOT included in the interpolated path.
%
% HOW TO USE:
%   1. Open QLabs and run Setup_Scene_Enhanced (scene must be loaded)
%   2. In QLabs: View menu -> "Coordinate Helper" (shows XYZ as you hover)
%   3. Run this script in a SEPARATE MATLAB session
%   4. For each leg, hover over road points in QLabs, read the X,Y coords
%      from the Coordinate Helper, and enter them here
%   5. Each point you enter gets marked with a sphere in QLabs
%   6. When done, the full path is drawn as a spline line on the road
%
% REQUIREMENTS: QLabs must be running with a scene loaded.

fprintf('========================================\n');
fprintf(' QLabs Road Waypoint Editor\n');
fprintf('========================================\n\n');

%% Add QVL Library to Path
newPathEntry = fullfile(getenv('QAL_DIR'), '0_libraries', 'matlab', 'qvl');
pathCell = regexp(path, pathsep, 'split');
if ispc
    onPath = any(strcmpi(newPathEntry, pathCell));
else
    onPath = any(strcmp(newPathEntry, pathCell));
end
if ~onPath
    path(path, newPathEntry);
    savepath;
end

%% Connect to QLabs
fprintf('Connecting to QLabs...\n');
qlabs = QuanserInteractiveLabs();
connected = qlabs.open('localhost');
if ~connected
    error('Failed to connect to QLabs. Make sure it is running.');
end
fprintf('Connected!\n\n');
cleanup = onCleanup(@() qlabs.close());

%% Settings
POINT_SPACING = 0.005;  % 5mm between dense path points
ROAD_HEIGHT   = 0.001;  % Slightly above road surface
MARKER_HEIGHT = 0.005;  % Sphere marker height
SPLINE_WIDTH  = 0.02;   % Spline line width on road
sphere_id     = 500;     % Starting actor ID for marker spheres
spline_id     = 600;     % Starting actor ID for spline lines

% Reference locations (display only — NOT part of path)
hub     = [-1.205, -0.83];
pickup  = [ 0.125,  4.395];
dropoff = [-0.905,  0.800];

%% Place reference markers in QLabs (spheres at hub/pickup/dropoff)
ref_shape = QLabsBasicShape(qlabs);

% Hub - magenta sphere
ref_shape.spawn_id_degrees(400, [hub(1), hub(2), 0.02], [0,0,0], [0.04, 0.04, 0.04], ...
    QLabsBasicShape.SHAPE_SPHERE, false);
ref_shape.set_material_properties([1, 0, 1], 0.4, false);

% Pickup - green sphere
ref_shape.spawn_id_degrees(401, [pickup(1), pickup(2), 0.02], [0,0,0], [0.04, 0.04, 0.04], ...
    QLabsBasicShape.SHAPE_SPHERE, false);
ref_shape.set_material_properties([0, 1, 0], 0.4, false);

% Dropoff - red sphere
ref_shape.spawn_id_degrees(402, [dropoff(1), dropoff(2), 0.02], [0,0,0], [0.04, 0.04, 0.04], ...
    QLabsBasicShape.SHAPE_SPHERE, false);
ref_shape.set_material_properties([1, 0, 0], 0.4, false);

fprintf('Reference markers placed:\n');
fprintf('  Magenta sphere = Hub (-1.205, -0.83)\n');
fprintf('  Green sphere   = Pickup (0.125, 4.395)\n');
fprintf('  Red sphere     = Dropoff (-0.905, 0.800)\n\n');

%% Collect waypoints for each leg
leg_names  = {'Hub -> Pickup', 'Pickup -> Dropoff', 'Dropoff -> Hub'};
leg_colors = {[0, 1, 0], [0, 0.5, 1], [1, 0, 1]};  % green, blue, magenta
marker_shape = QLabsBasicShape(qlabs);
all_legs_x = {};
all_legs_y = {};

%% ---- Load from existing manual_path.mat ----
prev_mat = fullfile(fileparts(mfilename('fullpath')), 'manual_path.mat');
if ~isfile(prev_mat)
    error('manual_path.mat not found. Need existing path data.');
end
prev = load(prev_mat, 'path_x4', 'path_y4', 'idx_pickup', 'idx_dropoff');

% Leg 1: split into LOCKED before + EDITABLE bend + LOCKED after
% The bend after the junction where the car turns from heading west
% to heading north onto the west road (past parking lot entrance).
% This is the bend that was causing the car to sometimes turn left
% back toward the hub instead of continuing right.
% Index 1400: (-0.435, 1.077) — heading west, approaching the bend
% Index 1850: (-1.705, 2.231) — heading north on the straight west road
BEND_START = 1400;
BEND_END   = 1850;

leg1_before_x = prev.path_x4(1:BEND_START);              % LOCKED: hub to junction approach
leg1_before_y = prev.path_y4(1:BEND_START);
leg1_after_x  = prev.path_x4(BEND_END:prev.idx_pickup);  % LOCKED: after bend to pickup
leg1_after_y  = prev.path_y4(BEND_END:prev.idx_pickup);

% Leg 2: LOCKED
leg2_dense_x = prev.path_x4(prev.idx_pickup:prev.idx_dropoff);
leg2_dense_y = prev.path_y4(prev.idx_pickup:prev.idx_dropoff);

% Leg 3: LOCKED
leg3_dense_x = prev.path_x4(prev.idx_dropoff:end);
leg3_dense_y = prev.path_y4(prev.idx_dropoff:end);

all_legs_x{2} = leg2_dense_x(:);
all_legs_y{2} = leg2_dense_y(:);
all_legs_x{3} = leg3_dense_x(:);
all_legs_y{3} = leg3_dense_y(:);

leg1b_len = sum(sqrt(diff(leg1_before_x).^2 + diff(leg1_before_y).^2));
leg1a_len = sum(sqrt(diff(leg1_after_x).^2 + diff(leg1_after_y).^2));
leg2_len  = sum(sqrt(diff(leg2_dense_x).^2 + diff(leg2_dense_y).^2));
leg3_len  = sum(sqrt(diff(leg3_dense_x).^2 + diff(leg3_dense_y).^2));
fprintf('Leg 1 before bend:         LOCKED — %d points (%.3f m)\n', length(leg1_before_x), leg1b_len);
fprintf('  Ends at: (%.3f, %.3f)\n', leg1_before_x(end), leg1_before_y(end));
fprintf('Leg 1 after bend:          LOCKED — %d points (%.3f m)\n', length(leg1_after_x), leg1a_len);
fprintf('  Starts at: (%.3f, %.3f)\n', leg1_after_x(1), leg1_after_y(1));
fprintf('Leg 2 (Pickup -> Dropoff): LOCKED — %d points (%.3f m)\n', length(leg2_dense_x), leg2_len);
fprintf('Leg 3 (Dropoff -> Hub):    LOCKED — %d points (%.3f m)\n\n', length(leg3_dense_x), leg3_len);

% Draw locked sections in QLabs
step1b = max(1, floor(length(leg1_before_x) / 80));
step1a = max(1, floor(length(leg1_after_x) / 80));
step2  = max(1, floor(length(leg2_dense_x) / 80));
step3  = max(1, floor(length(leg3_dense_x) / 80));
update_preview_spline(qlabs, spline_id + 0, ...
    leg1_before_x(1:step1b:end), leg1_before_y(1:step1b:end), ROAD_HEIGHT, SPLINE_WIDTH, [0.5, 0.5, 0.5]);
update_preview_spline(qlabs, spline_id + 4, ...
    leg1_after_x(1:step1a:end), leg1_after_y(1:step1a:end), ROAD_HEIGHT, SPLINE_WIDTH, [0.5, 0.5, 0.5]);
update_preview_spline(qlabs, spline_id + 2, ...
    leg2_dense_x(1:step2:end), leg2_dense_y(1:step2:end), ROAD_HEIGHT, SPLINE_WIDTH, leg_colors{2});
update_preview_spline(qlabs, spline_id + 3, ...
    leg3_dense_x(1:step3:end), leg3_dense_y(1:step3:end), ROAD_HEIGHT, SPLINE_WIDTH, leg_colors{3});

% Place markers at start and end of editable section
marker_shape.spawn_id_degrees(498, ...
    [leg1_before_x(end), leg1_before_y(end), 0.02], [0,0,0], [0.03, 0.03, 0.03], ...
    QLabsBasicShape.SHAPE_SPHERE, false);
marker_shape.set_material_properties([1, 1, 0], 0.4, false);  % yellow = bend start
marker_shape.spawn_id_degrees(499, ...
    [leg1_after_x(1), leg1_after_y(1), 0.02], [0,0,0], [0.03, 0.03, 0.03], ...
    QLabsBasicShape.SHAPE_SPHERE, false);
marker_shape.set_material_properties([1, 0.5, 0], 0.4, false);  % orange = bend end
fprintf('Yellow sphere  = bend START (%.3f, %.3f)\n', leg1_before_x(end), leg1_before_y(end));
fprintf('Orange sphere  = bend END   (%.3f, %.3f)\n', leg1_after_x(1), leg1_after_y(1));
fprintf('Locked sections drawn in QLabs.\n\n');

%% ---- Junction bend (INTERACTIVE) ----
fprintf('Open the QLabs Coordinate Helper (View menu) to read X,Y coords.\n');
fprintf('Start from the YELLOW SPHERE and trace to the ORANGE sphere.\n');
fprintf('Take the bend WIDER to avoid cutting the corner.\n\n');

leg = 1;
fprintf('=== JUNCTION BEND (editable section) ===\n');
fprintf('  Enter waypoints as: x, y  or  x, y, z  (z is ignored)\n');
fprintf('  Type "done" when finished.\n');
fprintf('  Type "undo" to remove the last point.\n\n');

wx = []; wy = [];
pt_count = 0;

while true
    prompt_str = sprintf('  Point %d > ', pt_count + 1);
    user_input = input(prompt_str, 's');

    if strcmpi(strtrim(user_input), 'done')
        break;
    end

    if strcmpi(strtrim(user_input), 'undo')
        if pt_count > 0
            marker_shape.spawn_id_degrees(sphere_id + pt_count - 1, ...
                [0, 0, -10], [0,0,0], [0.001, 0.001, 0.001], ...
                QLabsBasicShape.SHAPE_SPHERE, false);
            wx(end) = [];
            wy(end) = [];
            pt_count = pt_count - 1;
            fprintf('    Removed last point. %d points remaining.\n', pt_count);
            if pt_count >= 2
                update_preview_spline(qlabs, spline_id + 1, ...
                    wx, wy, ROAD_HEIGHT, SPLINE_WIDTH, leg_colors{1});
            end
        else
            fprintf('    No points to undo.\n');
        end
        continue;
    end

    % Parse coordinates (accept "x, y" or "x, y, z" — z is ignored)
    parts = strsplit(strtrim(user_input), {',', ' '});
    parts = parts(~cellfun(@isempty, parts));
    if length(parts) < 2 || length(parts) > 3
        fprintf('    Invalid format. Enter as: x, y  (z is optional and ignored)\n');
        continue;
    end

    x = str2double(parts{1});
    y = str2double(parts{2});
    if isnan(x) || isnan(y)
        fprintf('    Invalid numbers. Try again.\n');
        continue;
    end

    pt_count = pt_count + 1;
    wx(pt_count) = x;
    wy(pt_count) = y;

    marker_shape.spawn_id_degrees(sphere_id, ...
        [x, y, MARKER_HEIGHT], [0,0,0], [0.015, 0.015, 0.015], ...
        QLabsBasicShape.SHAPE_SPHERE, false);
    marker_shape.set_material_properties(leg_colors{1}, 0.4, false);
    sphere_id = sphere_id + 1;

    fprintf('    Added (%.3f, %.3f) — marker placed in QLabs\n', x, y);

    if pt_count >= 2
        update_preview_spline(qlabs, spline_id + 1, ...
            wx, wy, ROAD_HEIGHT, SPLINE_WIDTH, leg_colors{1});
    end
end

if length(wx) < 2
    error('Leg 1b needs at least 2 points!');
end

% Densify the hand-drawn bend
[dense_bend_x, dense_bend_y] = interpolate_path(wx, wy, POINT_SPACING);
total_bend_len = sum(sqrt(diff(dense_bend_x).^2 + diff(dense_bend_y).^2));
fprintf('  Bend complete: %d waypoints -> %d dense points (%.3f m)\n\n', ...
    length(wx), length(dense_bend_x), total_bend_len);

% Combine: locked before + editable bend + locked after = full leg 1
all_legs_x{1} = [leg1_before_x(:); dense_bend_x(:); leg1_after_x(:)];
all_legs_y{1} = [leg1_before_y(:); dense_bend_y(:); leg1_after_y(:)];

%% Combine all legs
path_x4 = [all_legs_x{1}; all_legs_x{2}; all_legs_x{3}];
path_y4 = [all_legs_y{1}; all_legs_y{2}; all_legs_y{3}];
idx_pickup  = length(all_legs_x{1});
idx_dropoff = length(all_legs_x{1}) + length(all_legs_x{2});

fprintf('\n========================================\n');
fprintf(' Path Summary\n');
fprintf('========================================\n');
for i = 1:3
    if ~isempty(all_legs_x{i})
        leg_len = sum(sqrt(diff(all_legs_x{i}).^2 + diff(all_legs_y{i}).^2));
        fprintf('  Leg %d (%s): %d pts, %.3f m\n', i, leg_names{i}, length(all_legs_x{i}), leg_len);
    end
end
fprintf('  Total: %d points\n', length(path_x4));
fprintf('\nPath is visible as spline lines on the road in QLabs.\n');

%% MATLAB preview plot
figure('Name', 'Path in World Coordinates', 'NumberTitle', 'off');
hold on; axis equal; grid on;
if ~isempty(all_legs_x{1})
    plot(all_legs_x{1}, all_legs_y{1}, 'g-', 'LineWidth', 2.5);
end
if ~isempty(all_legs_x{2})
    plot(all_legs_x{2}, all_legs_y{2}, 'b-', 'LineWidth', 2.5);
end
if ~isempty(all_legs_x{3})
    plot(all_legs_x{3}, all_legs_y{3}, 'm-', 'LineWidth', 2.5);
end
plot(hub(1), hub(2), 'mp', 'MarkerSize', 15, 'LineWidth', 3);
plot(pickup(1), pickup(2), 'g^', 'MarkerSize', 15, 'LineWidth', 3);
plot(dropoff(1), dropoff(2), 'rs', 'MarkerSize', 15, 'LineWidth', 3);
legend('Hub->Pickup', 'Pickup->Dropoff', 'Dropoff->Hub');
xlabel('X (m)'); ylabel('Y (m)');
title('Final Path (World Coordinates)');

%% Save
resp = input('\nSave this path? (y/n): ', 's');
if strcmpi(resp, 'y')
    assignin('base', 'path_x4', path_x4);
    assignin('base', 'path_y4', path_y4);
    save('manual_path.mat', 'path_x4', 'path_y4', 'idx_pickup', 'idx_dropoff');
    fprintf('  Saved to workspace AND manual_path.mat\n');
else
    fprintf('  NOT saved.\n');
end
fprintf('Done!\n');


%% ===== Helper functions =====

function update_preview_spline(qlabs, spline_actor_id, wx, wy, z, width, color)
    % Draw/update a spline line on the road in QLabs
    spline = QLabsSplineLine(qlabs);
    spline.spawn_id_degrees(spline_actor_id, [0, 0, 0], [0, 0, 0], [1, 1, 1], ...
        QLabsSplineLine.LINEAR, false);

    n = length(wx);
    pointList = zeros(n, 4, 'single');
    for i = 1:n
        pointList(i, :) = [single(wx(i)), single(wy(i)), single(z), single(width)];
    end
    spline.set_points(single(color), pointList, false);
end

function [dx, dy] = interpolate_path(wx, wy, spacing)
    n = length(wx);
    if n < 2, dx = wx(:); dy = wy(:); return; end
    dx = []; dy = [];
    for i = 1:n-1
        L = sqrt((wx(i+1)-wx(i))^2 + (wy(i+1)-wy(i))^2);
        if L < 1e-6, continue; end
        n_pts = max(2, round(L / spacing));
        t = linspace(0, 1, n_pts);
        if i < n-1, t = t(1:end-1); end
        dx = [dx, wx(i) + t*(wx(i+1)-wx(i))];
        dy = [dy, wy(i) + t*(wy(i+1)-wy(i))];
    end
    dx = dx(:); dy = dy(:);
end
