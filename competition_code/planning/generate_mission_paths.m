function mission_paths = generate_mission_paths()
%GENERATE_MISSION_PATHS Generate smooth waypoint paths for the taxi mission.
%
%   mission_paths = generate_mission_paths()
%
%   Generates spline-smoothed waypoint paths for each leg of the taxi mission:
%     Leg 1: Taxi Hub -> Pickup Location
%     Leg 2: Pickup -> Dropoff Location
%     Leg 3: Dropoff -> Taxi Hub (return)
%
%   All coordinates are in WORLD frame (meters), matching the
%   stateEstimation output after LIDAR convergence.

    % Get the road network
    [nodes, edges, ~] = waypoint_map();

    % Key node indices (from waypoint_map.m)
    HUB_NODE     = 1;   % Taxi Hub
    PICKUP_NODE  = 36;  % Pickup location
    DROPOFF_NODE = 37;  % Dropoff location

    % Plan each leg using A*
    fprintf('Planning Leg 1: Hub -> Pickup...\n');
    [~, path1_world, dist1] = astar_planner(nodes, edges, HUB_NODE, PICKUP_NODE);
    fprintf('  Path found: %d waypoints, %.2f m\n', size(path1_world, 1), dist1);

    fprintf('Planning Leg 2: Pickup -> Dropoff...\n');
    [~, path2_world, dist2] = astar_planner(nodes, edges, PICKUP_NODE, DROPOFF_NODE);
    fprintf('  Path found: %d waypoints, %.2f m\n', size(path2_world, 1), dist2);

    fprintf('Planning Leg 3: Dropoff -> Hub...\n');
    [~, path3_world, dist3] = astar_planner(nodes, edges, DROPOFF_NODE, HUB_NODE);
    fprintf('  Path found: %d waypoints, %.2f m\n', size(path3_world, 1), dist3);

    % Smooth and densify paths using spline interpolation
    spacing = 0.05;  % 5cm between points
    path1_smooth = smooth_path(path1_world, spacing);
    path2_smooth = smooth_path(path2_world, spacing);
    path3_smooth = smooth_path(path3_world, spacing);

    fprintf('  Leg 1 smoothed: %d -> %d points\n', size(path1_world,1), size(path1_smooth,1));
    fprintf('  Leg 2 smoothed: %d -> %d points\n', size(path2_world,1), size(path2_smooth,1));
    fprintf('  Leg 3 smoothed: %d -> %d points\n', size(path3_world,1), size(path3_smooth,1));

    % Keep in WORLD frame
    mission_paths.hub_to_pickup  = path1_smooth;
    mission_paths.pickup_to_drop = path2_smooth;
    mission_paths.drop_to_hub    = path3_smooth;

    % Concatenate into one continuous route for pathPlanner
    mission_paths.full_route = [
        path1_smooth;
        path2_smooth(2:end, :);
        path3_smooth(2:end, :);
    ];

    mission_paths.leg_lengths = [
        size(path1_smooth, 1), ...
        size(path2_smooth, 1), ...
        size(path3_smooth, 1), ...
    ];

    fprintf('\nMission paths generated (spline-smoothed):\n');
    fprintf('  Total distance: %.2f m\n', dist1 + dist2 + dist3);
    fprintf('  Total waypoints: %d\n', size(mission_paths.full_route, 1));
end


function smooth = smooth_path(waypoints, spacing)
%SMOOTH_PATH Fit a spline through waypoints and resample at uniform spacing.
%
%   Uses cubic spline interpolation to create smooth curves through
%   the A* waypoint nodes, eliminating sharp corners.
%
%   Inputs:
%     waypoints - Nx2 array of [x, y] from A* planner
%     spacing   - desired distance between output points (meters)
%
%   Output:
%     smooth - Mx2 array of smoothly interpolated [x, y] points

    n = size(waypoints, 1);
    if n < 3
        % Too few points for spline, just densify linearly
        smooth = densify_path(waypoints, spacing);
        return;
    end

    % Compute cumulative arc length along the waypoint chain
    cum_dist = zeros(n, 1);
    for i = 2:n
        cum_dist(i) = cum_dist(i-1) + norm(waypoints(i,:) - waypoints(i-1,:));
    end
    total_len = cum_dist(end);

    if total_len < 1e-6
        smooth = waypoints;
        return;
    end

    % Create uniform parameter values along the arc length
    n_out = max(3, round(total_len / spacing) + 1);
    t_out = linspace(0, total_len, n_out)';

    % Fit cubic spline for x and y separately as functions of arc length
    % Use 'pchip' (Piecewise Cubic Hermite) to avoid overshoot
    % that standard cubic spline can produce at sharp turns
    x_smooth = pchip(cum_dist, waypoints(:,1), t_out);
    y_smooth = pchip(cum_dist, waypoints(:,2), t_out);

    smooth = [x_smooth, y_smooth];

    % Ensure start and end points are exact
    smooth(1, :) = waypoints(1, :);
    smooth(end, :) = waypoints(end, :);
end


function dense_path = densify_path(path, max_spacing)
%DENSIFY_PATH Insert intermediate points so no gap exceeds max_spacing.
    if size(path, 1) < 2
        dense_path = path;
        return;
    end

    dense_path = path(1, :);

    for i = 2:size(path, 1)
        p1 = path(i-1, :);
        p2 = path(i, :);
        seg_dist = norm(p2 - p1);

        if seg_dist > max_spacing
            n_points = ceil(seg_dist / max_spacing);
            for j = 1:n_points
                t = j / n_points;
                interp_pt = p1 + t * (p2 - p1);
                dense_path = [dense_path; interp_pt];
            end
        else
            dense_path = [dense_path; p2];
        end
    end
end
