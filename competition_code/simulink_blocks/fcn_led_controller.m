function led_color = fcn_led_controller(mission_state)
%#codegen
% MATLAB Function Block: LED Color Controller
%
% Input:  mission_state [double] - current FSM state (0-12)
% Output: led_color [1x3 double] - RGB color [0-1]

    state = round(mission_state);

    switch state
        case 0  % IDLE (at hub)
            led_color = [1.0, 0.0, 1.0];  % Magenta
        case {1, 2}  % NAV_TO_PICKUP, STOPPING_PICKUP
            led_color = [0.0, 1.0, 0.0];  % Green
        case {3, 4, 5}  % AT_PICKUP, NAV_TO_DROPOFF, STOPPING_DROPOFF
            led_color = [0.0, 0.0, 1.0];  % Blue
        case 6  % AT_DROPOFF
            led_color = [1.0, 0.5, 0.0];  % Orange
        case {7, 8, 9}  % NAV_TO_HUB, STOPPING_HUB, COMPLETE
            led_color = [1.0, 0.0, 1.0];  % Magenta
        case 10  % WAIT_TRAFFIC
            led_color = [1.0, 1.0, 0.0];  % Yellow
        case {11, 12}  % WAIT_STOP_SIGN, OBSTACLE_STOP
            led_color = [1.0, 0.0, 0.0];  % Red
        otherwise
            led_color = [0.0, 0.0, 0.0];  % Off
    end
end
