function [near_stop_sign, closest_dist] = check_stop_sign_proximity(...
    car_pos, stop_sign_positions, detection_radius)
%CHECK_STOP_SIGN_PROXIMITY Check if car is near any known stop sign.
%
%   [near_stop_sign, closest_dist] = check_stop_sign_proximity(...
%       car_pos, stop_sign_positions, detection_radius)
%
%   Uses known stop sign locations from the map to determine if the car
%   is approaching a stop sign. This is faster and more reliable than
%   purely vision-based detection.
%
%   Inputs:
%     car_pos              - [x, y] current position (EKF frame)
%     stop_sign_positions  - Nx2 array of stop sign positions (EKF frame)
%     detection_radius     - distance threshold in meters
%
%   Outputs:
%     near_stop_sign - logical, true if within detection_radius of any sign
%     closest_dist   - distance to nearest stop sign (meters)

    near_stop_sign = false;
    closest_dist = inf;

    n = size(stop_sign_positions, 1);

    for i = 1:n
        d = norm(car_pos - stop_sign_positions(i, :));
        if d < closest_dist
            closest_dist = d;
        end
    end

    if closest_dist < detection_radius
        near_stop_sign = true;
    end
end
