%% check_lidar_bias.m
% Get the exact value of all Bias blocks in lidarLocalization

model = 'VIRTUAL_self_driving_stack_v2';
if ~bdIsLoaded(model)
    load_system(model);
end

lidar_path = [model '/lidarLocalization'];

% Get ALL bias blocks (recursive)
bias_blocks = find_system(lidar_path, 'BlockType', 'Bias');
fprintf('=== LIDAR LOCALIZATION BIAS BLOCKS ===\n');
for i = 1:length(bias_blocks)
    name = get_param(bias_blocks{i}, 'Name');
    val = get_param(bias_blocks{i}, 'Bias');
    short = strrep(bias_blocks{i}, [lidar_path '/'], '');
    fprintf('  %s: Bias = %s\n', short, val);
end

% Get ALL constant blocks
const_blocks = find_system(lidar_path, 'BlockType', 'Constant');
fprintf('\n=== LIDAR LOCALIZATION CONSTANTS ===\n');
for i = 1:length(const_blocks)
    name = get_param(const_blocks{i}, 'Name');
    val = get_param(const_blocks{i}, 'Value');
    short = strrep(const_blocks{i}, [lidar_path '/'], '');
    fprintf('  %s: Value = %s\n', short, val);
end

% Get ALL gain blocks
gain_blocks = find_system(lidar_path, 'BlockType', 'Gain');
fprintf('\n=== LIDAR LOCALIZATION GAINS ===\n');
for i = 1:length(gain_blocks)
    name = get_param(gain_blocks{i}, 'Name');
    val = get_param(gain_blocks{i}, 'Gain');
    short = strrep(gain_blocks{i}, [lidar_path '/'], '');
    fprintf('  %s: Gain = %s\n', short, val);
end

% Evaluate cal_pos in workspace
fprintf('\n=== KEY WORKSPACE VALUES ===\n');
fprintf('cal_pos = [%s]\n', num2str(cal_pos));
fprintf('qcar2_lidar_to_map_rotation = %.6f rad (%.2f deg)\n', ...
    qcar2_lidar_to_map_rotation, rad2deg(qcar2_lidar_to_map_rotation));

% Check if any bias evaluates to cal_pos
fprintf('\n=== EVALUATING BIAS EXPRESSIONS ===\n');
for i = 1:length(bias_blocks)
    short = strrep(bias_blocks{i}, [lidar_path '/'], '');
    val_str = get_param(bias_blocks{i}, 'Bias');
    try
        val_num = evalin('base', val_str);
        fprintf('  %s = %s => [%s]\n', short, val_str, num2str(val_num));
    catch
        fprintf('  %s = %s => [cannot evaluate]\n', short, val_str);
    end
end

fprintf('\n=== DONE ===\n');
