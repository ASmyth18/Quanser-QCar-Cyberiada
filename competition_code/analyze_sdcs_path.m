%% analyze_sdcs_path.m
% Analyze SDCS Path 7 to understand its route and find key mission locations.
% Run AFTER Setup_QCar2_Params.m so path_x4/path_y4 are loaded.

fprintf('=== Analyzing SDCS Path 7 ===\n\n');

% Key mission locations (WORLD frame)
hub_pos     = [-1.205, -0.83];
pickup_pos  = [0.125, 4.395];
dropoff_pos = [-0.905, 0.800];

n = length(path_x4);
fprintf('Path has %d points\n', n);
fprintf('X range: [%.3f, %.3f]\n', min(path_x4), max(path_x4));
fprintf('Y range: [%.3f, %.3f]\n\n', min(path_y4), max(path_y4));

% Find closest points on path to each mission location
d_hub = sqrt((path_x4 - hub_pos(1)).^2 + (path_y4 - hub_pos(2)).^2);
d_pick = sqrt((path_x4 - pickup_pos(1)).^2 + (path_y4 - pickup_pos(2)).^2);
d_drop = sqrt((path_x4 - dropoff_pos(1)).^2 + (path_y4 - dropoff_pos(2)).^2);

[min_d_hub, idx_hub] = min(d_hub);
[min_d_pick, idx_pick] = min(d_pick);
[min_d_drop, idx_drop] = min(d_drop);

fprintf('Closest path point to Hub:     index %d/%d, distance %.3f m, at (%.3f, %.3f)\n', ...
    idx_hub, n, min_d_hub, path_x4(idx_hub), path_y4(idx_hub));
fprintf('Closest path point to Pickup:  index %d/%d, distance %.3f m, at (%.3f, %.3f)\n', ...
    idx_pick, n, min_d_pick, path_x4(idx_pick), path_y4(idx_pick));
fprintf('Closest path point to Dropoff: index %d/%d, distance %.3f m, at (%.3f, %.3f)\n', ...
    idx_drop, n, min_d_drop, path_x4(idx_drop), path_y4(idx_drop));

% Find ALL points within threshold of each location (path may pass nearby multiple times)
threshold = 0.3; % 30cm
fprintf('\n--- All path points within %.1f m of each location ---\n', threshold);

hub_nearby = find(d_hub < threshold);
pick_nearby = find(d_pick < threshold);
drop_nearby = find(d_drop < threshold);

fprintf('Hub nearby indices:     '); print_index_groups(hub_nearby);
fprintf('Pickup nearby indices:  '); print_index_groups(pick_nearby);
fprintf('Dropoff nearby indices: '); print_index_groups(drop_nearby);

% Compute cumulative distance along path
cum_dist = zeros(n, 1);
for i = 2:n
    cum_dist(i) = cum_dist(i-1) + sqrt((path_x4(i)-path_x4(i-1))^2 + (path_y4(i)-path_y4(i-1))^2);
end
fprintf('\nTotal path length: %.2f m\n', cum_dist(end));

% Plot the full path with mission locations
figure('Name', 'SDCS Path 7 Analysis', 'NumberTitle', 'off', 'Position', [100 100 900 700]);
hold on;

% Color the path by index (to see direction)
scatter(path_x4, path_y4, 3, 1:n, 'filled');
colorbar('Title', 'Point Index');
colormap(jet);

% Mark key locations
plot(hub_pos(1), hub_pos(2), 'mp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Taxi Hub');
plot(pickup_pos(1), pickup_pos(2), 'g^', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Pickup');
plot(dropoff_pos(1), dropoff_pos(2), 'rs', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Dropoff');

% Mark closest path points
plot(path_x4(idx_hub), path_y4(idx_hub), 'mo', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', sprintf('Path@Hub (idx %d)', idx_hub));
plot(path_x4(idx_pick), path_y4(idx_pick), 'go', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', sprintf('Path@Pickup (idx %d)', idx_pick));
plot(path_x4(idx_drop), path_y4(idx_drop), 'ro', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', sprintf('Path@Dropoff (idx %d)', idx_drop));

% Show path start and end
plot(path_x4(1), path_y4(1), 'k>', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Path Start');
plot(path_x4(end), path_y4(end), 'k<', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Path End');

% Mark every 200th point with index label
for i = 1:200:n
    text(path_x4(i)+0.05, path_y4(i)+0.05, sprintf('%d', i), 'FontSize', 7, 'Color', [0.5 0 0]);
end

legend('Location', 'eastoutside');
xlabel('X (m) - World Frame');
ylabel('Y (m) - World Frame');
title('SDCS Path 7 with Mission Locations');
axis equal; grid on;
hold off;

% Print path segments to understand route order
fprintf('\n--- Path trajectory summary (every 100 points) ---\n');
fprintf('Index   X       Y       CumDist\n');
for i = 1:100:n
    fprintf('%5d  %7.3f  %7.3f  %7.2f m\n', i, path_x4(i), path_y4(i), cum_dist(i));
end
fprintf('%5d  %7.3f  %7.3f  %7.2f m  (END)\n', n, path_x4(n), path_y4(n), cum_dist(n));

function print_index_groups(indices)
    if isempty(indices)
        fprintf('(none)\n');
        return;
    end
    % Group consecutive indices
    groups = {};
    g_start = indices(1);
    g_end = indices(1);
    for k = 2:length(indices)
        if indices(k) == g_end + 1
            g_end = indices(k);
        else
            groups{end+1} = sprintf('%d-%d', g_start, g_end);
            g_start = indices(k);
            g_end = indices(k);
        end
    end
    groups{end+1} = sprintf('%d-%d', g_start, g_end);
    fprintf('%s\n', strjoin(groups, ', '));
end
