function led_cmd = led_controller(mission_state, params)
%LED_CONTROLLER Determine LED color based on mission state.
%
%   led_cmd = led_controller(mission_state, params)
%
%   Returns the appropriate LED color for the QCar2's LED strip
%   based on the current mission state, following competition rules:
%     - Magenta: At hub / returning to hub
%     - Green:   Navigating to pickup
%     - Blue:    At pickup (passenger boarding) / carrying passenger
%     - Orange:  At dropoff (passenger exiting)
%
%   Inputs:
%     mission_state - current FSM state (integer)
%     params        - struct with LED_* fields from Setup_Params_Enhanced
%
%   Outputs:
%     led_cmd - [R, G, B] color values (0-1 scale)

    switch mission_state
        case 0   % IDLE
            led_cmd = params.LED_MAGENTA;

        case 1   % NAV_TO_PICKUP
            led_cmd = params.LED_GREEN;

        case 2   % STOPPING_PICKUP
            led_cmd = params.LED_GREEN;

        case 3   % AT_PICKUP
            led_cmd = params.LED_BLUE;

        case 4   % NAV_TO_DROPOFF
            led_cmd = params.LED_BLUE;

        case 5   % STOPPING_DROPOFF
            led_cmd = params.LED_BLUE;

        case 6   % AT_DROPOFF
            led_cmd = params.LED_ORANGE;

        case 7   % NAV_TO_HUB
            led_cmd = params.LED_MAGENTA;

        case 8   % STOPPING_HUB
            led_cmd = params.LED_MAGENTA;

        case 9   % COMPLETE
            led_cmd = params.LED_MAGENTA;

        case 10  % WAIT_TRAFFIC
            led_cmd = params.LED_YELLOW;

        case 11  % WAIT_STOP_SIGN
            led_cmd = params.LED_RED;

        case 12  % OBSTACLE_STOP
            led_cmd = params.LED_RED;

        otherwise
            led_cmd = params.LED_OFF;
    end
end
