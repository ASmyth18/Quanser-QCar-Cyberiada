## Prerequisites

- MATLAB R2025b (or compatible version)
- Simulink
- QUARC 2025 SP1 (with valid competition license)
- Quanser Interactive Labs (QLabs)
- Deep Learning Toolbox
- Computer Vision Toolbox
- GPU Coder
- MATLAB Coder Interface for Deep Learning Libraries (Add-On)
- Visual Studio 2022 (for QUARC code generation)

## How to Run (Virtual Stage)

Two MATLAB instances are required.

### Instance 1 - Scene Setup

1. Open MATLAB
2. Navigate to `student-competition-resources-matlab/Virtual_MATLAB_Resources/self_driving_stack_resources/`
3. Open Quanser Interactive Labs (QLabs) and select the **Plane** workspace
4. Set `spawn_location = 1` in `Setup_Real_Scenario.m` (for calibration)
5. Run:
   ```matlab
   Setup_Real_Scenario
   ```
6. The scene will load with roads, signs, traffic lights, and the QCar2

### Instance 2 - Calibration (Required Before Every Session)

1. Open a second MATLAB instance
2. Navigate to `student-competition-resources-matlab/Virtual_MATLAB_Resources/self_driving_stack_resources/`
3. Link the MATLAB workspace to the Simulink models:
   ```matlab
   Setup_QCar2_Params
   ```
   **Note:** This will error if calibration hasn't been run yet. Fully to be expected, you can ignore it.
4. Open the calibration model:
   ```matlab
   open_system('QCar2_Virtual_calibrate')
   ```
5. Build and run via **Monitor & Tune** (QUARC tab) for **15-20 seconds**, then stop the model
6. Run the params setup again (this time it will succeed):
   ```matlab
   Setup_QCar2_Params
   ```

### Instance 1 - Switch to Taxi Hub Spawn

1. Back in Instance 1, stop `Setup_Real_Scenario` (Ctrl+C)
2. Change `spawn_location = 2` in `Setup_Real_Scenario.m`
3. Run `Setup_Real_Scenario` again - the car will respawn at the Taxi Hub

### Instance 2 - Run the Self-Driving Stack

1. Set up the competition workspace (loads the mission path):
   ```matlab
   cd('C:\Users\adams\Desktop\Qunaser_Main_Project\competition_code')
   setup_competition_workspace
   ```
2. Open the main Simulink model:
   ```matlab
   open_system('VIRTUAL_self_driving_stack_v2')
   ```
3. Build and run via **Monitor & Tune** (QUARC tab)
4. The car will:
   - Wait ~10 seconds at the Taxi Hub (magenta LEDs)
   - Navigate to Pickup at [0.125, 4.395] (green LEDs)
   - Stop for 3 seconds at Pickup (blue LEDs)
   - Navigate to Dropoff at [-0.905, 0.800] (blue LEDs)
   - Stop for 3 seconds at Dropoff (orange LEDs)
   - Return to Taxi Hub at [-1.205, -0.83] (magenta LEDs)
   - Stop at Hub (complete)
   I haven't actually looked at the LEDs as they change, but it should be correct.
