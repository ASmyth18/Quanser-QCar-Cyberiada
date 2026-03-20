/*
 * VIRTUAL_self_driving_stack_v2_private.h
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

#ifndef VIRTUAL_self_driving_stack_v2_private_h_
#define VIRTUAL_self_driving_stack_v2_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#include "zero_crossing_types.h"
#include "VIRTUAL_self_driving_stack_v2.h"
#include "VIRTUAL_self_driving_stack_v2_types.h"

/* A global buffer for storing error messages (defined in quanser_common library) */
EXTERN char _rt_error_message[512];
extern real_T rt_hypotd_snf(real_T u0, real_T u1);
extern real_T rt_modd_snf(real_T u0, real_T u1);
extern real_T rt_atan2d_snf(real_T u0, real_T u1);
extern real_T rt_powd_snf(real_T u0, real_T u1);
extern void maxPoolingKernel18029049445488117936(const real32_T *inputBufferPtr,
  real32_T *outputBufferPtr, int32_T startIdxWithPaddingOffsetInputT);
extern void maxPooling18029049445488117936(const real32_T *inputTensor, real32_T
  *outputTensor);
extern void maxPoolingKernel9173568525719178749(const real32_T *inputBufferPtr,
  real32_T *outputBufferPtr, int32_T startIdxWithPaddingOffsetInputT);
extern void maxPooling9173568525719178749(const real32_T *inputTensor, real32_T *
  outputTensor);
extern void maxPoolingKernel6663882391764541772(const real32_T *inputBufferPtr,
  real32_T *outputBufferPtr, int32_T startIdxWithPaddingOffsetInputT);
extern void maxPooling6663882391764541772(const real32_T *inputTensor, real32_T *
  outputTensor);
extern int32_T div_nde_s32_floor(int32_T numerator, int32_T denominator);
extern void VIRTUAL_s_IfActionSubsystem(real_T rtu_aoa1rad, real_T
  *rty_steering1rad, P_IfActionSubsystem_VIRTUAL_s_T *localP);

/* private model entry point functions */
extern void VIRTUAL_self_driving_stack_v2_derivatives(void);

#endif                            /* VIRTUAL_self_driving_stack_v2_private_h_ */
