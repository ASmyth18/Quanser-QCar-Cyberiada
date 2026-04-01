function [new_state, active_path_idx, desired_speed, led_color, ...
         status_msg] = mission_state_machine(...
    current_state, car_pos, car_speed, ...
    dist_to_destination, traffic_light, stop_sign_detected, ...
    obstacle_dist, elapsed_time, stop_timer, params)
%MISSION_STATE_MACHINE Finite state machine for the taxi mission.
%
%   Controls the high-level behavior of the self-driving car through
%   the competition scenario: Hub → Pickup → Dropoff → Hub.
%
%   States (from Setup_Params_Enhanced):
%     0: IDLE              - Waiting at hub
%     1: NAV_TO_PICKUP     - Driving to pickup location
%     2: STOPPING_PICKUP   - Decelerating at pickup
%     3: AT_PICKUP         - Stopped, passenger boarding
%     4: NAV_TO_DROPOFF    - Driving to dropoff
%     5: STOPPING_DROPOFF  - Decelerating at dropoff
%     6: AT_DROPOFF        - Stopped, passenger exiting
%     7: NAV_TO_HUB        - Returning to hub
%     8: STOPPING_HUB      - Decelerating at hub
%     9: COMPLETE          - Mission complete
%    10: WAIT_TRAFFIC      - Waiting at red traffic light
%    11: WAIT_STOP_SIGN    - Waiting at stop sign
%    12: OBSTACLE_STOP     - Emergency stop for obstacle
%
%   Inputs:
%     current_state       - current FSM state
%     car_pos             - [x, y] current position (EKF frame)
%     car_speed           - current speed (m/s)
%     dist_to_destination - distance to current target (meters)
%     traffic_light       - 0: none, 1: red, 2: yellow, 3: green
%     stop_sign_detected  - logical
%     obstacle_dist       - distance to nearest obstacle (meters)
%     elapsed_time        - time since entering current state (seconds)
%     stop_timer          - time spent stopped (seconds)
%     params              - struct from Setup_Params_Enhanced
%
%   Outputs:
%     new_state       - next FSM state
%     active_path_idx - which path to follow (1=hub->pickup, 2=pickup->drop, 3=drop->hub, 0=none)
%     desired_speed   - target speed (m/s)
%     led_color       - [R, G, B] LED color (0-1)
%     status_msg      - descriptive status string

    new_state = current_state;
    active_path_idx = 0;
    desired_speed = 0;
    led_color = params.LED_MAGENTA;
    status_msg = '';

    switch current_state

        case 0  % IDLE
            led_color = params.LED_MAGENTA;
            desired_speed = 0;
            active_path_idx = 0;
            status_msg = 'IDLE: At taxi hub, ready to start';

            % Auto-start after initialization time
            if elapsed_time > params.Initialization_Time
                new_state = 1;  % NAV_TO_PICKUP
            end

        case 1  % NAV_TO_PICKUP
            led_color = params.LED_GREEN;
            active_path_idx = 1;
            desired_speed = params.CRUISE_SPEED;
            status_msg = sprintf('NAV_TO_PICKUP: %.2fm to pickup', dist_to_destination);

            % Check arrival at pickup
            if dist_to_destination < params.POSITION_TOLERANCE
                new_state = 2;  % STOPPING_PICKUP
            end

            % Handle traffic events
            [new_state, desired_speed] = handle_traffic_events(...
                new_state, desired_speed, traffic_light, ...
                stop_sign_detected, obstacle_dist, car_pos, params);

        case 2  % STOPPING_PICKUP
            led_color = params.LED_GREEN;
            active_path_idx = 1;
            desired_speed = 0;
            status_msg = 'STOPPING_PICKUP: Decelerating at pickup';

            if abs(car_speed) < params.STOP_SPEED_THRESH
                new_state = 3;  % AT_PICKUP
            end

        case 3  % AT_PICKUP
            led_color = params.LED_BLUE;
            active_path_idx = 0;
            desired_speed = 0;
            status_msg = sprintf('AT_PICKUP: Boarding (%.1fs)', stop_timer);

            % Wait for passenger boarding
            if stop_timer >= params.STOP_DURATION
                new_state = 4;  % NAV_TO_DROPOFF
            end

        case 4  % NAV_TO_DROPOFF
            led_color = params.LED_BLUE;  % Carrying passenger
            active_path_idx = 2;
            desired_speed = params.CRUISE_SPEED;
            status_msg = sprintf('NAV_TO_DROPOFF: %.2fm to dropoff', dist_to_destination);

            % Check arrival at dropoff
            if dist_to_destination < params.POSITION_TOLERANCE
                new_state = 5;  % STOPPING_DROPOFF
            end

            % Handle traffic events
            [new_state, desired_speed] = handle_traffic_events(...
                new_state, desired_speed, traffic_light, ...
                stop_sign_detected, obstacle_dist, car_pos, params);

        case 5  % STOPPING_DROPOFF
            led_color = params.LED_BLUE;
            active_path_idx = 2;
            desired_speed = 0;
            status_msg = 'STOPPING_DROPOFF: Decelerating at dropoff';

            if abs(car_speed) < params.STOP_SPEED_THRESH
                new_state = 6;  % AT_DROPOFF
            end

        case 6  % AT_DROPOFF
            led_color = params.LED_ORANGE;
            active_path_idx = 0;
            desired_speed = 0;
            status_msg = sprintf('AT_DROPOFF: Unloading (%.1fs)', stop_timer);

            % Wait for passenger exit
            if stop_timer >= params.STOP_DURATION
                new_state = 7;  % NAV_TO_HUB
            end

        case 7  % NAV_TO_HUB
            led_color = params.LED_MAGENTA;
            active_path_idx = 3;
            desired_speed = params.CRUISE_SPEED;
            status_msg = sprintf('NAV_TO_HUB: %.2fm to hub', dist_to_destination);

            % Check arrival at hub
            if dist_to_destination < params.POSITION_TOLERANCE
                new_state = 8;  % STOPPING_HUB
            end

            % Handle traffic events
            [new_state, desired_speed] = handle_traffic_events(...
                new_state, desired_speed, traffic_light, ...
                stop_sign_detected, obstacle_dist, car_pos, params);

        case 8  % STOPPING_HUB
            led_color = params.LED_MAGENTA;
            active_path_idx = 3;
            desired_speed = 0;
            status_msg = 'STOPPING_HUB: Returning to hub';

            if abs(car_speed) < params.STOP_SPEED_THRESH
                new_state = 9;  % COMPLETE
            end

        case 9  % COMPLETE
            led_color = params.LED_MAGENTA;
            active_path_idx = 0;
            desired_speed = 0;
            status_msg = 'COMPLETE: Mission finished!';

        case 10 % WAIT_TRAFFIC
            led_color = params.LED_YELLOW;
            desired_speed = 0;
            status_msg = sprintf('WAIT_TRAFFIC: Red light (%.1fs)', stop_timer);

            % Resume when light turns green
            if traffic_light == 3  % GREEN
                new_state = current_state;  % Will be overridden by caller
                % The caller should restore the previous navigation state
            end

        case 11 % WAIT_STOP_SIGN
            led_color = params.LED_RED;
            desired_speed = 0;
            status_msg = sprintf('WAIT_STOP_SIGN: Stopped (%.1fs)', stop_timer);

            % Resume after stop duration
            if stop_timer >= params.STOP_SIGN_WAIT
                new_state = current_state;  % Will be overridden by caller
            end

        case 12 % OBSTACLE_STOP
            led_color = params.LED_RED;
            desired_speed = 0;
            status_msg = 'OBSTACLE_STOP: Obstacle detected!';

            % Resume when obstacle clears
            if obstacle_dist > params.OBSTACLE_SLOW_DIST
                new_state = current_state;  % Will be overridden by caller
            end

        otherwise
            new_state = 0;
            status_msg = 'ERROR: Unknown state, resetting to IDLE';
    end
end


function [state, speed] = handle_traffic_events(state, speed, ...
    traffic_light, stop_sign, obstacle_dist, car_pos, params)
%HANDLE_TRAFFIC_EVENTS Check for traffic events during navigation.
    % Priority: obstacle > traffic light > stop sign

    % Obstacle check
    if obstacle_dist < params.OBSTACLE_STOP_DIST
        speed = 0;
        return;
    elseif obstacle_dist < params.OBSTACLE_SLOW_DIST
        factor = (obstacle_dist - params.OBSTACLE_STOP_DIST) / ...
                 (params.OBSTACLE_SLOW_DIST - params.OBSTACLE_STOP_DIST);
        speed = speed * max(0, factor);
    end

    % Traffic light check (only near intersection)
    dist_to_int = norm(car_pos - params.INTERSECTION_CENTER_EKF);
    if dist_to_int < params.INTERSECTION_RADIUS * 2
        if traffic_light == 1  % RED
            speed = 0;
        elseif traffic_light == 2  % YELLOW
            speed = min(speed, params.APPROACH_SPEED);
        end
    end

    % Stop sign check
    if stop_sign
        speed = 0;
    end
end
