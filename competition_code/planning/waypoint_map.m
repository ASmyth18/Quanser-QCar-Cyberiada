function [nodes, edges, node_names] = waypoint_map()
%WAYPOINT_MAP Define the road network as a graph of waypoints.
%
%   [nodes, edges, node_names] = waypoint_map()
%
%   Returns the road network for the Quanser SDCS competition map.
%   All coordinates are in WORLD frame (meters).
%
%   Outputs:
%     nodes      - Nx2 array of [x, y] waypoint positions
%     edges      - Mx2 array of [from_node, to_node] connections
%     node_names - Nx1 cell array of node labels
%
%   Road layout (approximate, based on sign/traffic light positions):
%   The map has:
%   - A taxi hub area in the bottom-left
%   - A main road loop around the perimeter
%   - An intersection with traffic lights in the center
%   - A roundabout in the upper portion
%   - Internal roads connecting areas
%
%   Map flooring center: (0.13, 1.67)
%   Map approximate bounds: (-2.3, -1.4) to (2.5, 4.7)

    % ===== NODE DEFINITIONS =====
    % Format: [x, y] in world coordinates
    % Organized by region for clarity

    % --- Taxi Hub Area ---
    nodes_hub = [
        -1.205, -0.83;    % 1: Taxi hub (start/end)
        -1.0,   -0.50;    % 2: Hub exit road
        -0.7,   -0.20;    % 3: Hub approach junction
    ];

    % --- Bottom Road (South) ---
    nodes_south = [
        -0.3,   -1.00;    % 4: South road west
         0.0,   -1.00;    % 5: South road center (yield sign area)
         0.5,   -1.00;    % 6: South road east
         1.0,   -0.80;    % 7: SE corner approach
    ];

    % --- East Road ---
    nodes_east = [
         1.8,    0.20;    % 8: East road south (stop sign)
         2.0,    0.60;    % 9: East mid
         2.0,    0.95;    % 10: East road crosswalk area
         1.9,    1.50;    % 11: East road approach intersection
         1.9,    1.70;    % 12: East road north (stop sign area)
    ];

    % --- Traffic Light Intersection ---
    nodes_intersection = [
         0.6,    0.48;    % 13: Intersection SE approach
         0.6,    0.95;    % 14: Intersection east
         0.6,    1.55;    % 15: Intersection NE
        -0.37,   1.55;    % 16: Intersection NW
        -0.37,   0.95;    % 17: Intersection west (crosswalk)
        -0.37,   0.30;    % 18: Intersection SW
         0.13,   0.95;    % 19: Intersection center
    ];

    % --- West Road ---
    nodes_west = [
        -0.60,   0.30;    % 20: West road south
        -0.80,   0.60;    % 21: West mid
        -0.60,   1.28;    % 22: West road at traffic light
        -1.0,    1.50;    % 23: West road north
    ];

    % --- North / Roundabout Area ---
    nodes_roundabout = [
         0.13,   2.00;    % 24: Pre-roundabout south
         0.13,   2.50;    % 25: Roundabout south entry
        -0.30,   2.80;    % 26: Roundabout west
        -0.30,   3.20;    % 27: Roundabout NW
         0.13,   3.50;    % 28: Roundabout north
         0.60,   3.20;    % 29: Roundabout NE
         0.60,   2.80;    % 30: Roundabout east entry
         1.0,    2.50;    % 31: East approach to roundabout
    ];

    % --- Upper Area (Pickup Region) ---
    nodes_upper = [
        -0.50,   3.60;    % 32: NW parking (stop sign)
        -1.20,   3.20;    % 33: Far NW
        -1.50,   2.20;    % 34: West parking (stop sign)
         0.0,    3.97;    % 35: North area (roundabout sign)
         0.125,  4.395;   % 36: PICKUP LOCATION
    ];

    % --- Dropoff Area ---
    nodes_dropoff = [
        -0.905,  0.800;   % 37: DROPOFF LOCATION
    ];

    % Concatenate all nodes
    nodes = [
        nodes_hub;
        nodes_south;
        nodes_east;
        nodes_intersection;
        nodes_west;
        nodes_roundabout;
        nodes_upper;
        nodes_dropoff;
    ];

    % Node names for debugging
    node_names = {
        'Hub', 'Hub_Exit', 'Hub_Junction', ...
        'South_W', 'South_C', 'South_E', 'SE_Corner', ...
        'East_S', 'East_Mid', 'East_Cross', 'East_N_App', 'East_N', ...
        'Int_SE', 'Int_E', 'Int_NE', 'Int_NW', 'Int_W', 'Int_SW', 'Int_Center', ...
        'West_S', 'West_Mid', 'West_TL', 'West_N', ...
        'Pre_Round', 'Round_S', 'Round_W', 'Round_NW', 'Round_N', 'Round_NE', 'Round_E', 'East_Round', ...
        'NW_Park', 'Far_NW', 'West_Park', 'North_Area', 'Pickup', ...
        'Dropoff', ...
    };

    % ===== EDGE DEFINITIONS =====
    % Bidirectional edges (both directions of travel)
    % Format: [from_node, to_node]

    edges = [
        % Hub connections
        1,  2;     % Hub to Hub Exit
        2,  1;     % Hub Exit to Hub
        2,  3;     % Hub Exit to Hub Junction
        3,  2;     % Hub Junction to Hub Exit

        % Hub Junction to roads
        3,  20;    % Hub Junction to West South
        20, 3;
        3,  18;    % Hub Junction to Intersection SW
        18, 3;
        3,  4;     % Hub Junction to South West
        4,  3;

        % South Road
        4,  5;     5,  4;
        5,  6;     6,  5;
        6,  7;     7,  6;

        % SE corner to East Road
        7,  8;     8,  7;
        8,  9;     9,  8;
        9,  10;    10, 9;
        10, 11;    11, 10;
        11, 12;    12, 11;

        % East to Intersection
        8,  13;    13, 8;
        13, 14;    14, 13;
        14, 15;    15, 14;
        13, 18;    18, 13;

        % Intersection internal
        15, 16;    16, 15;
        16, 17;    17, 16;
        17, 18;    18, 17;
        14, 19;    19, 14;
        17, 19;    19, 17;
        15, 19;    19, 15;
        18, 19;    19, 18;

        % West road
        20, 21;    21, 20;
        21, 22;    22, 21;
        22, 23;    23, 22;
        20, 18;    18, 20;
        22, 17;    17, 22;

        % Intersection to North
        15, 24;    24, 15;
        16, 24;    24, 16;
        12, 31;    31, 12;

        % Roundabout
        24, 25;    25, 24;
        25, 26;    26, 25;
        26, 27;    27, 26;
        27, 28;    28, 27;
        28, 29;    29, 28;
        29, 30;    30, 29;
        30, 25;    25, 30;
        30, 31;    31, 30;

        % Upper area
        27, 32;    32, 27;
        32, 33;    33, 32;
        33, 34;    34, 33;
        34, 23;    23, 34;
        28, 35;    35, 28;
        35, 36;    36, 35;

        % Dropoff connection
        22, 37;    37, 22;
        17, 37;    37, 17;
        21, 37;    37, 21;
    ];
end
