%% run_data_collection.m
% MATLAB Instance 2: Manual driving with Xbox controller for data collection
%
% PREREQUISITES:
%   - Instance 1 running (Setup_Real_Scenario with spawn_location=2)
%   - Calibration completed
%   - Xbox controller plugged in
%
% AFTER DRIVING:
%   - Stop the model (Ctrl+T or click Stop in Simulink)
%   - Run: extract_training_data

fprintf('========================================\n');
fprintf(' Data Collection: Manual Driving Mode\n');
fprintf('========================================\n\n');

%% Setup paths
cd('C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources');

comp_root = 'C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code';
addpath(genpath(comp_root));

%% Step 1: Load QCar2 parameters
fprintf('Step 1: Loading QCar2 parameters...\n');
Setup_QCar2_Params;

%% Step 2: Open data collection model
fprintf('\nStep 2: Opening data collection model...\n');
fprintf('Controls:\n');
fprintf('  Left Stick X  = Steering\n');
fprintf('  Right Trigger  = Forward speed\n');
fprintf('  Left Trigger   = Reverse (optional)\n\n');
fprintf('Instructions:\n');
fprintf('  1. Click RUN (Monitor & Tune) in Simulink\n');
fprintf('  2. Drive around the entire map slowly\n');
fprintf('  3. Pass through all intersections, signs, traffic lights\n');
fprintf('  4. Vary your lane position for lane detection data\n');
fprintf('  5. When done, STOP the model\n');
fprintf('  6. Run: extract_training_data\n\n');

open_system('VIRTUAL_data_collection');
