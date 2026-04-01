function [new_state, active_path, desired_speed, led_color, status_msg] = ...
    mission_state_machine_wrapper(current_state, car_pos, car_speed, ...
    dist_to_dest, traffic_light, stop_sign_detected, obstacle_dist, ...
    elapsed_time, stop_timer)
%MISSION_STATE_MACHINE_WRAPPER Wrapper for mission_state_machine.
%   Called via coder.extrinsic from Simulink.
%   Packs the params struct from workspace variables.

    persistent params_cached
    if isempty(params_cached)
        p = struct();
        p.CRUISE_SPEED = 0.3;
        p.APPROACH_SPEED = 0.15;
        p.INTERSECTION_SPEED = 0.2;
        p.ROUNDABOUT_SPEED = 0.15;
        p.MAX_SPEED = 0.5;
        p.APPROACH_DIST = 0.3;
        p.STOP_DIST = 0.05;
        p.POSITION_TOLERANCE = 0.08;
        p.STOP_SPEED_THRESH = 0.01;
        p.STOP_DURATION = 2.0;
        p.PP_LOOKAHEAD_DIST = 0.25;
        p.PP_MIN_LOOKAHEAD = 0.10;
        p.PP_MAX_LOOKAHEAD = 0.50;
        p.PP_SPEED_GAIN = 0.5;
        p.PP_WHEELBASE = 0.256;
        p.MAX_STEER_ANGLE = deg2rad(30);
        p.INTERSECTION_CENTER_EKF = [0.075, 0.915];
        p.INTERSECTION_RADIUS = 0.5;
        p.ROUNDABOUT_CENTER_EKF = [1.2, 3.2];
        p.ROUNDABOUT_RADIUS = 0.8;
        p.STOP_SIGN_POSITIONS_EKF = [-1.50,3.60; -1.50,2.20; 2.41,0.206; 1.766,1.697];
        p.STOP_SIGN_DETECTION_RADIUS = 0.4;
        p.STOP_SIGN_WAIT = 3.0;
        p.OBSTACLE_STOP_DIST = 0.3;
        p.OBSTACLE_SLOW_DIST = 0.6;
        p.MISSION_TIMEOUT = 180;
        p.LED_MAGENTA = [1.0, 0.0, 1.0];
        p.LED_GREEN = [0.0, 1.0, 0.0];
        p.LED_BLUE = [0.0, 0.0, 1.0];
        p.LED_ORANGE = [1.0, 0.5, 0.0];
        p.LED_RED = [1.0, 0.0, 0.0];
        p.LED_YELLOW = [1.0, 1.0, 0.0];
        p.LED_OFF = [0.0, 0.0, 0.0];
        p.Initialization_Time = 3.0;
        params_cached = p;
    end

    [new_state, active_path, desired_speed, led_color, status_msg] = ...
        mission_state_machine(current_state, car_pos, car_speed, ...
        dist_to_dest, traffic_light, stop_sign_detected, obstacle_dist, ...
        elapsed_time, stop_timer, params_cached);
end
