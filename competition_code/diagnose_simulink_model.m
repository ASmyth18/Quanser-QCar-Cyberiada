%% diagnose_simulink_model.m
% Inspects the VIRTUAL_self_driving_stack_v2 Simulink model to understand
% how it reads path data, what variables it uses, and how steering works.
%
% Run this AFTER opening the model:
%   open_system('VIRTUAL_self_driving_stack_v2')

model = 'VIRTUAL_self_driving_stack_v2';

fprintf('=== DIAGNOSING SIMULINK MODEL ===\n\n');

%% 1. List all top-level subsystems
fprintf('--- TOP-LEVEL SUBSYSTEMS ---\n');
blocks = find_system(model, 'SearchDepth', 1, 'BlockType', 'SubSystem');
for i = 1:length(blocks)
    fprintf('  %s\n', blocks{i});
end

%% 2. Find all "From Workspace" blocks (these read workspace variables)
fprintf('\n--- FROM WORKSPACE BLOCKS ---\n');
fw_blocks = find_system(model, 'BlockType', 'FromWorkspace');
for i = 1:length(fw_blocks)
    varname = get_param(fw_blocks{i}, 'VariableName');
    fprintf('  Block: %s\n', fw_blocks{i});
    fprintf('    Variable: %s\n', varname);
end

%% 3. Find all Constant blocks (may contain path data)
fprintf('\n--- CONSTANT BLOCKS (checking for path references) ---\n');
const_blocks = find_system(model, 'BlockType', 'Constant');
for i = 1:length(const_blocks)
    val = get_param(const_blocks{i}, 'Value');
    name = const_blocks{i};
    % Only show if references a workspace variable (not a number)
    if ~isempty(val) && isnan(str2double(val))
        fprintf('  Block: %s\n', name);
        fprintf('    Value: %s\n', val);
    end
end

%% 4. Find all Lookup Table blocks
fprintf('\n--- LOOKUP TABLE BLOCKS ---\n');
lut_blocks = find_system(model, 'BlockType', 'Lookup_n-D');
for i = 1:length(lut_blocks)
    fprintf('  Block: %s\n', lut_blocks{i});
end
lut_blocks2 = find_system(model, 'BlockType', 'Lookup');
for i = 1:length(lut_blocks2)
    fprintf('  Block: %s\n', lut_blocks2{i});
end

%% 5. Find all MATLAB Function blocks (Stateflow)
fprintf('\n--- MATLAB FUNCTION / STATEFLOW BLOCKS ---\n');
sf_blocks = find_system(model, 'MaskType', 'Stateflow');
for i = 1:length(sf_blocks)
    fprintf('  Block: %s\n', sf_blocks{i});
end
% Also try finding Embedded MATLAB
em_blocks = find_system(model, 'BlockType', 'SubSystem', 'SFBlockType', 'MATLAB Function');
for i = 1:length(em_blocks)
    fprintf('  MATLAB Function: %s\n', em_blocks{i});
end

%% 6. Inspect the steeringCommander subsystem
fprintf('\n--- STEERING COMMANDER CONTENTS ---\n');
try
    steer_blocks = find_system([model '/steeringCommander'], 'SearchDepth', 2);
    for i = 1:length(steer_blocks)
        bt = get_param(steer_blocks{i}, 'BlockType');
        fprintf('  [%s] %s\n', bt, steer_blocks{i});
    end
catch e
    fprintf('  Could not inspect: %s\n', e.message);
end

%% 7. Find all Goto/From blocks (signal routing)
fprintf('\n--- GOTO BLOCKS ---\n');
goto_blocks = find_system(model, 'BlockType', 'Goto');
for i = 1:length(goto_blocks)
    tag = get_param(goto_blocks{i}, 'GotoTag');
    fprintf('  %s -> Tag: %s\n', goto_blocks{i}, tag);
end

fprintf('\n--- FROM BLOCKS ---\n');
from_blocks = find_system(model, 'BlockType', 'From');
for i = 1:length(from_blocks)
    tag = get_param(from_blocks{i}, 'GotoTag');
    fprintf('  %s -> Tag: %s\n', from_blocks{i}, tag);
end

%% 8. Find blocks with "path" in their name
fprintf('\n--- BLOCKS WITH "path" IN NAME ---\n');
path_blocks = find_system(model, 'Name', '*path*');
for i = 1:length(path_blocks)
    fprintf('  %s\n', path_blocks{i});
end
path_blocks2 = find_system(model, 'Name', '*Path*');
for i = 1:length(path_blocks2)
    fprintf('  %s\n', path_blocks2{i});
end

%% 9. Find blocks with "waypoint" or "route" in their name
fprintf('\n--- BLOCKS WITH "waypoint"/"route"/"mission" IN NAME ---\n');
for keyword = {'waypoint', 'route', 'mission', 'Waypoint', 'Route', 'Mission'}
    try
        found = find_system(model, 'Name', ['*' keyword{1} '*']);
        for i = 1:length(found)
            fprintf('  %s\n', found{i});
        end
    catch
    end
end

%% 10. Check what variables the model references
fprintf('\n--- MODEL WORKSPACE VARIABLES ---\n');
try
    mdlWks = get_param(model, 'ModelWorkspace');
    varList = mdlWks.whos;
    for i = 1:length(varList)
        fprintf('  %s (%s)\n', varList(i).name, varList(i).class);
    end
catch e
    fprintf('  Could not read: %s\n', e.message);
end

fprintf('\n=== DIAGNOSIS COMPLETE ===\n');
