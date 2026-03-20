%% run_instance2_drive.m
% MATLAB Instance 2: Load parameters + Run self-driving Simulink model
%
% PREREQUISITES:
%   - Instance 1 must be running (run_instance1_scene.m)
%   - QLabs must show the car spawned at the Taxi Hub
%
% This script:
%   1. Loads QCar2 calibration parameters
%   2. Loads competition paths and mission data
%   3. Opens the Simulink model for running

fprintf('========================================\n');
fprintf(' Instance 2: Self-Driving Controller\n');
fprintf('========================================\n\n');

%% Setup paths
cd('C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources');

comp_root = 'C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code';
addpath(genpath(comp_root));

%% Step 1: Load base QCar2 parameters
fprintf('Step 1: Loading QCar2 parameters...\n');
Setup_QCar2_Params;

%% Step 2: Load competition workspace (paths, mission data)
fprintf('\nStep 2: Loading competition workspace...\n');
run(fullfile(comp_root, 'setup_competition_workspace.m'));

%% Step 3: Open Simulink model
fprintf('\nStep 3: Opening Simulink model...\n');
fprintf('Click the RUN button (green triangle) in Simulink to start.\n');
fprintf('Or run: sim(''VIRTUAL_self_driving_stack_v2'')\n\n');

open_system('VIRTUAL_self_driving_stack_v2');
