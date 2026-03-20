/*
 * QCar2_Virtual_calibrate_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "QCar2_Virtual_calibrate".
 *
 * Model version              : 10.0
 * Simulink Coder version : 25.2 (R2025b) 28-Jul-2025
 * C source code generated on : Tue Mar 17 15:20:20 2026
 *
 * Target selection: quarc_win64.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "QCar2_Virtual_calibrate.h"

/* Block parameters (default storage) */
P_QCar2_Virtual_calibrate_T QCar2_Virtual_calibrate_P = {
  /* Mask Parameter: BodyFrame_maximum_rho
   * Referenced by: '<Root>/Body Frame'
   */
  7.0,

  /* Mask Parameter: BodyFrame_maximum_theta
   * Referenced by: '<Root>/Body Frame'
   */
  360.0,

  /* Mask Parameter: BodyFrame_minimum_rho
   * Referenced by: '<Root>/Body Frame'
   */
  0.0,

  /* Mask Parameter: BodyFrame_minimum_theta
   * Referenced by: '<Root>/Body Frame'
   */
  0.0,

  /* Mask Parameter: BodyFrame_direction
   * Referenced by: '<Root>/Body Frame'
   */
  2,

  /* Mask Parameter: BodyFrame_update_rate
   * Referenced by: '<Root>/Body Frame'
   */
  1,

  /* Mask Parameter: BodyFrame_zero_location
   * Referenced by: '<Root>/Body Frame'
   */
  1,

  /* Expression: zeros (1,384)
   * Referenced by: '<S2>/Constant'
   */
  { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 },

  /* Expression: timing_budget
   * Referenced by: '<S3>/Ranging Sensor'
   */
  0.033,

  /* Expression: measurement_period
   * Referenced by: '<S3>/Ranging Sensor'
   */
  0.04,

  /* Expression: max_interpolated_distance
   * Referenced by: '<S3>/Ranging Sensor'
   */
  0.05,

  /* Expression: max_interpolated_angle
   * Referenced by: '<S3>/Ranging Sensor'
   */
  5.0,

  /* Expression: -pi/2
   * Referenced by: '<Root>/QCar 2 Lidar to Map Frame Offset'
   */
  -1.5707963267948966,

  /* Expression: pi - 7*pi/180
   * Referenced by: '<Root>/QCar 2 Virtual to Physical Lidar offset'
   */
  3.01941960595019,

  /* Expression: line1_width
   * Referenced by: '<Root>/Body Frame'
   */
  0.5,

  /* Expression: line1_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.0, 0.447, 0.741 },

  /* Expression: marker1_size
   * Referenced by: '<Root>/Body Frame'
   */
  1.0,

  /* Expression: marker1_edge_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.0, 0.447059, 0.741176 },

  /* Expression: marker1_face_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.0, 0.447059, 0.741176 },

  /* Expression: line2_width
   * Referenced by: '<Root>/Body Frame'
   */
  0.5,

  /* Expression: line2_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.85098, 0.32549, 0.0980392 },

  /* Expression: marker2_size
   * Referenced by: '<Root>/Body Frame'
   */
  6.0,

  /* Expression: marker2_edge_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.85098, 0.32549, 0.0980392 },

  /* Expression: marker2_face_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.85098, 0.32549, 0.0980392 },

  /* Expression: line3_width
   * Referenced by: '<Root>/Body Frame'
   */
  0.5,

  /* Expression: line3_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.929412, 0.694118, 0.12549 },

  /* Expression: marker3_size
   * Referenced by: '<Root>/Body Frame'
   */
  6.0,

  /* Expression: marker3_edge_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.929412, 0.694118, 0.12549 },

  /* Expression: marker3_face_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.929412, 0.694118, 0.12549 },

  /* Expression: line4_width
   * Referenced by: '<Root>/Body Frame'
   */
  0.5,

  /* Expression: line4_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.494118, 0.184314, 0.556863 },

  /* Expression: marker4_size
   * Referenced by: '<Root>/Body Frame'
   */
  6.0,

  /* Expression: marker4_edge_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.494118, 0.184314, 0.556863 },

  /* Expression: marker4_face_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.494118, 0.184314, 0.556863 },

  /* Expression: line5_width
   * Referenced by: '<Root>/Body Frame'
   */
  0.5,

  /* Expression: line5_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.466667, 0.67451, 0.188235 },

  /* Expression: marker5_size
   * Referenced by: '<Root>/Body Frame'
   */
  6.0,

  /* Expression: marker5_edge_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.466667, 0.67451, 0.188235 },

  /* Expression: marker5_face_color
   * Referenced by: '<Root>/Body Frame'
   */
  { 0.466667, 0.67451, 0.188235 },

  /* Expression: 355
   * Referenced by: '<Root>/Constant2'
   */
  355.0,

  /* Computed Parameter: ToHostFile_Encoding
   * Referenced by: '<S2>/To Host File'
   */
  1,

  /* Computed Parameter: ToHostFile1_Encoding
   * Referenced by: '<S2>/To Host File1'
   */
  1,

  /* Computed Parameter: BodyFrame_L1Style
   * Referenced by: '<Root>/Body Frame'
   */
  5,

  /* Computed Parameter: BodyFrame_L1Marker
   * Referenced by: '<Root>/Body Frame'
   */
  4,

  /* Computed Parameter: BodyFrame_L2Style
   * Referenced by: '<Root>/Body Frame'
   */
  1,

  /* Computed Parameter: BodyFrame_L2Marker
   * Referenced by: '<Root>/Body Frame'
   */
  14,

  /* Computed Parameter: BodyFrame_L3Style
   * Referenced by: '<Root>/Body Frame'
   */
  1,

  /* Computed Parameter: BodyFrame_L3Marker
   * Referenced by: '<Root>/Body Frame'
   */
  14,

  /* Computed Parameter: BodyFrame_L4Style
   * Referenced by: '<Root>/Body Frame'
   */
  1,

  /* Computed Parameter: BodyFrame_L4Marker
   * Referenced by: '<Root>/Body Frame'
   */
  14,

  /* Computed Parameter: BodyFrame_L5Style
   * Referenced by: '<Root>/Body Frame'
   */
  1,

  /* Computed Parameter: BodyFrame_L5Marker
   * Referenced by: '<Root>/Body Frame'
   */
  14,

  /* Computed Parameter: ToHostFile_Decimation
   * Referenced by: '<S2>/To Host File'
   */
  1U,

  /* Computed Parameter: ToHostFile_BitRate
   * Referenced by: '<S2>/To Host File'
   */
  2000000U,

  /* Computed Parameter: ToHostFile1_Decimation
   * Referenced by: '<S2>/To Host File1'
   */
  1U,

  /* Computed Parameter: ToHostFile1_BitRate
   * Referenced by: '<S2>/To Host File1'
   */
  2000000U,

  /* Computed Parameter: RangingSensor_Range
   * Referenced by: '<S3>/Ranging Sensor'
   */
  3U,

  /* Computed Parameter: SystemTimebase_StopOnOverrun
   * Referenced by: '<Root>/System Timebase'
   */
  false,

  /* Computed Parameter: RangingSensor_Active
   * Referenced by: '<S3>/Ranging Sensor'
   */
  true,

  /* Expression: variable_name_argument
   * Referenced by: '<S2>/To Host File'
   */
  { 100U, 105U, 115U, 116U, 97U, 110U, 99U, 101U, 95U, 110U, 101U, 119U, 95U,
    113U, 99U, 97U, 114U, 50U, 0U },

  /* Computed Parameter: ToHostFile_FileFormat
   * Referenced by: '<S2>/To Host File'
   */
  1U,

  /* Expression: file_name_argument
   * Referenced by: '<S2>/To Host File'
   */
  { 100U, 105U, 115U, 116U, 97U, 110U, 99U, 101U, 95U, 110U, 101U, 119U, 95U,
    113U, 99U, 97U, 114U, 50U, 46U, 109U, 97U, 116U, 0U },

  /* Expression: variable_name_argument
   * Referenced by: '<S2>/To Host File1'
   */
  { 97U, 110U, 103U, 108U, 101U, 115U, 95U, 110U, 101U, 119U, 95U, 113U, 99U,
    97U, 114U, 50U, 0U },

  /* Computed Parameter: ToHostFile1_FileFormat
   * Referenced by: '<S2>/To Host File1'
   */
  1U,

  /* Expression: file_name_argument
   * Referenced by: '<S2>/To Host File1'
   */
  { 97U, 110U, 103U, 108U, 101U, 115U, 95U, 110U, 101U, 119U, 95U, 113U, 99U,
    97U, 114U, 50U, 46U, 109U, 97U, 116U, 0U },

  /* Computed Parameter: BodyFrame_Mode
   * Referenced by: '<Root>/Body Frame'
   */
  2U,

  /* Computed Parameter: Gain_Gain
   * Referenced by: '<Root>/Gain'
   */
  200U
};
