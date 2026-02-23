%func bev_transform.m - Bird's Eye View transform module for QCar2
%  Provides inverse-perspective mapping (homography warp) from the 4 CSI
%  cameras into a single composite top-down view for locational awareness.
%
%  Usage:
%    bev = bev_transform();
%    ctx = bev.init(myCar, bev_params);
%    [ctx, composite] = bev.update(ctx, myCar, car_x, car_y, car_yaw);
%    bev.draw(ctx);

function bev = bev_transform()
    bev.init           = @bev_init;
    bev.capture        = @bev_capture;
    bev.warp_single    = @bev_warp_single;
    bev.stitch         = @bev_stitch;
    bev.update         = @bev_update;
    bev.draw           = @bev_draw;
    bev.close_figure   = @bev_close_figure;
end


%% ====================== INIT ====================== 
function ctx = bev_init(myCar, bev_params)
%BEV_INIT  Pre-compute homography matrices and allocate output buffers.
%
%   ctx = bev_init(myCar, bev_params)
%
%   myCar      - QLabsQCar2 actor handle (used to grab a calibration frame)
%   bev_params - struct from vehicle_params.m with fields:
%                  .output_size     [H, W]
%                  .ground_width_m  real-world width in metres
%                  .ground_length_m real-world length in metres
%                  .show_figure     logical
%
%   Returns ctx struct with pre-computed transforms and state.

    ctx = struct();
    ctx.params = bev_params;
    ctx.out_h  = bev_params.output_size(1);
    ctx.out_w  = bev_params.output_size(2);

    % Camera IDs (from QLabsQCar2 constants)
    ctx.CAM_FRONT = 3;   % CAMERA_CSI_FRONT
    ctx.CAM_BACK  = 1;   % CAMERA_CSI_BACK
    ctx.CAM_LEFT  = 2;   % CAMERA_CSI_LEFT
    ctx.CAM_RIGHT = 0;   % CAMERA_CSI_RIGHT

    % CSI camera native resolution
    ctx.cam_w = 820;
    ctx.cam_h = 410;

    % Grab one calibration frame from front camera to verify connectivity
    [ok, test_img] = myCar.get_image(ctx.CAM_FRONT);
    if ok && ~isempty(test_img)
        [ctx.cam_h, ctx.cam_w, ~] = size(test_img);
        fprintf('[BEV] Calibration frame: %dx%d\n', ctx.cam_w, ctx.cam_h);
    else
        fprintf('[BEV] WARNING: Could not grab calibration frame. Using defaults 820x410.\n');
    end

    % ------------------------------------------------------------------
    % Homography source points (trapezoidal ROI in each camera image)
    % These define the ground-plane region visible in each CSI camera.
    %
    % Source points are [x, y] in image coordinates (col, row).
    % Destination points map to a rectangular region in the output BEV.
    % ------------------------------------------------------------------

    W = ctx.cam_w;
    H = ctx.cam_h;
    oW = ctx.out_w;
    oH = ctx.out_h;

    % --- Front camera: maps to TOP half of composite ---
    % Trapezoid: bottom-left, bottom-right, top-right, top-left
    ctx.src_front = [W*0.10, H*0.95;   % bottom-left
                     W*0.90, H*0.95;   % bottom-right
                     W*0.65, H*0.40;   % top-right
                     W*0.35, H*0.40];  % top-left

    ctx.dst_front = [oW*0.15, oH*0.50;  % bottom-left  (centre of composite)
                     oW*0.85, oH*0.50;  % bottom-right
                     oW*0.85, oH*0.05;  % top-right     (top of composite)
                     oW*0.15, oH*0.05]; % top-left

    % --- Rear camera: maps to BOTTOM half ---
    ctx.src_back  = [W*0.10, H*0.95;
                     W*0.90, H*0.95;
                     W*0.65, H*0.40;
                     W*0.35, H*0.40];

    ctx.dst_back  = [oW*0.85, oH*0.50;  % note: mirrored L-R (rear faces backward)
                     oW*0.15, oH*0.50;
                     oW*0.15, oH*0.95;
                     oW*0.85, oH*0.95];

    % --- Left camera: maps to LEFT strip ---
    ctx.src_left  = [W*0.10, H*0.95;
                     W*0.90, H*0.95;
                     W*0.65, H*0.40;
                     W*0.35, H*0.40];

    ctx.dst_left  = [oW*0.15, oH*0.50;  % bottom-left (toward rear)
                     oW*0.15, oH*0.05;  % bottom-right(toward front, but left side)
                     oW*0.05, oH*0.20;
                     oW*0.05, oH*0.35];

    % --- Right camera: maps to RIGHT strip ---
    ctx.src_right = [W*0.10, H*0.95;
                     W*0.90, H*0.95;
                     W*0.65, H*0.40;
                     W*0.35, H*0.40];

    ctx.dst_right = [oW*0.85, oH*0.05;
                     oW*0.85, oH*0.50;
                     oW*0.95, oH*0.35;
                     oW*0.95, oH*0.20];

    % Compute projective transforms
    ctx.tform_front = fitgeotrans(ctx.src_front, ctx.dst_front, 'projective');
    ctx.tform_back  = fitgeotrans(ctx.src_back,  ctx.dst_back,  'projective');
    ctx.tform_left  = fitgeotrans(ctx.src_left,  ctx.dst_left,  'projective');
    ctx.tform_right = fitgeotrans(ctx.src_right, ctx.dst_right, 'projective');

    % Output spatial reference for imwarp
    ctx.out_ref = imref2d([oH, oW], [1 oW], [1 oH]);

    % Composite buffer
    ctx.composite = zeros(oH, oW, 3, 'uint8');

    % Figure handle (created on first draw)
    ctx.fig = [];
    ctx.img_handle = [];
    ctx.car_arrow  = [];

    % Tick counter for rate-gating
    ctx.tick = 0;

    fprintf('[BEV] Initialised — output %dx%d, ground %.1f x %.1f m\n', ...
        oW, oH, bev_params.ground_width_m, bev_params.ground_length_m);
end


%% ====================== CAPTURE ======================
function imgs = bev_capture(myCar, ctx)
%BEV_CAPTURE  Grab images from all 4 CSI cameras.
%   Returns a struct with fields: front, back, left, right.
%   Any failed capture is replaced with a black image.

    black = zeros(ctx.cam_h, ctx.cam_w, 3, 'uint8');

    [ok_f, img_f] = myCar.get_image(ctx.CAM_FRONT);
    [ok_b, img_b] = myCar.get_image(ctx.CAM_BACK);
    [ok_l, img_l] = myCar.get_image(ctx.CAM_LEFT);
    [ok_r, img_r] = myCar.get_image(ctx.CAM_RIGHT);

    imgs.front = conditional_img(ok_f, img_f, black);
    imgs.back  = conditional_img(ok_b, img_b, black);
    imgs.left  = conditional_img(ok_l, img_l, black);
    imgs.right = conditional_img(ok_r, img_r, black);
end


%% ====================== WARP SINGLE ======================
function warped = bev_warp_single(img, tform, out_ref)
%BEV_WARP_SINGLE  Apply a projective transform to a single camera image.
%   Uses imwarp with bilinear interpolation and black fill.

    warped = imwarp(img, tform, 'OutputView', out_ref, ...
                    'InterpolationMethod', 'bilinear', 'FillValues', 0);
end


%% ====================== STITCH ======================
function composite = bev_stitch(wF, wB, wL, wR, out_h, out_w)
%BEV_STITCH  Alpha-blend 4 warped camera views into a single composite.
%   Simple max-blend: at each pixel take the brightest contribution.
%   This avoids dark seams while keeping the implementation lightweight.

    composite = zeros(out_h, out_w, 3, 'uint8');

    % Max-blend each layer (fast, avoids artifacts at seam boundaries)
    composite = max(composite, wF);
    composite = max(composite, wB);
    composite = max(composite, wL);
    composite = max(composite, wR);
end


%% ====================== UPDATE ======================
function [ctx, composite] = bev_update(ctx, myCar, ~, ~, ~)
%BEV_UPDATE  Full pipeline: capture → warp → stitch.
%
%   [ctx, composite] = bev_update(ctx, myCar, car_x, car_y, car_yaw)
%
%   car_x, car_y, car_yaw are accepted but unused in the core transform
%   (reserved for future world-frame overlay features).

    % 1. Capture from all 4 cameras
    imgs = bev_capture(myCar, ctx);

    % 2. Warp each view into top-down perspective
    wF = bev_warp_single(imgs.front, ctx.tform_front, ctx.out_ref);
    wB = bev_warp_single(imgs.back,  ctx.tform_back,  ctx.out_ref);
    wL = bev_warp_single(imgs.left,  ctx.tform_left,  ctx.out_ref);
    wR = bev_warp_single(imgs.right, ctx.tform_right, ctx.out_ref);

    % 3. Stitch into composite
    composite = bev_stitch(wF, wB, wL, wR, ctx.out_h, ctx.out_w);
    ctx.composite = composite;
end


%% ====================== DRAW ======================
function ctx = bev_draw(ctx, car_x, car_y, car_yaw)
%BEV_DRAW  Render or update the live BEV figure.
%   Creates the figure on first call; on subsequent calls updates the
%   image data without recreating the figure (fast).

    if isempty(ctx.composite)
        return;
    end

    % Create figure on first call
    if isempty(ctx.fig) || ~isvalid(ctx.fig)
        ctx.fig = figure('Name', 'Bird''s Eye View', ...
                         'NumberTitle', 'off', ...
                         'MenuBar', 'none', ...
                         'Position', [50, 50, ctx.out_w+40, ctx.out_h+80], ...
                         'Color', [0.1 0.1 0.12]);

        ax = axes(ctx.fig, 'Position', [0.02 0.08 0.96 0.88]);
        ctx.img_handle = imshow(ctx.composite, 'Parent', ax);
        hold(ax, 'on');

        % Draw car icon at centre
        cx = ctx.out_w / 2;
        cy = ctx.out_h / 2;

        % Car body rectangle (small indicator)
        car_w = 16; car_h = 24;
        rectangle('Position', [cx-car_w/2, cy-car_h/2, car_w, car_h], ...
                  'EdgeColor', [0 1 0.5], 'LineWidth', 2, ...
                  'FaceColor', [0 0.6 0.3], 'Curvature', 0.3, ...
                  'Parent', ax);

        % Heading arrow (forward = up in BEV)
        arrow_len = 20;
        dx = arrow_len * sin(car_yaw);
        dy = -arrow_len * cos(car_yaw);
        ctx.car_arrow = quiver(ax, cx, cy, dx, dy, 0, ...
                               'Color', [1 1 0], 'LineWidth', 2, ...
                               'MaxHeadSize', 2);

        % Title with position info
        title(ax, sprintf('BEV  |  x=%.2f  y=%.2f  θ=%.0f°', ...
              car_x, car_y, car_yaw*180/pi), ...
              'Color', 'w', 'FontSize', 10);

        hold(ax, 'off');
    else
        % Fast update: just replace image data and arrow
        set(ctx.img_handle, 'CData', ctx.composite);

        % Update heading arrow
        if ~isempty(ctx.car_arrow) && isvalid(ctx.car_arrow)
            arrow_len = 20;
            set(ctx.car_arrow, ...
                'UData', arrow_len * sin(car_yaw), ...
                'VData', -arrow_len * cos(car_yaw));
        end

        % Update title
        ax = get(ctx.img_handle, 'Parent');
        title(ax, sprintf('BEV  |  x=%.2f  y=%.2f  θ=%.0f°', ...
              car_x, car_y, car_yaw*180/pi), ...
              'Color', 'w', 'FontSize', 10);

        drawnow limitrate;
    end
end


%% ====================== CLOSE ======================
function bev_close_figure(ctx)
%BEV_CLOSE_FIGURE  Close the BEV figure if it exists.
    if ~isempty(ctx.fig) && isvalid(ctx.fig)
        close(ctx.fig);
        fprintf('[BEV] Figure closed.\n');
    end
end


%% ====================== HELPERS ======================
function img = conditional_img(ok, captured, fallback)
%CONDITIONAL_IMG  Return captured image if ok, otherwise fallback.
    if ok && ~isempty(captured)
        img = captured;
    else
        img = fallback;
    end
end
