function [path_hub2pickup, path_pickup2drop, path_drop2hub] = build_mission_from_sdcs(~)
%BUILD_MISSION_FROM_SDCS Build mission paths from real SDCS road data.
%
%   Instead of using a hand-crafted waypoint graph, this function extracts
%   segments from the competition-provided SDCS_Paths_7.mat paths which
%   trace the actual road centerlines.
%
%   Returns paths in WORLD coordinates (what Simulink pathPlanner expects).

    % Load the real road paths
    sdcs_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources';
    data = load(fullfile(sdcs_dir, 'SDCS_Paths_7.mat'));

    % Key locations in WORLD coordinates (NOT EKF frame).
    % The Simulink pathPlanner expects paths in world coords because
    % the state estimation converts EKF output to world internally.
    hub_world     = [-1.205, -0.83];
    pickup_world  = [0.125, 4.395];
    dropoff_world = [-0.905, 0.800];

    % Load all paths in their ORIGINAL world coordinates (no conversion!)
    paths_world = {};
    path_names = {'path_x', 'path_x2', 'path_x3', 'path_x4', 'path_x5', 'path_x6', 'path_x7'};
    path_ynames = {'path_y', 'path_y2', 'path_y3', 'path_y4', 'path_y5', 'path_y6', 'path_y7'};

    for i = 1:length(path_names)
        if isfield(data, path_names{i}) && isfield(data, path_ynames{i})
            px = data.(path_names{i});
            py = data.(path_ynames{i});
            paths_world{i} = [px, py];
        end
    end

    % For each pair of locations, find the best path and segment
    fprintf('Building mission from SDCS paths (WORLD coordinates)...\n');

    % === LEG 1: Hub -> Pickup ===
    path_hub2pickup = find_best_route(paths_world, hub_world, pickup_world, 'Hub->Pickup');

    % === LEG 2: Pickup -> Dropoff ===
    path_pickup2drop = find_best_route(paths_world, pickup_world, dropoff_world, 'Pickup->Dropoff');

    % === LEG 3: Dropoff -> Hub ===
    path_drop2hub = find_best_route(paths_world, dropoff_world, hub_world, 'Dropoff->Hub');

    fprintf('Mission paths built from real road data.\n');
end


function best_segment = find_best_route(paths_ekf, start_pt, end_pt, label)
%FIND_BEST_ROUTE Find the shortest road segment connecting two points.
%   Searches all available SDCS paths to find the one with the shortest
%   segment between the nearest points to start_pt and end_pt.

    best_segment = [];
    best_length = inf;
    best_path_idx = 0;

    for p = 1:length(paths_ekf)
        path = paths_ekf{p};
        if isempty(path)
            continue;
        end

        n = size(path, 1);

        % Find closest point to start
        d_start = sqrt((path(:,1) - start_pt(1)).^2 + (path(:,2) - start_pt(2)).^2);
        [min_d_start, idx_start] = min(d_start);

        % Find closest point to end
        d_end = sqrt((path(:,1) - end_pt(1)).^2 + (path(:,2) - end_pt(2)).^2);
        [min_d_end, idx_end] = min(d_end);

        % Skip if either point is too far from the path (> 0.5m)
        if min_d_start > 0.5 || min_d_end > 0.5
            continue;
        end

        % Extract segment (handle circular paths - try both directions)
        if idx_start < idx_end
            % Forward direction
            seg_fwd = path(idx_start:idx_end, :);
            len_fwd = sum(sqrt(diff(seg_fwd(:,1)).^2 + diff(seg_fwd(:,2)).^2));

            % Backward (wrap around)
            seg_bwd = [path(idx_start:-1:1, :); path(end:-1:idx_end, :)];
            len_bwd = sum(sqrt(diff(seg_bwd(:,1)).^2 + diff(seg_bwd(:,2)).^2));
        else
            % Forward (wrap around)
            seg_fwd = [path(idx_start:end, :); path(1:idx_end, :)];
            len_fwd = sum(sqrt(diff(seg_fwd(:,1)).^2 + diff(seg_fwd(:,2)).^2));

            % Backward direction
            seg_bwd = path(idx_start:-1:idx_end, :);
            len_bwd = sum(sqrt(diff(seg_bwd(:,1)).^2 + diff(seg_bwd(:,2)).^2));
        end

        % Pick shorter direction
        if len_fwd <= len_bwd
            seg = seg_fwd;
            seg_len = len_fwd;
        else
            seg = seg_bwd;
            seg_len = len_bwd;
        end

        if seg_len < best_length
            best_length = seg_len;
            best_segment = seg;
            best_path_idx = p;
        end
    end

    if isempty(best_segment)
        warning('Could not find route for %s! Using straight line.', label);
        best_segment = [start_pt; end_pt];
        best_length = norm(end_pt - start_pt);
        best_path_idx = 0;
    end

    fprintf('  %s: Path %d, %d pts, %.2f m (start gap: %.3f m, end gap: %.3f m)\n', ...
        label, best_path_idx, size(best_segment,1), best_length, ...
        norm(best_segment(1,:) - start_pt), norm(best_segment(end,:) - end_pt));
end
