%% fix_obstacle_detection.m
% Fixes the MATLAB Function block indexing error in obstacleDetection.
% Error: float values (240.4) used as array indices.
% Fix: wrap index variables in floor() calls.

model = 'VIRTUAL_self_driving_stack_v2';

if ~bdIsLoaded(model)
    load_system(model);
end

% The target block path
block_path = [model '/obstacleDetection/obstacleDetection Markham March 22/Steering based  image subselector'];

% Get the MATLAB Function block's script
try
    % For MATLAB Function blocks, use Stateflow root to find the chart
    rt = sfroot;
    % Find all MATLAB Function (Embedded MATLAB) blocks
    eml_blocks = rt.find('-isa', 'Stateflow.EMChart');

    if isempty(eml_blocks)
        % Try alternative: find via the block's chart
        block_handle = get_param(block_path, 'Handle');
        chart = find(rt, '-isa', 'Stateflow.EMChart', 'Path', block_path);

        if isempty(chart)
            % Try getting all charts including EMCharts
            all_charts = rt.find('-isa', 'Stateflow.Chart', '-or', '-isa', 'Stateflow.EMChart');
            fprintf('All charts/EMCharts found: %d\n', length(all_charts));
            for i = 1:length(all_charts)
                fprintf('  %d: %s (%s)\n', i, all_charts(i).Path, class(all_charts(i)));
            end
        end
    end

    found = false;
    all_items = rt.find('-isa', 'Stateflow.EMChart');
    if isempty(all_items)
        % Broader search
        all_items = rt.find();
    end

    for i = 1:length(all_items)
        try
            if isprop(all_items(i), 'Path') && contains(all_items(i).Path, 'Steering based')
                fprintf('Found target: %s (class: %s)\n', all_items(i).Path, class(all_items(i)));

                if isprop(all_items(i), 'Script')
                    old_script = all_items(i).Script;
                    fprintf('\n--- Current Script (first 500 chars) ---\n');
                    fprintf('%s\n', old_script(1:min(500, length(old_script))));
                    fprintf('--- End ---\n\n');

                    % Apply fix: add floor() to indexing
                    new_script = strrep(old_script, ...
                        'depth(upper_h:lower_h, left_w:right_w)', ...
                        'depth(floor(upper_h):floor(lower_h), floor(left_w):floor(right_w))');

                    if strcmp(old_script, new_script)
                        % Try alternate patterns
                        new_script = regexprep(old_script, ...
                            'depth\((\w+):(\w+),\s*(\w+):(\w+)\)', ...
                            'depth(floor($1):floor($2), floor($3):floor($4))');
                    end

                    if ~strcmp(old_script, new_script)
                        all_items(i).Script = new_script;
                        fprintf('FIXED! Added floor() to array indices.\n');
                        found = true;
                    else
                        fprintf('Could not find the exact pattern. Full script:\n');
                        fprintf('%s\n', old_script);
                    end
                end
                break;
            end
        catch
            continue;
        end
    end

    if ~found
        fprintf('\nAutomatic fix failed. Trying alternative approach...\n');
        fprintf('Attempting to disable obstacleDetection subsystem instead.\n\n');

        % Alternative: just comment out the obstacleDetection subsystem
        % by replacing its output with a safe constant
        obs_path = [model '/obstacleDetection'];
        try
            % Get output port info
            ph = get_param(obs_path, 'PortHandles');
            fprintf('obstacleDetection has %d output ports\n', length(ph.Outport));

            % Check what Goto tags the subsystem feeds
            obs_blocks = find_system(obs_path, 'SearchDepth', 1, 'BlockType', 'Goto');
            for j = 1:length(obs_blocks)
                tag = get_param(obs_blocks{j}, 'GotoTag');
                fprintf('  Goto: %s\n', tag);
            end
            obs_gotos = find_system(obs_path, 'SearchDepth', 1, 'BlockType', 'Outport');
            for j = 1:length(obs_gotos)
                fprintf('  Outport: %s\n', get_param(obs_gotos{j}, 'Name'));
            end

            fprintf('\nTo manually disable: comment out the obstacleDetection subsystem\n');
            fprintf('in Simulink and replace obstacleDistance with a large constant (e.g., 10.0)\n');
        catch me2
            fprintf('Error: %s\n', me2.message);
        end
    end

catch me
    fprintf('Error: %s\n', me.message);
    fprintf('\nManual fix instructions:\n');
    fprintf('1. Open the model: open_system(''%s'')\n', model);
    fprintf('2. Navigate to: obstacleDetection > obstacleDetection Markham March 22\n');
    fprintf('3. Double-click "Steering based image subselector"\n');
    fprintf('4. Find line 11: region = double(depth(upper_h:lower_h, left_w:right_w));\n');
    fprintf('5. Change to:    region = double(depth(floor(upper_h):floor(lower_h), floor(left_w):floor(right_w)));\n');
    fprintf('6. Save and close the editor\n');
end
