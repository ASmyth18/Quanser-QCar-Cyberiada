/*
 * VIRTUAL_data_collection_private.h
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

#ifndef VIRTUAL_data_collection_private_h_
#define VIRTUAL_data_collection_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#include "zero_crossing_types.h"
#include "VIRTUAL_data_collection.h"
#include "VIRTUAL_data_collection_types.h"

/* A global buffer for storing error messages (defined in quanser_common library) */
EXTERN char _rt_error_message[512];
extern real_T rt_hypotd_snf(real_T u0, real_T u1);
extern real_T rt_modd_snf(real_T u0, real_T u1);
extern real_T rt_powd_snf(real_T u0, real_T u1);
extern real_T rt_atan2d_snf(real_T u0, real_T u1);
extern real_T rt_roundd_snf(real_T u);
extern void VIRTUAL_d_IfActionSubsystem(real_T rtu_aoa1rad, real_T
  *rty_steering1rad, P_IfActionSubsystem_VIRTUAL_d_T *localP);

/* private model entry point functions */
extern void VIRTUAL_data_collection_derivatives(void);

#endif                                 /* VIRTUAL_data_collection_private_h_ */
