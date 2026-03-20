function [steer_angle, target_idx, lookahead_pt, cross_track_error] = ...
    pure_pursuit_controller(car_x, car_y, car_heading, speed, path_x, path_y, params)
%PURE_PURSUIT_CONTROLLER Pure Pursuit lateral controller for path following.
%
%   [steer_angle, target_idx, lookahead_pt, cross_track_error] = ...
%       pure_pursuit_controller(car_x, car_y, car_heading, speed, path_x, path_y, params)
%
%   Implements the Pure Pursuit path following algorithm. Computes the
%   steering angle needed to follow a path of waypoints by tracking a
%   lookahead point on the path.
%
%   Inputs:
%     car_x, car_y  - current car position (EKF frame, meters)
%     car_heading   - current car heading (radians, 0 = east, CCW positive)
%     speed         - current speed (m/s)
%     path_x        - Nx1 array of path x-coordinates (EKF frame)
%     path_y        - Nx1 array of path y-coordinates (EKF frame)
%     params        - struct with PP_* fields from Setup_Params_Enhanced
%
%   Outputs:
%     steer_angle      - steering angle in radians (positive = right)
%     target_idx       - index of the nearest waypoint on path
%     lookahead_pt     - [x, y] of the lookahead target point
%     cross_track_error - lateral distance from path (meters)

    n_pts = length(path_x);
    steer_angle = 0;
    target_idx = 1;
    lookahead_pt = [path_x(1), path_y(1)];
    cross_track_error = 0;

    if n_pts < 2
        return;
    end

    % Adaptive lookahead distance based on speed
    Ld = params.PP_LOOKAHEAD_DIST + params.PP_SPEED_GAIN * abs(speed);
    Ld = max(params.PP_MIN_LOOKAHEAD, min(params.PP_MAX_LOOKAHEAD, Ld));

    % Find the nearest point on the path
    dx = path_x - car_x;
    dy = path_y - car_y;
    dists = sqrt(dx.^2 + dy.^2);
    [min_dist, nearest_idx] = min(dists);
    cross_track_error = min_dist;
    target_idx = nearest_idx;

    % Find the lookahead point (first point beyond Ld from car)
    lookahead_idx = nearest_idx;
    for i = nearest_idx:n_pts
        if dists(i) >= Ld
            lookahead_idx = i;
            break;
        end
        if i == n_pts
            lookahead_idx = n_pts;
        end
    end

    % Interpolate lookahead point if between waypoints
    if lookahead_idx > 1 && lookahead_idx < n_pts
        d1 = dists(lookahead_idx - 1);
        d2 = dists(lookahead_idx);

        if abs(d2 - d1) > 1e-6
            t = (Ld - d1) / (d2 - d1);
            t = max(0, min(1, t));
            lx = path_x(lookahead_idx-1) + t * (path_x(lookahead_idx) - path_x(lookahead_idx-1));
            ly = path_y(lookahead_idx-1) + t * (path_y(lookahead_idx) - path_y(lookahead_idx-1));
        else
            lx = path_x(lookahead_idx);
            ly = path_y(lookahead_idx);
        end
    else
        lx = path_x(lookahead_idx);
        ly = path_y(lookahead_idx);
    end

    lookahead_pt = [lx, ly];

    % Transform lookahead point to vehicle frame
    dx_la = lx - car_x;
    dy_la = ly - car_y;

    % Rotate to vehicle frame (vehicle's x-axis is forward)
    local_x =  cos(car_heading) * dx_la + sin(car_heading) * dy_la;
    local_y = -sin(car_heading) * dx_la + cos(car_heading) * dy_la;

    % Pure Pursuit steering law
    % steer = atan2(2 * L * sin(alpha), Ld)
    % where alpha is the angle to the lookahead point in vehicle frame
    % Simplified: steer = atan2(2 * L * local_y, Ld^2)

    L = params.PP_WHEELBASE;
    actual_Ld = sqrt(dx_la^2 + dy_la^2);
    actual_Ld = max(actual_Ld, 0.01);  % prevent division by zero

    steer_angle = atan2(2 * L * local_y, actual_Ld^2);

    % Clamp steering angle
    max_steer = params.MAX_STEER_ANGLE;
    steer_angle = max(-max_steer, min(max_steer, steer_angle));
end
