/*
 * VIRTUAL_data_collection_dt.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "VIRTUAL_data_collection".
 *
 * Model version              : 11.60
 * Simulink Coder version : 25.2 (R2025b) 28-Jul-2025
 * C source code generated on : Thu Mar 19 22:16:09 2026
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
  sizeof(qthread_section_t),
  sizeof(t_game_controller_states),
  sizeof(t_host_remote_interface),
  sizeof(t_ranging_sensor),
  sizeof(t_ranging_measurement),
  sizeof(t_video3d),
  sizeof(t_video3d_stream),
  sizeof(t_int64),
  sizeof(t_uint64),
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
  "qthread_section_t",
  "t_game_controller_states",
  "t_host_remote_interface",
  "t_ranging_sensor",
  "t_ranging_measurement",
  "t_video3d",
  "t_video3d_stream",
  "t_int64",
  "t_uint64",
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
  { (char_T *)(&VIRTUAL_data_collection_B.realsenseDepthCapture_o2), 25, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_B.encodercounts), 0, 0, 5083 },

  { (char_T *)(&VIRTUAL_data_collection_B.Constant1[0]), 0, 0, 805 },

  { (char_T *)(&VIRTUAL_data_collection_B.realsenseDepthCapture_o1[0]), 1, 0,
    307207 },

  { (char_T *)(&VIRTUAL_data_collection_B.HostInitialize_o2), 6, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_B.RangingSensor_o6), 5, 0, 9 },

  { (char_T *)(&VIRTUAL_data_collection_B.HostInitialize_o1), 3, 0, 4608001 },

  { (char_T *)(&VIRTUAL_data_collection_B.RelationalOperator1), 8, 0, 8 }
  ,

  { (char_T *)(&VIRTUAL_data_collection_DW.HostGameController_ControllerSt), 18,
    0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.HostGameController_Lock), 17, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.RangingSensor_Measurements[0]), 21, 0,
    1000 },

  { (char_T *)(&VIRTUAL_data_collection_DW.Time1_Timeout), 15, 0, 23 },

  { (char_T *)(&VIRTUAL_data_collection_DW.Delay_DSTATE), 0, 0, 3684 },

  { (char_T *)(&VIRTUAL_data_collection_DW.rightCSICamera_VideoCapture), 16, 0,
    4 },

  { (char_T *)(&VIRTUAL_data_collection_DW.HostInitialize_ConnectedHandle), 19,
    0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.RangingSensor_Sensor), 20, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.Video3DInitialize_Video3D), 22, 0, 2
  },

  { (char_T *)(&VIRTUAL_data_collection_DW.realsenseDepthCapture_Stream), 23, 0,
    1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.LIDARScanMatch_Matcher), 26, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.HILInitialize_Card), 27, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.HILReadTimebase_Task), 28, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_DW.HostInitialize_PWORK[0]), 11, 0, 31 },

  { (char_T *)(&VIRTUAL_data_collection_DW.LIDARScanMatch_Scan[0]), 1, 0, 2773 },

  { (char_T *)(&VIRTUAL_data_collection_DW.HILInitialize_DOStates[0]), 6, 0, 45
  },

  { (char_T *)(&VIRTUAL_data_collection_DW.HILInitialize_POSortedChans[0]), 7, 0,
    2 },

  { (char_T *)(&VIRTUAL_data_collection_DW.BodyFrame_IWORK[0]), 10, 0, 8 },

  { (char_T *)(&VIRTUAL_data_collection_DW.TmpRTBAtMATLABFunction1Inport1_), 2,
    0, 7 },

  { (char_T *)(&VIRTUAL_data_collection_DW.TmpRTBAtMATLABFunction1Inport_f[0]),
    3, 0, 3686400 },

  { (char_T *)(&VIRTUAL_data_collection_DW.HILInitialize_DOBits[0]), 8, 0, 64 },

  { (char_T *)
    (&VIRTUAL_data_collection_DW.IfActionSubsystem2.IfActionSubsystem_SubsysRanBC),
    2, 0, 1 },

  { (char_T *)
    (&VIRTUAL_data_collection_DW.IfActionSubsystem1.IfActionSubsystem_SubsysRanBC),
    2, 0, 1 },

  { (char_T *)
    (&VIRTUAL_data_collection_DW.IfActionSubsystem.IfActionSubsystem_SubsysRanBC),
    2, 0, 1 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  32U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&VIRTUAL_data_collection_P.CSI_Sample_Time), 0, 0, 5348 },

  { (char_T *)(&VIRTUAL_data_collection_P.BodyFrame_direction), 6, 0, 8 },

  { (char_T *)(&VIRTUAL_data_collection_P.HILWrite_digital_channels[0]), 7, 0,
    19 },

  { (char_T *)(&VIRTUAL_data_collection_P.Video3DInitialize_active), 8, 0, 1 },

  { (char_T *)(&VIRTUAL_data_collection_P.Constant_Value[0]), 0, 0, 345 },

  { (char_T *)(&VIRTUAL_data_collection_P.HostInitialize_SendBufferSize), 6, 0,
    31 },

  { (char_T *)(&VIRTUAL_data_collection_P.Gain1_Gain_n[0]), 1, 0, 9 },

  { (char_T *)(&VIRTUAL_data_collection_P.HILInitialize_AIChannels[0]), 7, 0, 57
  },

  { (char_T *)(&VIRTUAL_data_collection_P.HostInitialize_RunClient), 8, 0, 48 },

  { (char_T *)(&VIRTUAL_data_collection_P.HostGameController_Controller), 2, 0,
    1 },

  { (char_T *)(&VIRTUAL_data_collection_P.HostInitialize_URI[0]), 3, 0, 36 },

  { (char_T *)(&VIRTUAL_data_collection_P.IfActionSubsystem2.Bias_Bias), 0, 0, 1
  },

  { (char_T *)(&VIRTUAL_data_collection_P.IfActionSubsystem1.Bias_Bias), 0, 0, 1
  },

  { (char_T *)(&VIRTUAL_data_collection_P.IfActionSubsystem.Bias_Bias), 0, 0, 1
  }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  14U,
  rtPTransitions
};

/* [EOF] VIRTUAL_data_collection_dt.h */
