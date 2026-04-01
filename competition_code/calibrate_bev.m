%% Calibrate Bird's Eye View Transform
% Computes the homography and precomputes pixel lookup tables
% for fast codegen-compatible BEV warping at runtime.
%
% Run this ONCE, then the lookup tables are saved for use in Simulink.

%% 1. Define source points (trapezoid in front camera image)
% Picked from a straight road frame: bottom-left, bottom-right, top-right, top-left
src = [208, 470; 591, 462; 453, 316; 331, 302];

%% 2. Define destination points (rectangle in BEV output)
% BEV output is 200x200 pixels
BEV_W = 200;
BEV_H = 200;
dst = [50, 200; 150, 200; 150, 50; 50, 50];

%% 3. Compute projective transform (image -> BEV)
tform_fwd = fitgeotform2d(src, dst, 'projective');

% Inverse transform (BEV -> image) for pixel sampling
tform_inv = fitgeotform2d(dst, src, 'projective');

%% 4. Precompute lookup tables for codegen
% For each BEV pixel, compute the corresponding source image coordinate
map_x = zeros(BEV_H, BEV_W, 'single');
map_y = zeros(BEV_H, BEV_W, 'single');

for row = 1:BEV_H
    for col = 1:BEV_W
        % Transform BEV pixel to source image coordinates
        pt = transformPointsForward(tform_inv, [col, row]);
        map_x(row, col) = single(pt(1));
        map_y(row, col) = single(pt(2));
    end
end

%% 5. Physical calibration
% Lane width in simulation = 0.28m
% In BEV, the lane spans from dst column 50 to 150 = 100 pixels
lane_width_m = 0.28;
lane_width_px = 100;  % dst right (150) - dst left (50)
meters_per_pixel_x = lane_width_m / lane_width_px;  % 0.0028 m/px

% Vertical: estimate from source point spacing
% Bottom row to top row in BEV = 150 pixels (row 200 to row 50)
% Physical distance: roughly 1.0m look-ahead (estimated)
look_ahead_m = 1.0;
look_ahead_px = 150;
meters_per_pixel_y = look_ahead_m / look_ahead_px;

%% 6. Save everything
save('C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code\bev_calibration.mat', ...
    'map_x', 'map_y', 'BEV_W', 'BEV_H', ...
    'meters_per_pixel_x', 'meters_per_pixel_y', ...
    'lane_width_m', 'tform_fwd', 'tform_inv', ...
    'src', 'dst');

fprintf('BEV calibration saved.\n');
fprintf('  BEV size: %dx%d\n', BEV_W, BEV_H);
fprintf('  Meters/pixel (lateral):      %.4f m/px\n', meters_per_pixel_x);
fprintf('  Meters/pixel (longitudinal): %.4f m/px\n', meters_per_pixel_y);
fprintf('  Lane width: %.2f m\n', lane_width_m);

%% 7. Visual verification
img = imread('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\frame4\frame_00020.png');
bev = imwarp(img, tform_fwd, 'OutputView', imref2d([BEV_H, BEV_W]));

figure;
subplot(1,2,1); imshow(img); title('Front View');
hold on; plot(src([1:4,1],1), src([1:4,1],2), 'r-o', 'LineWidth', 2);
subplot(1,2,2); imshow(bev); title('Bird''s Eye View');
hold on;
plot([BEV_W/2, BEV_W/2], [1, BEV_H], 'g--', 'LineWidth', 1); % center line
plot([50, 50], [1, BEV_H], 'r--', 'LineWidth', 1);  % left boundary
plot([150, 150], [1, BEV_H], 'r--', 'LineWidth', 1); % right boundary
