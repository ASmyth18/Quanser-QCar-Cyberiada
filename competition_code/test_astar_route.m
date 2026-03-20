%% test_astar_route.m
% Quick test: generate A* paths and display them with the SDCS paths overlay
% to verify the waypoint graph actually follows roads.

comp_root = 'C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code';
addpath(genpath(comp_root));

sdcs_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources';
data = load(fullfile(sdcs_dir, 'SDCS_Paths_7.mat'));

%% Generate A* routes
mission_paths = generate_mission_paths();

%% Print route details
[nodes, edges, names] = waypoint_map();

fprintf('\n=== A* ROUTE: Hub -> Pickup ===\n');
[path_nodes1, ~, dist1] = astar_planner(nodes, edges, 1, 36);
for i = 1:length(path_nodes1)
    n = path_nodes1(i);
    fprintf('  %2d: %s (%.3f, %.3f)\n', n, names{n}, nodes(n,1), nodes(n,2));
end
fprintf('  Distance: %.2f m\n', dist1);

fprintf('\n=== A* ROUTE: Pickup -> Dropoff ===\n');
[path_nodes2, ~, dist2] = astar_planner(nodes, edges, 36, 37);
for i = 1:length(path_nodes2)
    n = path_nodes2(i);
    fprintf('  %2d: %s (%.3f, %.3f)\n', n, names{n}, nodes(n,1), nodes(n,2));
end
fprintf('  Distance: %.2f m\n', dist2);

fprintf('\n=== A* ROUTE: Dropoff -> Hub ===\n');
[path_nodes3, ~, dist3] = astar_planner(nodes, edges, 37, 1);
for i = 1:length(path_nodes3)
    n = path_nodes3(i);
    fprintf('  %2d: %s (%.3f, %.3f)\n', n, names{n}, nodes(n,1), nodes(n,2));
end
fprintf('  Distance: %.2f m\n', dist3);

fprintf('\nTotal mission: %.2f m\n', dist1 + dist2 + dist3);

%% Plot: A* route overlaid on SDCS paths
figure('Name', 'A* Route vs SDCS Paths', 'NumberTitle', 'off', ...
    'Position', [50 50 1000 900]);
hold on;

% SDCS paths (faint, for road reference)
path_names = {'path_x', 'path_x2', 'path_x3', 'path_x4', 'path_x5', 'path_x6', 'path_x7'};
path_ynames = {'path_y', 'path_y2', 'path_y3', 'path_y4', 'path_y5', 'path_y6', 'path_y7'};
for i = 1:7
    px = data.(path_names{i});
    py = data.(path_ynames{i});
    plot(px, py, '-', 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5, 'HandleVisibility', 'off');
end

% Waypoint graph edges
for i = 1:size(edges, 1)
    n1 = edges(i,1); n2 = edges(i,2);
    plot([nodes(n1,1) nodes(n2,1)], [nodes(n1,2) nodes(n2,2)], ...
        'k--', 'LineWidth', 0.5, 'HandleVisibility', 'off');
end

% Waypoint nodes with labels
plot(nodes(:,1), nodes(:,2), 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'w', ...
    'DisplayName', 'Waypoints');
for i = 1:size(nodes, 1)
    text(nodes(i,1)+0.03, nodes(i,2)+0.03, sprintf('%d', i), 'FontSize', 7);
end

% A* route
route = mission_paths.full_route;
leg1_end = mission_paths.leg_lengths(1);
leg2_end = leg1_end + mission_paths.leg_lengths(2) - 1;

plot(route(1:leg1_end, 1), route(1:leg1_end, 2), 'g-', 'LineWidth', 3, ...
    'DisplayName', 'A* Leg 1: Hub->Pickup');
plot(route(leg1_end:leg2_end, 1), route(leg1_end:leg2_end, 2), 'b-', 'LineWidth', 3, ...
    'DisplayName', 'A* Leg 2: Pickup->Dropoff');
plot(route(leg2_end:end, 1), route(leg2_end:end, 2), 'm-', 'LineWidth', 3, ...
    'DisplayName', 'A* Leg 3: Dropoff->Hub');

% Key locations
plot(-1.205, -0.83, 'mp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Hub');
plot(0.125, 4.395, 'g^', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Pickup');
plot(-0.905, 0.800, 'rs', 'MarkerSize', 15, 'LineWidth', 3, 'DisplayName', 'Dropoff');

% Traffic lights
tl = [0.6, 1.55; -0.6, 1.28; -0.37, 0.3; 0.75, 0.48];
plot(tl(:,1), tl(:,2), 'yo', 'MarkerSize', 10, 'LineWidth', 2, 'MarkerFaceColor', 'y', ...
    'DisplayName', 'Traffic Lights');

legend('Location', 'eastoutside');
xlabel('X (m)'); ylabel('Y (m)');
title('A* Route Overlaid on SDCS Road Paths');
axis equal; grid on;
hold off;

fprintf('\n=== DONE ===\n');
