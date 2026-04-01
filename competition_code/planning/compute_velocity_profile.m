function [v_profile, curvature] = compute_velocity_profile(path_x, path_y, v_max, v_min, a_max)
%COMPUTE_VELOCITY_PROFILE Curvature-based optimal velocity profiling.
%
%   [v_profile, curvature] = compute_velocity_profile(path_x, path_y, v_max, v_min, a_max)
%
%   Computes a speed limit at each waypoint based on local path curvature,
%   then applies forward/backward acceleration passes to ensure the car can
%   physically achieve the target speed at each point (respecting a_max).
%
%   This implements a simplified version of the time-optimal velocity
%   planning algorithm used in autonomous racing, where the velocity at
%   each path point is limited by:
%     1. Lateral acceleration constraint: v <= sqrt(a_lat_max / kappa)
%     2. Longitudinal acceleration constraint: forward/backward pass
%
%   For the QCar2 (1/10 scale, 0.256m wheelbase), tight turns like
%   roundabouts and intersection right-turns require significant slowdown.
%
%   Inputs:
%     path_x  [Nx1] - x coordinates of path waypoints (meters)
%     path_y  [Nx1] - y coordinates of path waypoints (meters)
%     v_max   [1x1] - maximum cruise speed (m/s), e.g. 0.5
%     v_min   [1x1] - minimum speed in curves (m/s), e.g. 0.15
%     a_max   [1x1] - max longitudinal accel/decel (m/s^2), e.g. 0.5
%
%   Outputs:
%     v_profile  [Nx1] - speed limit at each waypoint (m/s)
%     curvature  [Nx1] - signed curvature at each waypoint (1/m)
%
%   The curvature is computed using the Menger curvature formula for
%   three consecutive points, which is numerically stable for densely
%   sampled paths.
%
%   Reference: Braghin et al., "Race driver model", 2008
%              Lipp & Boyd, "Minimum-time speed optimisation over a
%              fixed path", 2014

    n = length(path_x);
    curvature  = zeros(n, 1);
    v_profile  = v_max * ones(n, 1);

    if n < 3
        return;
    end

    % ===== Step 1: Compute curvature using Menger formula =====
    % For three consecutive points P1, P2, P3:
    %   kappa = 2 * |cross(P2-P1, P3-P1)| / (|P2-P1| * |P3-P1| * |P3-P2|)
    % This is the reciprocal of the circumradius of the triangle.
    %
    % We use a sliding window with a stride to reduce noise from the
    % 5mm waypoint spacing while capturing the actual road curvature.

    STRIDE = 10;  % Look 10 points ahead/behind (~5cm at 5mm spacing)

    for i = 1:n
        i_prev = max(1, i - STRIDE);
        i_next = min(n, i + STRIDE);

        if i_prev == i || i_next == i
            curvature(i) = 0;
            continue;
        end

        % Vectors from P_prev to P_curr and P_prev to P_next
        ax = path_x(i)      - path_x(i_prev);
        ay = path_y(i)      - path_y(i_prev);
        bx = path_x(i_next) - path_x(i_prev);
        by = path_y(i_next) - path_y(i_prev);

        % Cross product magnitude (2x triangle area)
        cross_mag = abs(ax * by - ay * bx);

        % Edge lengths
        d1 = sqrt(ax^2 + ay^2);
        d2 = sqrt(bx^2 + by^2);
        cx = path_x(i_next) - path_x(i);
        cy = path_y(i_next) - path_y(i);
        d3 = sqrt(cx^2 + cy^2);

        denom = d1 * d2 * d3;
        if denom > 1e-10
            curvature(i) = 2 * cross_mag / denom;
        end
    end

    % ===== Step 2: Curvature-based speed limit =====
    % Lateral acceleration: a_lat = v^2 * kappa
    % Speed limit:          v <= sqrt(a_lat_max / kappa)
    %
    % For QCar2 on smooth flooring, a_lat_max ~ 0.8 m/s^2 is conservative
    % (avoids tyre slip and kerb mounting on 1/10 scale model)

    A_LAT_MAX = 0.8;  % lateral acceleration limit (m/s^2)

    for i = 1:n
        if curvature(i) > 0.01  % avoid division by tiny curvature
            v_curv = sqrt(A_LAT_MAX / curvature(i));
            v_profile(i) = min(v_max, max(v_min, v_curv));
        end
    end

    % ===== Step 3: Forward pass (acceleration limited) =====
    % Ensure the car can accelerate from current speed to the next
    % point's speed within the distance between them.
    %   v_next^2 <= v_curr^2 + 2 * a_max * ds

    for i = 2:n
        ds = sqrt((path_x(i) - path_x(i-1))^2 + (path_y(i) - path_y(i-1))^2);
        v_reachable = sqrt(v_profile(i-1)^2 + 2 * a_max * ds);
        v_profile(i) = min(v_profile(i), v_reachable);
    end

    % ===== Step 4: Backward pass (deceleration limited) =====
    % Ensure the car can decelerate from current speed to the next
    % point's speed.
    %   v_prev^2 <= v_next^2 + 2 * a_max * ds

    for i = (n-1):-1:1
        ds = sqrt((path_x(i+1) - path_x(i))^2 + (path_y(i+1) - path_y(i))^2);
        v_reachable = sqrt(v_profile(i+1)^2 + 2 * a_max * ds);
        v_profile(i) = min(v_profile(i), v_reachable);
    end

    % ===== Step 5: Smooth the profile =====
    % Apply a simple moving average to avoid jerky speed changes
    WINDOW = 20;  % ~10cm smoothing window
    v_smooth = v_profile;
    for i = 1:n
        i_lo = max(1, i - WINDOW);
        i_hi = min(n, i + WINDOW);
        v_smooth(i) = mean(v_profile(i_lo:i_hi));
    end
    v_profile = v_smooth;

    fprintf('Velocity profile computed:\n');
    fprintf('  Max curvature: %.3f 1/m (radius %.3f m)\n', max(curvature), 1/max(max(curvature), 0.001));
    fprintf('  Speed range: [%.3f, %.3f] m/s\n', min(v_profile), max(v_profile));
    fprintf('  Points below v_max: %d / %d\n', sum(v_profile < v_max - 0.01), n);
end
