%% diagnose_path_following.m
% Deep investigation of how the pathPlanner selects and follows paths.
% Run AFTER opening the model: open_system('VIRTUAL_self_driving_stack_v2')

model = 'VIRTUAL_self_driving_stack_v2';

fprintf('=== PATH FOLLOWING DIAGNOSIS ===\n\n');

%% 1. Inspect pathPlanner subsystem deeply
fprintf('--- PATHPLANNER CONTENTS (depth 3) ---\n');
try
    pp_blocks = find_system([model '/pathPlanner'], 'SearchDepth', 3);
    for i = 1:length(pp_blocks)
        bt = get_param(pp_blocks{i}, 'BlockType');
        fprintf('  [%s] %s\n', bt, pp_blocks{i});
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 2. Find ALL Constant blocks inside pathPlanner (path selection?)
fprintf('\n--- PATHPLANNER CONSTANT BLOCKS ---\n');
try
    pp_const = find_system([model '/pathPlanner'], 'BlockType', 'Constant');
    for i = 1:length(pp_const)
        val = get_param(pp_const{i}, 'Value');
        fprintf('  %s = %s\n', pp_const{i}, val);
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 3. Find Switch/Multiport/Selector blocks (path selection mechanism)
fprintf('\n--- SWITCH/SELECTOR BLOCKS IN PATHPLANNER ---\n');
for blocktype = {'Switch', 'MultiPortSwitch', 'Selector', 'ManualSwitch'}
    try
        found = find_system([model '/pathPlanner'], 'BlockType', blocktype{1});
        for i = 1:length(found)
            fprintf('  [%s] %s\n', blocktype{1}, found{i});
            % Get criteria for switches
            if strcmp(blocktype{1}, 'Switch')
                crit = get_param(found{i}, 'Criteria');
                thresh = get_param(found{i}, 'Threshold');
                fprintf('    Criteria: %s, Threshold: %s\n', crit, thresh);
            end
        end
    catch
    end
end

%% 4. Find From blocks in pathPlanner (what signals does it receive?)
fprintf('\n--- FROM BLOCKS IN PATHPLANNER ---\n');
try
    pp_from = find_system([model '/pathPlanner'], 'BlockType', 'From');
    for i = 1:length(pp_from)
        tag = get_param(pp_from{i}, 'GotoTag');
        fprintf('  %s -> Tag: %s\n', pp_from{i}, tag);
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 5. Find Goto blocks in stateEstimation (what does it output?)
fprintf('\n--- GOTO BLOCKS IN STATE ESTIMATION ---\n');
try
    se_goto = find_system([model '/stateEstimation'], 'BlockType', 'Goto');
    for i = 1:length(se_goto)
        tag = get_param(se_goto{i}, 'GotoTag');
        fprintf('  %s -> Tag: %s\n', se_goto{i}, tag);
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 6. Find From blocks in steeringCommander (what drives steering?)
fprintf('\n--- FROM BLOCKS IN STEERING COMMANDER ---\n');
try
    sc_from = find_system([model '/steeringCommander'], 'BlockType', 'From');
    for i = 1:length(sc_from)
        tag = get_param(sc_from{i}, 'GotoTag');
        fprintf('  %s -> Tag: %s\n', sc_from{i}, tag);
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 7. Check if there's a "path index" or "path number" selector
fprintf('\n--- SEARCHING FOR PATH INDEX/SELECTOR ---\n');
for keyword = {'path_index', 'pathIndex', 'path_num', 'pathNum', 'selectedPath', 'path_sel', 'pathSel', 'activePath'}
    try
        found = find_system(model, 'Name', ['*' keyword{1} '*']);
        for i = 1:length(found)
            bt = get_param(found{i}, 'BlockType');
            fprintf('  [%s] %s\n', bt, found{i});
        end
    catch
    end
end

%% 8. Inspect look-ahead generator blocks
fprintf('\n--- LOOK AHEAD GENERATOR DETAILS ---\n');
try
    lag_blocks = find_system([model '/pathPlanner'], 'Name', '*Look*');
    for i = 1:length(lag_blocks)
        bt = get_param(lag_blocks{i}, 'BlockType');
        fprintf('  [%s] %s\n', bt, lag_blocks{i});
        % If it's a subsystem, show its ports
        if strcmp(bt, 'SubSystem')
            ports = get_param(lag_blocks{i}, 'Ports');
            fprintf('    Ports [in out]: %s\n', mat2str(ports));
            inports = find_system(lag_blocks{i}, 'SearchDepth', 1, 'BlockType', 'Inport');
            for j = 1:length(inports)
                pname = get_param(inports{j}, 'Name');
                fprintf('    Input: %s\n', pname);
            end
            outports = find_system(lag_blocks{i}, 'SearchDepth', 1, 'BlockType', 'Outport');
            for j = 1:length(outports)
                pname = get_param(outports{j}, 'Name');
                fprintf('    Output: %s\n', pname);
            end
        end
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 9. Check ALL From blocks in pathPlanner AND steeringCommander
% to trace complete signal flow
fprintf('\n--- COMPLETE SIGNAL FLOW (From tags in key subsystems) ---\n');
for subsys = {'pathPlanner', 'steeringCommander', 'speedController'}
    try
        from_blocks = find_system([model '/' subsys{1}], 'BlockType', 'From');
        if ~isempty(from_blocks)
            fprintf('  %s reads:\n', subsys{1});
            for i = 1:length(from_blocks)
                tag = get_param(from_blocks{i}, 'GotoTag');
                fprintf('    <- %s\n', tag);
            end
        end
    catch
    end
end

%% 10. Check workspace variables that the model expects
fprintf('\n--- CHECKING KEY WORKSPACE VARIABLES ---\n');
vars_to_check = {'path_x4', 'path_y4', 'path_x', 'path_y', 'QcarKF_X0', ...
                  'cal_pos', 'steering_Kp', 'steering_Kd'};
for i = 1:length(vars_to_check)
    vname = vars_to_check{i};
    if evalin('base', sprintf('exist(''%s'', ''var'')', vname))
        val = evalin('base', vname);
        if numel(val) <= 6
            fprintf('  %s = %s\n', vname, mat2str(val, 4));
        else
            fprintf('  %s: [%d x %d], range x=[%.3f, %.3f], y=[%.3f, %.3f]\n', ...
                vname, size(val,1), size(val,2), min(val(:,1)), max(val(:,1)), ...
                min(val(:,min(2,end))), max(val(:,min(2,end))));
        end
    else
        fprintf('  %s: NOT FOUND in workspace\n', vname);
    end
end

%% 11. Check if stateEstimation adds cal_pos offset
fprintf('\n--- CHECKING FOR cal_pos USAGE IN STATE ESTIMATION ---\n');
try
    se_const = find_system([model '/stateEstimation'], 'BlockType', 'Constant');
    for i = 1:length(se_const)
        val = get_param(se_const{i}, 'Value');
        fprintf('  %s = %s\n', se_const{i}, val);
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

% Also check for Sum/Add blocks that might add cal_pos
try
    se_sum = find_system([model '/stateEstimation'], 'BlockType', 'Sum');
    for i = 1:length(se_sum)
        inputs = get_param(se_sum{i}, 'Inputs');
        fprintf('  [Sum] %s inputs: %s\n', se_sum{i}, inputs);
    end
catch
end

fprintf('\n=== DIAGNOSIS COMPLETE ===\n');
fprintf('Copy the output above and share it.\n');
