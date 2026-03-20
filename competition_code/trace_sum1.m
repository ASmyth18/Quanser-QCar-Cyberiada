%% trace_sum1.m - Trace what feeds Sum1 in stateEstimation

model = 'VIRTUAL_self_driving_stack_v2';
se_path = [model '/stateEstimation'];

% Find Sum1
sum1_path = [se_path '/Sum1'];
fprintf('=== TRACING Sum1 INPUTS ===\n');

ph = get_param(sum1_path, 'PortHandles');
fprintf('Sum1 has %d input ports\n', length(ph.Inport));

for i = 1:length(ph.Inport)
    line = get_param(ph.Inport(i), 'Line');
    src_port = get_param(line, 'SrcPortHandle');
    src_block = get_param(src_port, 'Parent');
    src_type = get_param(src_block, 'BlockType');
    short = strrep(src_block, [se_path '/'], '');
    fprintf('\nSum1 input %d: %s (type: %s)\n', i, short, src_type);

    % Chase From blocks
    if strcmp(src_type, 'From')
        tag = get_param(src_block, 'GotoTag');
        fprintf('  Tag: %s\n', tag);
    elseif strcmp(src_type, 'Selector')
        % Check what feeds the selector
        sph = get_param(src_block, 'PortHandles');
        sline = get_param(sph.Inport(1), 'Line');
        ssrc = get_param(sline, 'SrcPortHandle');
        ssrc_block = get_param(ssrc, 'Parent');
        fprintf('  Selector fed by: %s (type: %s)\n', ...
            strrep(ssrc_block, [se_path '/'], ''), get_param(ssrc_block, 'BlockType'));
        if strcmp(get_param(ssrc_block, 'BlockType'), 'From')
            fprintf('    Tag: %s\n', get_param(ssrc_block, 'GotoTag'));
        end
    elseif strcmp(src_type, 'Constant')
        val = get_param(src_block, 'Value');
        fprintf('  Value: %s\n', val);
    elseif strcmp(src_type, 'Bias')
        val = get_param(src_block, 'Bias');
        fprintf('  Bias value: %s\n', val);
    elseif strcmp(src_type, 'Gain')
        val = get_param(src_block, 'Gain');
        fprintf('  Gain value: %s\n', val);
    end

    % Try one more level of tracing
    try
        sph2 = get_param(src_block, 'PortHandles');
        if ~isempty(sph2.Inport)
            for j = 1:length(sph2.Inport)
                line2 = get_param(sph2.Inport(j), 'Line');
                src2 = get_param(line2, 'SrcPortHandle');
                src2_block = get_param(src2, 'Parent');
                src2_type = get_param(src2_block, 'BlockType');
                fprintf('  <- input %d: %s (%s)\n', j, ...
                    strrep(src2_block, [se_path '/'], ''), src2_type);
                if strcmp(src2_type, 'From')
                    fprintf('     Tag: %s\n', get_param(src2_block, 'GotoTag'));
                elseif strcmp(src2_type, 'Constant')
                    fprintf('     Value: %s\n', get_param(src2_block, 'Value'));
                end
            end
        end
    catch
    end
end

% Also trace ManualSwitch1
fprintf('\n=== TRACING ManualSwitch1 (heading) ===\n');
ms_path = [se_path '/Manual Switch1'];
mph = get_param(ms_path, 'PortHandles');
for i = 1:length(mph.Inport)
    try
        line = get_param(mph.Inport(i), 'Line');
        src = get_param(line, 'SrcPortHandle');
        src_block = get_param(src, 'Parent');
        src_type = get_param(src_block, 'BlockType');
        fprintf('ManualSwitch1 input %d: %s (%s)\n', i, ...
            strrep(src_block, [se_path '/'], ''), src_type);
        if strcmp(src_type, 'From')
            fprintf('  Tag: %s\n', get_param(src_block, 'GotoTag'));
        end
    catch
        fprintf('ManualSwitch1 input %d: error\n', i);
    end
end

% Check which position ManualSwitch1 is in
try
    sw_val = get_param(ms_path, 'CurrentSetting');
    fprintf('ManualSwitch1 current setting: %s\n', sw_val);
catch
end

fprintf('\n=== DONE ===\n');
