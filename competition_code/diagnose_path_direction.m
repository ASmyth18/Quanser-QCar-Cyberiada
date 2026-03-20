%% diagnose_path_direction.m
% Check if the reordered path goes in the right direction from the hub
% and whether the initial heading matches the path tangent

%% Load the same data as setup_competition_workspace
sdcs_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources';
data = load(fullfile(sdcs_dir, 'SDCS_Paths_7.mat'));

p7_world = [data.path_x7, data.path_y7];
n_pts = size(p7_world, 1);

hub_world = [-1.205, -0.83];
d_hub = sqrt((p7_world(:,1)-hub_world(1)).^2 + (p7_world(:,2)-hub_world(2)).^2);
[~, idx_hub] = min(d_hub);

% Reorder to start at hub
p7 = [p7_world(idx_hub:end, :); p7_world(1:idx_hub-1, :)];

%% Show first 50 points - which direction does the path go?
fprintf('=== FIRST 50 POINTS OF REORDERED PATH 7 ===\n');
fprintf('(Path starts at hub)\n\n');
for i = 1:min(50, size(p7,1))
    fprintf('  [%4d] x=%.4f  y=%.4f', i, p7(i,1), p7(i,2));
    if i > 1
        dx = p7(i,1) - p7(i-1,1);
        dy = p7(i,2) - p7(i-1,2);
        angle_world = atan2d(dy, dx);
        fprintf('  dx=%.4f dy=%.4f angle=%.1f deg', dx, dy, angle_world);
    end
    fprintf('\n');
end

%% Path tangent at start
dx = p7(10,1) - p7(1,1);
dy = p7(10,2) - p7(1,2);
path_tangent_world = atan2d(dy, dx);
fprintf('\n=== PATH TANGENT (first 10 pts) ===\n');
fprintf('  Direction: %.1f deg world (atan2 convention: 0=+X, 90=+Y)\n', path_tangent_world);
fprintf('  dx=%.4f  dy=%.4f\n', dx, dy);

%% Car heading at hub
% QLabs yaw = -44.7 deg (0=+X, CCW positive)
% EKF heading = QLabs_yaw - (-90) = +45.3 deg
% EKF convention: 0 = calibration heading = QLabs -90 = facing -Y world
%
% The EKF bicycle model: dx = speed*cos(th), dy = speed*sin(th)
% At calibration (th=0): car faces QLabs -90 (facing -Y world)
%   dx_ekf = speed*cos(0) = speed > 0 => EKF +x = car forward = world -Y
%   dy_ekf = speed*sin(0) = 0
% At th=90 deg: dx_ekf = 0, dy_ekf = speed > 0 => EKF +y = world -X? or +X?
%
% This means EKF frame is ROTATED 90 deg from world frame
% EKF heading th maps to world heading as: world_heading = th - 90 deg (QLabs convention)
% Or equivalently: car direction in world = QLabs_yaw = EKF_heading + CAL_yaw = th + (-90)

fprintf('\n=== CAR HEADING AT HUB ===\n');
hub_yaw_qlabs = -44.7; % degrees
cal_yaw_qlabs = -90;   % degrees
ekf_heading = hub_yaw_qlabs - cal_yaw_qlabs; % +45.3 deg
fprintf('  QLabs yaw: %.1f deg\n', hub_yaw_qlabs);
fprintf('  EKF heading: %.1f deg\n', ekf_heading);

% What direction does the car actually face in world?
% QLabs convention: 0=+X, CCW positive
% So -44.7 deg means car faces 44.7 deg clockwise from +X
%   = roughly between +X and -Y (southeast-ish... actually NE of -Y)
% cos(-44.7) = 0.71, sin(-44.7) = -0.70 => car moves toward (+0.71, -0.70) world
car_dir_world = hub_yaw_qlabs;
fprintf('  Car faces %.1f deg world (QLabs convention)\n', car_dir_world);
fprintf('  Car moves toward: (%.3f, %.3f) in world\n', cosd(car_dir_world), sind(car_dir_world));

%% CRITICAL: Does the EKF heading match world heading for pathPlanner?
% The pathPlanner uses the heading from stateEstimation to project the
% look-ahead point. If stateEstimation heading is EKF (+45.3) but the
% path tangent is in world frame, there's a mismatch.
fprintf('\n=== HEADING MISMATCH ANALYSIS ===\n');
fprintf('  Path tangent (world): %.1f deg\n', path_tangent_world);
fprintf('  EKF heading output:   %.1f deg\n', ekf_heading);
fprintf('  Car actual direction (world): %.1f deg\n', car_dir_world);
fprintf('  EKF-to-world offset: %.1f deg (= CAL_YAW = -90)\n', cal_yaw_qlabs);
fprintf('\n  If pathPlanner treats heading as world angle:\n');
fprintf('    Look-ahead projects toward world angle %.1f deg\n', ekf_heading);
fprintf('    But car actually faces world angle %.1f deg\n', car_dir_world);
fprintf('    MISMATCH: %.1f deg\n', ekf_heading - car_dir_world);

%% After LIDAR convergence, what frame is heading in?
% The LIDAR Match Scans has Gain [1 -1 -1] which flips heading sign.
% No heading bias is added.
% So LIDAR heading = -matched_heading (sign flip only)
% The EKF receives LIDAR heading as a measurement and converges.
% Since there's no +90 deg offset added, the heading stays in EKF frame.
fprintf('\n=== LIDAR HEADING PROCESSING ===\n');
fprintf('  LIDAR Match Scans Gain: [1 -1 -1] (flips Y and heading)\n');
fprintf('  No heading Calibration Bias added\n');
fprintf('  => LIDAR heading output is sign-flipped, but NOT offset\n');
fprintf('  => EKF heading converges to: FLIPPED convention (still not world)\n');
fprintf('  => stateEstimation heading is NOT in world frame\n');

%% What does the pathPlanner see?
% Position: world frame (after LIDAR convergence)
% Heading: EKF frame (no heading bias)
% Path: world frame
% When pathPlanner computes look-ahead, it projects from (x,y) in direction (heading)
% But heading is EKF, not world => look-ahead is in the WRONG direction
% This causes the car to steer toward the wrong part of the path!
fprintf('\n=== ROOT CAUSE HYPOTHESIS ===\n');
fprintf('  stateEstimation outputs MIXED frames:\n');
fprintf('    Position: WORLD (LIDAR adds cal_pos = [0, 2.13])\n');
fprintf('    Heading:  EKF   (no heading bias, 0 = cal heading)\n');
fprintf('  pathPlanner expects heading in SAME frame as path (world)\n');
fprintf('  => Look-ahead point projected in wrong direction\n');
fprintf('  => Car steers toward wrong path segment\n');
fprintf('\n  FIX: Either:\n');
fprintf('  1. Rotate paths to match EKF heading convention\n');
fprintf('  2. Add heading offset in Simulink (hard to modify)\n');
fprintf('  3. Use a path algorithm that does not depend on heading\n');

%% Plot
figure('Name', 'Path Direction Diagnostic', 'NumberTitle', 'off');
hold on;

% Full path
plot(p7(:,1), p7(:,2), 'b-', 'LineWidth', 0.5, 'DisplayName', 'Full Path 7');

% First 100 points highlighted
plot(p7(1:100,1), p7(1:100,2), 'g-', 'LineWidth', 3, 'DisplayName', 'First 100 pts');

% Hub
plot(hub_world(1), hub_world(2), 'rp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Hub');

% Direction arrows every 10 points for first 50
for i = 1:10:50
    if i < size(p7,1)-1
        dx = p7(i+1,1) - p7(i,1);
        dy = p7(i+1,2) - p7(i,2);
        quiver(p7(i,1), p7(i,2), dx*20, dy*20, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 2);
    end
end

% Car heading arrow (actual world direction)
arrow_len = 0.3;
quiver(hub_world(1), hub_world(2), ...
    arrow_len*cosd(hub_yaw_qlabs), arrow_len*sind(hub_yaw_qlabs), 0, ...
    'r', 'LineWidth', 3, 'MaxHeadSize', 2, 'DisplayName', 'Car actual heading (world)');

% EKF heading arrow (what pathPlanner sees)
quiver(hub_world(1), hub_world(2), ...
    arrow_len*cosd(ekf_heading), arrow_len*sind(ekf_heading), 0, ...
    'm', 'LineWidth', 3, 'MaxHeadSize', 2, 'DisplayName', 'EKF heading (what pathPlanner sees)');

legend('Location', 'best');
xlabel('X (m)'); ylabel('Y (m)');
title('Path Direction + Heading Mismatch');
axis equal; grid on;
hold off;

fprintf('\n=== DONE ===\n');
