/*
 * VIRTUAL_self_driving_stack_v2_dt.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "VIRTUAL_self_driving_stack_v2".
 *
 * Model version              : 11.64
 * Simulink Coder version : 25.2 (R2025b) 28-Jul-2025
 * C source code generated on : Fri Mar 20 17:23:56 2026
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
  sizeof(t_video_capture),
  sizeof(t_ranging_sensor),
  sizeof(t_ranging_measurement),
  sizeof(t_uint64),
  sizeof(c_coder_internal_ctarget_dlne_T),
  sizeof(t_lidar2d_scan_matcher),
  sizeof(t_card),
  sizeof(t_task),
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
  "t_video_capture",
  "t_ranging_sensor",
  "t_ranging_measurement",
  "t_uint64",
  "c_coder_internal_ctarget_dlne_T",
  "t_lidar2d_scan_matcher",
  "t_card",
  "t_task",
  "uint_T",
  "char_T",
  "uchar_T",
  "time_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&VIRTUAL_self_driving_stack_v2_B.encodercounts), 0, 0, 5878 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_B.lane_offset), 1, 0, 9 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_B.light_color), 6, 0, 5 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_B.RangingSensor_o6), 5, 0, 9 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_B.rightCSICamera_o1[0]), 3, 0,
    4608000 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_B.RelationalOperator1), 8, 0, 7 }
  ,

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.RangingSensor_Measurements[0]),
    18, 0, 1000 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.Time_Timeout), 15, 0, 23 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.Delay_DSTATE), 0, 0, 3681 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.rightCSICamera_VideoCapture), 16,
    0, 4 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.RangingSensor_Sensor), 17, 0, 1
  },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.ToHostFile1_PointsWritten), 19,
    0, 2 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Matcher), 21, 0,
    1 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card), 22, 0, 1 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_Task), 23, 0, 1
  },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.ToHostFile1_PWORK[0]), 11, 0, 33
  },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.lane_offset_Buffer0), 1, 0, 2775
  },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOStates[0]), 6, 0,
    48 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedChans[0]),
    7, 0, 6 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.net), 20, 0, 1 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.BodyFrame_IWORK[0]), 10, 0, 8 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport1_),
    2, 0, 7 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport_f
               [0]), 3, 0, 3686400 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOBits[0]), 8, 0,
    63 },

  { (char_T *)
    (&VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem2.IfActionSubsystem_SubsysRanBC),
    2, 0, 1 },

  { (char_T *)
    (&VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem1.IfActionSubsystem_SubsysRanBC),
    2, 0, 1 },

  { (char_T *)
    (&VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem.IfActionSubsystem_SubsysRanBC),
    2, 0, 1 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  27U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.CSI_Sample_Time), 0, 0, 5348 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.BodyFrame_direction), 6, 0, 9 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.ToHostFile_bitrate), 7, 0, 19 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.Constant_Value[0]), 0, 0, 333 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOWatchdog), 6, 0,
    31 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.Gain1_Gain_n[0]), 1, 0, 11 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.HILInitialize_AIChannels[0]), 7,
    0, 59 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.HILInitialize_Active), 8, 0, 41
  },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.HILReadTimebase_OverflowMode), 3,
    0, 170 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.IfActionSubsystem2.Bias_Bias), 0,
    0, 1 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.IfActionSubsystem1.Bias_Bias), 0,
    0, 1 },

  { (char_T *)(&VIRTUAL_self_driving_stack_v2_P.IfActionSubsystem.Bias_Bias), 0,
    0, 1 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  12U,
  rtPTransitions
};

/* [EOF] VIRTUAL_self_driving_stack_v2_dt.h */
