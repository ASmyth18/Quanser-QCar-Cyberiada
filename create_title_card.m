%% create_title_card.m
% Generates a professional title card for the competition video.
% Trinity College Dublin branding with blue bar at bottom.

output_path = 'C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code\title_card.png';

%% Settings
WIDTH  = 1920;
HEIGHT = 1080;
TRINITY_BLUE = [0, 83, 155] / 255;  % TCD official blue (#00539B)
BAR_HEIGHT = 200;

%% Create canvas (white background)
card = ones(HEIGHT, WIDTH, 3, 'uint8') * 255;

%% Try to load Trinity image
trinity_img_path = '';
candidates = {
    'C:\Users\adams\Desktop\trinity.png'
    'C:\Users\adams\Desktop\trinity.jpg'
    'C:\Users\adams\Pictures\trinity.png'
    'C:\Users\adams\Pictures\trinity.jpg'
    'C:\Users\adams\Desktop\Qunaser_Main_Project\trinity.png'
    'C:\Users\adams\Desktop\Qunaser_Main_Project\trinity.jpg'
};
for i = 1:length(candidates)
    if isfile(candidates{i})
        trinity_img_path = candidates{i};
        break;
    end
end

if ~isempty(trinity_img_path)
    % Load and center the Trinity image in the upper portion
    timg = imread(trinity_img_path);
    % Scale to fit upper area (above the blue bar)
    avail_h = HEIGHT - BAR_HEIGHT - 40;  % leave margin
    avail_w = WIDTH - 80;
    [ih, iw, ~] = size(timg);
    scale = min(avail_w / iw, avail_h / ih);
    new_w = round(iw * scale);
    new_h = round(ih * scale);
    timg = imresize(timg, [new_h, new_w]);

    % Center in upper portion
    y_off = round((avail_h - new_h) / 2) + 20;
    x_off = round((WIDTH - new_w) / 2);
    card(y_off:y_off+new_h-1, x_off:x_off+new_w-1, :) = timg;
    fprintf('Trinity image loaded from: %s\n', trinity_img_path);
else
    fprintf('No Trinity image found. Place trinity.png or trinity.jpg in:\n');
    fprintf('  C:\\Users\\adams\\Desktop\\\n');
    fprintf('  or C:\\Users\\adams\\Desktop\\Qunaser_Main_Project\\\n');
    fprintf('Then re-run this script.\n\n');
    fprintf('Generating card with text only...\n');
end

%% Draw Trinity blue bar at bottom
for row = (HEIGHT - BAR_HEIGHT + 1):HEIGHT
    card(row, :, 1) = uint8(TRINITY_BLUE(1) * 255);
    card(row, :, 2) = uint8(TRINITY_BLUE(2) * 255);
    card(row, :, 3) = uint8(TRINITY_BLUE(3) * 255);
end

%% Add text to the blue bar
% Main title
card = insertText(card, [WIDTH/2, HEIGHT - BAR_HEIGHT + 35], ...
    'Quanser Self-Driving Car Competition', ...
    'FontSize', 42, 'TextColor', 'white', 'BoxOpacity', 0, ...
    'AnchorPoint', 'CenterTop');

% Subtitle
card = insertText(card, [WIDTH/2, HEIGHT - BAR_HEIGHT + 100], ...
    'Autonomous Taxi Mission  |  Trinity College Dublin', ...
    'FontSize', 28, 'TextColor', [200 220 255], 'BoxOpacity', 0, ...
    'AnchorPoint', 'CenterTop');

% Team/date line
card = insertText(card, [WIDTH/2, HEIGHT - BAR_HEIGHT + 150], ...
    'Virtual Stage  |  April 2026', ...
    'FontSize', 20, 'TextColor', [180 200 240], 'BoxOpacity', 0, ...
    'AnchorPoint', 'CenterTop');

%% Save
imwrite(card, output_path);
fprintf('Title card saved: %s\n', output_path);
fprintf('Resolution: %dx%d\n', WIDTH, HEIGHT);

%% Preview
figure('Name', 'Title Card Preview', 'NumberTitle', 'off');
imshow(card);
title('Title Card');
