%% diagnose_signal_trace.m
% Traces the EXACT signal path from stateEstimation to pathPlanner
% to determine what coordinate frame the pathPlanner operates in.
%
% Run AFTER: open_system('VIRTUAL_self_driving_stack_v2')

model = 'VIRTUAL_self_driving_stack_v2';

fprintf('=== SIGNAL TRACE: stateEstimation -> pathPlanner ===\n\n');

%% 1. Trace pathPlanner's currentPose input back to its source
fprintf('--- TRACING pathPlanner currentPose INPUT ---\n');
try
    pp = [model '/pathPlanner'];
    ph = get_param(pp, 'PortHandles');

    % First inport is currentPose
    line_handle = get_param(ph.Inport(1), 'Line');
    src_port = get_param(line_handle, 'SrcPortHandle');
    src_block = get_param(src_port, 'Parent');
    src_bt = get_param(src_block, 'BlockType');
    fprintf('  pathPlanner/currentPose comes from:\n');
    fprintf('    Block: %s\n', src_block);
    fprintf('    Type:  %s\n', src_bt);

    % If it's a Mux or Sum, trace further back
    if ismember(src_bt, {'Sum', 'Mux', 'Gain', 'Add'})
        fprintf('    (Intermediate block - tracing further...)\n');
        src_ph = get_param(src_block, 'PortHandles');
        for k = 1:length(src_ph.Inport)
            ln = get_param(src_ph.Inport(k), 'Line');
            sp = get_param(ln, 'SrcPortHandle');
            sb = get_param(sp, 'Parent');
            fprintf('    Input %d from: %s [%s]\n', k, sb, get_param(sb, 'BlockType'));
        end
    end

    % If it's a From block, show the tag
    if strcmp(src_bt, 'From')
        tag = get_param(src_block, 'GotoTag');
        fprintf('    GotoTag: %s\n', tag);
        % Find the matching Goto
        goto_blocks = find_system(model, 'BlockType', 'Goto', 'GotoTag', tag);
        for g = 1:length(goto_blocks)
            fprintf('    Goto source: %s\n', goto_blocks{g});
        end
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 2. Check ALL top-level signal routing (blocks NOT inside subsystems)
fprintf('\n--- TOP-LEVEL BLOCKS (between subsystems) ---\n');
try
    top_blocks = find_system(model, 'SearchDepth', 1);
    for i = 2:length(top_blocks)  % skip model itself
        bt = get_param(top_blocks{i}, 'BlockType');
        if ~strcmp(bt, 'SubSystem')
            name = get_param(top_blocks{i}, 'Name');
            fprintf('  [%s] %s\n', bt, name);
            % Show values for constants
            if strcmp(bt, 'Constant')
                val = get_param(top_blocks{i}, 'Value');
                fprintf('    Value: %s\n', val);
            end
        end
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 3. Trace stateEstimation outputs
fprintf('\n--- TRACING stateEstimation OUTPUTS ---\n');
try
    se = [model '/stateEstimation'];
    se_ph = get_param(se, 'PortHandles');
    for p = 1:length(se_ph.Outport)
        line_handle = get_param(se_ph.Outport(p), 'Line');
        if line_handle ~= -1
            dst_ports = get_param(line_handle, 'DstPortHandle');
            for d = 1:length(dst_ports)
                dst_block = get_param(dst_ports(d), 'Parent');
                fprintf('  Output %d -> %s [%s]\n', p, dst_block, get_param(dst_block, 'BlockType'));
            end
        end
    end
catch e
    fprintf('  Error: %s\n', e.message);
end

%% 4. Check what the Goto tags "currentXY" and "currentHeading" map to
fprintf('\n--- FINDING Goto tags: currentXY, currentHeading ---\n');
for tag = {'currentXY', 'currentHeading'}
    try
        goto_blocks = find_system(model, 'BlockType', 'Goto', 'GotoTag', tag{1});
        for g = 1:length(goto_blocks)
            fprintf('  Goto "%s" at: %s\n', tag{1}, goto_blocks{g});
        end
        if isempty(goto_blocks)
            fprintf('  Goto "%s": NOT FOUND (probably set inside pathPlanner from inport)\n', tag{1});
        end
    catch
    end
end

%% 5. Quick simulation test - what does pathPlanner actually receive?
fprintf('\n--- QUICK FRAME TEST ---\n');
fprintf('  QcarKF_X0 = %s (EKF initial state)\n', mat2str(QcarKF_X0', 4));
fprintf('  cal_pos   = %s\n', mat2str(cal_pos));
fprintf('  Hub WORLD = [-1.205, -0.83]\n');
fprintf('  Hub EKF   = [-1.205, -2.83]\n');
fprintf('  path_x4 range: [%.3f, %.3f]\n', min(path_x4), max(path_x4));
fprintf('  path_y4 range: [%.3f, %.3f]\n', min(path_y4), max(path_y4));
fprintf('\n  If pathPlanner gets EKF coords, paths should have y near -2.83 at hub.\n');
fprintf('  If pathPlanner gets WORLD coords, paths should have y near -0.83 at hub.\n');
fprintf('  Current path_y4 at first point: %.3f\n', path_y4(1));

if abs(path_y4(1) - (-0.83)) < 0.5
    fprintf('  -> Paths are in WORLD frame.\n');
    fprintf('  -> If car position is also in WORLD, this is correct.\n');
    fprintf('  -> If car position is in EKF, paths need EKF conversion!\n');
elseif abs(path_y4(1) - (-2.83)) < 0.5
    fprintf('  -> Paths are in EKF frame.\n');
end

%% 6. Check for cal_pos additions anywhere in the signal path
fprintf('\n--- SEARCHING FOR cal_pos REFERENCES IN ENTIRE MODEL ---\n');
try
    all_const = find_system(model, 'BlockType', 'Constant');
    for i = 1:length(all_const)
        val = get_param(all_const{i}, 'Value');
        if contains(val, 'cal_pos') || contains(val, 'cal_origin')
            fprintf('  FOUND: %s = %s\n', all_const{i}, val);
        end
    end
    fprintf('  (If nothing found above, cal_pos is NOT used in the model)\n');
catch e
    fprintf('  Error: %s\n', e.message);
end

fprintf('\n=== TRACE COMPLETE ===\n');
