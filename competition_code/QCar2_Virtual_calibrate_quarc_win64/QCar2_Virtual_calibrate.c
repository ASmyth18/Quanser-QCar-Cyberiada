/*
 * QCar2_Virtual_calibrate.c
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
#include "rtwtypes.h"
#include <emmintrin.h>
#include "rt_nonfinite.h"
#include <string.h>
#include "QCar2_Virtual_calibrate_private.h"
#include "QCar2_Virtual_calibrate_dt.h"

/* Named constants for MATLAB Function: '<Root>/MATLAB Function2' */
#define QCar2_Virtual_calibr_CALL_EVENT (-1)

/* Block signals (default storage) */
B_QCar2_Virtual_calibrate_T QCar2_Virtual_calibrate_B;

/* Block states (default storage) */
DW_QCar2_Virtual_calibrate_T QCar2_Virtual_calibrate_DW;

/* Real-time model */
static RT_MODEL_QCar2_Virtual_calibr_T QCar2_Virtual_calibrate_M_;
RT_MODEL_QCar2_Virtual_calibr_T *const QCar2_Virtual_calibrate_M =
  &QCar2_Virtual_calibrate_M_;

/* Model output function */
void QCar2_Virtual_calibrate_output(void)
{
  __m128d tmp;
  real_T QCar2VirtualtoPhysicalLidaroffs;
  real_T b_ex;
  real_T ex;
  int32_T i;
  int32_T k;
  boolean_T exitg1;
  boolean_T rtb_RelationalOperator1;
  boolean_T tmp_0;

  /* Reset subsysRan breadcrumbs */
  srClearBC(QCar2_Virtual_calibrate_DW.WriteMatfiles_SubsysRanBC);

  /* S-Function (ranging_sensor_block): '<S3>/Ranging Sensor' */

  /* S-Function Block: QCar2_Virtual_calibrate/captureLIDAR/Ranging Sensor (ranging_sensor_block) */
  {
    t_ranging_sensor_information info;
    t_error result;
    result = rplidar_read(QCar2_Virtual_calibrate_DW.RangingSensor_Sensor,
                          RANGING_MEASUREMENT_MODE_NORMAL,
                          QCar2_Virtual_calibrate_P.RangingSensor_MaxInterpolationD,
                          QCar2_Virtual_calibrate_P.RangingSensor_MaxInterpolationA,
                          &QCar2_Virtual_calibrate_DW.RangingSensor_Measurements[
                          0], 384);
    QCar2_Virtual_calibrate_B.RangingSensor_o5 = (result >= 0);
    if (result >= 0) {
      {
        int_T i1;
        real_T *y0 = &QCar2_Virtual_calibrate_B.RangingSensor_o1[0];
        real_T *y1 = &QCar2_Virtual_calibrate_B.RangingSensor_o2[0];
        real_T *y2 = &QCar2_Virtual_calibrate_B.RangingSensor_o3[0];
        real_T *y3 = &QCar2_Virtual_calibrate_B.RangingSensor_o4[0];
        uint16_T *y7 = &QCar2_Virtual_calibrate_B.RangingSensor_o8[0];
        uint16_T *y8 = &QCar2_Virtual_calibrate_B.RangingSensor_o9[0];
        t_ranging_measurement *dw_Measurements =
          &QCar2_Virtual_calibrate_DW.RangingSensor_Measurements[0];
        for (i1=0; i1 < 384; i1++) {
          y0[i1] = dw_Measurements[i1].distance;
          y2[i1] = dw_Measurements[i1].heading;
          y3[i1] = dw_Measurements[i1].quality / 100.0;
        }
      }

      QCar2_Virtual_calibrate_B.RangingSensor_o6 = result;
    } else {
      QCar2_Virtual_calibrate_B.RangingSensor_o6 = 0;
      if (result != -QERR_WOULD_BLOCK) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(QCar2_Virtual_calibrate_M, _rt_error_message);
      }
    }

    result = rplidar_get_device_information
      (QCar2_Virtual_calibrate_DW.RangingSensor_Sensor, &info);
    if (result >= 0) {
      QCar2_Virtual_calibrate_B.RangingSensor_o7 = info.model;
      QCar2_Virtual_calibrate_B.RangingSensor_o8[0] =
        info.hardware_version.major;
      QCar2_Virtual_calibrate_B.RangingSensor_o8[1] =
        info.hardware_version.minor;
      QCar2_Virtual_calibrate_B.RangingSensor_o8[2] =
        info.hardware_version.release;
      QCar2_Virtual_calibrate_B.RangingSensor_o8[3] =
        info.hardware_version.build;
      QCar2_Virtual_calibrate_B.RangingSensor_o9[0] =
        info.firmware_version.major;
      QCar2_Virtual_calibrate_B.RangingSensor_o9[1] =
        info.firmware_version.minor;
      QCar2_Virtual_calibrate_B.RangingSensor_o9[2] =
        info.firmware_version.release;
      QCar2_Virtual_calibrate_B.RangingSensor_o9[3] =
        info.firmware_version.build;
    }
  }

  for (i = 0; i <= 382; i += 2) {
    /* Bias: '<Root>/QCar 2 Lidar to Map Frame Offset' incorporates:
     *  Bias: '<Root>/QCar 2 Virtual to Physical Lidar offset'
     */
    tmp = _mm_loadu_pd(&QCar2_Virtual_calibrate_B.RangingSensor_o3[i]);

    /* Bias: '<Root>/QCar 2 Virtual to Physical Lidar offset' incorporates:
     *  Bias: '<Root>/QCar 2 Lidar to Map Frame Offset'
     */
    _mm_storeu_pd(&QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[i],
                  _mm_add_pd(_mm_add_pd(tmp, _mm_set1_pd
      (QCar2_Virtual_calibrate_P.QCar2LidartoMapFrameOffset_Bias)), _mm_set1_pd
      (QCar2_Virtual_calibrate_P.QCar2VirtualtoPhysicalLidaroffs)));
  }

  /* MATLAB Function: '<Root>/MATLAB Function2' incorporates:
   *  MATLAB Function: '<S2>/MATLAB Function1'
   */
  QCar2_Virtual_calibrate_DW.sfEvent_o = QCar2_Virtual_calibr_CALL_EVENT;

  /* Outputs for Enabled SubSystem: '<Root>/Write Matfiles' incorporates:
   *  EnablePort: '<S2>/Enable'
   */
  /* MATLAB Function 'MATLAB Function2': '<S1>:1' */
  /* '<S1>:1:3' */
  tmp_0 = !rtIsNaN(QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[0]);

  /* End of Outputs for SubSystem: '<Root>/Write Matfiles' */
  if (tmp_0) {
    i = 1;
  } else {
    i = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k < 385)) {
      if (!rtIsNaN(QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k -
                   1])) {
        i = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  if (i == 0) {
    ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[0];
  } else {
    ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[i - 1];
    for (k = i + 1; k < 385; k++) {
      QCar2VirtualtoPhysicalLidaroffs =
        QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k - 1];
      if (ex < QCar2VirtualtoPhysicalLidaroffs) {
        ex = QCar2VirtualtoPhysicalLidaroffs;
      }
    }
  }

  if (tmp_0) {
    i = 1;
  } else {
    i = 0;
    k = 2;
    exitg1 = false;
    while ((!exitg1) && (k < 385)) {
      if (!rtIsNaN(QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k -
                   1])) {
        i = k;
        exitg1 = true;
      } else {
        k++;
      }
    }
  }

  if (i == 0) {
    b_ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[0];
  } else {
    b_ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[i - 1];
    for (k = i + 1; k < 385; k++) {
      QCar2VirtualtoPhysicalLidaroffs =
        QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k - 1];
      if (b_ex > QCar2VirtualtoPhysicalLidaroffs) {
        b_ex = QCar2VirtualtoPhysicalLidaroffs;
      }
    }
  }

  QCar2_Virtual_calibrate_B.angle_range_d = ex - b_ex;

  /* '<S1>:1:4' */
  QCar2_Virtual_calibrate_B.angle_range_d *= 57.295779513082323;

  /* End of MATLAB Function: '<Root>/MATLAB Function2' */

  /* RelationalOperator: '<Root>/Relational Operator1' incorporates:
   *  Constant: '<Root>/Constant2'
   */
  rtb_RelationalOperator1 = (QCar2_Virtual_calibrate_B.angle_range_d >=
    QCar2_Virtual_calibrate_P.Constant2_Value);

  /* Gain: '<Root>/Gain' */
  if (rtb_RelationalOperator1) {
    /* Gain: '<Root>/Gain' */
    QCar2_Virtual_calibrate_B.Gain = QCar2_Virtual_calibrate_P.Gain_Gain;
  } else {
    /* Gain: '<Root>/Gain' */
    QCar2_Virtual_calibrate_B.Gain = 0U;
  }

  /* End of Gain: '<Root>/Gain' */
  /* Outputs for Enabled SubSystem: '<Root>/Write Matfiles' incorporates:
   *  EnablePort: '<S2>/Enable'
   */
  if (rtb_RelationalOperator1) {
    QCar2_Virtual_calibrate_DW.WriteMatfiles_MODE = true;

    /* MATLAB Function: '<S2>/MATLAB Function1' */
    QCar2_Virtual_calibrate_DW.sfEvent = QCar2_Virtual_calibr_CALL_EVENT;

    /* MATLAB Function 'Write Matfiles/MATLAB Function1': '<S5>:1' */
    /* '<S5>:1:1' */
    /* '<S5>:1:4' */
    /* '<S5>:1:5' */
    memcpy(&QCar2_Virtual_calibrate_B.fixed_array[0],
           &QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[0], 384U *
           sizeof(real_T));

    /* '<S5>:1:8' */
    if (tmp_0) {
      i = 1;
    } else {
      i = 0;
      k = 2;
      exitg1 = false;
      while ((!exitg1) && (k < 385)) {
        if (!rtIsNaN(QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k
                     - 1])) {
          i = k;
          exitg1 = true;
        } else {
          k++;
        }
      }
    }

    if (i == 0) {
      ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[0];
    } else {
      ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[i - 1];
      for (k = i + 1; k < 385; k++) {
        QCar2VirtualtoPhysicalLidaroffs =
          QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k - 1];
        if (ex < QCar2VirtualtoPhysicalLidaroffs) {
          ex = QCar2VirtualtoPhysicalLidaroffs;
        }
      }
    }

    if (tmp_0) {
      i = 1;
    } else {
      i = 0;
      k = 2;
      exitg1 = false;
      while ((!exitg1) && (k < 385)) {
        if (!rtIsNaN(QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k
                     - 1])) {
          i = k;
          exitg1 = true;
        } else {
          k++;
        }
      }
    }

    if (i == 0) {
      b_ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[0];
    } else {
      b_ex = QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[i - 1];
      for (k = i + 1; k < 385; k++) {
        QCar2VirtualtoPhysicalLidaroffs =
          QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs[k - 1];
        if (b_ex > QCar2VirtualtoPhysicalLidaroffs) {
          b_ex = QCar2VirtualtoPhysicalLidaroffs;
        }
      }
    }

    /* '<S5>:1:9' */
    QCar2_Virtual_calibrate_B.angle_range = (ex - b_ex) * 57.295779513082323;

    /* MATLAB Function: '<S2>/MATLAB Function' */
    QCar2_Virtual_calibrate_DW.sfEvent_h = QCar2_Virtual_calibr_CALL_EVENT;

    /* MATLAB Function 'Write Matfiles/MATLAB Function': '<S4>:1' */
    /* '<S4>:1:1' */
    /* '<S4>:1:3' */
    /* '<S4>:1:4' */
    memcpy(&QCar2_Virtual_calibrate_B.fixed_array_p[0],
           &QCar2_Virtual_calibrate_B.RangingSensor_o1[0], 384U * sizeof(real_T));
    srUpdateBC(QCar2_Virtual_calibrate_DW.WriteMatfiles_SubsysRanBC);
  } else {
    QCar2_Virtual_calibrate_DW.WriteMatfiles_MODE = false;
  }

  /* End of Outputs for SubSystem: '<Root>/Write Matfiles' */
}

/* Model update function */
void QCar2_Virtual_calibrate_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++QCar2_Virtual_calibrate_M->Timing.clockTick0)) {
    ++QCar2_Virtual_calibrate_M->Timing.clockTickH0;
  }

  QCar2_Virtual_calibrate_M->Timing.t[0] =
    QCar2_Virtual_calibrate_M->Timing.clockTick0 *
    QCar2_Virtual_calibrate_M->Timing.stepSize0 +
    QCar2_Virtual_calibrate_M->Timing.clockTickH0 *
    QCar2_Virtual_calibrate_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void QCar2_Virtual_calibrate_initialize(void)
{
  /* Start for S-Function (ranging_sensor_block): '<S3>/Ranging Sensor' */

  /* S-Function Block: QCar2_Virtual_calibrate/captureLIDAR/Ranging Sensor (ranging_sensor_block) */
  {
    t_error result;
    result = rplidar_open("tcpip://localhost:18966", (t_ranging_distance)
                          (QCar2_Virtual_calibrate_P.RangingSensor_Range - 1),
                          &QCar2_Virtual_calibrate_DW.RangingSensor_Sensor);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(QCar2_Virtual_calibrate_M, _rt_error_message);
    }
  }

  /* Start for Enabled SubSystem: '<Root>/Write Matfiles' */
  QCar2_Virtual_calibrate_DW.WriteMatfiles_MODE = false;

  /* End of Start for SubSystem: '<Root>/Write Matfiles' */

  /* ConstCode for Width: '<Root>/Width' */
  QCar2_Virtual_calibrate_B.Width = 384.0;

  /* SystemInitialize for MATLAB Function: '<Root>/MATLAB Function2' */
  QCar2_Virtual_calibrate_DW.sfEvent_o = QCar2_Virtual_calibr_CALL_EVENT;

  /* SystemInitialize for Enabled SubSystem: '<Root>/Write Matfiles' */
  /* SystemInitialize for MATLAB Function: '<S2>/MATLAB Function1' */
  QCar2_Virtual_calibrate_DW.sfEvent = QCar2_Virtual_calibr_CALL_EVENT;

  /* SystemInitialize for MATLAB Function: '<S2>/MATLAB Function' */
  QCar2_Virtual_calibrate_DW.sfEvent_h = QCar2_Virtual_calibr_CALL_EVENT;

  /* End of SystemInitialize for SubSystem: '<Root>/Write Matfiles' */
}

/* Model terminate function */
void QCar2_Virtual_calibrate_terminate(void)
{
  /* Terminate for S-Function (ranging_sensor_block): '<S3>/Ranging Sensor' */

  /* S-Function Block: QCar2_Virtual_calibrate/captureLIDAR/Ranging Sensor (ranging_sensor_block) */
  {
    rplidar_close(QCar2_Virtual_calibrate_DW.RangingSensor_Sensor);
    QCar2_Virtual_calibrate_DW.RangingSensor_Sensor = NULL;
    QCar2_Virtual_calibrate_DW.RangingSensor_Sensor = NULL;
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  QCar2_Virtual_calibrate_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  QCar2_Virtual_calibrate_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  QCar2_Virtual_calibrate_initialize();
}

void MdlTerminate(void)
{
  QCar2_Virtual_calibrate_terminate();
}

/* Registration function */
RT_MODEL_QCar2_Virtual_calibr_T *QCar2_Virtual_calibrate(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)QCar2_Virtual_calibrate_M, 0,
                sizeof(RT_MODEL_QCar2_Virtual_calibr_T));

  /* Initialize timing info */
  {
    int_T *mdlTsMap = QCar2_Virtual_calibrate_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    QCar2_Virtual_calibrate_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    QCar2_Virtual_calibrate_M->Timing.sampleTimes =
      (&QCar2_Virtual_calibrate_M->Timing.sampleTimesArray[0]);
    QCar2_Virtual_calibrate_M->Timing.offsetTimes =
      (&QCar2_Virtual_calibrate_M->Timing.offsetTimesArray[0]);

    /* task periods */
    QCar2_Virtual_calibrate_M->Timing.sampleTimes[0] = (0.05);

    /* task offsets */
    QCar2_Virtual_calibrate_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(QCar2_Virtual_calibrate_M,
             &QCar2_Virtual_calibrate_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = QCar2_Virtual_calibrate_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    QCar2_Virtual_calibrate_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(QCar2_Virtual_calibrate_M, 5.0);
  QCar2_Virtual_calibrate_M->Timing.stepSize0 = 0.05;

  /* External mode info */
  QCar2_Virtual_calibrate_M->Sizes.checksums[0] = (631371864U);
  QCar2_Virtual_calibrate_M->Sizes.checksums[1] = (1459574279U);
  QCar2_Virtual_calibrate_M->Sizes.checksums[2] = (1872521194U);
  QCar2_Virtual_calibrate_M->Sizes.checksums[3] = (3234462749U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[5];
    QCar2_Virtual_calibrate_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = (sysRanDType *)
      &QCar2_Virtual_calibrate_DW.WriteMatfiles_SubsysRanBC;
    systemRan[3] = (sysRanDType *)
      &QCar2_Virtual_calibrate_DW.WriteMatfiles_SubsysRanBC;
    systemRan[4] = (sysRanDType *)
      &QCar2_Virtual_calibrate_DW.WriteMatfiles_SubsysRanBC;
    rteiSetModelMappingInfoPtr(QCar2_Virtual_calibrate_M->extModeInfo,
      &QCar2_Virtual_calibrate_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(QCar2_Virtual_calibrate_M->extModeInfo,
                        QCar2_Virtual_calibrate_M->Sizes.checksums);
    rteiSetTPtr(QCar2_Virtual_calibrate_M->extModeInfo, rtmGetTPtr
                (QCar2_Virtual_calibrate_M));
  }

  QCar2_Virtual_calibrate_M->solverInfoPtr =
    (&QCar2_Virtual_calibrate_M->solverInfo);
  QCar2_Virtual_calibrate_M->Timing.stepSize = (0.05);
  rtsiSetFixedStepSize(&QCar2_Virtual_calibrate_M->solverInfo, 0.05);
  rtsiSetSolverMode(&QCar2_Virtual_calibrate_M->solverInfo,
                    SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  QCar2_Virtual_calibrate_M->blockIO = ((void *) &QCar2_Virtual_calibrate_B);
  (void) memset(((void *) &QCar2_Virtual_calibrate_B), 0,
                sizeof(B_QCar2_Virtual_calibrate_T));

  {
    QCar2_Virtual_calibrate_B.Width = 384.0;
  }

  /* parameters */
  QCar2_Virtual_calibrate_M->defaultParam = ((real_T *)
    &QCar2_Virtual_calibrate_P);

  /* states (dwork) */
  QCar2_Virtual_calibrate_M->dwork = ((void *) &QCar2_Virtual_calibrate_DW);
  (void) memset((void *)&QCar2_Virtual_calibrate_DW, 0,
                sizeof(DW_QCar2_Virtual_calibrate_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    QCar2_Virtual_calibrate_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 23;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  QCar2_Virtual_calibrate_M->Sizes.numContStates = (0);/* Number of continuous states */
  QCar2_Virtual_calibrate_M->Sizes.numY = (0);/* Number of model outputs */
  QCar2_Virtual_calibrate_M->Sizes.numU = (0);/* Number of model inputs */
  QCar2_Virtual_calibrate_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  QCar2_Virtual_calibrate_M->Sizes.numSampTimes = (1);/* Number of sample times */
  QCar2_Virtual_calibrate_M->Sizes.numBlocks = (30);/* Number of blocks */
  QCar2_Virtual_calibrate_M->Sizes.numBlockIO = (16);/* Number of block outputs */
  QCar2_Virtual_calibrate_M->Sizes.numBlockPrms = (556);/* Sum of parameter "widths" */
  return QCar2_Virtual_calibrate_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
