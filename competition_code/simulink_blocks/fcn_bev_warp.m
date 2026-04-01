function bev_image = fcn_bev_warp(rgb_image)
%#codegen
% Warp front camera image to Bird's Eye View using precomputed lookup tables.
% Loads bev_calibration.mat (map_x, map_y) once, then uses nearest-neighbor
% sampling for each BEV pixel. Fully codegen-compatible.

    persistent bev_map_x bev_map_y
    if isempty(bev_map_x)
        cal = coder.load('bev_calibration.mat');
        bev_map_x = cal.map_x;  % [200 x 200] single
        bev_map_y = cal.map_y;  % [200 x 200] single
    end

    BEV_H = int32(200);
    BEV_W = int32(200);
    IMG_H = int32(480);
    IMG_W = int32(640);

    bev_image = zeros(BEV_H, BEV_W, 3, 'uint8');

    for row = 1:BEV_H
        for col = 1:BEV_W
            sx = int32(round(double(bev_map_x(row, col))));
            sy = int32(round(double(bev_map_y(row, col))));
            if sx >= 1 && sx <= IMG_W && sy >= 1 && sy <= IMG_H
                bev_image(row, col, 1) = rgb_image(sy, sx, 1);
                bev_image(row, col, 2) = rgb_image(sy, sx, 2);
                bev_image(row, col, 3) = rgb_image(sy, sx, 3);
            end
        end
    end
end
