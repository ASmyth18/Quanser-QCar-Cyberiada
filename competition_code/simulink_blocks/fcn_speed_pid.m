function throttle = fcn_speed_pid(desired_speed, car_speed)
%#codegen
% MATLAB Function Block: PID Speed Controller
%
% Inputs:
%   desired_speed [double] - target speed (m/s)
%   car_speed     [double] - current speed (m/s)
%
% Output:
%   throttle [double] - motor command [-1 to 1]

    persistent integral prev_error
    if isempty(integral)
        integral = 0;
        prev_error = 0;
    end

    % PID gains
    Kp = 2.0;
    Ki = 0.5;
    Kd = 0.1;
    MAX_THROTTLE = 0.5;
    dt = 0.002;  % Controller_Sample_Time

    % Compute error
    err = desired_speed - car_speed;

    % Integral with anti-windup
    integral = integral + err * dt;
    max_integral = MAX_THROTTLE / max(Ki, 0.01);
    integral = max(-max_integral, min(max_integral, integral));

    % Derivative
    deriv = (err - prev_error) / dt;
    prev_error = err;

    % PID output
    throttle = Kp * err + Ki * integral + Kd * deriv;

    % Clamp
    throttle = max(-MAX_THROTTLE, min(MAX_THROTTLE, throttle));
end
