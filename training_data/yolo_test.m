detector = yolov4ObjectDetector('tiny-yolov4-coco');

% Test on a frame that has signs/lights
img = imread('C:\Users\adams\Desktop\Qunaser_Main_Project\training_data\frame\frame_00350.png');
[bboxes, scores, labels] = detect(detector, img, 'Threshold', 0.3);

% Show results
detectedImg = insertObjectAnnotation(img, 'rectangle', bboxes, cellstr(labels));
imshow(detectedImg);
