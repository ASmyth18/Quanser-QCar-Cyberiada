%% inspect_paths.m
% Shows what's actually in SDCS_Paths_7.mat and plots all available paths
% Run this to understand the road layout.

cd('C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources');

data = load('SDCS_Paths_7.mat');
fprintf('Variables in SDCS_Paths_7.mat:\n');
vars = fieldnames(data);
for i = 1:length(vars)
    v = data.(vars{i});
    fprintf('  %s: %s [%s]\n', vars{i}, mat2str(size(v)), class(v));
end

%% Plot all paths
figure('Name', 'All SDCS Paths', 'NumberTitle', 'off');
hold on;
colors = lines(length(vars)/2 + 1);
ci = 1;

% Find all path_x*/path_y* pairs
path_nums = {};
for i = 1:length(vars)
    name = vars{i};
    if startsWith(name, 'path_x')
        num = name(7:end);  % extract the number
        path_nums{end+1} = num;
    end
end

cal_pos_local = [0, 2, 0];  % standard calibration position

for i = 1:length(path_nums)
    num = path_nums{i};
    xvar = ['path_x' num];
    yvar = ['path_y' num];

    if isfield(data, xvar) && isfield(data, yvar)
        px = data.(xvar);
        py = data.(yvar);

        % Convert to EKF frame for plotting
        px_ekf = px - cal_pos_local(1);
        py_ekf = py - cal_pos_local(2);

        plot(px_ekf, py_ekf, '-', 'LineWidth', 2, 'Color', colors(ci,:), ...
            'DisplayName', sprintf('Path %s (%d pts)', num, length(px)));

        % Mark start and end
        plot(px_ekf(1), py_ekf(1), 'o', 'MarkerSize', 10, 'Color', colors(ci,:), 'LineWidth', 2);
        plot(px_ekf(end), py_ekf(end), 'x', 'MarkerSize', 10, 'Color', colors(ci,:), 'LineWidth', 2);

        ci = ci + 1;

        fprintf('\nPath %s: %d points\n', num, length(px));
        fprintf('  Start (world): [%.3f, %.3f] | EKF: [%.3f, %.3f]\n', px(1), py(1), px_ekf(1), py_ekf(1));
        fprintf('  End   (world): [%.3f, %.3f] | EKF: [%.3f, %.3f]\n', px(end), py(end), px_ekf(end), py_ekf(end));
    end
end

% Plot key competition locations (EKF frame)
hub_ekf = [-1.205, -0.83] - cal_pos_local(1:2);
pickup_ekf = [0.125, 4.395] - cal_pos_local(1:2);
dropoff_ekf = [-0.905, 0.800] - cal_pos_local(1:2);

plot(hub_ekf(1), hub_ekf(2), 'mp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Taxi Hub');
plot(pickup_ekf(1), pickup_ekf(2), 'g^', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Pickup');
plot(dropoff_ekf(1), dropoff_ekf(2), 'rs', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Dropoff');

% Plot LIDAR scan if available
if exist('range_qcar2', 'var') && exist('angles_qcar2', 'var')
    [lx, ly] = pol2cart(-angles_qcar2 - qcar2_lidar_to_map_rotation, range_qcar2);
    plot(lx, ly, 'k.', 'MarkerSize', 1, 'DisplayName', 'LIDAR walls');
end

legend('Location', 'best');
xlabel('X (m) - EKF Frame');
ylabel('Y (m) - EKF Frame');
title('All Available SDCS Paths + Competition Locations');
axis equal; grid on;
hold off;

fprintf('\n=== Key Locations (EKF frame) ===\n');
fprintf('Hub:     [%.3f, %.3f]\n', hub_ekf);
fprintf('Pickup:  [%.3f, %.3f]\n', pickup_ekf);
fprintf('Dropoff: [%.3f, %.3f]\n', dropoff_ekf);
