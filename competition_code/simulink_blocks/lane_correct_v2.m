function [steer_correction, speed_scale] = lane_correct(lane_offset, lane_heading, lane_detected, current_speed)
    %#codegen
    % Hybrid Stanley controller: active when yellow line visible,
    % smoothly fades to zero at intersections.
    % Also reduces speed when making large corrections (tight turns).

    persistent filtered_offset filtered_heading prev_steer confidence
    if isempty(filtered_offset)
        filtered_offset = single(0);
        filtered_heading = single(0);
        prev_steer = double(0);
        confidence = single(0);
    end

    K_stanley = single(2.5);
    V_SOFT    = single(0.05);

    % Smooth confidence: ramp up when lane visible, fade when not
    if lane_detected == int32(1)
        confidence = confidence + single(0.15);
        if confidence > single(1.0)
            confidence = single(1.0);
        end
    else
        confidence = confidence - single(0.05);
        if confidence < single(0.0)
            confidence = single(0.0);
        end
    end

    if confidence > single(0.01)
        v = single(abs(current_speed));
        if v < single(0.01)
            v = single(0.01);
        end

        ALPHA = single(0.3);
        filtered_offset  = ALPHA * lane_offset  + (single(1) - ALPHA) * filtered_offset;
        filtered_heading = ALPHA * lane_heading + (single(1) - ALPHA) * filtered_heading;

        crosstrack_term = atan(K_stanley * filtered_offset / (v + V_SOFT));
        raw_correction = -(filtered_heading + crosstrack_term);

        steer_correction = double(confidence * single(raw_correction));
    else
        steer_correction = double(0);
        filtered_offset = single(0);
        filtered_heading = single(0);
    end

    % Rate limit
    MAX_RATE = double(0.05);
    delta = steer_correction - prev_steer;
    if delta > MAX_RATE
        steer_correction = prev_steer + MAX_RATE;
    elseif delta < -MAX_RATE
        steer_correction = prev_steer - MAX_RATE;
    end
    prev_steer = steer_correction;

    % Clamp
    MAX_CORR = double(0.35);
    if steer_correction > MAX_CORR
        steer_correction = MAX_CORR;
    elseif steer_correction < -MAX_CORR
        steer_correction = -MAX_CORR;
    end

    % Speed scaling — slow down proportional to steering correction magnitude
    % Full speed at 0 correction, 50% speed at max correction
    corr_ratio = abs(steer_correction) / MAX_CORR;
    speed_scale = double(1.0 - 0.5 * corr_ratio);
end
