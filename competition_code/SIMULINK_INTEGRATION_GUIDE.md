# Simulink Integration Guide

## Overview

This guide explains how to integrate the competition MATLAB algorithms into
the `VIRTUAL_self_driving_stack_v2.slx` Simulink model provided by Quanser.

The existing Simulink model already handles:
- QUARC hardware I/O (cameras, LIDAR, IMU, motors)
- Extended Kalman Filter (EKF) for localization
- Basic PD steering controller
- Path following on pre-defined paths

**What we add:**
- Mission state machine (taxi pickup/dropoff cycle)
- Traffic light detection from camera
- Stop sign detection (proximity + vision)
- LIDAR obstacle detection
- Adaptive speed control
- Pure Pursuit path following
- LED status management

---

## Step-by-Step Integration

### Step 1: Load Enhanced Parameters

In your MATLAB workspace, run:
```matlab
run('Setup_QCar2_Params.m');          % Original parameters
run('setup/Setup_Params_Enhanced.m');  % Competition-specific parameters
```

### Step 2: Generate Mission Paths

```matlab
mission_paths = generate_mission_paths([0, 2.0]);
save('mission_paths.mat', 'mission_paths');
```

This creates waypoint paths for all three mission legs (hub->pickup, pickup->dropoff, dropoff->hub).

### Step 3: Add MATLAB Function Blocks in Simulink

Open `VIRTUAL_self_driving_stack_v2.slx` and add the following MATLAB Function blocks:

#### 3a. Mission State Machine Block

**Location:** In the Orange "Decision and Planning" subsystem.

**Create MATLAB Function block** with:
- Inputs: `car_pos`, `car_speed`, `dist_to_dest`, `traffic_light`, `stop_sign`, `obstacle_dist`
- Outputs: `mission_state`, `active_path_idx`, `desired_speed`, `led_color`
- Code: Copy contents of `mission/mission_state_machine.m`
- Use `persistent` variables for state tracking:
  ```matlab
  persistent state prev_state state_entry_time stop_timer
  if isempty(state)
      state = 0; prev_state = -1;
      state_entry_time = 0; stop_timer = 0;
  end
  ```

#### 3b. Pure Pursuit Controller Block

**Location:** In the Blue "Controllers" subsystem, alongside or replacing the existing steering controller.

**Create MATLAB Function block** with:
- Inputs: `car_x`, `car_y`, `car_heading`, `speed`, `path_x`, `path_y`
- Output: `steer_angle`
- Code: Copy contents of `control/pure_pursuit_controller.m`
- Parameters: Pass `PP_*` variables from workspace

#### 3c. Traffic Light Detector Block

**Location:** In the Green "Environment Interpretation" subsystem.

**Create MATLAB Function block** with:
- Input: `front_camera_image` (from CSI Front camera Video Capture block)
- Outputs: `light_color`, `confidence`
- Code: Copy contents of `perception/detect_traffic_light.m`
- Sample time: Match `CSI_Sample_Time`

#### 3d. Obstacle Detector Block

**Location:** In the Green "Environment Interpretation" subsystem.

**Create MATLAB Function block** with:
- Inputs: `lidar_angles`, `lidar_distances` (from LiDAR Scan Match block)
- Outputs: `obstacle_detected`, `closest_dist`
- Code: Copy contents of `perception/detect_obstacles_lidar.m`
- Sample time: Match `LiDAR_Sample_Time`

#### 3e. Speed Controller Block

**Location:** In the Blue "Controllers" subsystem.

**Create MATLAB Function block** with:
- Inputs: `desired_speed`, `current_speed`
- Output: `throttle`
- Code: Copy contents of `control/pid_speed_controller.m`
- Use `persistent` for integral/derivative state

#### 3f. LED Controller Block

**Location:** Connect to the LED Strip output block.

**Create MATLAB Function block** with:
- Input: `mission_state`
- Output: `led_cmd` (3-element RGB vector)
- Code: Copy contents of `mission/led_controller.m`

### Step 4: Signal Routing

Use Simulink `Goto`/`From` blocks (following the existing convention in the model) to route signals:

| Signal | Tag Name | Source | Destination |
|--------|----------|--------|-------------|
| EKF Position | `EKF_pos` | EKF output | State Machine, Pure Pursuit |
| EKF Heading | `EKF_heading` | EKF output | Pure Pursuit |
| Car Speed | `car_speed` | Tachometer/EKF | Speed Controller, State Machine |
| Front Camera | `csi_front` | Video Capture | Traffic Light Detector |
| LIDAR Data | `lidar_data` | LiDAR block | Obstacle Detector |
| Steering Cmd | `steer_cmd` | Pure Pursuit | HIL Write |
| Throttle Cmd | `throttle_cmd` | Speed Controller | HIL Write |
| LED Color | `led_cmd` | LED Controller | LED Strip block |
| Mission State | `mission_state` | State Machine | LED Controller |
| Active Path | `active_path` | State Machine | Path Selector |

### Step 5: Path Selection Logic

Add a `Switch` or `Multiport Switch` block to select the active path based on `active_path_idx`:
- Index 1: `mission_paths.hub_to_pickup` (loaded from .mat)
- Index 2: `mission_paths.pickup_to_drop`
- Index 3: `mission_paths.drop_to_hub`
- Index 0: Zero path (stopped)

Load paths into Simulink via workspace variables or `From Workspace` blocks.

### Step 6: Timing Configuration

Ensure sample times match:
- State Machine: `Controller_Sample_Time` (1/500s = 2ms)
- Pure Pursuit: `Controller_Sample_Time`
- Speed PID: `Controller_Sample_Time`
- Traffic Light: `CSI_Sample_Time` (~33ms)
- Obstacle Detection: `LiDAR_Sample_Time` (~67ms)
- LED Controller: `Controller_Sample_Time`

---

## Architecture Diagram

```
                    +------------------+
                    |   QUARC HIL I/O  |
                    |  (Red Subsystem) |
                    +--------+---------+
                             |
              +--------------+---------------+
              |              |               |
        +-----v-----+ +-----v-----+ +-------v------+
        |  Cameras   | |   LIDAR   | | IMU/Gyro/    |
        | (CSI/RGB)  | |  Scanner  | | Tachometer   |
        +-----+------+ +-----+-----+ +-------+------+
              |              |               |
     +--------v-------+ +---v---------+  +--v-----------+
     | Traffic Light   | | Obstacle    |  | Gyro KF      |
     | Detector        | | Detector    |  | + EKF Pose   |
     | (Green)         | | (Green)     |  | Estimation   |
     +--------+--------+ +---+---------+  +--+-----------+
              |              |               |
              +------+-------+------+--------+
                     |              |
              +------v------+ +----v---------+
              | Mission FSM | | Pure Pursuit |
              | (Orange)    | | Controller   |
              +------+------+ | (Blue)       |
                     |        +----+---------+
              +------v------+      |
              | Speed PID   |      |
              | (Blue)      |      |
              +------+------+      |
                     |             |
              +------v-------------v-------+
              |     Motor + Steering       |
              |     + LED Commands         |
              |     (Red - HIL Write)      |
              +----------------------------+
```

---

## Testing Checklist

Before submission, verify:

- [ ] Car starts at taxi hub with Magenta LEDs
- [ ] Car navigates to pickup location, LEDs turn Green
- [ ] Car stops at pickup, LEDs turn Blue, waits 2+ seconds
- [ ] Car navigates to dropoff, LEDs stay Blue
- [ ] Car stops at dropoff, LEDs turn Orange, waits 2+ seconds
- [ ] Car returns to hub, LEDs turn Magenta
- [ ] Car stays in lane throughout
- [ ] Car stops at traffic lights (red/yellow)
- [ ] Car resumes when light turns green
- [ ] Car stops at stop signs for 3+ seconds
- [ ] Car avoids obstacles in path
- [ ] No collisions with walls or barriers
- [ ] Mission completes within timeout

---

## File Reference

| File | Purpose | Simulink Location |
|------|---------|-------------------|
| `setup/Setup_Params_Enhanced.m` | All competition parameters | Workspace |
| `planning/waypoint_map.m` | Road network graph | Workspace (offline) |
| `planning/astar_planner.m` | A* path planning | Workspace (offline) |
| `planning/generate_mission_paths.m` | Mission path generation | Workspace (offline) |
| `perception/detect_traffic_light.m` | Camera traffic light detection | Green subsystem |
| `perception/detect_stop_sign.m` | Camera stop sign detection | Green subsystem |
| `perception/detect_obstacles_lidar.m` | LIDAR obstacle detection | Green subsystem |
| `perception/detect_lanes.m` | Lane line detection | Green subsystem |
| `perception/check_stop_sign_proximity.m` | Map-based stop sign check | Green subsystem |
| `control/pure_pursuit_controller.m` | Path following | Blue subsystem |
| `control/pid_speed_controller.m` | Speed control | Blue subsystem |
| `control/compute_desired_speed.m` | Context-aware speed | Orange subsystem |
| `mission/mission_state_machine.m` | Mission FSM | Orange subsystem |
| `mission/led_controller.m` | LED color management | Output to LED strip |
| `run_competition.m` | Standalone test script | N/A (development) |
| `setup/Setup_Scene_Enhanced.m` | QLabs scene setup | Separate session |
