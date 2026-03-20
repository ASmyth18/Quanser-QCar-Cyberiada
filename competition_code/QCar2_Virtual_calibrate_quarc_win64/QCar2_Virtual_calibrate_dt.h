/*
 * QCar2_Virtual_calibrate_dt.h
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

#include "ext_types.h"

/* data type size table */
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T),
  sizeof(int32_T),
  sizeof(t_timeout),
  sizeof(t_ranging_sensor),
  sizeof(t_ranging_measurement),
  sizeof(t_uint64),
  sizeof(uint_T),
  sizeof(char_T),
  sizeof(uchar_T),
  sizeof(time_T)
};

/* data type name table */
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T",
  "physical_connection",
  "t_timeout",
  "t_ranging_sensor",
  "t_ranging_measurement",
  "t_uint64",
  "uint_T",
  "char_T",
  "uchar_T",
  "time_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&QCar2_Virtual_calibrate_B.RangingSensor_o1[0]), 0, 0, 2691 },

  { (char_T *)(&QCar2_Virtual_calibrate_B.RangingSensor_o6), 6, 0, 1 },

  { (char_T *)(&QCar2_Virtual_calibrate_B.RangingSensor_o7), 5, 0, 9 },

  { (char_T *)(&QCar2_Virtual_calibrate_B.Gain), 3, 0, 1 },

  { (char_T *)(&QCar2_Virtual_calibrate_B.RangingSensor_o5), 8, 0, 1 }
  ,

  { (char_T *)(&QCar2_Virtual_calibrate_DW.RangingSensor_Measurements[0]), 17, 0,
    384 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.SystemTimebase_PreviousTime), 15, 0,
    1 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.BodyFrame_XBuffer[0]), 0, 0, 768 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.RangingSensor_Sensor), 16, 0, 1 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.ToHostFile_PointsWritten), 18, 0, 2 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.DataSize_PWORK.LoggedData[0]), 11, 0,
    10 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.sfEvent), 6, 0, 3 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.ToHostFile_SamplesCount), 7, 0, 4 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.BodyFrame_IWORK[0]), 10, 0, 2 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.WriteMatfiles_SubsysRanBC), 2, 0, 1 },

  { (char_T *)(&QCar2_Virtual_calibrate_DW.BodyFrame_IsFull), 8, 0, 5 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  16U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&QCar2_Virtual_calibrate_P.BodyFrame_maximum_rho), 0, 0, 4 },

  { (char_T *)(&QCar2_Virtual_calibrate_P.BodyFrame_direction), 6, 0, 3 },

  { (char_T *)(&QCar2_Virtual_calibrate_P.Constant_Value[0]), 0, 0, 446 },

  { (char_T *)(&QCar2_Virtual_calibrate_P.ToHostFile_Encoding), 6, 0, 12 },

  { (char_T *)(&QCar2_Virtual_calibrate_P.ToHostFile_Decimation), 7, 0, 5 },

  { (char_T *)(&QCar2_Virtual_calibrate_P.SystemTimebase_StopOnOverrun), 8, 0, 2
  },

  { (char_T *)(&QCar2_Virtual_calibrate_P.ToHostFile_VarName[0]), 3, 0, 84 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  7U,
  rtPTransitions
};

/* [EOF] QCar2_Virtual_calibrate_dt.h */
