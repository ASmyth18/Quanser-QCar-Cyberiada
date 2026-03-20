%% diagnose_steering.m
% Investigate the steeringCommander Cross Track Controller
% and the missing Goto16 signal

model = 'VIRTUAL_self_driving_stack_v2';
if ~bdIsLoaded(model)
    load_system(model);
end

%% 1. Investigate Goto16
fprintf('=== GOTO16 INVESTIGATION ===\n');
try
    goto16_path = [model '/Goto16'];
    tag16 = get_param(goto16_path, 'GotoTag');
    fprintf('Goto16 tag: %s\n', tag16);

    % Find all From blocks with this tag
    froms = find_system(model, 'BlockType', 'From', 'GotoTag', tag16);
    fprintf('From blocks with tag "%s": %d\n', tag16, length(froms));
    for i = 1:length(froms)
        fprintf('  %s\n', froms{i});
    end

    % Trace what feeds Goto16
    ph = get_param(goto16_path, 'PortHandles');
    if ~isempty(ph.Inport)
        line = get_param(ph.Inport(1), 'Line');
        src = get_param(line, 'SrcPortHandle');
        src_block = get_param(src, 'Parent');
        fprintf('Goto16 fed by: %s (type: %s)\n', src_block, get_param(src_block, 'BlockType'));
    end
catch ME
    fprintf('Error investigating Goto16: %s\n', ME.message);
end

%% 2. Investigate steeringCommander
fprintf('\n=== STEERING COMMANDER ===\n');
sc_path = [model '/steeringCommander'];

% List all blocks inside
all_blocks = find_system(sc_path, 'SearchDepth', 1);
fprintf('Blocks in steeringCommander:\n');
for i = 2:length(all_blocks)
    btype = get_param(all_blocks{i}, 'BlockType');
    name = get_param(all_blocks{i}, 'Name');
    fprintf('  [%s] %s\n', btype, name);
end

%% 3. Cross Track Controller details
fprintf('\n=== CROSS TRACK CONTROLLER ===\n');
ctc_path = [sc_path '/Cross Track Controller'];
ctc_blocks = find_system(ctc_path, 'SearchDepth', 2);
fprintf('Blocks in Cross Track Controller:\n');
for i = 2:length(ctc_blocks)
    btype = get_param(ctc_blocks{i}, 'BlockType');
    name = get_param(ctc_blocks{i}, 'Name');
    short = strrep(ctc_blocks{i}, [ctc_path '/'], '');
    fprintf('  [%s] %s\n', btype, short);

    % Show key parameters
    if strcmp(btype, 'Demux')
        try
            outputs = get_param(ctc_blocks{i}, 'Outputs');
            fprintf('    Outputs: %s\n', outputs);
        catch; end
    elseif strcmp(btype, 'Mux')
        try
            inputs = get_param(ctc_blocks{i}, 'Inputs');
            fprintf('    Inputs: %s\n', inputs);
        catch; end
    elseif strcmp(btype, 'Gain')
        try
            val = get_param(ctc_blocks{i}, 'Gain');
            fprintf('    Gain: %s\n', val);
        catch; end
    elseif strcmp(btype, 'Constant')
        try
            val = get_param(ctc_blocks{i}, 'Value');
            fprintf('    Value: %s\n', val);
        catch; end
    elseif strcmp(btype, 'From')
        try
            tag = get_param(ctc_blocks{i}, 'GotoTag');
            fprintf('    Tag: %s\n', tag);
        catch; end
    elseif strcmp(btype, 'Inport')
        try
            pnum = get_param(ctc_blocks{i}, 'Port');
            fprintf('    Port: %s\n', pnum);
        catch; end
    end
end

%% 4. Trace the Demux and Mux connections
fprintf('\n=== DEMUX/MUX PORT CONNECTIONS ===\n');

% Find the Demux
demux_blocks = find_system(ctc_path, 'BlockType', 'Demux');
for d = 1:length(demux_blocks)
    fprintf('\nDemux: %s\n', strrep(demux_blocks{d}, [ctc_path '/'], ''));
    ph = get_param(demux_blocks{d}, 'PortHandles');

    % What feeds the Demux?
    try
        line = get_param(ph.Inport(1), 'Line');
        src = get_param(line, 'SrcPortHandle');
        src_block = get_param(src, 'Parent');
        fprintf('  Input from: %s (%s)\n', strrep(src_block, [ctc_path '/'], ''), ...
            get_param(src_block, 'BlockType'));
        if strcmp(get_param(src_block, 'BlockType'), 'From')
            fprintf('    Tag: %s\n', get_param(src_block, 'GotoTag'));
        end
    catch; fprintf('  Input: error tracing\n'); end

    % Where do Demux outputs go?
    for p = 1:length(ph.Outport)
        try
            line = get_param(ph.Outport(p), 'Line');
            dsts = get_param(line, 'DstPortHandle');
            if isempty(dsts) || all(dsts == -1)
                fprintf('  Output %d: NOT CONNECTED\n', p);
            else
                for dd = 1:length(dsts)
                    dst_block = get_param(dsts(dd), 'Parent');
                    fprintf('  Output %d -> %s (%s)\n', p, ...
                        strrep(dst_block, [ctc_path '/'], ''), ...
                        get_param(dst_block, 'BlockType'));
                end
            end
        catch
            fprintf('  Output %d: error tracing\n', p);
        end
    end
end

% Find the Mux
mux_blocks = find_system(ctc_path, 'BlockType', 'Mux');
for m = 1:length(mux_blocks)
    fprintf('\nMux: %s\n', strrep(mux_blocks{m}, [ctc_path '/'], ''));
    ph = get_param(mux_blocks{m}, 'PortHandles');

    % What feeds each Mux input?
    for p = 1:length(ph.Inport)
        try
            line = get_param(ph.Inport(p), 'Line');
            src = get_param(line, 'SrcPortHandle');
            if src == -1
                fprintf('  Input %d: NOT CONNECTED\n', p);
            else
                src_block = get_param(src, 'Parent');
                fprintf('  Input %d from: %s (%s)\n', p, ...
                    strrep(src_block, [ctc_path '/'], ''), ...
                    get_param(src_block, 'BlockType'));
            end
        catch
            fprintf('  Input %d: NOT CONNECTED or error\n', p);
        end
    end

    % Where does Mux output go?
    try
        line = get_param(ph.Outport(1), 'Line');
        dsts = get_param(line, 'DstPortHandle');
        for dd = 1:length(dsts)
            dst_block = get_param(dsts(dd), 'Parent');
            fprintf('  Output -> %s (%s)\n', ...
                strrep(dst_block, [ctc_path '/'], ''), ...
                get_param(dst_block, 'BlockType'));
        end
    catch; end
end

%% 5. Check pathPlanner outputs
fprintf('\n=== PATHPLANNER OUTPUTS ===\n');
pp_path = [model '/pathPlanner'];
pp_gotos = find_system(pp_path, 'BlockType', 'Goto');
for i = 1:length(pp_gotos)
    tag = get_param(pp_gotos{i}, 'GotoTag');
    short = strrep(pp_gotos{i}, [pp_path '/'], '');
    fprintf('  %s -> tag: %s\n', short, tag);
end

% Check what tags steeringCommander reads
fprintf('\n=== STEERINGCOMMANDER FROM BLOCKS ===\n');
sc_froms = find_system(sc_path, 'BlockType', 'From');
for i = 1:length(sc_froms)
    tag = get_param(sc_froms{i}, 'GotoTag');
    short = strrep(sc_froms{i}, [sc_path '/'], '');
    fprintf('  %s reads tag: %s\n', short, tag);
end

fprintf('\n=== DONE ===\n');
