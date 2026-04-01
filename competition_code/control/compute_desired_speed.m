function desired_speed = compute_desired_speed(car_pos, target_pos, ...
    dist_to_target, obstacle_dist, traffic_light_state, at_stop_sign, params)
%COMPUTE_DESIRED_SPEED Compute target speed based on driving context.
%
%   desired_speed = compute_desired_speed(car_pos, target_pos, ...
%       dist_to_target, obstacle_dist, traffic_light_state, at_stop_sign, params)
%
%   Determines the appropriate speed based on:
%   - Distance to next waypoint/destination
%   - Obstacle proximity
%   - Traffic light state
%   - Stop sign presence
%   - Road context (roundabout, intersection)
%
%   Inputs:
%     car_pos             - [x, y] current position (EKF frame)
%     target_pos          - [x, y] target position (EKF frame)
%     dist_to_target      - distance to final destination (meters)
%     obstacle_dist       - distance to nearest obstacle (meters, inf if none)
%     traffic_light_state - 0: none, 1: red, 2: yellow, 3: green
%     at_stop_sign        - logical, true if near a stop sign
%     params              - struct from Setup_Params_Enhanced
%
%   Outputs:
%     desired_speed - target speed in m/s

    % Start with cruise speed
    desired_speed = params.CRUISE_SPEED;

    % Check if near intersection (traffic light area)
    dist_to_intersection = norm(car_pos - params.INTERSECTION_CENTER_EKF);
    if dist_to_intersection < params.INTERSECTION_RADIUS
        desired_speed = min(desired_speed, params.INTERSECTION_SPEED);
    end

    % Check if in roundabout area
    dist_to_roundabout = norm(car_pos - params.ROUNDABOUT_CENTER_EKF);
    if dist_to_roundabout < params.ROUNDABOUT_RADIUS
        desired_speed = min(desired_speed, params.ROUNDABOUT_SPEED);
    end

    % Traffic light response
    if traffic_light_state == 1  % RED
        if dist_to_intersection < params.INTERSECTION_RADIUS * 1.5
            desired_speed = 0;
        end
    elseif traffic_light_state == 2  % YELLOW
        if dist_to_intersection < params.INTERSECTION_RADIUS
            desired_speed = 0;
        else
            desired_speed = min(desired_speed, params.APPROACH_SPEED);
        end
    end

    % Stop sign response
    if at_stop_sign
        desired_speed = 0;
    end

    % Obstacle avoidance
    if obstacle_dist < params.OBSTACLE_STOP_DIST
        desired_speed = 0;
    elseif obstacle_dist < params.OBSTACLE_SLOW_DIST
        % Proportional slowdown
        slow_factor = (obstacle_dist - params.OBSTACLE_STOP_DIST) / ...
                      (params.OBSTACLE_SLOW_DIST - params.OBSTACLE_STOP_DIST);
        desired_speed = desired_speed * slow_factor;
    end

    % Approach slowdown near destination
    if dist_to_target < params.APPROACH_DIST
        approach_factor = dist_to_target / params.APPROACH_DIST;
        desired_speed = desired_speed * approach_factor;
    end

    % Full stop at destination
    if dist_to_target < params.STOP_DIST
        desired_speed = 0;
    end

    % Enforce limits
    desired_speed = max(0, min(params.MAX_SPEED, desired_speed));
end
