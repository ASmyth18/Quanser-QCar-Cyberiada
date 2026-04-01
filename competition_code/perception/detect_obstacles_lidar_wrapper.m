function [obstacle_detected, closest_dist] = detect_obstacles_lidar_wrapper(angles, distances)
%DETECT_OBSTACLES_LIDAR_WRAPPER Wrapper for detect_obstacles_lidar.
%   Called via coder.extrinsic from Simulink MATLAB Function blocks.
%   Packs the params struct internally so the block only needs raw LIDAR data.
%
%   Inputs:
%     angles    - Nx1 scan angles (radians, 0 = forward, CCW)
%     distances - Nx1 distances (meters)
%
%   Outputs:
%     obstacle_detected - logical, true if obstacle in forward path
%     closest_dist      - distance to nearest obstacle (meters), inf if none

    persistent params_cached
    if isempty(params_cached)
        p = struct();
        p.LIDAR_MIN_RANGE     = 0.05;
        p.LIDAR_MAX_RANGE     = 2.0;
        p.LIDAR_FORWARD_ANGLE = deg2rad(45);
        p.LIDAR_CLUSTER_DIST  = 0.1;
        p.LIDAR_MIN_CLUSTER   = 3;
        params_cached = p;
    end

    [obstacle_detected, closest_dist, ~, ~] = ...
        detect_obstacles_lidar(angles, distances, params_cached);
end
