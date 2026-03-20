function [throttle, error, integral_out] = pid_speed_controller(...
    desired_speed, current_speed, dt, integral_in, prev_error, Kp, Ki, Kd, max_throttle)
%PID_SPEED_CONTROLLER PID controller for longitudinal speed control.
%
%   [throttle, error, integral_out] = pid_speed_controller(...
%       desired_speed, current_speed, dt, integral_in, prev_error, Kp, Ki, Kd, max_throttle)
%
%   Computes throttle command using PID control to match desired speed.
%
%   Inputs:
%     desired_speed - target speed (m/s)
%     current_speed - measured speed (m/s)
%     dt           - time step (seconds)
%     integral_in  - accumulated integral error from previous step
%     prev_error   - previous error for derivative term
%     Kp, Ki, Kd   - PID gains
%     max_throttle - maximum absolute throttle value
%
%   Outputs:
%     throttle     - throttle command [-max_throttle, max_throttle]
%     error        - current speed error (for next derivative calc)
%     integral_out - updated integral term (for next step)

    % Speed error
    error = desired_speed - current_speed;

    % Integral with anti-windup
    integral_out = integral_in + error * dt;
    max_integral = max_throttle / max(Ki, 0.001);
    integral_out = max(-max_integral, min(max_integral, integral_out));

    % Derivative
    if dt > 0
        derivative = (error - prev_error) / dt;
    else
        derivative = 0;
    end

    % PID output
    throttle = Kp * error + Ki * integral_out + Kd * derivative;

    % Clamp output
    throttle = max(-max_throttle, min(max_throttle, throttle));
end
