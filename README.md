# Quanser Self-Driving Car Competition - QCar2

Autonomous taxi system for the Quanser Self-Driving Car Student Competition. A 1/10-scale QCar2 completes a full taxi cycle (Hub to Pickup to Dropoff to Hub_ while obeying traffic lights, stop signs, yield signs, and roundabout rules.

**Trinity College Dublin**

## Architecture

### Perception (Dual-Network)
- **MobileNetV2** traffic light classifier (4 classes: none/red/yellow/green) — runs every frame at 30 fps
- **YOLOv8-nano** road sign detector (stop/yield/roundabout) — runs on alternating frames for efficiency
- Both networks exported as `dlnetwork` objects for QUARC code generation

### Localisation
- Extended Kalman Filter (EKF) fusing wheel odometry + LIDAR scan matching
- State: `[x, y, heading]` relative to calibration origin at (0, 2.0) world coordinates

### Planning
- Choice of automatic or hand-tuned waypoint path (~406 points at 5 cm spacing) covering the full mission route
- Curvature-based velocity profiling: Menger curvature at each waypoint sets a speed limit via `v <= sqrt(a_lat_max / kappa)`, with forward/backward acceleration smoothing passes
- A* graph planner available for alternative routing

### Control
- **Lateral:** Pure Pursuit controller with look-ahead distance
- **Longitudinal:** PID speed controller tracking the velocity profile (cruise 0.4 m/s)
- Controller rate: 500 Hz

### Mission FSM
- 7-state machine: IDLE → NAV_PICKUP → AT_PICKUP → NAV_DROPOFF → AT_DROPOFF → NAV_HUB → COMPLETE
- Proximity-gated traffic light response with heading gate (only reacts to lights ahead, not cross-traffic)
- Red light latch with debounce, hard timeout, and cooldown to prevent re-latching
- Stop sign detection requires both map proximity AND YOLOv8 confirmation
- LIDAR-based obstacle avoidance with proportional slowdown

## Prerequisites

- MATLAB R2025b (or compatible)
- Simulink + QUARC 2025 SP1
- Quanser Interactive Labs (QLabs)
- Deep Learning Toolbox
- Computer Vision Toolbox
- MATLAB Coder + GPU Coder
- Visual Studio 2022 (for QUARC code generation)

## Project Structure

```
competition_code/
  setup_competition_workspace.m    # Loads path, velocity profile, workspace vars
  extract_autonomous_data.m        # Post-run data extraction
  manual_waypoint_editor.m         # Interactive path editing tool
  create_title_card.m              # Video title card generator
  generate_ml_feed.m               # Post-hoc ML detection overlay video
  generate_bev_video.m             # Post-hoc bird's eye view video
  replay_bev.m                     # 2D map replay animation
  calibrate_bev.m                  # BEV homography calibration

  simulink_blocks/                 # MATLAB Function blocks for Simulink
    mission_fcn_v2.m               # Mission FSM (active)
    perception_fcn_v5.m            # MobileNetV2 + YOLOv8 perception (active)
    fcn_velocity_lookup.m          # Speed from velocity profile
    fcn_pure_pursuit.m             # Pure pursuit lateral control
    fcn_speed_pid.m                # PID longitudinal control
    fcn_obstacle_detector.m        # LIDAR obstacle detection
    fcn_look_ahead.m               # Path look-ahead generator
    fcn_led_controller.m           # LED strip control

  planning/                        # Path planning
    waypoint_map.m                 # 37-node waypoint graph
    astar_planner.m                # A* pathfinding
    compute_velocity_profile.m     # Curvature-based speed limits
    generate_mission_paths.m       # Mission route generation
    load_manual_paths.m            # Manual path loader

  perception/                      # Perception modules
    detect_traffic_light.m         # HSV traffic light detection
    detect_road_signs.m            # Road sign detection
    detect_obstacles_lidar.m       # LIDAR processing
    detect_lanes.m                 # Lane detection

  mission/                         # Mission logic
    mission_state_machine.m        # Legacy FSM
    led_controller.m               # LED state mapper

  control/                         # Control algorithms
    pure_pursuit_controller.m      # Pure pursuit
    pid_speed_controller.m         # PID speed
    compute_desired_speed.m        # Speed computation

  # Model weights (tracked via .gitignore whitelist)
  yolo_net.mat                     # YOLOv4-tiny weights
  yolo_anchors.mat                 # YOLO anchor boxes
  trained_yolo_detector.mat        # Full detector object
  lane_net.mat                     # Lane detection CNN
  manual_path.mat                  # Mission waypoint path
  bev_calibration.mat              # BEV homography data
  angles_new_qcar2.mat             # LIDAR angle calibration
  distance_new_qcar2.mat           # LIDAR distance calibration

student-competition-resources-matlab/   # Official Quanser resources
  Virtual_MATLAB_Resources/
    self_driving_stack_resources/
      Setup_Real_Scenario.m              # Instance 1: scene setup
      Setup_QCar2_Params.m               # Instance 2: calibration params
      QCar2_Virtual_calibrate.slx        # Calibration model
      VIRTUAL_self_driving_stack_v2.slx  # Main Simulink model

Quanser_Interactive_Labs_Resources-main/ # QLabs MATLAB/Python library
```

## How to Run

Two MATLAB instances are required.

### Instance 1 — Scene Setup

1. Open MATLAB, navigate to `student-competition-resources-matlab/Virtual_MATLAB_Resources/self_driving_stack_resources/`
2. Open QLabs and select the **Plane** workspace
3. Set `spawn_location = 1` in `Setup_Real_Scenario.m`
4. Run `Setup_Real_Scenario`

### Instance 2 — Calibration (once per session)

1. Open a second MATLAB instance in the same resources directory
2. Run `Setup_QCar2_Params` (will error on first run — expected)
3. Open `QCar2_Virtual_calibrate`, build and run via **Monitor & Tune** for 15-20 seconds, then stop
4. Run `Setup_QCar2_Params` again (succeeds now)

### Instance 1 — Respawn at Taxi Hub

1. Stop `Setup_Real_Scenario` (Ctrl+C)
2. Change `spawn_location = 2`, re-run `Setup_Real_Scenario`

### Instance 2 — Run Self-Driving Stack

```matlab
cd('C:\Users\adams\Desktop\Quanser_Main_Project\competition_code')
setup_competition_workspace
open_system('VIRTUAL_self_driving_stack_v2')
```

Build and run via **Monitor & Tune** (QUARC tab). The car will:
- Wait ~10s at Hub (magenta LEDs)
- Navigate to Pickup (green LEDs)
- Stop 3s for passenger boarding (blue LEDs)
- Navigate to Dropoff (blue LEDs)
- Stop 3s for passenger exit (orange LEDs)
- Return to Hub (magenta LEDs)

## Key Parameters

| Parameter | Value | Location |
|-----------|-------|----------|
| Cruise speed | 0.4 m/s | `setup_competition_workspace.m` |
| QCar2 wheelbase | 0.256 m | ~ |
| Waypoint tolerance | 0.35 m | `mission_fcn_v2.m` |
| Stop/pickup dwell | 3.0 s | `mission_fcn_v2.m` |
| Init delay | 10.0 s | `mission_fcn_v2.m` |
| Grace period | 15.0 s | `mission_fcn_v2.m` |
| Red debounce | 3 frames | `mission_fcn_v2.m` |
| Red timeout | 4.0 s | `mission_fcn_v2.m` |
| Red cooldown | 8.0 s | `mission_fcn_v2.m` |
| Stop sign wait | 2.5 s | `mission_fcn_v2.m` |
| LIDAR stop dist | 0.3 m | `mission_fcn_v2.m` |
| Intersection react | 1.0 m | `mission_fcn_v2.m` |

## Post-Run Video Generation

After a successful run, extract data and generate video feeds:

```matlab
extract_autonomous_data      % Creates run folder with frames + metadata
generate_ml_feed             % ML detection overlay video
generate_bev_video           % Bird's eye view transformation
replay_bev                   % 2D map replay with trajectory
```

## Competition Info

- **Competition:** Quanser Self-Driving Car Student Competition
- **Team:** Trinity College Dublin
- **Stage:** Virtual (April 2026)
- **Submission:** GitHub repository + 3-minute YouTube video
- **Constraint:** MATLAB/Simulink only; QUARC real-time models for vehicle interface
