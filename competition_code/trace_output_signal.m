%% trace_output_signal.m
% Trace exactly what signal becomes the stateEstimation output port

model = 'VIRTUAL_self_driving_stack_v2';
if ~bdIsLoaded(model)
    load_system(model);
end

fprintf('=== TRACING stateEstimation OUTPUT ===\n\n');

se_path = [model '/stateEstimation'];

%% Find the outport block inside stateEstimation
outports = find_system(se_path, 'SearchDepth', 1, 'BlockType', 'Outport');
fprintf('Output ports in stateEstimation:\n');
for i = 1:length(outports)
    name = get_param(outports{i}, 'Name');
    fprintf('  %s\n', name);

    % Trace the signal feeding this outport
    ph = get_param(outports{i}, 'PortHandles');
    try
        line = get_param(ph.Inport(1), 'Line');
        src_port = get_param(line, 'SrcPortHandle');
        src_block = get_param(src_port, 'Parent');
        src_type = get_param(src_block, 'BlockType');
        fprintf('  Fed by: %s (type: %s)\n', strrep(src_block, [se_path '/'], ''), src_type);

        % If it's a Goto/From, show the tag
        if strcmp(src_type, 'From')
            tag = get_param(src_block, 'GotoTag');
            fprintf('  From tag: %s\n', tag);

            % Now find the Goto with this tag inside stateEstimation
            gotos = find_system(se_path, 'BlockType', 'Goto', 'GotoTag', tag);
            for j = 1:length(gotos)
                fprintf('  Matching Goto: %s\n', strrep(gotos{j}, [se_path '/'], ''));
                % Trace what feeds this Goto
                gph = get_param(gotos{j}, 'PortHandles');
                gline = get_param(gph.Inport(1), 'Line');
                gsrc = get_param(gline, 'SrcPortHandle');
                gsrc_block = get_param(gsrc, 'Parent');
                fprintf('  Goto fed by: %s (type: %s)\n', ...
                    strrep(gsrc_block, [se_path '/'], ''), ...
                    get_param(gsrc_block, 'BlockType'));

                % Keep tracing back
                if strcmp(get_param(gsrc_block, 'BlockType'), 'Mux')
                    mph = get_param(gsrc_block, 'PortHandles');
                    for k = 1:length(mph.Inport)
                        mline = get_param(mph.Inport(k), 'Line');
                        msrc = get_param(mline, 'SrcPortHandle');
                        msrc_block = get_param(msrc, 'Parent');
                        msrc_type = get_param(msrc_block, 'BlockType');
                        fprintf('    Mux input %d: %s (type: %s)\n', k, ...
                            strrep(msrc_block, [se_path '/'], ''), msrc_type);

                        if strcmp(msrc_type, 'From')
                            mtag = get_param(msrc_block, 'GotoTag');
                            fprintf('      From tag: %s\n', mtag);
                        elseif strcmp(msrc_type, 'SubSystem')
                            % Check outports of the subsystem
                            sub_outports = find_system(msrc_block, 'SearchDepth', 1, 'BlockType', 'Outport');
                            for m = 1:length(sub_outports)
                                fprintf('      SubSystem outport: %s\n', get_param(sub_outports{m}, 'Name'));
                            end
                        end
                    end
                elseif strcmp(get_param(gsrc_block, 'BlockType'), 'From')
                    ftag = get_param(gsrc_block, 'GotoTag');
                    fprintf('    From tag: %s\n', ftag);
                end
            end
        elseif strcmp(src_type, 'Mux')
            mph = get_param(src_block, 'PortHandles');
            for k = 1:length(mph.Inport)
                mline = get_param(mph.Inport(k), 'Line');
                msrc = get_param(mline, 'SrcPortHandle');
                msrc_block = get_param(msrc, 'Parent');
                msrc_type = get_param(msrc_block, 'BlockType');
                fprintf('  Mux input %d: %s (type: %s)\n', k, ...
                    strrep(msrc_block, [se_path '/'], ''), msrc_type);
                if strcmp(msrc_type, 'From')
                    mtag = get_param(msrc_block, 'GotoTag');
                    fprintf('    From tag: %s\n', mtag);
                end
            end
        end
    catch me
        fprintf('  Error tracing: %s\n', me.message);
    end
end

%% Also check: what generates the 'senFusEstimate' signal
fprintf('\n--- SENSOR FUSION ESTIMATE SOURCE ---\n');
sf_gotos = find_system(se_path, 'BlockType', 'Goto', 'GotoTag', 'senFusEstimate');
for i = 1:length(sf_gotos)
    fprintf('senFusEstimate Goto at: %s\n', strrep(sf_gotos{i}, [se_path '/'], ''));
    gph = get_param(sf_gotos{i}, 'PortHandles');
    gline = get_param(gph.Inport(1), 'Line');
    gsrc = get_param(gline, 'SrcPortHandle');
    gsrc_block = get_param(gsrc, 'Parent');
    fprintf('  Fed by: %s\n', strrep(gsrc_block, [se_path '/'], ''));
end

%% Check 'xy' signal source
fprintf('\n--- XY SIGNAL SOURCE ---\n');
xy_gotos = find_system(se_path, 'BlockType', 'Goto', 'GotoTag', 'xy');
for i = 1:length(xy_gotos)
    fprintf('xy Goto at: %s\n', strrep(xy_gotos{i}, [se_path '/'], ''));
    gph = get_param(xy_gotos{i}, 'PortHandles');
    gline = get_param(gph.Inport(1), 'Line');
    gsrc = get_param(gline, 'SrcPortHandle');
    gsrc_block = get_param(gsrc, 'Parent');
    fprintf('  Fed by: %s (type: %s)\n', strrep(gsrc_block, [se_path '/'], ''), get_param(gsrc_block, 'BlockType'));
end

%% Check 'currPose' signal source
fprintf('\n--- CURRPOSE SIGNAL SOURCE ---\n');
cp_gotos = find_system(se_path, 'BlockType', 'Goto', 'GotoTag', 'currPose');
for i = 1:length(cp_gotos)
    fprintf('currPose Goto at: %s\n', strrep(cp_gotos{i}, [se_path '/'], ''));
    gph = get_param(cp_gotos{i}, 'PortHandles');
    gline = get_param(gph.Inport(1), 'Line');
    gsrc = get_param(gline, 'SrcPortHandle');
    gsrc_block = get_param(gsrc, 'Parent');
    fprintf('  Fed by: %s (type: %s)\n', strrep(gsrc_block, [se_path '/'], ''), get_param(gsrc_block, 'BlockType'));

    % If From, chase it
    if strcmp(get_param(gsrc_block, 'BlockType'), 'From')
        tag = get_param(gsrc_block, 'GotoTag');
        fprintf('    From tag: %s\n', tag);
    elseif strcmp(get_param(gsrc_block, 'BlockType'), 'Mux')
        mph = get_param(gsrc_block, 'PortHandles');
        for k = 1:length(mph.Inport)
            try
                mline = get_param(mph.Inport(k), 'Line');
                msrc = get_param(mline, 'SrcPortHandle');
                msrc_block = get_param(msrc, 'Parent');
                msrc_type = get_param(msrc_block, 'BlockType');
                fprintf('    Mux input %d: %s (%s)\n', k, strrep(msrc_block, [se_path '/'], ''), msrc_type);
                if strcmp(msrc_type, 'From')
                    fprintf('      Tag: %s\n', get_param(msrc_block, 'GotoTag'));
                end
            catch
                fprintf('    Mux input %d: error\n', k);
            end
        end
    end
end

%% Check lidarLocalization output and what feeds EKF
fprintf('\n--- LIDAR LOCALIZATION OUTPUT ---\n');
lidar_path = [model '/lidarLocalization'];
lidar_outports = find_system(lidar_path, 'SearchDepth', 1, 'BlockType', 'Outport');
for i = 1:length(lidar_outports)
    name = get_param(lidar_outports{i}, 'Name');
    fprintf('lidarLocalization outport: %s\n', name);
end

lidar_gotos = find_system(lidar_path, 'BlockType', 'Goto');
for i = 1:length(lidar_gotos)
    tag = get_param(lidar_gotos{i}, 'GotoTag');
    short = strrep(lidar_gotos{i}, [lidar_path '/'], '');
    fprintf('lidarLocalization Goto: %s -> tag "%s"\n', short, tag);
end

% Check all blocks at depth 2 in lidarLocalization
fprintf('\nAll blocks in lidarLocalization (depth 2):\n');
all_lidar = find_system(lidar_path, 'SearchDepth', 2);
for i = 2:length(all_lidar)
    btype = get_param(all_lidar{i}, 'BlockType');
    short = strrep(all_lidar{i}, [lidar_path '/'], '');
    fprintf('  [%s] %s\n', btype, short);
end

fprintf('\n=== TRACE COMPLETE ===\n');
