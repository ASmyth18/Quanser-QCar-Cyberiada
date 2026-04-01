function speed_limit = fcn_velocity_lookup(car_x, car_y, path_x, path_y, v_profile)
%#codegen
% Look up the curvature-based speed limit at the car's current position.

    persistent last_idx;
    if isempty(last_idx)
        last_idx = 1;
    end

    n = length(path_x);
    speed_limit = 0.5;

    if n < 2
        return;
    end

    % Windowed forward-only search
    search_start = max(1, last_idx - 15);
    search_end   = min(n, last_idx + 60);

    min_dist = 1e6;
    best_idx = last_idx;
    for idx = search_start:search_end
        px = path_x(idx);
        py = path_y(idx);
        dx_val = px(1) - car_x;
        dy_val = py(1) - car_y;
        d = dx_val .* dx_val + dy_val .* dy_val;
        if d(1) < min_dist
            min_dist = d(1);
            best_idx = idx;
        end
    end

    last_idx = best_idx;
    vp = v_profile(best_idx);
    speed_limit = vp(1);
end
