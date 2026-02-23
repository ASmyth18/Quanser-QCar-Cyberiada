function bev = bev_transform()
    bev.init = @bev_transform
    bev.cap = @bev_transform
    bev.warp_single = @bev_transform
    bev.stitch = @bev_transform
    bev.update = @bev_transform
    bev.draw = @bev_transform
    bev.close_fig = @bev_transform
end

function ctx = bev_init(myCar, params)
    ctx = struct();
    ctx.params = bev_params();
    ctx.out_h = bev_params.output_size(1);
    ctx.out_w = bev_params.output_size(2);

    ctx.cam_f = 3;
    ctx.cam_b = 1;
    ctx.cam_l = 2;
    ctx.cam_r = 0;
    
    ctx.cam_w = 820;
    ctx.cam_h = 410;

    W = ctx.cam_w
    H = ctx.cam_H

    ctx.cam_center = [ctx.cam_w / 2, ctx.cam_h / 2];

    oW = ctx.out_w
    OH = ctx.out_H

    ctx.src_front = [W*0.10, H*0.95;
                     W*0.90, H*0.95;
                     W*0.65, H*0.40;
                     W*.35, H*0.40;];
    ctx.src_back = [W*0.10, H*0.05;
                    W*0.90, H*0.05;
                    W*0.65, H*0.60;
                    W*0.35, H*0.60;];
    ctx.src_right = [W*0.10, H*0.95;
                     W*0.90, H*0.95;
                     W*0.65, H*0.40;
                     W*0.35, H*0.40]
    ctx.src_left = [W*0.10, H*0.95;
                    W*0.90, H*0.95;
                    W*0.65, H*0.40;
                    W*0.35, H*0.40];

    