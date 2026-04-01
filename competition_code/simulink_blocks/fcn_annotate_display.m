function annotated = fcn_annotate_display(rgb_image, light_color, sign_type, speed_scale)
%#codegen
% Lightweight detection overlay for camera feed.
% Draws a thin colored strip at the top (5px) to indicate traffic light state,
% and a thin bar at the bottom showing speed. Non-intrusive.

    annotated = rgb_image;
    STRIP_H = int32(5);

    % --- Top strip: traffic light state ---
    r = uint8(60); g = uint8(60); b = uint8(60);  % dark grey = none
    if light_color == int32(1)
        r = uint8(255); g = uint8(0);   b = uint8(0);    % red
    elseif light_color == int32(2)
        r = uint8(255); g = uint8(255); b = uint8(0);    % yellow
    elseif light_color == int32(3)
        r = uint8(0);   g = uint8(255); b = uint8(0);    % green
    end
    for row = 1:STRIP_H
        for col = int32(1):int32(640)
            annotated(row, col, 1) = r;
            annotated(row, col, 2) = g;
            annotated(row, col, 3) = b;
        end
    end

    % --- Small sign indicator dot (top-right, 10x10) ---
    if sign_type > int32(0)
        sr = uint8(255); sg = uint8(255); sb = uint8(0);  % yellow default
        if sign_type == int32(1)
            sr = uint8(255); sg = uint8(0); sb = uint8(0);    % stop = red
        elseif sign_type == int32(3)
            sr = uint8(0); sg = uint8(100); sb = uint8(255);  % roundabout = blue
        end
        for row = int32(8):int32(17)
            for col = int32(625):int32(634)
                annotated(row, col, 1) = sr;
                annotated(row, col, 2) = sg;
                annotated(row, col, 3) = sb;
            end
        end
    end

    % --- Bottom speed bar (3px tall) ---
    bar_w = max(int32(1), int32(round(double(speed_scale) * 640.0)));
    if bar_w > int32(640)
        bar_w = int32(640);
    end
    for row = int32(478):int32(480)
        for col = 1:bar_w
            annotated(row, col, 1) = uint8(0);
            annotated(row, col, 2) = uint8(200);
            annotated(row, col, 3) = uint8(0);
        end
    end
end
