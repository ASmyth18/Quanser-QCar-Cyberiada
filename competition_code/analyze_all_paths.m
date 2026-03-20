%% analyze_all_paths.m
% Plot all 7 SDCS paths to find which ones cover interior roads.
% Run AFTER Setup_QCar2_Params.m

load('SDCS_Paths_7.mat');

hub_pos     = [-1.205, -0.83];
pickup_pos  = [0.125, 4.395];
dropoff_pos = [-0.905, 0.800];

path_names = {'path 1','path 2','path 3','path 4','path 5','path 6','path 7'};
px = {path_x, path_x2, path_x3, path_x4, path_x5, path_x6, path_x7};
py = {path_y, path_y2, path_y3, path_y4, path_y5, path_y6, path_y7};
colors = {'r','g','b','c','m','k',[0.8 0.5 0]};

figure('Name','All SDCS Paths','NumberTitle','off','Position',[50 50 1000 800]);
hold on;

for k = 1:7
    x = px{k}; y = py{k};
    plot(x, y, '-', 'Color', colors{k}, 'LineWidth', 1.2, 'DisplayName', ...
        sprintf('%s (%d pts)', path_names{k}, length(x)));

    % Distance to each mission location
    d_hub  = min(sqrt((x - hub_pos(1)).^2 + (y - hub_pos(2)).^2));
    d_pick = min(sqrt((x - pickup_pos(1)).^2 + (y - pickup_pos(2)).^2));
    d_drop = min(sqrt((x - dropoff_pos(1)).^2 + (y - dropoff_pos(2)).^2));

    fprintf('%s: %4d pts | Hub: %.3f m | Pickup: %.3f m | Dropoff: %.3f m\n', ...
        path_names{k}, length(x), d_hub, d_pick, d_drop);
end

% Mission locations
plot(hub_pos(1), hub_pos(2), 'mp', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Hub');
plot(pickup_pos(1), pickup_pos(2), 'g^', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Pickup');
plot(dropoff_pos(1), dropoff_pos(2), 'rs', 'MarkerSize', 20, 'LineWidth', 3, 'DisplayName', 'Dropoff');

legend('Location','eastoutside');
xlabel('X (m)'); ylabel('Y (m)');
title('All SDCS Paths with Mission Locations');
axis equal; grid on;
hold off;
