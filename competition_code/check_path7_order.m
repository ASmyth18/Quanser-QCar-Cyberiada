%% check_path7_order.m
% Check if Path 7 visits Hub -> Pickup -> Dropoff -> Hub in correct order.

sdcs_dir = 'C:\Users\adams\Desktop\Qunaser_Main_Project\student-competition-resources-matlab\Virtual_MATLAB_Resources\self_driving_stack_resources';
data = load(fullfile(sdcs_dir, 'SDCS_Paths_7.mat'));

p7 = [data.path_x7, data.path_y7];
n = size(p7, 1);

hub_w     = [-1.205, -0.83];
pickup_w  = [0.125, 4.395];
dropoff_w = [-0.905, 0.800];

% Find nearest indices
d_hub = sqrt((p7(:,1)-hub_w(1)).^2 + (p7(:,2)-hub_w(2)).^2);
d_pick = sqrt((p7(:,1)-pickup_w(1)).^2 + (p7(:,2)-pickup_w(2)).^2);
d_drop = sqrt((p7(:,1)-dropoff_w(1)).^2 + (p7(:,2)-dropoff_w(2)).^2);

[~, idx_hub] = min(d_hub);
[~, idx_pick] = min(d_pick);
[~, idx_drop] = min(d_drop);

fprintf('Path 7: %d points\n', n);
fprintf('Hub     nearest at index %d/%d (%.1f%%)\n', idx_hub, n, 100*idx_hub/n);
fprintf('Pickup  nearest at index %d/%d (%.1f%%)\n', idx_pick, n, 100*idx_pick/n);
fprintf('Dropoff nearest at index %d/%d (%.1f%%)\n', idx_drop, n, 100*idx_drop/n);

% Check order
if idx_hub < idx_pick && idx_pick < idx_drop
    fprintf('\nOrder: Hub(%d) -> Pickup(%d) -> Dropoff(%d) -> [loop back to Hub]\n', idx_hub, idx_pick, idx_drop);
    fprintf('GOOD: Natural forward order matches mission!\n');
elseif idx_hub > idx_pick || idx_pick > idx_drop
    fprintf('\nOrder does NOT match. Indices: Hub=%d, Pickup=%d, Dropoff=%d\n', idx_hub, idx_pick, idx_drop);
    fprintf('May need to reorder the path start point.\n');
end

% Show what a reordered path starting at hub would look like
reordered = [p7(idx_hub:end, :); p7(1:idx_hub-1, :)];
d_pick2 = sqrt((reordered(:,1)-pickup_w(1)).^2 + (reordered(:,2)-pickup_w(2)).^2);
d_drop2 = sqrt((reordered(:,1)-dropoff_w(1)).^2 + (reordered(:,2)-dropoff_w(2)).^2);
[~, idx_pick2] = min(d_pick2);
[~, idx_drop2] = min(d_drop2);

fprintf('\nReordered (starting at hub):\n');
fprintf('  Pickup at index %d/%d (%.1f%%)\n', idx_pick2, n, 100*idx_pick2/n);
fprintf('  Dropoff at index %d/%d (%.1f%%)\n', idx_drop2, n, 100*idx_drop2/n);

if idx_pick2 < idx_drop2
    fprintf('  GOOD: Hub -> Pickup -> Dropoff -> Hub (forward)\n');
else
    fprintf('  REVERSE needed: Hub -> Dropoff -> Pickup\n');
    fprintf('  Trying reverse...\n');
    rev = flipud(reordered);
    d_pick3 = sqrt((rev(:,1)-pickup_w(1)).^2 + (rev(:,2)-pickup_w(2)).^2);
    d_drop3 = sqrt((rev(:,1)-dropoff_w(1)).^2 + (rev(:,2)-dropoff_w(2)).^2);
    [~, idx_pick3] = min(d_pick3);
    [~, idx_drop3] = min(d_drop3);
    fprintf('  Reversed: Pickup at %d, Dropoff at %d\n', idx_pick3, idx_drop3);
    if idx_pick3 < idx_drop3
        fprintf('  GOOD after reverse: Hub -> Pickup -> Dropoff -> Hub\n');
    end
end

% Plot
cal_origin = [0, 2.0];
figure('Name', 'Path 7 Direction Check', 'NumberTitle', 'off');
hold on;
p7_ekf = p7 - cal_origin;

% Color by index to show direction
scatter(p7_ekf(:,1), p7_ekf(:,2), 5, 1:n, 'filled');
colorbar; colormap(jet);
title('Path 7 colored by index (blue=start, red=end)');

% Mark locations
plot(hub_w(1)-cal_origin(1), hub_w(2)-cal_origin(2), 'mp', 'MarkerSize', 20, 'LineWidth', 3);
plot(pickup_w(1)-cal_origin(1), pickup_w(2)-cal_origin(2), 'g^', 'MarkerSize', 20, 'LineWidth', 3);
plot(dropoff_w(1)-cal_origin(1), dropoff_w(2)-cal_origin(2), 'rs', 'MarkerSize', 20, 'LineWidth', 3);

% Mark start/end of path
plot(p7_ekf(1,1), p7_ekf(1,2), 'wo', 'MarkerSize', 15, 'LineWidth', 3);
text(p7_ekf(1,1)+0.1, p7_ekf(1,2), 'PATH START', 'Color', 'w', 'FontSize', 10);

xlabel('X (m) - EKF'); ylabel('Y (m) - EKF');
axis equal; grid on;
hold off;
