%% run_instance1_scene.m
% MATLAB Instance 1: Scene setup + Traffic light controller
%
% This script sets up the QLabs environment for the competition.
% It spawns the QCar2 at the Taxi Hub, sets up all signage,
% starts the RT model, and runs the traffic light controller.
%
% PREREQUISITES:
%   - Run QLabs.launch first, select QCar2 + Plane
%   - Wait for QLabs to fully load
%
% NOTE: This script blocks in the traffic light loop.
%       Press Ctrl+C to stop.

fprintf('========================================\n');
fprintf(' Instance 1: Scene Setup\n');
fprintf('========================================\n\n');

%% Add library paths
qvl_path = fullfile('C:\Users\adams\Desktop\Qunaser_Main_Project', ...
    'Quanser_Interactive_Labs_Resources-main', 'matlab', 'qvl');
addpath(qvl_path);

%% Run the official scene setup
% This handles: floor, walls, signs, crosswalks, cameras, car spawn, RT model
cd('C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources');

% Use taxi hub spawn location
spawn_location = 2;

% Run the setup (this will start RT model and enter traffic light loop)
fprintf('Running Setup_Real_Scenario...\n');
fprintf('This will start the traffic light controller (runs forever).\n');
fprintf('Press Ctrl+C to stop.\n\n');
Setup_Real_Scenario;
