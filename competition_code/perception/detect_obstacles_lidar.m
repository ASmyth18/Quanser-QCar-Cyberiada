function [obstacle_detected, closest_dist, closest_angle, num_obstacles] = ...
    detect_obstacles_lidar(angles, distances, params)
%DETECT_OBSTACLES_LIDAR Detect obstacles from LIDAR scan data.
%
%   [obstacle_detected, closest_dist, closest_angle, num_obstacles] = ...
%       detect_obstacles_lidar(angles, distances, params)
%
%   Processes LIDAR scan data to detect obstacles in the forward path
%   using range filtering and point clustering.
%
%   Inputs:
%     angles    - Nx1 array of scan angles in radians (0 = forward, CCW)
%     distances - Nx1 array of distances in meters
%     params    - struct with LIDAR_* fields from Setup_Params_Enhanced
%
%   Outputs:
%     obstacle_detected - logical, true if obstacle in forward path
%     closest_dist      - distance to nearest obstacle (meters)
%     closest_angle     - angle to nearest obstacle (radians)
%     num_obstacles     - number of distinct obstacle clusters detected

    obstacle_detected = false;
    closest_dist = inf;
    closest_angle = 0;
    num_obstacles = 0;

    if isempty(angles) || isempty(distances)
        return;
    end

    n = length(angles);

    % Filter by range
    valid = (distances > params.LIDAR_MIN_RANGE) & ...
            (distances < params.LIDAR_MAX_RANGE);

    % Filter by forward cone
    % Angles: 0 = forward, wrapping around to 2*pi
    % Forward cone: angle < half_angle OR angle > (2*pi - half_angle)
    half_angle = params.LIDAR_FORWARD_ANGLE;
    forward = (angles < half_angle) | (angles > (2*pi - half_angle));

    % Combined mask
    mask = valid & forward;

    if ~any(mask)
        return;
    end

    % Get forward points
    fwd_angles = angles(mask);
    fwd_dists  = distances(mask);

    % Convert to XY for clustering
    x = sin(fwd_angles) .* fwd_dists;
    y = cos(fwd_angles) .* fwd_dists;

    % Simple distance-based clustering (DBSCAN-like single pass)
    n_pts = length(x);
    cluster_id = zeros(n_pts, 1);
    current_cluster = 0;

    % Sort by angle for sequential clustering
    [~, sort_idx] = sort(fwd_angles);
    x_sorted = x(sort_idx);
    y_sorted = y(sort_idx);
    d_sorted = fwd_dists(sort_idx);
    a_sorted = fwd_angles(sort_idx);

    for i = 1:n_pts
        if cluster_id(i) == 0
            % Start new cluster
            current_cluster = current_cluster + 1;
            cluster_id(i) = current_cluster;

            % Grow cluster
            for j = (i+1):n_pts
                if cluster_id(j) == 0
                    dx = x_sorted(j) - x_sorted(i);
                    dy = y_sorted(j) - y_sorted(i);
                    dist_between = sqrt(dx^2 + dy^2);

                    if dist_between < params.LIDAR_CLUSTER_DIST
                        cluster_id(j) = current_cluster;
                    end
                end
            end
        end
    end

    % Analyze clusters
    num_clusters = current_cluster;
    valid_obstacles = 0;

    for c = 1:num_clusters
        c_mask = (cluster_id == c);
        c_count = sum(c_mask);

        if c_count >= params.LIDAR_MIN_CLUSTER
            valid_obstacles = valid_obstacles + 1;
            c_min_dist = min(d_sorted(c_mask));
            c_mean_angle = mean(a_sorted(c_mask));

            if c_min_dist < closest_dist
                closest_dist = c_min_dist;
                closest_angle = c_mean_angle;
            end
        end
    end

    num_obstacles = valid_obstacles;

    if valid_obstacles > 0
        obstacle_detected = true;
    end
end
