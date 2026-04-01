function obstacle_dist = fcn_obstacle_detector(lidar_angles, lidar_dists)
%#codegen
% MATLAB Function Block: LIDAR Obstacle Detector (fully codegen-compatible)
%
% Detects obstacles in the forward path using range filtering and clustering.
%
% Inputs:
%   lidar_angles [Nx1 double] - scan angles (radians, 0=forward, CCW)
%   lidar_dists  [Nx1 double] - distances (meters)
%
% Output:
%   obstacle_dist [double] - distance to nearest obstacle (meters), inf if none

    obstacle_dist = inf;

    n = length(lidar_angles);
    if n < 1
        return;
    end

    % Parameters
    MIN_RANGE     = 0.05;        % ignore closer than this
    MAX_RANGE     = 2.0;         % ignore farther than this
    HALF_ANGLE    = 0.7854;      % pi/4 = 45 deg forward cone
    CLUSTER_DIST  = 0.1;         % clustering threshold (meters)
    MIN_CLUSTER   = 3;           % min points to count as obstacle
    TWO_PI        = 6.2831853;

    % Pass 1: filter valid forward points, find minimum distance
    % Use a fixed-size buffer for codegen
    MAX_FWD_PTS = int32(512);
    fwd_x = zeros(512, 1);
    fwd_y = zeros(512, 1);
    fwd_d = zeros(512, 1);
    fwd_a = zeros(512, 1);
    n_fwd = int32(0);

    for i = 1:n
        d = lidar_dists(i);
        a = lidar_angles(i);

        % Range filter
        if d <= MIN_RANGE || d >= MAX_RANGE
            continue;
        end

        % Forward cone filter: angle < half_angle OR angle > (2pi - half_angle)
        if a > HALF_ANGLE && a < (TWO_PI - HALF_ANGLE)
            continue;
        end

        if n_fwd < MAX_FWD_PTS
            n_fwd = n_fwd + int32(1);
            fwd_x(n_fwd) = sin(a) * d;
            fwd_y(n_fwd) = cos(a) * d;
            fwd_d(n_fwd) = d;
            fwd_a(n_fwd) = a;
        end
    end

    if n_fwd < int32(MIN_CLUSTER)
        return;
    end

    % Pass 2: simple sequential clustering
    % Sort by angle (insertion sort for codegen compatibility)
    for i = 2:int32(n_fwd)
        key_a = fwd_a(i);
        key_x = fwd_x(i);
        key_y = fwd_y(i);
        key_d = fwd_d(i);
        j = i - int32(1);
        while j >= int32(1) && fwd_a(j) > key_a
            fwd_a(j + int32(1)) = fwd_a(j);
            fwd_x(j + int32(1)) = fwd_x(j);
            fwd_y(j + int32(1)) = fwd_y(j);
            fwd_d(j + int32(1)) = fwd_d(j);
            j = j - int32(1);
        end
        fwd_a(j + int32(1)) = key_a;
        fwd_x(j + int32(1)) = key_x;
        fwd_y(j + int32(1)) = key_y;
        fwd_d(j + int32(1)) = key_d;
    end

    % Cluster assignment
    cluster_id = zeros(512, 1, 'int32');
    current_cluster = int32(0);

    for i = 1:int32(n_fwd)
        if cluster_id(i) == int32(0)
            current_cluster = current_cluster + int32(1);
            cluster_id(i) = current_cluster;
            for j = (i + int32(1)):int32(n_fwd)
                if cluster_id(j) == int32(0)
                    dx = fwd_x(j) - fwd_x(i);
                    dy = fwd_y(j) - fwd_y(i);
                    if sqrt(dx*dx + dy*dy) < CLUSTER_DIST
                        cluster_id(j) = current_cluster;
                    end
                end
            end
        end
    end

    % Pass 3: find closest valid cluster (>= MIN_CLUSTER points)
    for c = int32(1):current_cluster
        c_count = int32(0);
        c_min_d = inf;
        for i = 1:int32(n_fwd)
            if cluster_id(i) == c
                c_count = c_count + int32(1);
                if fwd_d(i) < c_min_d
                    c_min_d = fwd_d(i);
                end
            end
        end
        if c_count >= int32(MIN_CLUSTER) && c_min_d < obstacle_dist
            obstacle_dist = c_min_d;
        end
    end

end
