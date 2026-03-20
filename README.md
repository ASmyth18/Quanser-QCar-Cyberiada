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
3. Set up the car parameters:
   ```matlab
   Setup_QCar2_Params
   ```
   **Note:** This will error if calibration hasn't been run yet. Fully to be expected, you can ignore it.
4. Open the calibration model:
   ```matlab
   open_system('QCar2_Virtual_calibrate')
   ```
5. Link MATLAB and Simulink with the following command
   ```matlab
   system('"C:\Program Files\Quanser\QUARC\quarc_run.exe" -D -r -t tcpip://localhost:17000 "C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\Quanser_Interactive_Labs_Resources-main\rtmodels\QCar2\QCar2_Workspace_studio.rt-win64" &');
   ```
6. Build and run via **Monitor & Tune** (QUARC tab) for **15-20 seconds**, then stop the model
7. Run the params setup again (this time it will succeed):
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
   cd('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\competition_code')
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

## Data Collection and YOLO Retraining

If you need to retrain the detector (e.g., for the physical stage, to improve traffic light detection, or after environment changes), follow the full pipeline below.

### Step 1 - Collect Camera Data

The Simulink model includes **To Host File** blocks that record the front CSI camera feed and pose data during a run.

1. Complete the full setup (Instance 1 scene + Instance 2 calibration) as described in "How to Run" above
2. Run the self-driving stack via **Monitor & Tune** and let it complete 2-3 full laps of the mission route
3. Stop the model. Two files are saved:
   - `training_data/camera_feed.avi` — front camera video
   - `training_data/pose_data.mat` — car position/heading over time
4. **Before running again**, rename the output files (the To Host File block cannot overwrite locked files):
   ```matlab
   movefile('training_data\camera_feed.avi', 'training_data\camera_feed_run1.avi');
   movefile('training_data\pose_data.mat', 'training_data\pose_data_run1.mat');
   ```
5. Repeat steps 2-4 for additional runs if necessary

### Step 2 - Extract Frames from Video

Extract individual PNG frames from the recorded video:

```matlab
mkdir('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\training_data\frame');
v = VideoReader('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\training_data\camera_feed.avi');
i = 0;
while hasFrame(v)
    i = i + 1;
    frame = readFrame(v);
    imwrite(frame, sprintf('C:\\Users\\adams\\Desktop\\Quanser-QCar-Cyberiada\\training_data\\frame\\frame_%05d.png', i));
end
fprintf('Saved %d frames\n', i);
```

If you decide to do multiple runs, you have to offset the frame numbering:

```matlab
v = VideoReader('C:\Users\adams\Desktop\QQuanser-QCar-Cyberiada\training_data\camera_feed_run2.avi');
% i continues from where the previous run ended
while hasFrame(v)
    i = i + 1;
    frame = readFrame(v);
    imwrite(frame, sprintf('C:\\Users\\adams\\Desktop\\Quanser-QCar-Cyberiada\\training_data\\frame\\frame_%05d.png', i));
end
fprintf('Total frames: %d\n', i);
```

### Step 3 - Auto-Label Stop Signs with Pretrained YOLO

Use the COCO-pretrained YOLOv4-tiny to automatically detect stop signs across all frames:

```matlab
framesDir = 'C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\training_data\frame';
files = dir(fullfile(framesDir, '*.png'));
detector = yolov4ObjectDetector('tiny-yolov4-coco');

stopBoxes = cell(length(files), 1);
for i = 1:length(files)
    img = imread(fullfile(framesDir, files(i).name));
    [bboxes, scores, labels] = detect(detector, img, 'Threshold', 0.3);
    isStop = labels == 'stop sign';
    if any(isStop)
        stopBoxes{i} = bboxes(isStop, :);
    else
        stopBoxes{i} = zeros(0, 4);
    end
    if mod(i, 100) == 0
        fprintf('Processed %d / %d\n', i, length(files));
    end
end
save(fullfile(framesDir, '..', 'stop_sign_detections.mat'), 'stopBoxes', 'files');
fprintf('Done. Found stop signs in %d frames\n', sum(cellfun(@(x) size(x,1) > 0, stopBoxes)));
```

This, unfortunately, is not the most accurate, and so you'll likely still have to manually label things.

### Step 4 - Create Ground Truth with Pre-Filled Stop Signs

Run the ground truth creation script to build an `imageLabeler`-compatible object with stop signs pre-labelled:

```matlab
cd('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\competition_code')
create_ground_truth
```

This creates `training_data/gTruth_auto.mat` with 6 label classes:
- `stop_sign` (pre-filled from Step 3)
- `red_light` (empty - needs manual labelling)
- `green_light` (empty - needs manual labelling)
- `yellow_light` (empty - needs manual labelling)
- `yield_sign` (empty - needs manual labelling)
- `roundabout` (empty - needs manual labelling)

### Step 5 - Manual Labelling (Keyframes Only)

Open the ground truth in MATLAB's Image Labeller:

```matlab
load('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\training_data\gTruth_auto.mat');
imageLabeler(gTruth)
```

You needn't label every frame:

1. Pan through the frames and find ones where signs/lights are visible
2. Draw **Rectangle** bounding boxes around each object, selecting the appropriate label class
3. Label one **keyframe** every ~30-50 frames (wherever a sign or light is clearly visible)
4. Focus on frames near intersections for traffic lights
5. Review and correct the auto-labelled stop sign boxes
6. When done, export the labels: **Export > To Workspace** as `gTruth`
7. Save immediately:
   ```matlab
   save('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\training_data\gTruth_auto.mat', 'gTruth');
   ```
Make sure not to label the traffic light as a whole, but rather the individual light that is lit up. Also, make sure you're labelling with the correct label (i.e. don't label a red light as a yield sign).

### Step 6 - Propagate Labels Between Keyframes

The `propagate_labels.m` script uses KLT point tracking to automatically propagate bounding boxes from your manually labelled keyframes to all intermediate frames:

```matlab
cd('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\competition_code')
propagate_labels
```

This reads `gTruth_auto.mat` and produces `gTruth_propagated.mat`. Review the result:

```matlab
load('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\training_data\gTruth_propagated.mat');
imageLabeler(gTruth_propagated)
```

Scrub through and check:
- Boxes that drifted off the object
- Objects that appeared but weren't labelled (because no nearby keyframe)
- False propagations where tracking jumped to a different object

If corrections are needed:
1. Fix labels in Image Labeller
2. Export to workspace as `gTruth`
3. Save over the auto file:
   ```matlab
   save('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\training_data\gTruth_auto.mat', 'gTruth');
   ```
4. Run `propagate_labels` again
5. Repeat until everything or close to everything is correctly labelled

### Step 7 - Train YOLOv4-tiny

You needn't do this, Anna, just upload the training data to GitHub, and I'll train it, as this is very dependent on your pc specs (though I'll give the process anyway).

Once labelling is complete, train the detector:

```matlab
cd('C:\Users\adams\Desktop\Quanser-QCar-Cyberiada\competition_code')
train_yolo
```

This script:
1. Loads the propagated ground truth
2. Splits into 80% training / 20% validation
3. Estimates anchor boxes via k-means on bounding box dimensions
4. Creates a YOLOv4-tiny detector (pretrained on COCO, fine-tuned on your data)
5. Trains for 80 epochs with learning rate drops at epochs 30 and 60
6. Saves `trained_yolo_detector.mat` and `yolo_net.mat` to `competition_code/`

Training takes approximately **22 minutes** on an RTX 3070. Expected final loss values:
- Training loss: < 0.5
- Validation loss: < 2.5

Checkpoints are saved to `training_data/checkpoints/` in case training is interrupted.

### Step 8 - Verify the Trained Detector

Test the detector on sample frames:

```matlab
load('competition_code\trained_yolo_detector.mat');
img = imread('training_data\frame\frame_00500.png');
[bboxes, scores, labels] = detect(trainedDetector, img, 'Threshold', 0.4);
detImg = insertObjectAnnotation(img, 'rectangle', bboxes, cellstr(labels) + " " + string(round(scores, 2)));
imshow(detImg);
```

### Step 9 - Extract Network for Simulink

After training, extract the network and anchor boxes for use in the Simulink MATLAB Function block:

```matlab
load('competition_code\trained_yolo_detector.mat');
net = trainedDetector.Network;
anchorBoxes = trainedDetector.AnchorBoxes;
save('competition_code\yolo_net.mat', 'net');
save('competition_code\yolo_anchors.mat', 'anchorBoxes');
```

The `perception_fcn` MATLAB Function block in the Simulink model loads `yolo_net.mat` via `coder.loadDeepLearningNetwork` and performs inference at runtime. No further changes to the Simulink model are needed after retraining -- simply replace the `.mat` files and rebuild.
