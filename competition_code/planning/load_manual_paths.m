function mission_paths = load_manual_paths()
%LOAD_MANUAL_PATHS Load hand-drawn waypoint paths from manual_path.mat.
%
%   mission_paths = load_manual_paths()
%
%   Drop-in replacement for generate_mission_paths(). Loads the paths
%   created by manual_waypoint_editor.m, applies pchip spline smoothing
%   (same method as the SDCS paths), and resamples at 5cm spacing.
%
%   All coordinates are in WORLD frame (meters).

    % Find the .mat file (always use absolute path relative to this script)
    mat_file = fullfile(fileparts(mfilename('fullpath')), '..', 'manual_path.mat');
    if ~isfile(mat_file)
        % Try current directory as fallback
        mat_file = 'manual_path.mat';
    end
    if ~isfile(mat_file)
        error('Cannot find manual_path.mat. Run manual_waypoint_editor.m first.');
    end

    data = load(mat_file, 'path_x4', 'path_y4', 'idx_pickup', 'idx_dropoff');
    fprintf('Loaded manual paths from: %s\n', mat_file);

    % Split into 3 legs using the saved indices
    leg1_raw = [data.path_x4(1:data.idx_pickup), data.path_y4(1:data.idx_pickup)];
    leg2_raw = [data.path_x4(data.idx_pickup:data.idx_dropoff), data.path_y4(data.idx_pickup:data.idx_dropoff)];
    leg3_raw = [data.path_x4(data.idx_dropoff:end), data.path_y4(data.idx_dropoff:end)];

    % Spline-smooth each leg (same method as generate_mission_paths)
    spacing = 0.05;  % 5cm between points — matches SDCS path density
    mission_paths.hub_to_pickup  = smooth_path(leg1_raw, spacing);
    mission_paths.pickup_to_drop = smooth_path(leg2_raw, spacing);
    mission_paths.drop_to_hub    = smooth_path(leg3_raw, spacing);

    % Concatenated full route
    mission_paths.full_route = [
        mission_paths.hub_to_pickup;
        mission_paths.pickup_to_drop(2:end, :);
        mission_paths.drop_to_hub(2:end, :);
    ];

    mission_paths.leg_lengths = [
        size(mission_paths.hub_to_pickup, 1), ...
        size(mission_paths.pickup_to_drop, 1), ...
        size(mission_paths.drop_to_hub, 1), ...
    ];

    % Summary
    names = {'Hub -> Pickup', 'Pickup -> Dropoff', 'Dropoff -> Hub'};
    legs = {mission_paths.hub_to_pickup, mission_paths.pickup_to_drop, mission_paths.drop_to_hub};
    for i = 1:3
        leg = legs{i};
        leg_len = sum(sqrt(diff(leg(:,1)).^2 + diff(leg(:,2)).^2));
        fprintf('  Leg %d (%s): %d points, %.3f m\n', i, names{i}, size(leg,1), leg_len);
    end
    fprintf('  Total: %d points\n', size(mission_paths.full_route, 1));
end


function smooth = smooth_path(waypoints, spacing)
%SMOOTH_PATH Fit pchip spline through waypoints and resample at uniform spacing.
%   Eliminates jitter from hand-entered coordinates while preserving the
%   intended route. Same algorithm used by generate_mission_paths.

    n = size(waypoints, 1);
    if n < 2
        smooth = waypoints;
        return;
    end

    % Remove duplicate consecutive points
    keep = true(n, 1);
    for i = 2:n
        if norm(waypoints(i,:) - waypoints(i-1,:)) < 1e-6
            keep(i) = false;
        end
    end
    waypoints = waypoints(keep, :);
    n = size(waypoints, 1);

    if n < 3
        % Too few points for spline — densify linearly
        smooth = densify_linear(waypoints, spacing);
        return;
    end

    % Compute cumulative arc length
    cum_dist = zeros(n, 1);
    for i = 2:n
        cum_dist(i) = cum_dist(i-1) + norm(waypoints(i,:) - waypoints(i-1,:));
    end
    total_len = cum_dist(end);

    if total_len < 1e-6
        smooth = waypoints;
        return;
    end

    % Uniform resampling along arc length
    n_out = max(3, round(total_len / spacing) + 1);
    t_out = linspace(0, total_len, n_out)';

    % Pchip spline (no overshoot, smooth curves through waypoints)
    x_smooth = pchip(cum_dist, waypoints(:,1), t_out);
    y_smooth = pchip(cum_dist, waypoints(:,2), t_out);

    smooth = [x_smooth, y_smooth];

    % Ensure exact start and end
    smooth(1, :)   = waypoints(1, :);
    smooth(end, :) = waypoints(end, :);
end


function dense = densify_linear(path, max_spacing)
    if size(path, 1) < 2
        dense = path;
        return;
    end
    dense = path(1, :);
    for i = 2:size(path, 1)
        seg_dist = norm(path(i,:) - path(i-1,:));
        if seg_dist > max_spacing
            n_pts = ceil(seg_dist / max_spacing);
            for j = 1:n_pts
                t = j / n_pts;
                dense = [dense; path(i-1,:) + t * (path(i,:) - path(i-1,:))];
            end
        else
            dense = [dense; path(i,:)];
        end
    end
end
