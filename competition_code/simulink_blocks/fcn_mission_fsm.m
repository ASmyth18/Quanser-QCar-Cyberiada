function [desired_speed, active_path_idx, led_color, mission_state_out] = ...
    fcn_mission_fsm(ekf_pos, car_speed, light_color, sign_type, sign_dist, ...
                    obstacle_dist, mission_state_in, elapsed_time, stop_timer)
%#codegen
% MATLAB Function Block: Mission State Machine
%
% Inputs:
%   ekf_pos        [1x2 double]  - car position [x, y] in world frame
%   car_speed      [double]      - current speed m/s
%   light_color    [int32]       - 0=none, 1=red, 2=yellow, 3=green
%   sign_type      [int32]       - 0=none, 1=stop, 2=yield, 3=roundabout
%   sign_dist      [double]      - distance to detected sign (meters)
%   obstacle_dist  [double]      - distance to nearest obstacle (meters)
%   mission_state_in [double]    - current state (feedback)
%   elapsed_time   [double]      - time in current state (seconds)
%   stop_timer     [double]      - time spent stopped (seconds)
%
% Outputs:
%   desired_speed     [double]   - target speed m/s
%   active_path_idx   [double]   - which path leg (0-3)
%   led_color         [1x3 double] - LED RGB [0-1]
%   mission_state_out [double]   - new state

    % Declare extrinsic for mission_state_machine
    coder.extrinsic('mission_state_machine_wrapper');

    desired_speed = 0.0;
    active_path_idx = 0.0;
    led_color = zeros(1, 3);
    mission_state_out = mission_state_in;

    % Determine if stop sign detected (based on sign type and distance)
    stop_sign_detected = (sign_type == int32(1)) && (sign_dist < 0.5);

    % Compute distance to current destination
    persistent pickup_pos dropoff_pos hub_pos
    if isempty(pickup_pos)
        pickup_pos  = [0.125, 4.395];
        dropoff_pos = [-0.905, 0.800];
        hub_pos     = [-1.205, -0.83];
    end

    destinations = [pickup_pos; dropoff_pos; hub_pos];
    path_idx = round(mission_state_in);

    % Map state to active path
    if path_idx >= 1 && path_idx <= 2  % NAV_TO_PICKUP, STOPPING_PICKUP
        dest = destinations(1, :);
        active_path_idx = 1;
    elseif path_idx >= 4 && path_idx <= 5  % NAV_TO_DROPOFF, STOPPING_DROPOFF
        dest = destinations(2, :);
        active_path_idx = 2;
    elseif path_idx >= 7 && path_idx <= 8  % NAV_TO_HUB, STOPPING_HUB
        dest = destinations(3, :);
        active_path_idx = 3;
    else
        dest = ekf_pos;
        active_path_idx = 0;
    end

    dist_to_dest = norm(ekf_pos - dest);

    % Call state machine
    [new_state, new_path, new_speed, new_led, ~] = ...
        mission_state_machine_wrapper(mission_state_in, ekf_pos, car_speed, ...
        dist_to_dest, double(light_color), stop_sign_detected, ...
        obstacle_dist, elapsed_time, stop_timer);

    mission_state_out = new_state;
    if new_path > 0
        active_path_idx = new_path;
    end
    desired_speed = new_speed;
    led_color = new_led;
end
