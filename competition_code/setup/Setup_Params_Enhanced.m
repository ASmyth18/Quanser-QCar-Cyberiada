%% Setup_Params_Enhanced.m
% Enhanced parameter configuration for the Quanser Self-Driving Car Competition.
% Extends Setup_QCar2_Params.m with mission-specific parameters,
% perception tuning, and path planning configuration.
%
% Run this AFTER Setup_QCar2_Params.m to add competition-specific params.

%% ===== MISSION CONFIGURATION =====

% Key locations in WORLD coordinates (meters)
% These are the competition-defined coordinates
TAXI_HUB_POS    = [-1.205, -0.83];     % Starting position
% Heading: LIDAR Match Scans has two Gain [1 -1 -1] that cancel out,
% so heading output is in scan matching convention = WORLD frame.
% Both position and heading converge to WORLD frame after LIDAR lock.
TAXI_HUB_YAW_QLABS = -44.7;           % QLabs spawn yaw (degrees)
TAXI_HUB_YAW    = deg2rad(TAXI_HUB_YAW_QLABS); % World frame heading (rad)
PICKUP_POS      = [0.125, 4.395];      % Passenger pickup location
DROPOFF_POS     = [-0.905, 0.800];     % Passenger dropoff location

% Calibration origin (for reference only - NOT used for path conversion)
CAL_ORIGIN = [0, 2.0];  % cal_pos(1:2) from Setup_QCar2_Params

% All coordinates in WORLD frame (stateEstimation outputs world frame
% because LIDAR localization adds calibration bias internally)
TAXI_HUB_WORLD  = TAXI_HUB_POS;
PICKUP_WORLD    = PICKUP_POS;
DROPOFF_WORLD   = DROPOFF_POS;

% EKF aliases (same as WORLD - LIDAR localization outputs world coords)
TAXI_HUB_EKF    = TAXI_HUB_WORLD;
PICKUP_EKF      = PICKUP_WORLD;
DROPOFF_EKF     = DROPOFF_WORLD;

% Arrival thresholds
POSITION_TOLERANCE  = 0.08;   % meters - how close to target before "arrived"
HEADING_TOLERANCE   = deg2rad(15); % radians - heading alignment at stops
STOP_SPEED_THRESH   = 0.01;  % m/s - speed below which car is "stopped"
STOP_DURATION       = 2.0;   % seconds to remain stopped at pickup/dropoff

%% ===== SPEED CONFIGURATION =====

CRUISE_SPEED        = 0.3;    % m/s - normal driving speed (1/10 scale)
APPROACH_SPEED      = 0.15;   % m/s - slowing down near waypoints
INTERSECTION_SPEED  = 0.2;    % m/s - speed through intersections
ROUNDABOUT_SPEED    = 0.15;   % m/s - speed in roundabout
MAX_SPEED           = 0.5;    % m/s - absolute maximum speed

% Speed reduction distances
APPROACH_DIST       = 0.3;    % meters - start slowing this far from target
STOP_DIST           = 0.05;   % meters - full stop distance

%% ===== PURE PURSUIT CONTROLLER =====

PP_LOOKAHEAD_DIST   = 0.25;   % meters - lookahead distance
PP_MIN_LOOKAHEAD    = 0.10;   % meters - minimum lookahead
PP_MAX_LOOKAHEAD    = 0.50;   % meters - maximum lookahead
PP_SPEED_GAIN       = 0.5;    % lookahead scales with speed
PP_WHEELBASE        = 0.256;  % meters - QCar2 wheelbase (L)

%% ===== STEERING PD CONTROLLER (override if needed) =====
% These are set in Setup_QCar2_Params.m but can be overridden:
% steering_Kp = 1.2;
% steering_Kd = 0.6;
MAX_STEER_ANGLE     = deg2rad(30); % Maximum steering angle (rad)

%% ===== PERCEPTION: TRAFFIC LIGHT DETECTION =====

% HSV thresholds for traffic light color detection (OpenCV-style H: 0-180)
% Red light detection
TL_RED_H_LOW1   = 0;    TL_RED_H_HIGH1  = 10;
TL_RED_H_LOW2   = 170;  TL_RED_H_HIGH2  = 180;
TL_RED_S_LOW    = 100;  TL_RED_S_HIGH   = 255;
TL_RED_V_LOW    = 100;  TL_RED_V_HIGH   = 255;

% Yellow light detection
TL_YEL_H_LOW   = 15;   TL_YEL_H_HIGH   = 35;
TL_YEL_S_LOW   = 100;  TL_YEL_S_HIGH   = 255;
TL_YEL_V_LOW   = 100;  TL_YEL_V_HIGH   = 255;

% Green light detection
TL_GRN_H_LOW   = 40;   TL_GRN_H_HIGH   = 85;
TL_GRN_S_LOW   = 80;   TL_GRN_S_HIGH   = 255;
TL_GRN_V_LOW   = 80;   TL_GRN_V_HIGH   = 255;

% Minimum blob area to consider a valid traffic light (pixels^2)
TL_MIN_AREA     = 50;
TL_MAX_AREA     = 5000;

% ROI for traffic light detection in front camera image (640x480)
% [y_start, y_end, x_start, x_end]
TL_ROI = [1, 300, 1, 640];

%% ===== PERCEPTION: STOP SIGN DETECTION =====

% Red color thresholds for stop sign (HSV)
SS_RED_H_LOW1   = 0;    SS_RED_H_HIGH1  = 8;
SS_RED_H_LOW2   = 172;  SS_RED_H_HIGH2  = 180;
SS_RED_S_LOW    = 120;  SS_RED_S_HIGH   = 255;
SS_RED_V_LOW    = 70;   SS_RED_V_HIGH   = 255;

SS_MIN_AREA     = 100;   % Minimum area for a stop sign blob
SS_STOP_DIST    = 0.3;   % meters - distance to stop before stop sign

%% ===== PERCEPTION: YIELD & ROUNDABOUT SIGN DETECTION =====

% Roundabout sign: yellow diamond
% Yellow HSV range (OpenCV-style H: 0-180)
RS_YEL_H_LOW   = 15;   RS_YEL_H_HIGH   = 35;
RS_YEL_S_LOW   = 80;   RS_YEL_S_HIGH   = 255;
RS_YEL_V_LOW   = 80;   RS_YEL_V_HIGH   = 255;

% Yield sign: uses same red detection as stop sign (SS_RED_* params)
% Distinguished from stop sign by shape (inverted triangle vs octagon)

% Sign proximity detection (map-based, supplements vision)
YIELD_SIGN_POSITIONS = [
    0.75,  1.20;   % Near intersection
   -0.60,  0.80;   % West road
    1.50,  2.80;   % East roundabout approach
   -0.30,  3.50;   % NW area
];
YIELD_SIGN_DETECTION_RADIUS = 0.4;

ROUNDABOUT_SIGN_POSITIONS = [
    0.80,  2.50;   % Roundabout south entry
    0.50,  3.80;   % Roundabout north entry
   -0.20,  3.20;   % Roundabout west entry
];
ROUNDABOUT_SIGN_DETECTION_RADIUS = 0.4;

%% ===== PERCEPTION: LANE DETECTION =====

% Yellow lane line detection (HSV)
LANE_YEL_H_LOW  = 15;  LANE_YEL_H_HIGH = 40;
LANE_YEL_S_LOW  = 80;  LANE_YEL_S_HIGH = 255;
LANE_YEL_V_LOW  = 100; LANE_YEL_V_HIGH = 255;

% White lane line detection (HSV)
LANE_WHT_S_LOW  = 0;   LANE_WHT_S_HIGH = 50;
LANE_WHT_V_LOW  = 200; LANE_WHT_V_HIGH = 255;

% Lane detection ROI in front camera (640x480)
% Focus on lower portion of image where road lines appear
LANE_ROI = [350, 480, 50, 600];

%% ===== PERCEPTION: LIDAR OBSTACLE DETECTION =====

LIDAR_MIN_RANGE      = 0.05;   % meters - ignore points closer than this
LIDAR_MAX_RANGE      = 2.0;    % meters - ignore points farther than this
LIDAR_FORWARD_ANGLE  = deg2rad(45);  % cone half-angle for forward detection
LIDAR_CLUSTER_DIST   = 0.1;    % meters - distance threshold for clustering
LIDAR_MIN_CLUSTER    = 3;      % minimum points in a cluster to be obstacle
OBSTACLE_STOP_DIST   = 0.3;    % meters - stop if obstacle closer than this
OBSTACLE_SLOW_DIST   = 0.6;    % meters - slow down if obstacle within this

%% ===== LED COLORS (RGB 0-1) =====

LED_MAGENTA  = [1.0, 0.0, 1.0];   % At hub / returning
LED_GREEN    = [0.0, 1.0, 0.0];   % Navigating to pickup
LED_BLUE     = [0.0, 0.0, 1.0];   % At pickup (boarding)
LED_ORANGE   = [1.0, 0.5, 0.0];   % At dropoff
LED_RED      = [1.0, 0.0, 0.0];   % Emergency stop
LED_YELLOW   = [1.0, 1.0, 0.0];   % Waiting at traffic light
LED_OFF      = [0.0, 0.0, 0.0];   % LEDs off

%% ===== TRAFFIC LIGHT LOCATIONS (world coordinates) =====
% From Setup_Real_Scenario.m - traffic light positions
TLIGHT_POSITIONS = [
    0.60,  1.55;   % Light 1 (heading 0°)
   -0.60,  1.28;   % Light 2 (heading 90°)
   -0.37,  0.30;   % Light 3 (heading 180°)
    0.75,  0.48;   % Light 4 (heading -90°)
];

% Keep in world frame (stateEstimation outputs world frame)
TLIGHT_POSITIONS_WORLD = TLIGHT_POSITIONS;

% Intersection center (average of traffic light positions)
INTERSECTION_CENTER = mean(TLIGHT_POSITIONS, 1);
INTERSECTION_CENTER_WORLD = INTERSECTION_CENTER;
INTERSECTION_RADIUS = 0.5; % meters - how close to detect "at intersection"

%% ===== STOP SIGN LOCATIONS (world coordinates) =====
STOP_SIGN_POSITIONS = [
   -1.50,  3.60;   % Parking lot entrance 1
   -1.50,  2.20;   % Parking lot entrance 2
    2.41,  0.206;  % East side road
    1.766, 1.697;  % East side road
];
STOP_SIGN_POSITIONS_WORLD = STOP_SIGN_POSITIONS;
STOP_SIGN_DETECTION_RADIUS = 0.4; % meters - detect nearby stop signs

%% ===== ROUNDABOUT CONFIGURATION =====
ROUNDABOUT_CENTER = [1.2, 3.2];  % Approximate roundabout center (world)
ROUNDABOUT_CENTER_WORLD = ROUNDABOUT_CENTER;
ROUNDABOUT_RADIUS = 0.8;  % meters - roundabout outer radius

%% ===== STATE MACHINE STATES =====
STATE_IDLE              = 0;
STATE_NAV_TO_PICKUP     = 1;
STATE_STOPPING_PICKUP   = 2;
STATE_AT_PICKUP         = 3;
STATE_NAV_TO_DROPOFF    = 4;
STATE_STOPPING_DROPOFF  = 5;
STATE_AT_DROPOFF        = 6;
STATE_NAV_TO_HUB        = 7;
STATE_STOPPING_HUB      = 8;
STATE_COMPLETE          = 9;
STATE_WAIT_TRAFFIC      = 10;
STATE_WAIT_STOP_SIGN    = 11;
STATE_OBSTACLE_STOP     = 12;

%% ===== TIMING =====
MISSION_TIMEOUT     = 180;    % seconds - max time for entire mission
TRAFFIC_WAIT_MAX    = 30;     % seconds - max wait at traffic light
STOP_SIGN_WAIT      = 3.0;   % seconds - duration to stop at stop sign

%% ===== EKF FRAME ALIASES =====
% EKF outputs WORLD frame (LIDAR localization adds cal bias internally)
INTERSECTION_CENTER_EKF = INTERSECTION_CENTER_WORLD;
ROUNDABOUT_CENTER_EKF   = ROUNDABOUT_CENTER_WORLD;
STOP_SIGN_POSITIONS_EKF = STOP_SIGN_POSITIONS_WORLD;

%% ===== INITIALIZATION =====
Initialization_Time = 3.0;  % seconds before mission starts

disp('Enhanced competition parameters loaded successfully.');
disp(['  Taxi Hub (WORLD): [', num2str(TAXI_HUB_WORLD), ']']);
disp(['  Pickup   (WORLD): [', num2str(PICKUP_WORLD), ']']);
disp(['  Dropoff  (WORLD): [', num2str(DROPOFF_WORLD), ']']);
