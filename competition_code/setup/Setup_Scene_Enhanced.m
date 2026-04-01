%% Setup_Scene_Enhanced.m
% Complete scene setup for the Quanser Self-Driving Car Competition.
% Combines Setup_Competition_Map.m and Setup_Real_Scenario.m into a single
% unified setup script with all traffic elements.
%
% Usage:
%   1. Start QLabs (Quanser Interactive Labs)
%   2. Run this script in MATLAB
%   3. In a SEPARATE MATLAB session, run Setup_QCar2_Params.m then
%      Setup_Params_Enhanced.m
%   4. Open and run VIRTUAL_self_driving_stack_v2.slx
%
% NOTE: The traffic light controller runs in a blocking loop at the end
%       of this script. Run the self-driving stack from a different session.

%% Configuration
spawn_location = 2;  % 1 = calibration, 2 = taxi hub
enable_traffic_lights = true;
enable_signs = true;
enable_crosswalks = true;

%% Add QVL Library to Path
newPathEntry = fullfile(getenv('QAL_DIR'), '0_libraries', 'matlab', 'qvl');
pathCell = regexp(path, pathsep, 'split');
if ispc
    onPath = any(strcmpi(newPathEntry, pathCell));
else
    onPath = any(strcmp(newPathEntry, pathCell));
end
if ~onPath
    path(path, newPathEntry);
    savepath;
end

%% Stop Any Running RT Models
try
    qc_stop_model('tcpip://localhost:17000', 'QCar2_Workspace');
catch
end
pause(1);
try
    qc_stop_model('tcpip://localhost:17000', 'QCar2_Workspace_studio');
catch
end
pause(1);

%% Connect to QLabs
qlabs = QuanserInteractiveLabs();
connection_established = qlabs.open('localhost');
if ~connection_established
    error('Failed to connect to QLabs. Ensure Quanser Interactive Labs is running.');
end
disp('Connected to QLabs');

cleanupObj = onCleanup(@() qlabs.close());
num_destroyed = qlabs.destroy_all_spawned_actors();
fprintf('Destroyed %d existing actors\n', num_destroyed);

%% Spawn Flooring
x_offset = 0.13;
y_offset = 1.67;

hFloor = QLabsQCarFlooring(qlabs);
hFloor.spawn_degrees([x_offset, y_offset, 0.001], [0, 0, -90]);
disp('Floor spawned');

%% Spawn Boundary Walls
hWall = QLabsWalls(qlabs);
hWall.set_enable_dynamics(false);

% Left wall
for y = 0:4
    hWall.spawn_degrees([-2.4 + x_offset, (-y*1.0) + 2.55 + y_offset, 0.001], [0, 0, 0]);
end
% Top wall
for x = 0:4
    hWall.spawn_degrees([-1.9 + x + x_offset, 3.05 + y_offset, 0.001], [0, 0, 90]);
end
% Right wall
for y = 0:5
    hWall.spawn_degrees([2.4 + x_offset, (-y*1.0) + 2.55 + y_offset, 0.001], [0, 0, 0]);
end
% Bottom wall
for x = 0:3
    hWall.spawn_degrees([-0.9 + x + x_offset, -3.05 + y_offset, 0.001], [0, 0, 90]);
end
% Diagonal walls (hub area)
hWall.spawn_degrees([-2.03 + x_offset, -2.275 + y_offset, 0.001], [0, 0, 48]);
hWall.spawn_degrees([-1.575 + x_offset, -2.7 + y_offset, 0.001], [0, 0, 48]);
disp('Walls spawned');

%% Spawn Signs
if enable_signs
    % Stop Signs
    myStopSign = QLabsStopSign(qlabs);
    myStopSign.spawn_degrees([-1.5, 3.6, 0.006], [0, 0, -35], [0.1, 0.1, 0.1], false);
    myStopSign.spawn_degrees([-1.5, 2.2, 0.006], [0, 0, 35], [0.1, 0.1, 0.1], false);
    myStopSign.spawn_degrees([2.410, 0.206, 0.006], [0, 0, -90], [0.1, 0.1, 0.1], false);
    myStopSign.spawn_degrees([1.766, 1.697, 0.006], [0, 0, 90], [0.1, 0.1, 0.1], false);

    % Roundabout Signs
    myRoundaboutSign = QLabsRoundaboutSign(qlabs);
    myRoundaboutSign.spawn_degrees([2.392, 2.522, 0.006], [0, 0, -90], [0.1, 0.1, 0.1], false);
    myRoundaboutSign.spawn_degrees([0.698, 2.483, 0.006], [0, 0, -145], [0.1, 0.1, 0.1], false);
    myRoundaboutSign.spawn_degrees([0.007, 3.973, 0.006], [0, 0, 135], [0.1, 0.1, 0.1], false);

    % Yield Signs
    myYieldSign = QLabsYieldSign(qlabs);
    myYieldSign.spawn_degrees([0.0, -1.3, 0.006], [0, 0, -180], [0.1, 0.1, 0.1], false);
    myYieldSign.spawn_degrees([2.4, 3.2, 0.006], [0, 0, -90], [0.1, 0.1, 0.1], false);
    myYieldSign.spawn_degrees([1.1, 2.8, 0.006], [0, 0, -145], [0.1, 0.1, 0.1], false);
    myYieldSign.spawn_degrees([0.49, 3.8, 0.006], [0, 0, 135], [0.1, 0.1, 0.1], false);

    disp('Signs spawned');
end

%% Spawn Crosswalks
if enable_crosswalks
    myCrossWalk = QLabsCrosswalk(qlabs);
    myCrossWalk.spawn_degrees([-2 + x_offset, -1.475 + y_offset, 0.01], [0, 0, 0], [0.1, 0.1, 0.075], 0);
    myCrossWalk.spawn_degrees([-0.5, 0.95, 0.006], [0, 0, 90], [0.1, 0.1, 0.075], 0);
    myCrossWalk.spawn_degrees([0.15, 0.32, 0.006], [0, 0, 0], [0.1, 0.1, 0.075], 0);
    myCrossWalk.spawn_degrees([0.75, 0.95, 0.006], [0, 0, 90], [0.1, 0.1, 0.075], 0);
    myCrossWalk.spawn_degrees([0.13, 1.57, 0.006], [0, 0, 0], [0.1, 0.1, 0.075], 0);
    myCrossWalk.spawn_degrees([1.45, 0.95, 0.006], [0, 0, 90], [0.1, 0.1, 0.075], 0);

    % White guide lines
    mySpline = QLabsBasicShape(qlabs);
    mySpline.spawn_degrees([2.21, 0.2, 0.006], [0, 0, 0], [0.27, 0.02, 0.001], false);
    mySpline.spawn_degrees([1.951, 1.68, 0.006], [0, 0, 0], [0.27, 0.02, 0.001], false);
    mySpline.spawn_degrees([-0.05, -1.02, 0.006], [0, 0, 90], [0.38, 0.02, 0.001], false);

    disp('Crosswalks and guide lines spawned');
end

%% Spawn Cameras
camera1 = QLabsFreeCamera(qlabs);
camera1.spawn_degrees([0.15, 1.7, 5], [0, 90, 0]);
camera1.possess();

camera2 = QLabsFreeCamera(qlabs);
camera2.spawn_degrees([-0.36 + x_offset, -3.691 + y_offset, 2.652], [0, 47, 90]);
disp('Cameras spawned');

%% Spawn QCar2
calibration_location_rotation = [0, 2.13, 0.005, 0, 0, -90];
taxi_hub_location_rotation = [-1.205, -0.83, 0.005, 0, 0, -44.7];

myCar = QLabsQCar2(qlabs);
switch spawn_location
    case 1
        spawn = calibration_location_rotation;
        disp('Spawning QCar2 at CALIBRATION position');
    case 2
        spawn = taxi_hub_location_rotation;
        disp('Spawning QCar2 at TAXI HUB position');
end
myCar.spawn_id_degrees(0, spawn(1:3), spawn(4:6), [1/10, 1/10, 1/10], 1);

% Set initial LED color to Magenta
myCar.set_led_strip_uniform([1.0, 0.0, 1.0]);
disp('QCar2 spawned with Magenta LEDs');

%% Start QUARC Real-Time Model
file_workspace = fullfile(getenv('RTMODELS_DIR'), 'QCar2', 'QCar2_Workspace_studio.rt-win64');
pause(2);
system(['quarc_run -D -r -t tcpip://localhost:17000 ', file_workspace]);
pause(3);
disp('QUARC workspace model started');

%% Traffic Light Controller (blocking loop)
if enable_traffic_lights
    disp('Starting traffic light controller (runs continuously)...');
    disp('Press Ctrl+C to stop.');

    trafficLight1 = QLabsTrafficLight(qlabs);
    trafficLight2 = QLabsTrafficLight(qlabs);
    trafficLight3 = QLabsTrafficLight(qlabs);
    trafficLight4 = QLabsTrafficLight(qlabs);

    % Intersection 1
    trafficLight1.spawn_id_degrees(1, [0.6, 1.55, 0.006], [0, 0, 0], [0.1, 0.1, 0.1], 0, false);
    trafficLight2.spawn_id_degrees(2, [-0.6, 1.28, 0.006], [0, 0, 90], [0.1, 0.1, 0.1], 0, false);
    trafficLight3.spawn_id_degrees(3, [-0.37, 0.3, 0.006], [0, 0, 180], [0.1, 0.1, 0.1], 0, false);
    trafficLight4.spawn_id_degrees(4, [0.75, 0.48, 0.006], [0, 0, -90], [0.1, 0.1, 0.1], 0, false);

    flag = 0;
    while true
        switch flag
            case 0
                trafficLight1.set_color(QLabsTrafficLight.COLOR_RED);
                trafficLight3.set_color(QLabsTrafficLight.COLOR_RED);
                trafficLight2.set_color(QLabsTrafficLight.COLOR_GREEN);
                trafficLight4.set_color(QLabsTrafficLight.COLOR_GREEN);
            case 1
                trafficLight1.set_color(QLabsTrafficLight.COLOR_RED);
                trafficLight3.set_color(QLabsTrafficLight.COLOR_RED);
                trafficLight2.set_color(QLabsTrafficLight.COLOR_YELLOW);
                trafficLight4.set_color(QLabsTrafficLight.COLOR_YELLOW);
            case 2
                trafficLight1.set_color(QLabsTrafficLight.COLOR_GREEN);
                trafficLight3.set_color(QLabsTrafficLight.COLOR_GREEN);
                trafficLight2.set_color(QLabsTrafficLight.COLOR_RED);
                trafficLight4.set_color(QLabsTrafficLight.COLOR_RED);
            case 3
                trafficLight1.set_color(QLabsTrafficLight.COLOR_YELLOW);
                trafficLight3.set_color(QLabsTrafficLight.COLOR_YELLOW);
                trafficLight2.set_color(QLabsTrafficLight.COLOR_RED);
                trafficLight4.set_color(QLabsTrafficLight.COLOR_RED);
        end
        flag = mod(flag + 1, 4);
        pause(5);
    end
end
