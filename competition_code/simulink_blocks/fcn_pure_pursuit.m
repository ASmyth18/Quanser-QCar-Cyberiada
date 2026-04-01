function [steer_angle, curve_speed_scale] = fcn_pure_pursuit(ekf_x, ekf_y, ekf_heading, car_speed, path_x, path_y, active_path_idx)
%#codegen
% MATLAB Function Block: Pure Pursuit Steering Controller
% Uses persistent forward-only index to prevent backward waypoint snapping.
%
% Inputs:
%   ekf_x, ekf_y    [double] - car position (world frame)
%   ekf_heading      [double] - car heading (radians)
%   car_speed        [double] - current speed (m/s)
%   path_x, path_y   [Nx1 double] - full path waypoints
%   active_path_idx  [double] - which leg (0=stopped, 1-3=legs)
%
% Outputs:
%   steer_angle      [double] - steering angle (radians, positive=right)
%   curve_speed_scale [double] - 0 to 1 speed reduction for curves

    persistent last_nearest_idx;
    if isempty(last_nearest_idx)
        last_nearest_idx = int32(1);
    end

    steer_angle = 0.0;
    curve_speed_scale = 1.0;

    if active_path_idx < 1
        return;
    end

    % Pure Pursuit parameters
    WHEELBASE = 0.256;
    BASE_LOOKAHEAD = 0.30;
    SPEED_GAIN = 0.5;
    MIN_LOOKAHEAD = 0.15;
    MAX_LOOKAHEAD = 0.50;
    MAX_STEER = deg2rad(30);

    % Adaptive lookahead
    Ld = BASE_LOOKAHEAD + SPEED_GAIN * abs(car_speed);
    Ld = max(MIN_LOOKAHEAD, min(MAX_LOOKAHEAD, Ld));

    n_pts = int32(length(path_x));
    if n_pts < int32(2)
        return;
    end

    % --- FORWARD-ONLY nearest waypoint search ---
    % Only search within a window ahead of (and slightly behind) the last
    % known position. This prevents snapping to leg 3 waypoints when the
    % car is on leg 1 (they share the same physical road near the hub).
    BACK_WINDOW  = int32(20);   % allow ~1m backward (20 pts * 5cm)
    FWD_WINDOW   = int32(100);  % search ~5m forward (100 pts * 5cm)

    search_start = max(int32(1), last_nearest_idx - BACK_WINDOW);
    search_end   = min(n_pts, last_nearest_idx + FWD_WINDOW);

    min_dist = inf;
    nearest_idx = last_nearest_idx;
    for i = search_start:search_end
        d = sqrt((path_x(i) - ekf_x)^2 + (path_y(i) - ekf_y)^2);
        if d < min_dist
            min_dist = d;
            nearest_idx = i;
        end
    end

    % If car is very far from the search window (e.g. after reset/teleport),
    % do a full global search as fallback, but only once
    if min_dist > 1.0
        for i = int32(1):n_pts
            d = sqrt((path_x(i) - ekf_x)^2 + (path_y(i) - ekf_y)^2);
            if d < min_dist
                min_dist = d;
                nearest_idx = i;
            end
        end
    end

    % Update persistent index (monotonic: only allow forward or small backward)
    last_nearest_idx = nearest_idx;

    % Find lookahead point (first waypoint beyond Ld, searching forward only)
    look_idx = nearest_idx;
    for i = nearest_idx:n_pts
        d = sqrt((path_x(i) - ekf_x)^2 + (path_y(i) - ekf_y)^2);
        if d >= Ld
            look_idx = i;
            break;
        end
        look_idx = i;
    end

    % Target point
    tx = path_x(look_idx);
    ty = path_y(look_idx);

    % Transform to vehicle frame
    dx = tx - ekf_x;
    dy = ty - ekf_y;
    local_x =  dx * cos(ekf_heading) + dy * sin(ekf_heading);
    local_y = -dx * sin(ekf_heading) + dy * cos(ekf_heading);

    % Pure Pursuit steering law
    actual_Ld = sqrt(local_x^2 + local_y^2);
    if actual_Ld > 0.01
        steer_angle = atan2(2 * WHEELBASE * local_y, actual_Ld^2);
    end

    % Clamp steering
    steer_angle = max(-MAX_STEER, min(MAX_STEER, steer_angle));

    % Slow down in curves: scale speed based on steering magnitude
    % Full speed at 0 steer, 40% speed at max steer
    steer_ratio = abs(steer_angle) / MAX_STEER;
    curve_speed_scale = 1.0 - 0.6 * steer_ratio;
end
