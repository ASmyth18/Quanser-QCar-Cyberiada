function [speed_scale, led_strip] = mission_fcn(car_pose, sim_time, light_color, sign_type, lane_offset, lane_detected, sign_size, obstacle_dist)
%#codegen
% Mission state machine with proximity-gated perception.
%
% Changes from original:
%   - Traffic lights: only react when near intersection (EKF + map)
%   - Traffic lights: instant resume on green (no slow decay)
%   - Stop signs: require proximity to known position AND YOLOv8 detection
%   - Stop signs: approach slowdown based on sign_size, then full stop
%   - Obstacles: LIDAR-based proportional slowdown + hard stop
%   - Yield/roundabout: slowdown only when detected
%
% Inputs:
%   car_pose      [1x3] - [x, y, heading] from EKF (world frame)
%   sim_time      [double] - simulation time (seconds)
%   light_color   [int32] - 0=none, 1=red, 2=yellow, 3=green
%   sign_type     [int32] - 0=none, 1=stop, 2=yield, 3=roundabout
%   lane_offset   [single] - (unused in FSM, kept for wiring)
%   lane_detected [int32]  - (unused in FSM, kept for wiring)
%   sign_size     [single] - bounding box area (w*h pixels)
%   obstacle_dist [double] - distance to nearest LIDAR obstacle (meters)
%
% Outputs:
%   speed_scale [double] - 0 to 1 multiplier on cruise speed
%   led_strip   [1x3]   - RGB color (0-100 per channel)

    persistent state stop_timer
    persistent red_frames yellow_timer red_stop_time
    persistent sign_stop_timer sign_stopped
    persistent was_near_stop_sign
    persistent committed_to_intersection
    persistent red_latched red_cooldown_until

    if isempty(state)
        state = 0;
        stop_timer = 0;
        red_frames = 0;
        yellow_timer = 0;
        red_stop_time = 0;
        sign_stop_timer = 0;
        sign_stopped = false;
        was_near_stop_sign = false;
        red_latched = false;
        red_cooldown_until = 0;
        committed_to_intersection = false;
    end

    car_x = car_pose(1);
    car_y = car_pose(2);
    pos = [car_x, car_y];

    % ===== Known map locations =====
    PICKUP  = [0.125, 4.395];
    DROPOFF = [-0.905, 0.800];
    HUB     = [-1.205, -0.83];

    % Traffic light intersection center (average of 4 light positions)
    INTERSECTION_CENTER = [0.095, 0.9025];
    INTERSECTION_REACT_DIST = 1.0;

    % Roundabout center (average of Round_S/W/NW/N/NE/E nodes)
    ROUNDABOUT_CENTER = [0.15, 3.0];
    ROUNDABOUT_SLOW_DIST = 1.0;   % slow down within this radius

    % Known stop sign positions (world frame)
    % Signs 1 & 2 disabled: parking lot exits, angled and visible from road
    STOP_SIGN_1 = [99.0, 99.0];    % was [-1.50, 3.60]
    STOP_SIGN_2 = [99.0, 99.0];    % was [-1.50, 2.20]
    STOP_SIGN_3 = [2.41, 0.206];
    STOP_SIGN_4 = [1.766, 1.697];
    STOP_SIGN_REACT_DIST = 0.7;  % wider zone (parking lot signs disabled so safe)

    % Thresholds
    TOL  = 0.35;     % arrival tolerance (meters)
    WAIT = 3.0;      % dwell time at pickup/dropoff (seconds)
    INIT = 10.0;     % initialization delay (seconds)
    GRACE = 15.0;    % grace period before perception overrides (seconds)
    STOP_SIGN_WAIT = 2.5;  % how long to stop at stop sign
    RED_DEBOUNCE = 3;       % frames to confirm red light

    % LIDAR obstacle thresholds
    OBS_STOP_DIST = 0.3;   % hard stop
    OBS_SLOW_DIST = 0.6;   % start slowing

    % ===== Proximity checks =====
    dist_to_intersection = sqrt((car_x - INTERSECTION_CENTER(1))^2 + ...
                                (car_y - INTERSECTION_CENTER(2))^2);

    % Heading gate: only react to traffic lights when one is ahead of the car
    % (within ±45°). Prevents reacting to cross-traffic lights.
    car_heading = car_pose(3);
    LIGHT_POS = [0.6, 1.55; -0.6, 1.28; -0.37, 0.3; 0.75, 0.48];
    light_ahead = false;
    for k = 1:4
        angle_to_light = atan2(LIGHT_POS(k,2) - car_y, LIGHT_POS(k,1) - car_x);
        angle_diff = angle_to_light - car_heading;
        angle_diff = mod(angle_diff + pi, 2*pi) - pi;  % normalize to [-pi, pi]
        d_light = sqrt((car_x - LIGHT_POS(k,1))^2 + (car_y - LIGHT_POS(k,2))^2);
        if abs(angle_diff) < pi/4 && d_light < 1.5
            light_ahead = true;
        end
    end

    near_intersection = (dist_to_intersection < INTERSECTION_REACT_DIST) && light_ahead;

    % Check if near any known stop sign
    near_stop_sign = false;
    d1 = sqrt((car_x - STOP_SIGN_1(1))^2 + (car_y - STOP_SIGN_1(2))^2);
    d2 = sqrt((car_x - STOP_SIGN_2(1))^2 + (car_y - STOP_SIGN_2(2))^2);
    d3 = sqrt((car_x - STOP_SIGN_3(1))^2 + (car_y - STOP_SIGN_3(2))^2);
    d4 = sqrt((car_x - STOP_SIGN_4(1))^2 + (car_y - STOP_SIGN_4(2))^2);
    if d1 < STOP_SIGN_REACT_DIST || d2 < STOP_SIGN_REACT_DIST || ...
       d3 < STOP_SIGN_REACT_DIST || d4 < STOP_SIGN_REACT_DIST
        near_stop_sign = true;
    end

    % ===== Default outputs =====
    speed_scale = 1.0;
    led_strip = [100, 0, 100];  % magenta

    % ===== Mission state machine =====
    switch state
        case 0  % IDLE - waiting at hub
            speed_scale = 0;
            if sim_time > INIT
                state = 1;
            end

        case 1  % NAV_TO_PICKUP
            led_strip = [0, 100, 0];  % green
            if norm(pos - PICKUP) < TOL
                state = 2;
                stop_timer = sim_time;
            end

        case 2  % AT_PICKUP - passenger boarding
            speed_scale = 0;
            led_strip = [0, 0, 100];  % blue
            if (sim_time - stop_timer) > WAIT
                state = 3;
            end

        case 3  % NAV_TO_DROPOFF
            led_strip = [0, 0, 100];  % blue (carrying passenger)
            if norm(pos - DROPOFF) < TOL
                state = 4;
                stop_timer = sim_time;
            end

        case 4  % AT_DROPOFF - passenger exiting
            speed_scale = 0;
            led_strip = [100, 50, 0];  % orange
            if (sim_time - stop_timer) > WAIT
                state = 5;
            end

        case 5  % NAV_TO_HUB
            led_strip = [100, 0, 100];  % magenta
            if norm(pos - HUB) < TOL
                state = 6;
            end

        case 6  % COMPLETE
            speed_scale = 0;
    end

    % ===== Perception overrides (only after grace period, only in driving states) =====
    is_driving = (state == 1 || state == 3 || state == 5);
    if sim_time > GRACE && is_driving

        % --- 1. OBSTACLE (highest priority, LIDAR) ---
        if obstacle_dist < OBS_STOP_DIST
            speed_scale = 0;
            led_strip = [100, 0, 0];  % red
            return;
        elseif obstacle_dist < OBS_SLOW_DIST
            factor = (obstacle_dist - OBS_STOP_DIST) / (OBS_SLOW_DIST - OBS_STOP_DIST);
            speed_scale = speed_scale * max(0.1, factor);
        end

        % --- 2. TRAFFIC LIGHT (only near intersection, with committed logic) ---
        COMMITTED_DIST = 0.4;
        if dist_to_intersection < COMMITTED_DIST
            committed_to_intersection = true;
        end
        if dist_to_intersection > INTERSECTION_REACT_DIST
            committed_to_intersection = false;
        end

        % Always slow down when approaching intersection (gives time to react)
        if dist_to_intersection < 0.7 && ~committed_to_intersection
            speed_scale = min(speed_scale, 0.7);
        end

        % Traffic light logic: uses heading gate for initial detection,
        % but once latched on red, only green or timeout releases.
        if red_latched
            % Already stopped at red — only green or hard timeout releases.
            if light_color == int32(3)       % GREEN detected
                red_frames = 0;
                red_latched = false;
                red_stop_time = 0;
                red_cooldown_until = sim_time + 8.0;  % don't re-latch for 8s
            else
                % Hard timeout: release after 4s regardless of what's detected
                if red_stop_time == 0
                    red_stop_time = sim_time;
                end
                if (sim_time - red_stop_time) > 4.0
                    red_frames = 0;
                    red_latched = false;
                    red_stop_time = 0;
                    red_cooldown_until = sim_time + 8.0;  % don't re-latch for 8s
                end
            end

            if red_latched
                speed_scale = 0;
                led_strip = [100, 100, 0];  % yellow LED = waiting
            end
        elseif near_intersection && ~committed_to_intersection && sim_time > red_cooldown_until
            % Not latched and not in cooldown — accumulate red detections
            if light_color == int32(1)       % RED
                red_frames = red_frames + 1;
            elseif light_color == int32(2)   % YELLOW
                red_frames = red_frames + 1;
                speed_scale = min(speed_scale, 0.3);
            elseif light_color == int32(3)   % GREEN
                red_frames = 0;
            end

            if red_frames >= RED_DEBOUNCE
                red_latched = true;
                red_stop_time = 0;
                speed_scale = 0;
                led_strip = [100, 100, 0];
            end
        else
            if ~near_intersection
                red_frames = 0;
                yellow_timer = 0;
            end
        end

        % --- 3. STOP SIGN (map proximity + YOLO, with approach slowdown) ---
        min_stop_dist = min([d1, d2, d3, d4]);
        if near_stop_sign && ~sign_stopped
            if sign_type == int32(1)
                % YOLO confirms stop sign: full stop
                speed_scale = 0;
                led_strip = [100, 0, 0];  % red
                if sign_stop_timer == 0
                    sign_stop_timer = sim_time;
                end
                if (sim_time - sign_stop_timer) > STOP_SIGN_WAIT
                    sign_stopped = true;
                    sign_stop_timer = 0;
                end
            else
                % Approaching: proportional slowdown (closer = slower)
                % At 0.7m: speed_scale=0.5, at 0.3m: speed_scale=0.2
                approach_factor = min_stop_dist / STOP_SIGN_REACT_DIST;
                speed_scale = min(speed_scale, max(0.2, 0.5 * approach_factor + 0.1));
            end
        end

        % Reset stop sign state when car leaves the area
        if ~near_stop_sign && was_near_stop_sign
            sign_stopped = false;
            sign_stop_timer = 0;
        end
        was_near_stop_sign = near_stop_sign;

        % --- 4. YIELD / ROUNDABOUT (slow when detected) ---
        if sign_type == int32(2)
            speed_scale = min(speed_scale, 0.4);
        elseif sign_type == int32(3)
            speed_scale = min(speed_scale, 0.3);
        end

        % --- 5. TIGHT TURN ZONES (map-based speed reduction) ---
        % Roundabout: always slow when nearby (tight curves)
        dist_to_roundabout = sqrt((car_x - ROUNDABOUT_CENTER(1))^2 + ...
                                  (car_y - ROUNDABOUT_CENTER(2))^2);
        if dist_to_roundabout < ROUNDABOUT_SLOW_DIST
            speed_scale = min(speed_scale, 0.3);  % 30% speed in roundabout
        end

        % Intersection: slow when turning through (committed = inside)
        if committed_to_intersection
            speed_scale = min(speed_scale, 0.6);  % 60% speed in intersection
        end
    end

end
