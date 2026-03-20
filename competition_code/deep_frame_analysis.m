%% deep_frame_analysis.m
% Definitive test: determine what coordinate frame the stateEstimation
% actually outputs by examining all internal blocks and signal values.

model = 'VIRTUAL_self_driving_stack_v2';
if ~bdIsLoaded(model)
    load_system(model);
end

fprintf('=== DEEP FRAME ANALYSIS ===\n\n');

%% 1. Check lidarLocalization for cal_pos references
fprintf('--- LIDAR LOCALIZATION INTERNALS ---\n');
lidar_path = [model '/lidarLocalization'];
lidar_blocks = find_system(lidar_path, 'BlockType', 'Constant');
for i = 1:length(lidar_blocks)
    val = get_param(lidar_blocks{i}, 'Value');
    name = get_param(lidar_blocks{i}, 'Name');
    fprintf('  Constant "%s" = %s\n', name, val);
end

% Check for Sum blocks in lidarLocalization
lidar_sums = find_system(lidar_path, 'BlockType', 'Sum');
for i = 1:length(lidar_sums)
    inputs = get_param(lidar_sums{i}, 'Inputs');
    name = get_param(lidar_sums{i}, 'Name');
    fprintf('  Sum "%s" inputs: %s\n', name, inputs);
end

% Check for Gain blocks
lidar_gains = find_system(lidar_path, 'BlockType', 'Gain');
for i = 1:length(lidar_gains)
    val = get_param(lidar_gains{i}, 'Gain');
    name = get_param(lidar_gains{i}, 'Name');
    fprintf('  Gain "%s" = %s\n', name, val);
end

% Goto tags published by lidarLocalization
lidar_gotos = find_system(lidar_path, 'BlockType', 'Goto');
for i = 1:length(lidar_gotos)
    tag = get_param(lidar_gotos{i}, 'GotoTag');
    fprintf('  Goto: %s\n', tag);
end

%% 2. Check stateEstimation internals more deeply
fprintf('\n--- STATE ESTIMATION DEEP DIVE ---\n');

% All Constant blocks (recursive)
se_path = [model '/stateEstimation'];
se_consts = find_system(se_path, 'BlockType', 'Constant');
fprintf('\nAll Constants in stateEstimation:\n');
for i = 1:length(se_consts)
    val = get_param(se_consts{i}, 'Value');
    short_name = strrep(se_consts{i}, [se_path '/'], '');
    fprintf('  %s = %s\n', short_name, val);
end

% All Sum blocks
se_sums = find_system(se_path, 'BlockType', 'Sum');
fprintf('\nAll Sum blocks in stateEstimation:\n');
for i = 1:length(se_sums)
    inputs = get_param(se_sums{i}, 'Inputs');
    short_name = strrep(se_sums{i}, [se_path '/'], '');
    fprintf('  %s inputs: %s\n', short_name, inputs);
end

% All Bias blocks
se_bias = find_system(se_path, 'BlockType', 'Bias');
for i = 1:length(se_bias)
    val = get_param(se_bias{i}, 'Bias');
    short_name = strrep(se_bias{i}, [se_path '/'], '');
    fprintf('  Bias %s = %s\n', short_name, val);
end

% All Gain blocks
se_gains = find_system(se_path, 'BlockType', 'Gain');
fprintf('\nAll Gains in stateEstimation:\n');
for i = 1:length(se_gains)
    val = get_param(se_gains{i}, 'Gain');
    short_name = strrep(se_gains{i}, [se_path '/'], '');
    fprintf('  %s = %s\n', short_name, val);
end

% From blocks (what signals it reads)
se_froms = find_system(se_path, 'BlockType', 'From');
fprintf('\nFrom blocks in stateEstimation:\n');
for i = 1:length(se_froms)
    tag = get_param(se_froms{i}, 'GotoTag');
    short_name = strrep(se_froms{i}, [se_path '/'], '');
    fprintf('  %s -> %s\n', short_name, tag);
end

%% 3. Check stateEstimation output port connection
fprintf('\n--- STATE ESTIMATION OUTPUT TRACING ---\n');
se_handle = get_param(se_path, 'Handle');
ph = get_param(se_path, 'PortHandles');
fprintf('stateEstimation has %d output ports\n', length(ph.Outport));

for i = 1:length(ph.Outport)
    try
        line = get_param(ph.Outport(i), 'Line');
        dst_ports = get_param(line, 'DstPortHandle');
        for j = 1:length(dst_ports)
            dst_block = get_param(dst_ports(j), 'Parent');
            fprintf('  Output %d -> %s\n', i, strrep(dst_block, [model '/'], ''));
        end
    catch
        fprintf('  Output %d: unconnected\n', i);
    end
end

%% 4. Check what the EKF Stateflow block contains
fprintf('\n--- EKF STATEFLOW DETAILS ---\n');
rt = sfroot;
all_items = rt.find();
for i = 1:length(all_items)
    try
        if isprop(all_items(i), 'Path') && ...
           (contains(all_items(i).Path, 'QCar EKF') || ...
            contains(all_items(i).Path, 'Heading Kalman'))
            fprintf('Found: %s (class: %s)\n', all_items(i).Path, class(all_items(i)));
            if isprop(all_items(i), 'Script')
                script = all_items(i).Script;
                fprintf('--- Script (first 1000 chars) ---\n');
                fprintf('%s\n', script(1:min(1000, length(script))));
                fprintf('--- End ---\n\n');
            end
        end
    catch
        continue;
    end
end

%% 5. Check the Sensor Fusion block
fprintf('\n--- SENSOR FUSION DETAILS ---\n');
sf_path = [se_path '/Sensor Fusion - Complementary Filter'];
sf_consts = find_system(sf_path, 'BlockType', 'Constant');
for i = 1:length(sf_consts)
    val = get_param(sf_consts{i}, 'Value');
    name = get_param(sf_consts{i}, 'Name');
    fprintf('  Constant "%s" = %s\n', name, val);
end

% Check its MATLAB Function
for i = 1:length(all_items)
    try
        if isprop(all_items(i), 'Path') && ...
           contains(all_items(i).Path, 'Sensor Fusion') && ...
           contains(all_items(i).Path, 'MATLAB Function')
            fprintf('\nSensor Fusion MATLAB Function:\n');
            if isprop(all_items(i), 'Script')
                fprintf('%s\n', all_items(i).Script);
            end
        end
    catch
        continue;
    end
end

%% 6. Check what variables are in the workspace
fprintf('\n--- WORKSPACE FRAME CHECK ---\n');
fprintf('cal_pos = [%s]\n', num2str(cal_pos));
fprintf('QcarKF_X0 = [%s]\n', num2str(QcarKF_X0'));
if exist('path_x4', 'var')
    fprintf('path_x4: %d pts, range [%.3f, %.3f]\n', length(path_x4), min(path_x4), max(path_x4));
    fprintf('path_y4: %d pts, range [%.3f, %.3f]\n', length(path_y4), min(path_y4), max(path_y4));
    fprintf('path_x4(1)=%.3f, path_y4(1)=%.3f (first point)\n', path_x4(1), path_y4(1));
end

% Check if raw SDCS paths differ from our path_x4
sdcs_dir = fullfile(fileparts(which('Setup_QCar2_Params')));
data = load(fullfile(sdcs_dir, 'SDCS_Paths_7.mat'));
fprintf('\nRaw SDCS path_x4 from .mat: range [%.3f, %.3f]\n', min(data.path_x4), max(data.path_x4));
fprintf('Raw SDCS path_y4 from .mat: range [%.3f, %.3f]\n', min(data.path_y4), max(data.path_y4));
fprintf('Our path_x4 range: [%.3f, %.3f]\n', min(path_x4), max(path_x4));
fprintf('Our path_y4 range: [%.3f, %.3f]\n', min(path_y4), max(path_y4));

fprintf('\n=== ANALYSIS COMPLETE ===\n');
