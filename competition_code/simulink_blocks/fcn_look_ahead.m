function [desiredPathXY, currentPathXY, distanceToPath] = fcn_look_ahead(currentPose, lookAheadDistance, path_x, path_y)
%#codegen
% Replacement for the Path 4 Look Ahead Generator.
% Uses clamped (non-wrapping) search to prevent leg-snapping.
%
% The original used mod() to wrap indices, treating the path as circular.
% This path is not circular (Hub->Pickup->Dropoff->Hub, one-shot).
% Clamping prevents the car from snapping to waypoints on a different leg.
%
% Inputs:
%   currentPose        [1x3]  - [x, y, heading] from EKF
%   lookAheadDistance   [1x1]  - lookahead distance in meters
%   path_x, path_y     [Nx1]  - full path waypoints (from workspace)
%
% Outputs:
%   desiredPathXY      [1x2]  - lookahead target point [x, y]
%   currentPathXY      [1x2]  - nearest point on path [x, y]
%   distanceToPath     [1x1]  - distance to nearest path point (m)

    persistent last_idx;
    persistent initialized;
    if isempty(last_idx)
        last_idx = 1;
        initialized = false;
    end

    car_x = currentPose(1);
    car_y = currentPose(2);
    n = length(path_x);

    % Default outputs
    desiredPathXY = [0.0, 0.0];
    currentPathXY = [0.0, 0.0];
    distanceToPath = 100.0;

    if n < 2
        return;
    end

    % ===== Find nearest waypoint (clamped window, no wrapping) =====
    if ~initialized
        % First call: global search to find starting position
        min_dist = 1e9;
        best_idx = 1;
        for i = 1:n
            dx_i = path_x(i) - car_x;
            dy_i = path_y(i) - car_y;
            d = dx_i .* dx_i + dy_i .* dy_i;
            if d < min_dist
                min_dist = d;
                best_idx = i;
            end
        end
        last_idx = best_idx;
        initialized = true;
    else
        % Subsequent calls: windowed search (clamped, no wrapping)
        BACK_WIN  = 15;    % ~75cm backward
        FWD_WIN   = 80;    % ~4m forward
        search_start = max(1, last_idx - BACK_WIN);
        search_end   = min(n, last_idx + FWD_WIN);

        min_dist = 1e9;
        best_idx = last_idx;
        for i = search_start:search_end
            dx_i = path_x(i) - car_x;
            dy_i = path_y(i) - car_y;
            d = dx_i .* dx_i + dy_i .* dy_i;
            if d < min_dist
                min_dist = d;
                best_idx = i;
            end
        end

        % Fallback: if too far from window, do global search once
        if min_dist > 1.0
            for i = 1:n
                dx_i = path_x(i) - car_x;
                dy_i = path_y(i) - car_y;
                d = dx_i .* dx_i + dy_i .* dy_i;
                if d < min_dist
                    min_dist = d;
                    best_idx = i;
                end
            end
        end

        last_idx = best_idx;
    end

    % Current (nearest) path point
    currentPathXY = [path_x(last_idx), path_y(last_idx)];
    dx_c = path_x(last_idx) - car_x;
    dy_c = path_y(last_idx) - car_y;
    distanceToPath = sqrt(dx_c .* dx_c + dy_c .* dy_c);

    % ===== Find lookahead point (forward along path, CLAMPED) =====
    % Convert lookahead distance to approximate index offset
    % At 5mm spacing: 1m ~ 200 indices
    look_pts = max(1, round(lookAheadDistance .* 200.0));
    look_idx = min(n, last_idx + look_pts);

    desiredPathXY = [path_x(look_idx), path_y(look_idx)];
end
