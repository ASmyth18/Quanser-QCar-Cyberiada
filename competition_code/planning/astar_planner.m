function [path_nodes, path_coords, total_dist] = astar_planner(nodes, edges, start_node, goal_node)
%ASTAR_PLANNER A* path planning on the waypoint graph.
%
%   [path_nodes, path_coords, total_dist] = astar_planner(nodes, edges, start_node, goal_node)
%
%   Finds the shortest path between two nodes in the waypoint graph
%   using A* search with Euclidean distance heuristic.
%
%   Inputs:
%     nodes      - Nx2 array of [x, y] waypoint positions
%     edges      - Mx2 array of [from_node, to_node] directed connections
%     start_node - index of start node (1-based)
%     goal_node  - index of goal node (1-based)
%
%   Outputs:
%     path_nodes  - 1xK array of node indices along the path
%     path_coords - Kx2 array of [x, y] coordinates along the path
%     total_dist  - total path distance in meters

    n = size(nodes, 1);
    path_nodes = [];
    path_coords = [];
    total_dist = inf;

    if start_node < 1 || start_node > n || goal_node < 1 || goal_node > n
        warning('Invalid start or goal node.');
        return;
    end

    if start_node == goal_node
        path_nodes = start_node;
        path_coords = nodes(start_node, :);
        total_dist = 0;
        return;
    end

    % Build adjacency list with costs
    adj = cell(n, 1);
    for i = 1:size(edges, 1)
        from = edges(i, 1);
        to   = edges(i, 2);
        dist = norm(nodes(from, :) - nodes(to, :));
        adj{from} = [adj{from}; to, dist];
    end

    % A* search
    goal_pos = nodes(goal_node, :);

    % g_score: cost from start to each node
    g_score = inf(n, 1);
    g_score(start_node) = 0;

    % f_score: g + heuristic
    f_score = inf(n, 1);
    f_score(start_node) = heuristic(nodes(start_node, :), goal_pos);

    % came_from: for path reconstruction
    came_from = zeros(n, 1);

    % Open set (priority queue as simple sorted list)
    open_set = start_node;
    closed_set = false(n, 1);

    while ~isempty(open_set)
        % Find node in open_set with lowest f_score
        [~, min_idx] = min(f_score(open_set));
        current = open_set(min_idx);

        if current == goal_node
            % Reconstruct path
            path_nodes = reconstruct_path(came_from, current);
            path_coords = nodes(path_nodes, :);
            total_dist = g_score(current);
            return;
        end

        % Move current from open to closed
        open_set(min_idx) = [];
        closed_set(current) = true;

        % Expand neighbors
        neighbors = adj{current};
        if isempty(neighbors)
            continue;
        end

        for i = 1:size(neighbors, 1)
            neighbor = neighbors(i, 1);
            edge_cost = neighbors(i, 2);

            if closed_set(neighbor)
                continue;
            end

            tentative_g = g_score(current) + edge_cost;

            if tentative_g < g_score(neighbor)
                % Better path found
                came_from(neighbor) = current;
                g_score(neighbor) = tentative_g;
                f_score(neighbor) = tentative_g + heuristic(nodes(neighbor, :), goal_pos);

                if ~any(open_set == neighbor)
                    open_set = [open_set, neighbor];
                end
            end
        end
    end

    % No path found
    warning('No path found from node %d to node %d.', start_node, goal_node);
end


function h = heuristic(pos, goal)
    % Euclidean distance heuristic
    h = norm(pos - goal);
end


function path = reconstruct_path(came_from, current)
    path = current;
    while came_from(current) ~= 0
        current = came_from(current);
        path = [current, path];
    end
end
