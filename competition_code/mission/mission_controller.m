function [speed_override, led_rgb, mission_state_out, status] = mission_controller(car_x, car_y, car_speed, path_index, elapsed_time)
%MISSION_CONTROLLER Self-driving taxi mission logic.
%
%   This function is designed to be placed in a MATLAB Function block
%   inside the Simulink model. It monitors the car's position and
%   controls speed (for stopping at destinations) and LED colors.
%
%   INPUTS (from Simulink signals):
%     car_x, car_y    - Current position from stateEstimation [m, WORLD frame]
%     car_speed        - Current vehicle speed [m/s]
%     path_index       - Current path index from pathPlanner (closest point)
%     elapsed_time     - Simulation time [s]
%
%   OUTPUTS (to Simulink signals):
%     speed_override   - Speed multiplier (0.0 = full stop, 1.0 = normal driving)
%     led_rgb          - [R, G, B] LED color (0-1 scale), 3-element vector
%     mission_state_out - Current mission state (integer, for monitoring)
%     status           - Status flag (0=running, 1=mission complete)
%
%   MISSION STATES:
%     0 = INIT           - Waiting for LIDAR convergence (5s)
%     1 = NAV_TO_PICKUP  - Driving to pickup
%     2 = AT_PICKUP      - Stopped at pickup, waiting
%     3 = NAV_TO_DROPOFF - Driving to dropoff
%     4 = AT_DROPOFF     - Stopped at dropoff, waiting
%     5 = NAV_TO_HUB     - Returning to hub
%     6 = COMPLETE       - Mission finished, stopped at hub

    % Persistent state variables (survive between Simulink timesteps)
    persistent mission_state stop_timer

    if isempty(mission_state)
        mission_state = 0;  % Start in INIT
        stop_timer = 0;
    end

    % === MISSION PARAMETERS ===
    INIT_TIME        = 7.0;    % seconds to wait for LIDAR convergence
    STOP_DURATION    = 3.0;    % seconds to wait at pickup/dropoff
    POSITION_TOL     = 0.35;   % meters - proximity threshold for arrival
    STOP_SPEED_THRESH = 0.02;  % m/s - considered "stopped"

    % Mission locations (WORLD frame)
    PICKUP  = [0.125, 4.395];
    DROPOFF = [-0.905, 0.800];
    HUB     = [-1.205, -0.83];

    % LED colors [R, G, B]
    LED_MAGENTA = [1.0, 0.0, 1.0];  % At hub / returning
    LED_GREEN   = [0.0, 1.0, 0.0];  % Navigating to pickup
    LED_BLUE    = [0.0, 0.0, 1.0];  % At pickup / carrying passenger
    LED_ORANGE  = [1.0, 0.5, 0.0];  % At dropoff

    % Current distances to destinations
    car_pos = [car_x, car_y];
    dist_pickup  = norm(car_pos - PICKUP);
    dist_dropoff = norm(car_pos - DROPOFF);
    dist_hub     = norm(car_pos - HUB);

    % === STATE MACHINE ===
    speed_override = 1.0;  % default: normal speed
    led_rgb = LED_MAGENTA; % default color

    switch mission_state
        case 0  % INIT - wait for systems
            speed_override = 0.0;  % Stay still during init
            led_rgb = LED_MAGENTA;
            if elapsed_time > INIT_TIME
                mission_state = 1;
                fprintf('[MISSION] %.1fs: INIT -> NAV_TO_PICKUP\n', elapsed_time);
            end

        case 1  % NAV_TO_PICKUP
            speed_override = 1.0;
            led_rgb = LED_GREEN;
            if dist_pickup < POSITION_TOL
                mission_state = 2;
                stop_timer = elapsed_time;
                fprintf('[MISSION] %.1fs: Arrived at PICKUP (dist=%.3fm)\n', elapsed_time, dist_pickup);
            end

        case 2  % AT_PICKUP - stopped, waiting
            speed_override = 0.0;
            led_rgb = LED_BLUE;
            if (elapsed_time - stop_timer) > STOP_DURATION
                mission_state = 3;
                fprintf('[MISSION] %.1fs: AT_PICKUP -> NAV_TO_DROPOFF\n', elapsed_time);
            end

        case 3  % NAV_TO_DROPOFF
            speed_override = 1.0;
            led_rgb = LED_BLUE;
            if dist_dropoff < POSITION_TOL
                mission_state = 4;
                stop_timer = elapsed_time;
                fprintf('[MISSION] %.1fs: Arrived at DROPOFF (dist=%.3fm)\n', elapsed_time, dist_dropoff);
            end

        case 4  % AT_DROPOFF - stopped, waiting
            speed_override = 0.0;
            led_rgb = LED_ORANGE;
            if (elapsed_time - stop_timer) > STOP_DURATION
                mission_state = 5;
                fprintf('[MISSION] %.1fs: AT_DROPOFF -> NAV_TO_HUB\n', elapsed_time);
            end

        case 5  % NAV_TO_HUB
            speed_override = 1.0;
            led_rgb = LED_MAGENTA;
            if dist_hub < POSITION_TOL
                mission_state = 6;
                fprintf('[MISSION] %.1fs: Arrived at HUB - MISSION COMPLETE!\n', elapsed_time);
            end

        case 6  % COMPLETE
            speed_override = 0.0;
            led_rgb = LED_MAGENTA;
    end

    mission_state_out = mission_state;
    status = double(mission_state == 6);
end
