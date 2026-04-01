%% run_competition.m
% Main entry point for the Quanser Self-Driving Car Competition.
%
% This script:
%   1. Loads parameters and generates mission paths
%   2. Initializes the perception, planning, and control systems
%   3. Runs the mission state machine through the complete taxi cycle
%   4. Logs telemetry data for analysis and video demonstration
%
% PREREQUISITES:
%   - QLabs must be running with the scene set up (run Setup_Scene_Enhanced.m
%     in a separate MATLAB session)
%   - QUARC RT model must be running
%   - Setup_QCar2_Params.m must have been run
%
% IMPORTANT: This script is designed as a reference implementation.
%   For the competition submission, integrate these algorithms into the
%   VIRTUAL_self_driving_stack_v2.slx Simulink model as MATLAB Function blocks.

clear;
clc;

fprintf('========================================\n');
fprintf(' Quanser Self-Driving Car Competition\n');
fprintf(' Autonomous Taxi Mission Controller\n');
fprintf('========================================\n\n');

%% Add paths
addpath(genpath(fullfile(pwd, 'setup')));
addpath(genpath(fullfile(pwd, 'perception')));
addpath(genpath(fullfile(pwd, 'planning')));
addpath(genpath(fullfile(pwd, 'control')));
addpath(genpath(fullfile(pwd, 'mission')));

%% Load Parameters
fprintf('Loading parameters...\n');
run('Setup_QCar2_Params.m');
run('Setup_Params_Enhanced.m');

% Pack parameters into a struct for passing to functions
params = pack_params();

%% Load Mission Paths (hand-drawn from manual_waypoint_editor)
fprintf('\nLoading mission paths...\n');
mission_paths = load_manual_paths();
% To revert to A* planning, uncomment: mission_paths = generate_mission_paths();

% Store paths for each leg
paths = {
    mission_paths.hub_to_pickup, ...
    mission_paths.pickup_to_drop, ...
    mission_paths.drop_to_hub ...
};

% Destination positions (EKF frame)
destinations = [
    PICKUP_EKF;
    DROPOFF_EKF;
    TAXI_HUB_EKF;
];

fprintf('Mission paths ready.\n');

%% Initialize State Variables
mission_state = 0;  % IDLE
prev_state = -1;
active_path_idx = 0;
state_entry_time = 0;
stop_timer = 0;
mission_start_time = 0;

% PID state
pid_integral = 0;
pid_prev_error = 0;

% Speed PID gains
speed_Kp = 2.0;
speed_Ki = 0.5;
speed_Kd = 0.1;
max_throttle = 0.5;

% Telemetry logging
log_max = 10000;
log_idx = 0;
log_time = zeros(log_max, 1);
log_x = zeros(log_max, 1);
log_y = zeros(log_max, 1);
log_heading = zeros(log_max, 1);
log_speed = zeros(log_max, 1);
log_steer = zeros(log_max, 1);
log_state = zeros(log_max, 1);

fprintf('\n========================================\n');
fprintf(' Ready to start mission.\n');
fprintf(' The car will begin after %.0fs initialization.\n', Initialization_Time);
fprintf('========================================\n\n');

%% Main Control Loop
% NOTE: In the actual competition, this loop runs inside Simulink
% at Controller_Sample_Time rate. This standalone version simulates
% the control loop for development and testing.

dt = Controller_Sample_Time;
sim_time = 0;
mission_start_time = 0;
running = true;

% Simulated sensor data (replace with actual QUARC data in Simulink)
car_x = TAXI_HUB_EKF(1);
car_y = TAXI_HUB_EKF(2);
car_heading = TAXI_HUB_YAW;
car_speed = 0;

fprintf('Starting control loop (dt = %.4fs)...\n', dt);
fprintf('Press Ctrl+C to stop.\n\n');

try
    while running
        sim_time = sim_time + dt;

        %% === PERCEPTION ===

        % Traffic light detection (placeholder - replace with camera data)
        traffic_light_state = 0;  % 0=none, 1=red, 2=yellow, 3=green
        % In Simulink: use detect_traffic_light() with front camera image

        % Stop sign detection (placeholder)
        stop_sign_detected = false;
        % In Simulink: use detect_stop_sign() with front camera image
        % Also check proximity to known stop sign locations:
        for ss = 1:size(params.STOP_SIGN_POSITIONS_EKF, 1)
            d = norm([car_x, car_y] - params.STOP_SIGN_POSITIONS_EKF(ss, :));
            if d < params.STOP_SIGN_DETECTION_RADIUS
                stop_sign_detected = true;
                break;
            end
        end

        % LIDAR obstacle detection (placeholder)
        obstacle_dist = inf;
        % In Simulink: use detect_obstacles_lidar() with LIDAR data

        %% === STATE MACHINE ===

        % Compute distance to current destination
        if active_path_idx >= 1 && active_path_idx <= 3
            dest = destinations(active_path_idx, :);
            dist_to_dest = norm([car_x, car_y] - dest);
        else
            dist_to_dest = inf;
        end

        % Track state timing
        if mission_state ~= prev_state
            state_entry_time = sim_time;
            stop_timer = 0;
            prev_state = mission_state;
        end

        elapsed_in_state = sim_time - state_entry_time;

        % Update stop timer (time spent at near-zero speed)
        if abs(car_speed) < params.STOP_SPEED_THRESH
            stop_timer = stop_timer + dt;
        else
            stop_timer = 0;
        end

        % Run state machine
        [mission_state, active_path_idx, desired_speed, led_color, status_msg] = ...
            mission_state_machine(mission_state, [car_x, car_y], car_speed, ...
            dist_to_dest, traffic_light_state, stop_sign_detected, ...
            obstacle_dist, elapsed_in_state, stop_timer, params);

        %% === PATH FOLLOWING ===

        steer_angle = 0;

        if active_path_idx >= 1 && active_path_idx <= 3
            current_path = paths{active_path_idx};
            path_x = current_path(:, 1);
            path_y = current_path(:, 2);

            % Pure Pursuit controller
            [steer_angle, ~, ~, cross_track_err] = ...
                pure_pursuit_controller(car_x, car_y, car_heading, ...
                car_speed, path_x, path_y, params);
        end

        %% === SPEED CONTROL ===

        [throttle, pid_prev_error, pid_integral] = ...
            pid_speed_controller(desired_speed, car_speed, dt, ...
            pid_integral, pid_prev_error, speed_Kp, speed_Ki, speed_Kd, max_throttle);

        %% === APPLY CONTROLS ===
        % In Simulink: these values go to the QUARC HIL Write blocks
        % motor_cmd = throttle;
        % steering_cmd = steer_angle;
        % led_cmd = led_color;

        % Simulate vehicle dynamics (simple bicycle model)
        car_speed = car_speed + throttle * dt * 2;  % Simple acceleration
        car_speed = max(-params.MAX_SPEED, min(params.MAX_SPEED, car_speed));

        % Bicycle model kinematics
        if abs(car_speed) > 0.001
            beta = atan(0.5 * tan(steer_angle));
            car_x = car_x + car_speed * cos(car_heading + beta) * dt;
            car_y = car_y + car_speed * sin(car_heading + beta) * dt;
            car_heading = car_heading + (car_speed / params.PP_WHEELBASE) * sin(beta) * dt;
            car_heading = mod(car_heading + pi, 2*pi) - pi;
        end

        %% === LOGGING ===

        if mod(round(sim_time / dt), 50) == 0  % Log every 50 steps
            log_idx = min(log_idx + 1, log_max);
            log_time(log_idx) = sim_time;
            log_x(log_idx) = car_x;
            log_y(log_idx) = car_y;
            log_heading(log_idx) = car_heading;
            log_speed(log_idx) = car_speed;
            log_steer(log_idx) = steer_angle;
            log_state(log_idx) = mission_state;
        end

        % Print status periodically
        if mod(round(sim_time / dt), 500) == 0
            fprintf('[%.1fs] State=%d | Pos=(%.2f, %.2f) | Speed=%.2f | Steer=%.1f° | %s\n', ...
                sim_time, mission_state, car_x, car_y, car_speed, ...
                rad2deg(steer_angle), status_msg);
        end

        % Check mission complete
        if mission_state == 9
            fprintf('\n========================================\n');
            fprintf(' MISSION COMPLETE at t=%.1fs!\n', sim_time);
            fprintf('========================================\n');
            running = false;
        end

        % Check timeout
        if sim_time > params.MISSION_TIMEOUT
            fprintf('\n MISSION TIMEOUT at t=%.1fs\n', sim_time);
            running = false;
        end
    end

catch ME
    fprintf('\nControl loop stopped: %s\n', ME.message);
end

%% Post-Mission Analysis
fprintf('\n--- Telemetry Summary ---\n');
fprintf('Total time: %.1f seconds\n', sim_time);
fprintf('Data points logged: %d\n', log_idx);

if log_idx > 0
    % Plot trajectory
    figure('Name', 'Mission Trajectory', 'NumberTitle', 'off');

    subplot(2, 2, 1);
    plot(log_x(1:log_idx), log_y(1:log_idx), 'b-', 'LineWidth', 1.5);
    hold on;
    plot(PICKUP_EKF(1), PICKUP_EKF(2), 'g^', 'MarkerSize', 12, 'LineWidth', 2);
    plot(DROPOFF_EKF(1), DROPOFF_EKF(2), 'rs', 'MarkerSize', 12, 'LineWidth', 2);
    plot(TAXI_HUB_EKF(1), TAXI_HUB_EKF(2), 'mp', 'MarkerSize', 12, 'LineWidth', 2);
    legend('Trajectory', 'Pickup', 'Dropoff', 'Hub');
    xlabel('X (m)'); ylabel('Y (m)');
    title('Vehicle Trajectory');
    axis equal; grid on;

    subplot(2, 2, 2);
    plot(log_time(1:log_idx), log_speed(1:log_idx));
    xlabel('Time (s)'); ylabel('Speed (m/s)');
    title('Speed Profile'); grid on;

    subplot(2, 2, 3);
    plot(log_time(1:log_idx), rad2deg(log_steer(1:log_idx)));
    xlabel('Time (s)'); ylabel('Steering (deg)');
    title('Steering Angle'); grid on;

    subplot(2, 2, 4);
    stairs(log_time(1:log_idx), log_state(1:log_idx));
    xlabel('Time (s)'); ylabel('State');
    title('Mission State');
    yticks(0:12);
    yticklabels({'IDLE', 'NAV_PICKUP', 'STOP_PICKUP', 'AT_PICKUP', ...
                 'NAV_DROP', 'STOP_DROP', 'AT_DROP', 'NAV_HUB', ...
                 'STOP_HUB', 'COMPLETE', 'WAIT_TL', 'WAIT_SS', 'OBS_STOP'});
    grid on;

    sgtitle('Quanser SDCS - Mission Telemetry');
end


%% Helper: Pack parameters into struct
function p = pack_params()
    % Collect all workspace variables into a params struct
    % This is needed because MATLAB Function blocks in Simulink
    % require structured parameter passing

    p.CRUISE_SPEED = evalin('base', 'CRUISE_SPEED');
    p.APPROACH_SPEED = evalin('base', 'APPROACH_SPEED');
    p.INTERSECTION_SPEED = evalin('base', 'INTERSECTION_SPEED');
    p.ROUNDABOUT_SPEED = evalin('base', 'ROUNDABOUT_SPEED');
    p.MAX_SPEED = evalin('base', 'MAX_SPEED');
    p.APPROACH_DIST = evalin('base', 'APPROACH_DIST');
    p.STOP_DIST = evalin('base', 'STOP_DIST');
    p.POSITION_TOLERANCE = evalin('base', 'POSITION_TOLERANCE');
    p.STOP_SPEED_THRESH = evalin('base', 'STOP_SPEED_THRESH');
    p.STOP_DURATION = evalin('base', 'STOP_DURATION');
    p.Initialization_Time = evalin('base', 'Initialization_Time');

    p.PP_LOOKAHEAD_DIST = evalin('base', 'PP_LOOKAHEAD_DIST');
    p.PP_MIN_LOOKAHEAD = evalin('base', 'PP_MIN_LOOKAHEAD');
    p.PP_MAX_LOOKAHEAD = evalin('base', 'PP_MAX_LOOKAHEAD');
    p.PP_SPEED_GAIN = evalin('base', 'PP_SPEED_GAIN');
    p.PP_WHEELBASE = evalin('base', 'PP_WHEELBASE');
    p.MAX_STEER_ANGLE = evalin('base', 'MAX_STEER_ANGLE');

    p.INTERSECTION_CENTER_EKF = evalin('base', 'INTERSECTION_CENTER_EKF');
    p.INTERSECTION_RADIUS = evalin('base', 'INTERSECTION_RADIUS');
    p.ROUNDABOUT_CENTER_EKF = evalin('base', 'ROUNDABOUT_CENTER_EKF');
    p.ROUNDABOUT_RADIUS = evalin('base', 'ROUNDABOUT_RADIUS');
    p.STOP_SIGN_POSITIONS_EKF = evalin('base', 'STOP_SIGN_POSITIONS_EKF');
    p.STOP_SIGN_DETECTION_RADIUS = evalin('base', 'STOP_SIGN_DETECTION_RADIUS');
    p.STOP_SIGN_WAIT = evalin('base', 'STOP_SIGN_WAIT');

    p.OBSTACLE_STOP_DIST = evalin('base', 'OBSTACLE_STOP_DIST');
    p.OBSTACLE_SLOW_DIST = evalin('base', 'OBSTACLE_SLOW_DIST');

    p.MISSION_TIMEOUT = evalin('base', 'MISSION_TIMEOUT');

    % Traffic light HSV params
    p.TL_RED_H_LOW1 = evalin('base', 'TL_RED_H_LOW1');
    p.TL_RED_H_HIGH1 = evalin('base', 'TL_RED_H_HIGH1');
    p.TL_RED_H_LOW2 = evalin('base', 'TL_RED_H_LOW2');
    p.TL_RED_H_HIGH2 = evalin('base', 'TL_RED_H_HIGH2');
    p.TL_RED_S_LOW = evalin('base', 'TL_RED_S_LOW');
    p.TL_RED_S_HIGH = evalin('base', 'TL_RED_S_HIGH');
    p.TL_RED_V_LOW = evalin('base', 'TL_RED_V_LOW');
    p.TL_RED_V_HIGH = evalin('base', 'TL_RED_V_HIGH');
    p.TL_YEL_H_LOW = evalin('base', 'TL_YEL_H_LOW');
    p.TL_YEL_H_HIGH = evalin('base', 'TL_YEL_H_HIGH');
    p.TL_YEL_S_LOW = evalin('base', 'TL_YEL_S_LOW');
    p.TL_YEL_S_HIGH = evalin('base', 'TL_YEL_S_HIGH');
    p.TL_YEL_V_LOW = evalin('base', 'TL_YEL_V_LOW');
    p.TL_YEL_V_HIGH = evalin('base', 'TL_YEL_V_HIGH');
    p.TL_GRN_H_LOW = evalin('base', 'TL_GRN_H_LOW');
    p.TL_GRN_H_HIGH = evalin('base', 'TL_GRN_H_HIGH');
    p.TL_GRN_S_LOW = evalin('base', 'TL_GRN_S_LOW');
    p.TL_GRN_S_HIGH = evalin('base', 'TL_GRN_S_HIGH');
    p.TL_GRN_V_LOW = evalin('base', 'TL_GRN_V_LOW');
    p.TL_GRN_V_HIGH = evalin('base', 'TL_GRN_V_HIGH');
    p.TL_MIN_AREA = evalin('base', 'TL_MIN_AREA');
    p.TL_MAX_AREA = evalin('base', 'TL_MAX_AREA');
    p.TL_ROI = evalin('base', 'TL_ROI');

    % Stop sign HSV params
    p.SS_RED_H_LOW1 = evalin('base', 'SS_RED_H_LOW1');
    p.SS_RED_H_HIGH1 = evalin('base', 'SS_RED_H_HIGH1');
    p.SS_RED_H_LOW2 = evalin('base', 'SS_RED_H_LOW2');
    p.SS_RED_H_HIGH2 = evalin('base', 'SS_RED_H_HIGH2');
    p.SS_RED_S_LOW = evalin('base', 'SS_RED_S_LOW');
    p.SS_RED_S_HIGH = evalin('base', 'SS_RED_S_HIGH');
    p.SS_RED_V_LOW = evalin('base', 'SS_RED_V_LOW');
    p.SS_RED_V_HIGH = evalin('base', 'SS_RED_V_HIGH');
    p.SS_MIN_AREA = evalin('base', 'SS_MIN_AREA');

    % Roundabout sign HSV params
    p.RS_YEL_H_LOW = evalin('base', 'RS_YEL_H_LOW');
    p.RS_YEL_H_HIGH = evalin('base', 'RS_YEL_H_HIGH');
    p.RS_YEL_S_LOW = evalin('base', 'RS_YEL_S_LOW');
    p.RS_YEL_S_HIGH = evalin('base', 'RS_YEL_S_HIGH');
    p.RS_YEL_V_LOW = evalin('base', 'RS_YEL_V_LOW');
    p.RS_YEL_V_HIGH = evalin('base', 'RS_YEL_V_HIGH');

    p.LED_MAGENTA = evalin('base', 'LED_MAGENTA');
    p.LED_GREEN = evalin('base', 'LED_GREEN');
    p.LED_BLUE = evalin('base', 'LED_BLUE');
    p.LED_ORANGE = evalin('base', 'LED_ORANGE');
    p.LED_RED = evalin('base', 'LED_RED');
    p.LED_YELLOW = evalin('base', 'LED_YELLOW');
    p.LED_OFF = evalin('base', 'LED_OFF');
end
