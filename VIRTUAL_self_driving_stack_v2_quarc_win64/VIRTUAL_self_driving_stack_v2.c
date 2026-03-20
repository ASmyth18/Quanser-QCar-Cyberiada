/*
 * VIRTUAL_self_driving_stack_v2.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "VIRTUAL_self_driving_stack_v2".
 *
 * Model version              : 11.58
 * Simulink Coder version : 25.2 (R2025b) 28-Jul-2025
 * C source code generated on : Thu Mar 19 23:38:24 2026
 *
 * Target selection: quarc_win64.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "VIRTUAL_self_driving_stack_v2.h"
#include "rtwtypes.h"
#include "VIRTUAL_self_driving_stack_v2_private.h"
#include <string.h>
#include <emmintrin.h>
#include <math.h>
#include "rt_nonfinite.h"
#include "zero_crossing_types.h"
#include <float.h>
#include "rt_defines.h"
#include "VIRTUAL_self_driving_stack_v2_dt.h"

/* Named constants for MATLAB Function: '<Root>/MATLAB Function' */
#define VIRTUAL_self_driving_CALL_EVENT (-1)

/* Block signals (default storage) */
B_VIRTUAL_self_driving_stack__T VIRTUAL_self_driving_stack_v2_B;

/* Continuous states */
X_VIRTUAL_self_driving_stack__T VIRTUAL_self_driving_stack_v2_X;

/* Disabled State Vector */
XDis_VIRTUAL_self_driving_sta_T VIRTUAL_self_driving_stack_XDis;

/* Block states (default storage) */
DW_VIRTUAL_self_driving_stack_T VIRTUAL_self_driving_stack_v_DW;

/* Previous zero-crossings (trigger) states */
PrevZCX_VIRTUAL_self_driving__T VIRTUAL_self_driving_st_PrevZCX;

/* Real-time model */
static RT_MODEL_VIRTUAL_self_driving_T VIRTUAL_self_driving_stack_v_M_;
RT_MODEL_VIRTUAL_self_driving_T *const VIRTUAL_self_driving_stack_v_M =
  &VIRTUAL_self_driving_stack_v_M_;

/* Forward declaration for local functions */
static void VIRTUAL_self_driving_s_wrapToPi(real_T *lambda);
static void VIRTUAL_self_binary_expand_op_1(real_T in1_data[], int32_T in1_size
  [2], const real_T in2_data[], const int32_T in2_size[2], const real_T
  in3_data[], const int32_T in3_size[2]);
static real_T VIRTUAL_self_driving_stac_xnrm2(int32_T n, const real_T x_data[],
  int32_T ix0);
static void VIRTUAL_self_driving_sta_xgeqp3(real_T A_data[], const int32_T
  A_size[2], real_T tau_data[], int32_T *tau_size, int32_T jpvt_data[], int32_T
  jpvt_size[2]);
static void VIRTUAL_self_d_binary_expand_op(real_T in1_data[], int32_T *in1_size,
  const real_T in2_data[], const int32_T *in2_size, const real_T in3_data[],
  const int32_T in3_size[2], const real_T in4[3]);
static real_T VIRTUAL_self_driving_stack_norm(const real_T x[2]);
static void VIRTUAL_self_dri_nullAssignment(real_T x_data[], int32_T *x_size,
  const int32_T idx_data[], const int32_T *idx_size);
static void rate_monotonic_scheduler(void);
time_T rt_SimUpdateDiscreteEvents(
  int_T rtmNumSampTimes, void *rtmTimingData, int_T *rtmSampleHitPtr, int_T
  *rtmPerTaskSampleHits )
{
  rtmSampleHitPtr[1] = rtmStepTask(VIRTUAL_self_driving_stack_v_M, 1);
  rtmSampleHitPtr[2] = rtmStepTask(VIRTUAL_self_driving_stack_v_M, 2);
  rtmSampleHitPtr[3] = rtmStepTask(VIRTUAL_self_driving_stack_v_M, 3);
  rtmSampleHitPtr[4] = rtmStepTask(VIRTUAL_self_driving_stack_v_M, 4);
  rtmSampleHitPtr[5] = rtmStepTask(VIRTUAL_self_driving_stack_v_M, 5);
  rtmSampleHitPtr[6] = rtmStepTask(VIRTUAL_self_driving_stack_v_M, 6);
  rtmSampleHitPtr[7] = rtmStepTask(VIRTUAL_self_driving_stack_v_M, 7);
  UNUSED_PARAMETER(rtmNumSampTimes);
  UNUSED_PARAMETER(rtmTimingData);
  UNUSED_PARAMETER(rtmPerTaskSampleHits);
  return(-1);
}

/*
 *         This function updates active task flag for each subrate
 *         and rate transition flags for tasks that exchange data.
 *         The function assumes rate-monotonic multitasking scheduler.
 *         The function must be called at model base rate so that
 *         the generated code self-manages all its subrates and rate
 *         transition flags.
 */
static void rate_monotonic_scheduler(void)
{
  /* To ensure a deterministic data transfer between two rates,
   * data is transferred at the priority of a fast task and the frequency
   * of the slow task.  The following flags indicate when the data transfer
   * happens.  That is, a rate interaction flag is set true when both rates
   * will run, and false otherwise.
   */

  /* tid 1 shares data with slower tid rates: 2, 4, 5 */
  if (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[1] == 0) {
    VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_2 =
      (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[2] == 0);

    /* update PerTaskSampleHits matrix for non-inline sfcn */
    VIRTUAL_self_driving_stack_v_M->Timing.perTaskSampleHits[10] =
      VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_2;
    VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_4 =
      (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[4] == 0);

    /* update PerTaskSampleHits matrix for non-inline sfcn */
    VIRTUAL_self_driving_stack_v_M->Timing.perTaskSampleHits[12] =
      VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_4;
    VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_5 =
      (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[5] == 0);

    /* update PerTaskSampleHits matrix for non-inline sfcn */
    VIRTUAL_self_driving_stack_v_M->Timing.perTaskSampleHits[13] =
      VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_5;
  }

  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[2])++;
  if ((VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[2]) > 15) {/* Sample time: [0.032s, 0.0s] */
    VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[2] = 0;
  }

  (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[3])++;
  if ((VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[3]) > 16) {/* Sample time: [0.034s, 0.0s] */
    VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[3] = 0;
  }

  (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[4])++;
  if ((VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[4]) > 33) {/* Sample time: [0.068s, 0.0s] */
    VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[4] = 0;
  }

  (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[5])++;
  if ((VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[5]) > 49) {/* Sample time: [0.1s, 0.0s] */
    VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[5] = 0;
  }

  (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[6])++;
  if ((VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[6]) > 299) {/* Sample time: [0.6s, 0.0s] */
    VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[6] = 0;
  }

  (VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[7])++;
  if ((VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[7]) > 499) {/* Sample time: [1.0s, 0.0s] */
    VIRTUAL_self_driving_stack_v_M->Timing.TaskCounters.TID[7] = 0;
  }
}

/*
 * This function updates continuous states using the ODE1 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE1_IntgData *id = (ODE1_IntgData *)rtsiGetSolverData(si);
  real_T *f0 = id->f[0];
  int_T i;
  int_T nXc = 16;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);
  rtsiSetdX(si, f0);
  VIRTUAL_self_driving_stack_v2_derivatives();
  rtsiSetT(si, tnew);
  for (i = 0; i < nXc; ++i) {
    x[i] += h * f0[i];
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/*
 * Output and update for action system:
 *    '<S55>/If Action Subsystem'
 *    '<S55>/If Action Subsystem1'
 *    '<S55>/If Action Subsystem2'
 */
void VIRTUAL_s_IfActionSubsystem(real_T rtu_aoa1rad, real_T *rty_steering1rad,
  P_IfActionSubsystem_VIRTUAL_s_T *localP)
{
  /* Bias: '<S57>/Bias' */
  *rty_steering1rad = rtu_aoa1rad + localP->Bias_Bias;
}

/* Function for MATLAB Function: '<S39>/Heading Kalman Filter' */
static void VIRTUAL_self_driving_s_wrapToPi(real_T *lambda)
{
  real_T q;
  int32_T i;
  int32_T trueCount;
  boolean_T tmp;
  trueCount = 0;
  tmp = ((*lambda < -3.1415926535897931) || (*lambda > 3.1415926535897931));
  if (tmp) {
    for (i = 0; i < 1; i++) {
      trueCount++;
    }
  }

  for (i = 0; i < trueCount; i++) {
    if (rtIsNaN(*lambda + 3.1415926535897931) || rtIsInf(*lambda +
         3.1415926535897931)) {
      q = (rtNaN);
    } else {
      q = fabs((*lambda + 3.1415926535897931) / 6.2831853071795862);
      if (fabs(q - floor(q + 0.5)) > 2.2204460492503131E-16 * q) {
        q = fmod(*lambda + 3.1415926535897931, 6.2831853071795862);
      } else {
        q = 0.0;
      }

      if (q == 0.0) {
        q = 0.0;
      } else if (q < 0.0) {
        q += 6.2831853071795862;
      }
    }
  }

  for (i = 0; i < trueCount; i++) {
    if ((q == 0.0) && (*lambda + 3.1415926535897931 > 0.0)) {
      q = 6.2831853071795862;
    }
  }

  if (tmp) {
    *lambda = q - 3.1415926535897931;
  }
}

static void VIRTUAL_self_binary_expand_op_1(real_T in1_data[], int32_T in1_size
  [2], const real_T in2_data[], const int32_T in2_size[2], const real_T
  in3_data[], const int32_T in3_size[2])
{
  real_T in2_data_0[9];
  real_T in2_data_1[9];
  int32_T aux_1_1;
  int32_T i;
  int32_T i_0;
  int32_T in2_size_idx_0;
  int32_T in2_size_idx_0_0;
  int32_T in2_size_idx_1;
  int32_T loop_ub;
  int32_T scalarLB;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T vectorUB;

  /* MATLAB Function: '<S39>/QCar EKF' */
  i = in3_size[1];
  i_0 = in2_size[0];
  in2_size_idx_0 = in2_size[0];
  for (stride_0_0 = 0; stride_0_0 < i; stride_0_0++) {
    for (stride_0_1 = 0; stride_0_1 < i_0; stride_0_1++) {
      in2_data_0[stride_0_1 + in2_size_idx_0 * stride_0_0] = 0.0;
    }

    for (stride_0_1 = 0; stride_0_1 < 3; stride_0_1++) {
      real_T tmp;
      tmp = in3_data[3 * stride_0_0 + stride_0_1];
      scalarLB = (i_0 / 2) << 1;
      vectorUB = scalarLB - 2;
      for (stride_1_0 = 0; stride_1_0 <= vectorUB; stride_1_0 += 2) {
        __m128d tmp_0;
        __m128d tmp_1;
        tmp_0 = _mm_loadu_pd(&in2_data[in2_size[0] * stride_0_1 + stride_1_0]);
        aux_1_1 = in2_size_idx_0 * stride_0_0 + stride_1_0;
        tmp_1 = _mm_loadu_pd(&in2_data_0[aux_1_1]);
        _mm_storeu_pd(&in2_data_0[aux_1_1], _mm_add_pd(_mm_mul_pd(tmp_0,
          _mm_set1_pd(tmp)), tmp_1));
      }

      for (stride_1_0 = scalarLB; stride_1_0 < i_0; stride_1_0++) {
        vectorUB = in2_size_idx_0 * stride_0_0 + stride_1_0;
        in2_data_0[vectorUB] += in2_data[in2_size[0] * stride_0_1 + stride_1_0] *
          tmp;
      }
    }
  }

  if (in1_size[0] == 1) {
    in2_size_idx_0_0 = in2_size[0];
  } else {
    in2_size_idx_0_0 = in1_size[0];
  }

  if (in1_size[1] == 1) {
    in2_size_idx_1 = in3_size[1];
  } else {
    in2_size_idx_1 = in1_size[1];
  }

  stride_0_0 = (in2_size[0] != 1);
  stride_0_1 = (in3_size[1] != 1);
  stride_1_0 = (in1_size[0] != 1);
  scalarLB = (in1_size[1] != 1);
  vectorUB = 0;
  aux_1_1 = 0;
  if (in1_size[1] == 1) {
    loop_ub = in3_size[1];
  } else {
    loop_ub = in1_size[1];
  }

  for (i = 0; i < loop_ub; i++) {
    int32_T loop_ub_0;
    if (in1_size[0] == 1) {
      loop_ub_0 = in2_size_idx_0;
    } else {
      loop_ub_0 = in1_size[0];
    }

    for (i_0 = 0; i_0 < loop_ub_0; i_0++) {
      in2_data_1[i_0 + in2_size_idx_0_0 * i] = in2_data_0[i_0 * stride_0_0 +
        in2_size_idx_0 * vectorUB] + in1_data[i_0 * stride_1_0 + in1_size[0] *
        aux_1_1];
    }

    aux_1_1 += scalarLB;
    vectorUB += stride_0_1;
  }

  in1_size[0] = in2_size_idx_0_0;
  in1_size[1] = in2_size_idx_1;
  for (i = 0; i < in2_size_idx_1; i++) {
    for (i_0 = 0; i_0 < in2_size_idx_0_0; i_0++) {
      aux_1_1 = in2_size_idx_0_0 * i;
      in1_data[i_0 + aux_1_1] = in2_data_1[i_0 + aux_1_1];
    }
  }

  /* End of MATLAB Function: '<S39>/QCar EKF' */
}

/* Function for MATLAB Function: '<S39>/QCar EKF' */
static real_T VIRTUAL_self_driving_stac_xnrm2(int32_T n, const real_T x_data[],
  int32_T ix0)
{
  real_T y;
  int32_T k;
  y = 0.0;
  if (n >= 1) {
    if (n == 1) {
      y = fabs(x_data[ix0 - 1]);
    } else {
      real_T scale;
      int32_T kend;
      scale = 3.3121686421112381E-170;
      kend = (ix0 + n) - 1;
      for (k = ix0; k <= kend; k++) {
        real_T absxk;
        absxk = fabs(x_data[k - 1]);
        if (absxk > scale) {
          real_T t;
          t = scale / absxk;
          y = y * t * t + 1.0;
          scale = absxk;
        } else {
          real_T t;
          t = absxk / scale;
          y += t * t;
        }
      }

      y = scale * sqrt(y);
      if (rtIsNaN(y)) {
        k = ix0;
        int32_T exitg1;
        do {
          exitg1 = 0;
          if (k <= kend) {
            if (rtIsNaN(x_data[k - 1])) {
              exitg1 = 1;
            } else {
              k++;
            }
          } else {
            y = (rtInf);
            exitg1 = 1;
          }
        } while (exitg1 == 0);
      }
    }
  }

  return y;
}

real_T rt_hypotd_snf(real_T u0, real_T u1)
{
  real_T a;
  real_T b;
  real_T y;
  a = fabs(u0);
  b = fabs(u1);
  if (a < b) {
    a /= b;
    y = sqrt(a * a + 1.0) * b;
  } else if (a > b) {
    b /= a;
    y = sqrt(b * b + 1.0) * a;
  } else if (rtIsNaN(b)) {
    y = (rtNaN);
  } else {
    y = a * 1.4142135623730951;
  }

  return y;
}

/* Function for MATLAB Function: '<S39>/QCar EKF' */
static void VIRTUAL_self_driving_sta_xgeqp3(real_T A_data[], const int32_T
  A_size[2], real_T tau_data[], int32_T *tau_size, int32_T jpvt_data[], int32_T
  jpvt_size[2])
{
  real_T vn1_data[3];
  real_T vn2_data[3];
  real_T work_data[3];
  real_T s;
  real_T smax;
  real_T vn1;
  int32_T b_i;
  int32_T b_ix;
  int32_T c;
  int32_T d_ix;
  int32_T h;
  int32_T ii;
  int32_T ix;
  int32_T iy;
  int32_T m;
  int32_T minmana;
  int32_T mmi;
  int32_T n;
  int32_T nmi;
  int32_T pvt;
  static const int32_T offsets[4] = { 0, 1, 2, 3 };

  __m128d tmp;
  static const int32_T offsets_0[4] = { 0, 1, 2, 3 };

  int32_T exitg1;
  boolean_T exitg2;
  boolean_T guard1;
  m = A_size[0];
  n = A_size[1];
  if (A_size[0] <= A_size[1]) {
    minmana = A_size[0];
  } else {
    minmana = A_size[1];
  }

  *tau_size = minmana;
  if (minmana - 1 >= 0) {
    memset(&tau_data[0], 0, (uint32_T)minmana * sizeof(real_T));
  }

  guard1 = false;
  if (A_size[1] == 0) {
    guard1 = true;
  } else {
    if (A_size[0] <= A_size[1]) {
      b_i = A_size[0];
    } else {
      b_i = A_size[1];
    }

    if (b_i < 1) {
      guard1 = true;
    } else {
      jpvt_size[0] = 1;
      jpvt_size[1] = A_size[1];
      b_i = (A_size[1] / 4) << 2;
      d_ix = b_i - 4;
      for (ii = 0; ii <= d_ix; ii += 4) {
        _mm_storeu_si128((__m128i *)&jpvt_data[ii], _mm_add_epi32(_mm_add_epi32
          (_mm_set1_epi32(ii), _mm_loadu_si128((const __m128i *)&offsets_0[0])),
          _mm_set1_epi32(1)));
      }

      for (ii = b_i; ii < n; ii++) {
        jpvt_data[ii] = ii + 1;
      }

      if (minmana - 1 >= 0) {
        memset(&tau_data[0], 0, (uint32_T)minmana * sizeof(real_T));
      }

      for (minmana = 0; minmana < n; minmana++) {
        work_data[minmana] = 0.0;
        vn1 = VIRTUAL_self_driving_stac_xnrm2(m, A_data, minmana * m + 1);
        vn1_data[minmana] = vn1;
        vn2_data[minmana] = vn1;
      }

      if (A_size[0] <= A_size[1]) {
        c = A_size[0];
      } else {
        c = A_size[1];
      }

      for (minmana = 0; minmana < c; minmana++) {
        iy = minmana * m;
        ii = iy + minmana;
        nmi = (n - minmana) - 2;
        mmi = m - minmana;
        if (nmi + 1 < 0) {
          pvt = -1;
        } else {
          pvt = 0;
          if (nmi + 1 > 0) {
            smax = fabs(vn1_data[minmana]);
            for (b_i = 2; b_i <= nmi + 2; b_i++) {
              s = fabs(vn1_data[(minmana + b_i) - 1]);
              if (s > smax) {
                pvt = b_i - 1;
                smax = s;
              }
            }
          }
        }

        pvt += minmana;
        if (pvt != minmana) {
          b_ix = pvt * m;
          for (ix = 0; ix < m; ix++) {
            d_ix = b_ix + ix;
            smax = A_data[d_ix];
            b_i = iy + ix;
            A_data[d_ix] = A_data[b_i];
            A_data[b_i] = smax;
          }

          ix = jpvt_data[pvt];
          jpvt_data[pvt] = jpvt_data[minmana];
          jpvt_data[minmana] = ix;
          vn1_data[pvt] = vn1_data[minmana];
          vn2_data[pvt] = vn2_data[minmana];
        }

        if (minmana + 1 < m) {
          s = A_data[ii];
          pvt = ii + 2;
          tau_data[minmana] = 0.0;
          if (mmi > 0) {
            smax = VIRTUAL_self_driving_stac_xnrm2(mmi - 1, A_data, ii + 2);
            if (smax != 0.0) {
              smax = rt_hypotd_snf(A_data[ii], smax);
              if (A_data[ii] >= 0.0) {
                smax = -smax;
              }

              if (fabs(smax) < 1.0020841800044864E-292) {
                ix = 0;
                do {
                  ix++;
                  iy = ii + mmi;
                  b_i = (((((iy - ii) - 1) / 2) << 1) + ii) + 2;
                  d_ix = b_i - 2;
                  for (b_ix = pvt; b_ix <= d_ix; b_ix += 2) {
                    tmp = _mm_loadu_pd(&A_data[b_ix - 1]);
                    _mm_storeu_pd(&A_data[b_ix - 1], _mm_mul_pd(tmp, _mm_set1_pd
                      (9.9792015476736E+291)));
                  }

                  for (b_ix = b_i; b_ix <= iy; b_ix++) {
                    A_data[b_ix - 1] *= 9.9792015476736E+291;
                  }

                  smax *= 9.9792015476736E+291;
                  s *= 9.9792015476736E+291;
                } while ((fabs(smax) < 1.0020841800044864E-292) && (ix < 20));

                smax = rt_hypotd_snf(s, VIRTUAL_self_driving_stac_xnrm2(mmi - 1,
                  A_data, ii + 2));
                if (s >= 0.0) {
                  smax = -smax;
                }

                tau_data[minmana] = (smax - s) / smax;
                s = 1.0 / (s - smax);
                d_ix = b_i - 2;
                for (b_ix = pvt; b_ix <= d_ix; b_ix += 2) {
                  tmp = _mm_loadu_pd(&A_data[b_ix - 1]);
                  _mm_storeu_pd(&A_data[b_ix - 1], _mm_mul_pd(tmp, _mm_set1_pd(s)));
                }

                for (b_ix = b_i; b_ix <= iy; b_ix++) {
                  A_data[b_ix - 1] *= s;
                }

                for (b_i = 0; b_i < ix; b_i++) {
                  smax *= 1.0020841800044864E-292;
                }

                s = smax;
              } else {
                tau_data[minmana] = (smax - A_data[ii]) / smax;
                s = 1.0 / (A_data[ii] - smax);
                b_ix = ii + mmi;
                b_i = (((((b_ix - ii) - 1) / 2) << 1) + ii) + 2;
                d_ix = b_i - 2;
                for (ix = pvt; ix <= d_ix; ix += 2) {
                  tmp = _mm_loadu_pd(&A_data[ix - 1]);
                  _mm_storeu_pd(&A_data[ix - 1], _mm_mul_pd(tmp, _mm_set1_pd(s)));
                }

                for (ix = b_i; ix <= b_ix; ix++) {
                  A_data[ix - 1] *= s;
                }

                s = smax;
              }
            }
          }

          A_data[ii] = s;
        } else {
          tau_data[minmana] = 0.0;
        }

        if (minmana + 1 < n) {
          smax = A_data[ii];
          A_data[ii] = 1.0;
          ix = (ii + m) + 1;
          if (tau_data[minmana] != 0.0) {
            pvt = mmi - 1;
            b_i = (ii + mmi) - 1;
            while ((pvt + 1 > 0) && (A_data[b_i] == 0.0)) {
              pvt--;
              b_i--;
            }

            exitg2 = false;
            while ((!exitg2) && (nmi + 1 > 0)) {
              b_i = nmi * m + ix;
              b_ix = b_i;
              do {
                exitg1 = 0;
                if (b_ix <= b_i + pvt) {
                  if (A_data[b_ix - 1] != 0.0) {
                    exitg1 = 1;
                  } else {
                    b_ix++;
                  }
                } else {
                  nmi--;
                  exitg1 = 2;
                }
              } while (exitg1 == 0);

              if (exitg1 == 1) {
                exitg2 = true;
              }
            }
          } else {
            pvt = -1;
            nmi = -1;
          }

          if (pvt + 1 > 0) {
            if (nmi + 1 != 0) {
              if (nmi >= 0) {
                memset(&work_data[0], 0, (uint32_T)(nmi + 1) * sizeof(real_T));
              }

              b_i = 0;
              d_ix = m * nmi + ix;
              for (iy = ix; m < 0 ? iy >= d_ix : iy <= d_ix; iy += m) {
                s = 0.0;
                h = iy + pvt;
                for (b_ix = iy; b_ix <= h; b_ix++) {
                  s += A_data[(ii + b_ix) - iy] * A_data[b_ix - 1];
                }

                work_data[b_i] += s;
                b_i++;
              }
            }

            if (!(-tau_data[minmana] == 0.0)) {
              for (iy = 0; iy <= nmi; iy++) {
                vn1 = work_data[iy];
                if (vn1 != 0.0) {
                  s = vn1 * -tau_data[minmana];
                  b_i = pvt + ix;
                  for (b_ix = ix; b_ix <= b_i; b_ix++) {
                    A_data[b_ix - 1] += A_data[(ii + b_ix) - ix] * s;
                  }
                }

                ix += m;
              }
            }
          }

          A_data[ii] = smax;
        }

        for (ii = minmana + 2; ii <= n; ii++) {
          nmi = (ii - 1) * m + minmana;
          vn1 = vn1_data[ii - 1];
          if (vn1 != 0.0) {
            smax = fabs(A_data[nmi]) / vn1;
            smax = 1.0 - smax * smax;
            if (smax < 0.0) {
              smax = 0.0;
            }

            s = vn1 / vn2_data[ii - 1];
            s = s * s * smax;
            if (s <= 1.4901161193847656E-8) {
              if (minmana + 1 < m) {
                vn1 = VIRTUAL_self_driving_stac_xnrm2(mmi - 1, A_data, nmi + 2);
                vn1_data[ii - 1] = vn1;
                vn2_data[ii - 1] = vn1;
              } else {
                vn1_data[ii - 1] = 0.0;
                vn2_data[ii - 1] = 0.0;
              }
            } else {
              vn1_data[ii - 1] = vn1 * sqrt(smax);
            }
          }
        }
      }
    }
  }

  if (guard1) {
    jpvt_size[0] = 1;
    jpvt_size[1] = A_size[1];
    b_i = (A_size[1] / 4) << 2;
    d_ix = b_i - 4;
    for (m = 0; m <= d_ix; m += 4) {
      _mm_storeu_si128((__m128i *)&jpvt_data[m], _mm_add_epi32(_mm_add_epi32
        (_mm_set1_epi32(m), _mm_loadu_si128((const __m128i *)&offsets[0])),
        _mm_set1_epi32(1)));
    }

    for (m = b_i; m < n; m++) {
      jpvt_data[m] = m + 1;
    }
  }
}

static void VIRTUAL_self_d_binary_expand_op(real_T in1_data[], int32_T *in1_size,
  const real_T in2_data[], const int32_T *in2_size, const real_T in3_data[],
  const int32_T in3_size[2], const real_T in4[3])
{
  real_T in3_data_0[3];
  int32_T i;
  int32_T scalarLB;
  int32_T stride_0_0;
  int32_T stride_1_0;

  /* MATLAB Function: '<S39>/QCar EKF' */
  i = in3_size[0];
  if (i - 1 >= 0) {
    memset(&in3_data_0[0], 0, (uint32_T)i * sizeof(real_T));
  }

  for (stride_0_0 = 0; stride_0_0 < 3; stride_0_0++) {
    real_T tmp;
    int32_T vectorUB;
    tmp = in4[stride_0_0];
    scalarLB = (i / 2) << 1;
    vectorUB = scalarLB - 2;
    for (stride_1_0 = 0; stride_1_0 <= vectorUB; stride_1_0 += 2) {
      __m128d tmp_0;
      __m128d tmp_1;
      tmp_0 = _mm_loadu_pd(&in3_data[in3_size[0] * stride_0_0 + stride_1_0]);
      tmp_1 = _mm_loadu_pd(&in3_data_0[stride_1_0]);
      _mm_storeu_pd(&in3_data_0[stride_1_0], _mm_add_pd(_mm_mul_pd(tmp_0,
        _mm_set1_pd(tmp)), tmp_1));
    }

    for (stride_1_0 = scalarLB; stride_1_0 < i; stride_1_0++) {
      in3_data_0[stride_1_0] += in3_data[in3_size[0] * stride_0_0 + stride_1_0] *
        tmp;
    }
  }

  if (in3_size[0] == 1) {
    *in1_size = *in2_size;
  } else {
    *in1_size = in3_size[0];
  }

  stride_0_0 = (*in2_size != 1);
  stride_1_0 = (in3_size[0] != 1);
  if (in3_size[0] == 1) {
    scalarLB = *in2_size;
  } else {
    scalarLB = in3_size[0];
  }

  for (i = 0; i < scalarLB; i++) {
    in1_data[i] = in2_data[i * stride_0_0] - in3_data_0[i * stride_1_0];
  }

  /* End of MATLAB Function: '<S39>/QCar EKF' */
}

real_T rt_modd_snf(real_T u0, real_T u1)
{
  real_T y;
  y = u0;
  if (u1 == 0.0) {
    if (u0 == 0.0) {
      y = u1;
    }
  } else if (rtIsNaN(u0) || rtIsNaN(u1) || rtIsInf(u0)) {
    y = (rtNaN);
  } else if (u0 == 0.0) {
    y = 0.0 / u1;
  } else if (rtIsInf(u1)) {
    if ((u1 < 0.0) != (u0 < 0.0)) {
      y = u1;
    }
  } else {
    boolean_T yEq;
    y = fmod(u0, u1);
    yEq = (y == 0.0);
    if ((!yEq) && (u1 > floor(u1))) {
      real_T q;
      q = fabs(u0 / u1);
      yEq = !(fabs(q - floor(q + 0.5)) > DBL_EPSILON * q);
    }

    if (yEq) {
      y = u1 * 0.0;
    } else if ((u0 < 0.0) != (u1 < 0.0)) {
      y += u1;
    }
  }

  return y;
}

/* Function for MATLAB Function: '<Root>/MATLAB Function' */
static real_T VIRTUAL_self_driving_stack_norm(const real_T x[2])
{
  real_T absxk;
  real_T scale;
  real_T t;
  real_T y;
  scale = 3.3121686421112381E-170;
  absxk = fabs(x[0]);
  if (absxk > 3.3121686421112381E-170) {
    y = 1.0;
    scale = absxk;
  } else {
    t = absxk / 3.3121686421112381E-170;
    y = t * t;
  }

  absxk = fabs(x[1]);
  if (absxk > scale) {
    t = scale / absxk;
    y = y * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    y += t * t;
  }

  y = scale * sqrt(y);
  if (rtIsNaN(y)) {
    int32_T k;
    k = 0;
    int32_T exitg1;
    do {
      exitg1 = 0;
      if (k < 2) {
        if (rtIsNaN(x[k])) {
          exitg1 = 1;
        } else {
          k++;
        }
      } else {
        y = (rtInf);
        exitg1 = 1;
      }
    } while (exitg1 == 0);
  }

  return y;
}

real_T rt_atan2d_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else if (rtIsInf(u0) && rtIsInf(u1)) {
    int32_T tmp;
    int32_T tmp_0;
    if (u0 > 0.0) {
      tmp = 1;
    } else {
      tmp = -1;
    }

    if (u1 > 0.0) {
      tmp_0 = 1;
    } else {
      tmp_0 = -1;
    }

    y = atan2(tmp, tmp_0);
  } else if (u1 == 0.0) {
    if (u0 > 0.0) {
      y = RT_PI / 2.0;
    } else if (u0 < 0.0) {
      y = -(RT_PI / 2.0);
    } else {
      y = 0.0;
    }
  } else {
    y = atan2(u0, u1);
  }

  return y;
}

real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else {
    real_T tmp;
    real_T tmp_0;
    tmp = fabs(u0);
    tmp_0 = fabs(u1);
    if (rtIsInf(u1)) {
      if (tmp == 1.0) {
        y = 1.0;
      } else if (tmp > 1.0) {
        if (u1 > 0.0) {
          y = (rtInf);
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = (rtInf);
      }
    } else if (tmp_0 == 0.0) {
      y = 1.0;
    } else if (tmp_0 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = (rtNaN);
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

real_T rt_roundd_snf(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

/* Function for MATLAB Function: '<S14>/MATLAB Function' */
static void VIRTUAL_self_dri_nullAssignment(real_T x_data[], int32_T *x_size,
  const int32_T idx_data[], const int32_T *idx_size)
{
  int32_T b_k;
  int32_T k0;
  int32_T loop_ub;
  int32_T nxout;
  boolean_T b_data[1000];
  loop_ub = *x_size;
  if (*x_size - 1 >= 0) {
    memset(&b_data[0], 0, (uint32_T)*x_size * sizeof(boolean_T));
  }

  nxout = *idx_size;
  for (b_k = 0; b_k < nxout; b_k++) {
    b_data[idx_data[b_k] - 1] = true;
  }

  nxout = 0;
  for (b_k = 0; b_k < loop_ub; b_k++) {
    nxout += b_data[b_k];
  }

  nxout = *x_size - nxout;
  k0 = -1;
  for (b_k = 0; b_k < loop_ub; b_k++) {
    if ((b_k + 1 > *x_size) || (!b_data[b_k])) {
      k0++;
      x_data[k0] = x_data[b_k];
    }
  }

  if (nxout < 1) {
    *x_size = 0;
  } else {
    *x_size = nxout;
  }
}

/* Model output function for TID0 */
void VIRTUAL_self_driving_stack_v2_output0(void) /* Sample time: [0.0s, 0.0s] */
{
  /* local block i/o variables */
  real_T rtb_motorcurrent;
  real_T rtb_batteryvoltage;
  real_T rtb_x;
  real_T rtb_y;
  real_T rtb_x_a;
  real_T rtb_y_h;
  real_T rtb_z;
  real_T rtb_Unwrap224;
  real_T rtb_Time;
  real_T rtb_steering_angle;
  real_T rtb_wrappedoutput;
  __m128d tmp_2;
  __m128d tmp_3;
  __m128d tmp_4;
  __m128d tmp_6;
  real_T C_data[9];
  real_T F[9];
  real_T F_0[9];
  real_T P_times_CTransposed_data[9];
  real_T Y_data[9];
  real_T tmp_1[4];
  real_T tau_data[3];
  real_T y_data[3];
  real_T z_data[3];
  real_T P_times_CTransposed[2];
  real_T P_times_CTransposed_0[2];
  real_T tmp_5[2];
  real_T S;
  real_T b;
  real_T d;
  real_T rtb_Gain_k;
  real_T rtb_Integrator1_idx_0;
  real_T rtb_Integrator1_idx_1;
  real_T rtb_Integrator1_idx_2;
  real_T rtb_Subtract_idx_0;
  real_T rtb_Subtract_idx_1;
  real_T rtb_Subtract_idx_2;
  real_T rtb_Time1;
  real_T rtb_poseRateCorrection;
  real_T rtb_sampletime;
  real_T s;
  int32_T jpvt_data[3];
  int32_T F_tmp;
  int32_T F_tmp_0;
  int32_T b_ix;
  int32_T i;
  int32_T loop_ub;
  int32_T m;
  int32_T maxmn;
  int32_T minmn;
  int32_T mmj;
  int32_T scalarLB;
  int8_T o_data[3];
  int8_T rtAction;
  int8_T rtPrevAction;
  boolean_T rtb_TmpSignalConversionAtHILWri[16];
  boolean_T rtb_Equal1;
  boolean_T tmp;
  boolean_T tmp_0;
  ZCEventType zcEvent;
  static const int8_T p[3] = { 0, 0, 1 };

  static const real_T b_QCarEKF_Q[9] = { 0.001, 0.0, 0.0, 0.0, 0.001, 0.0, 0.0,
    0.0, 0.001 };

  int32_T C_size[2];
  int32_T P_times_CTransposed_size[2];
  int32_T R_size[2];
  int32_T jpvt_size[2];
  int32_T S_tmp;
  int32_T b_B_size_idx_0;
  int32_T tmp_7;
  int32_T y_size;
  if (rtmIsMajorTimeStep(VIRTUAL_self_driving_stack_v_M)) {
    /* set solver stop time */
    if (!(VIRTUAL_self_driving_stack_v_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                            ((VIRTUAL_self_driving_stack_v_M->Timing.clockTickH0
        + 1) * VIRTUAL_self_driving_stack_v_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                            ((VIRTUAL_self_driving_stack_v_M->Timing.clockTick0
        + 1) * VIRTUAL_self_driving_stack_v_M->Timing.stepSize0 +
        VIRTUAL_self_driving_stack_v_M->Timing.clockTickH0 *
        VIRTUAL_self_driving_stack_v_M->Timing.stepSize0 * 4294967296.0));
    }

    {                                  /* Sample time: [0.0s, 0.0s] */
      rate_monotonic_scheduler();
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(VIRTUAL_self_driving_stack_v_M)) {
    VIRTUAL_self_driving_stack_v_M->Timing.t[0] = rtsiGetT
      (&VIRTUAL_self_driving_stack_v_M->solverInfo);
  }

  /* Reset subsysRan breadcrumbs */
  srClearBC
    (VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem.IfActionSubsystem_SubsysRanBC);

  /* Reset subsysRan breadcrumbs */
  srClearBC(VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_SubsysRanB);

  /* RateTransition generated from: '<Root>/MATLAB Function' incorporates:
   *  RateTransition: '<S38>/RT'
   */
  tmp = rtmIsMajorTimeStep(VIRTUAL_self_driving_stack_v_M);
  if (tmp) {
    /* S-Function (hil_read_timebase_block): '<S9>/HIL Read Timebase' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/readQCarDAC/HIL Read Timebase (hil_read_timebase_block) */
    {
      t_error result;

      {
        t_timeout end_time;
        t_error local_result = timeout_get_high_resolution_time(&end_time);
        if (local_result == 0) {
          local_result = timeout_subtract
            (&VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTime,
             &end_time,
             &VIRTUAL_self_driving_stack_v_DW.ComputationTime_BeginTime);
        }

        if (local_result < 0) {
          msg_get_error_messageA(NULL, local_result, _rt_error_message, sizeof
            (_rt_error_message));
          rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        }
      }

      result = hil_task_read
        (VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_Task, 1,
         &VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_AnalogBuffer[0],
         &VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_EncoderBuffer,
         NULL,
         &VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer[0]
         );

      {
        t_error local_result = timeout_get_high_resolution_time
          (&VIRTUAL_self_driving_stack_v_DW.ComputationTime_BeginTime);
        if (local_result < 0) {
          msg_get_error_messageA(NULL, local_result, _rt_error_message, sizeof
            (_rt_error_message));
          rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        }
      }

      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      } else {
        rtb_motorcurrent =
          VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_AnalogBuffer[0];
        rtb_batteryvoltage =
          VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_AnalogBuffer[1];
        VIRTUAL_self_driving_stack_v2_B.encodercounts =
          VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_EncoderBuffer;
        rtb_x = VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer[0];
        rtb_y = VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer[1];
        VIRTUAL_self_driving_stack_v2_B.z =
          VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer[2];
        rtb_x_a = VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer[3];
        rtb_y_h = VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer[4];
        rtb_z = VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer[5];
        rtb_Time1 = VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_OtherBuffer
          [6];
      }
    }

    /* S-Function (inverse_modulus_block): '<S9>/Unwrap 2^24' */
    /* S-Function Block: VIRTUAL_self_driving_stack_v2/readQCarDAC/Unwrap 2^24 (inverse_modulus_block) */
    {
      static const real_T sampling_period = 0.002;
      real_T half_range = VIRTUAL_self_driving_stack_v2_P.Unwrap224_Modulus /
        2.0;
      real_T du, dy;
      if (VIRTUAL_self_driving_stack_v_DW.Unwrap224_FirstSample) {
        VIRTUAL_self_driving_stack_v_DW.Unwrap224_FirstSample = false;
        VIRTUAL_self_driving_stack_v_DW.Unwrap224_PreviousInput =
          VIRTUAL_self_driving_stack_v2_B.encodercounts;
      }

      du = (real_T) VIRTUAL_self_driving_stack_v2_B.encodercounts -
        VIRTUAL_self_driving_stack_v_DW.Unwrap224_PreviousInput;
      if (du > half_range) {
        VIRTUAL_self_driving_stack_v_DW.Unwrap224_Revolutions =
          VIRTUAL_self_driving_stack_v_DW.Unwrap224_Revolutions - 1;
        dy = du - VIRTUAL_self_driving_stack_v2_P.Unwrap224_Modulus;
      } else if (du < -half_range) {
        VIRTUAL_self_driving_stack_v_DW.Unwrap224_Revolutions =
          VIRTUAL_self_driving_stack_v_DW.Unwrap224_Revolutions + 1;
        dy = du + VIRTUAL_self_driving_stack_v2_P.Unwrap224_Modulus;
      } else {
        dy = du;
      }

      rtb_Unwrap224 = VIRTUAL_self_driving_stack_v2_B.encodercounts +
        VIRTUAL_self_driving_stack_v_DW.Unwrap224_Revolutions *
        VIRTUAL_self_driving_stack_v2_P.Unwrap224_Modulus;
      VIRTUAL_self_driving_stack_v_DW.Unwrap224_PreviousInput =
        VIRTUAL_self_driving_stack_v2_B.encodercounts;
    }

    /* Gain: '<S29>/wheel radius' incorporates:
     *  Gain: '<S29>/counts to rotations'
     *  Gain: '<S29>/gear ratios'
     *  Gain: '<S29>/rot//s to rad//s'
     */
    VIRTUAL_self_driving_stack_v2_B.wheelspeedms =
      VIRTUAL_self_driving_stack_v2_P.countstorotations_Gain * rtb_Time1 *
      VIRTUAL_self_driving_stack_v2_P.gearratios_Gain *
      VIRTUAL_self_driving_stack_v2_P.rotstorads_Gain *
      VIRTUAL_self_driving_stack_v2_P.wheelradius_Gain;

    /* Memory: '<S38>/Memory2' */
    rtb_Time1 = VIRTUAL_self_driving_stack_v_DW.Memory2_PreviousInput;

    /* RateTransition: '<S6>/Rate Transition' */
    if (VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_4) {
      /* RateTransition: '<S6>/Rate Transition' */
      VIRTUAL_self_driving_stack_v2_B.RateTransition[0] =
        VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[0];
      VIRTUAL_self_driving_stack_v2_B.RateTransition[1] =
        VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[1];
      VIRTUAL_self_driving_stack_v2_B.RateTransition[2] =
        VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[2];
    }

    /* End of RateTransition: '<S6>/Rate Transition' */

    /* Bias: '<S6>/Calibration Bias' */
    tmp_6 = _mm_add_pd(_mm_loadu_pd
                       (&VIRTUAL_self_driving_stack_v2_B.RateTransition[0]),
                       _mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_P.cal_pos[0]));

    /* Bias: '<S6>/Calibration Bias' */
    _mm_storeu_pd(&VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0], tmp_6);
    VIRTUAL_self_driving_stack_v2_B.CalibrationBias[2] =
      VIRTUAL_self_driving_stack_v2_B.RateTransition[2] +
      VIRTUAL_self_driving_stack_v2_P.cal_pos[2];

    /* RelationalOperator: '<S38>/Relational Operator1' */
    VIRTUAL_self_driving_stack_v2_B.RelationalOperator1 = (rtb_Time1 !=
      VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0]);
  }

  /* Outputs for Enabled SubSystem: '<S12>/Steering Based on LiDAR' incorporates:
   *  EnablePort: '<S55>/Enable'
   */
  /* Outputs for IfAction SubSystem: '<S55>/If Action Subsystem1' incorporates:
   *  ActionPort: '<S58>/Action Port'
   */
  /* Outputs for IfAction SubSystem: '<S55>/If Action Subsystem' incorporates:
   *  ActionPort: '<S57>/Action Port'
   */
  /* Outputs for IfAction SubSystem: '<S55>/If Action Subsystem2' incorporates:
   *  ActionPort: '<S59>/Action Port'
   */
  /* If: '<S55>/If' incorporates:
   *  Integrator: '<S33>/Integrator1'
   *  Integrator: '<S38>/Integrator'
   *  Integrator: '<S40>/Integrator1'
   *  Integrator: '<S53>/Integrator'
   *  Integrator: '<S53>/Integrator1'
   */
  tmp_0 = rtsiIsModeUpdateTimeStep(&VIRTUAL_self_driving_stack_v_M->solverInfo);

  /* End of Outputs for SubSystem: '<S55>/If Action Subsystem2' */
  /* End of Outputs for SubSystem: '<S55>/If Action Subsystem' */
  /* End of Outputs for SubSystem: '<S55>/If Action Subsystem1' */
  /* End of Outputs for SubSystem: '<S12>/Steering Based on LiDAR' */

  /* Integrator: '<S38>/Integrator' */
  if (tmp_0) {
    rtb_Equal1 = (((VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE ==
                    POS_ZCSIG) != (int32_T)
                   VIRTUAL_self_driving_stack_v2_B.RelationalOperator1) &&
                  (VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE !=
                   UNINITIALIZED_ZCSIG));
    VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE =
      VIRTUAL_self_driving_stack_v2_B.RelationalOperator1;

    /* evaluate zero-crossings and the level of the reset signal */
    if (rtb_Equal1 || VIRTUAL_self_driving_stack_v2_B.RelationalOperator1 ||
        VIRTUAL_self_driving_stack_v_DW.Integrator_DWORK1) {
      VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[0] =
        VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0];
      VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[1] =
        VIRTUAL_self_driving_stack_v2_B.CalibrationBias[1];
      VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[2] =
        VIRTUAL_self_driving_stack_v2_B.CalibrationBias[2];
    }
  }

  rtb_Integrator1_idx_0 = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[0];
  rtb_Integrator1_idx_1 = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[1];
  rtb_Integrator1_idx_2 = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[2];
  if (tmp) {
    /* RateTransition generated from: '<S39>/Heading Kalman Filter' incorporates:
     *  RateTransition generated from: '<S39>/QCar EKF'
     */
    rtb_Equal1 = VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_4;
    if (rtb_Equal1) {
      /* RateTransition generated from: '<S39>/Heading Kalman Filter' */
      VIRTUAL_self_driving_stack_v2_B.TmpRTBAtHeadingKalmanFilterInpo =
        VIRTUAL_self_driving_stack_v_DW.TmpRTBAtHeadingKalmanFilterInpo;
    }

    /* End of RateTransition generated from: '<S39>/Heading Kalman Filter' */

    /* MATLAB Function: '<S39>/Heading Kalman Filter' */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_j = VIRTUAL_self_driving_CALL_EVENT;

    /* MATLAB Function 'stateEstimation/Gyro KF + EKF/Heading Kalman Filter': '<S49>:1' */
    /* '<S49>:1:11' */
    /* '<S49>:1:13' */
    if (!VIRTUAL_self_driving_stack_v_DW.X_hat_not_empty_m) {
      /* '<S49>:1:4' */
      VIRTUAL_self_driving_stack_v_DW.X_hat_not_empty_m = true;
      VIRTUAL_self_driving_stack_v_DW.P_not_empty_k = true;
      VIRTUAL_self_driving_stack_v_DW.I_not_empty_n = true;

      /* '<S49>:1:11' */
      tmp_6 = _mm_add_pd(_mm_mul_pd(_mm_set1_pd
        (VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time), _mm_set1_pd
        (0.0)), _mm_loadu_pd(&VIRTUAL_self_driving_stack_v_DW.I_i[0]));
      _mm_storeu_pd(&VIRTUAL_self_driving_stack_v_DW.A[0], tmp_6);
      VIRTUAL_self_driving_stack_v_DW.A[2] =
        VIRTUAL_self_driving_stack_v_DW.I_i[2] -
        VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time;
      VIRTUAL_self_driving_stack_v_DW.A[3] =
        VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time * 0.0 +
        VIRTUAL_self_driving_stack_v_DW.I_i[3];
      VIRTUAL_self_driving_stack_v_DW.A_not_empty = true;

      /* '<S49>:1:13' */
      VIRTUAL_self_driving_stack_v_DW.B[0] =
        VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time;
      VIRTUAL_self_driving_stack_v_DW.B[1] =
        VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time * 0.0;
      VIRTUAL_self_driving_stack_v_DW.B_not_empty = true;
      VIRTUAL_self_driving_stack_v_DW.C_not_empty = true;
    }

    /* '<S49>:1:19' */
    tmp_6 = _mm_add_pd(_mm_add_pd(_mm_mul_pd(_mm_set_pd
      (VIRTUAL_self_driving_stack_v_DW.X_hat_b[0],
       VIRTUAL_self_driving_stack_v_DW.A[0]), _mm_set_pd
      (VIRTUAL_self_driving_stack_v_DW.A[1],
       VIRTUAL_self_driving_stack_v_DW.X_hat_b[0])), _mm_mul_pd(_mm_set1_pd
      (VIRTUAL_self_driving_stack_v_DW.X_hat_b[1]), _mm_loadu_pd
      (&VIRTUAL_self_driving_stack_v_DW.A[2]))), _mm_mul_pd(_mm_loadu_pd
      (&VIRTUAL_self_driving_stack_v_DW.B[0]), _mm_set1_pd
      (VIRTUAL_self_driving_stack_v2_B.z)));
    _mm_storeu_pd(&P_times_CTransposed_0[0], tmp_6);

    /* '<S49>:1:20' */
    rtb_Subtract_idx_1 = VIRTUAL_self_driving_stack_v_DW.A[0];
    rtb_poseRateCorrection = VIRTUAL_self_driving_stack_v_DW.A[1];
    s = VIRTUAL_self_driving_stack_v_DW.A[2];
    d = VIRTUAL_self_driving_stack_v_DW.A[3];
    for (maxmn = 0; maxmn < 2; maxmn++) {
      VIRTUAL_self_driving_stack_v_DW.X_hat_b[maxmn] =
        P_times_CTransposed_0[maxmn];
      b_ix = maxmn << 1;
      S = VIRTUAL_self_driving_stack_v_DW.P_m[b_ix];
      rtb_Subtract_idx_2 = rtb_Subtract_idx_1 * S;
      rtb_Subtract_idx_0 = rtb_poseRateCorrection * S;
      S = VIRTUAL_self_driving_stack_v_DW.P_m[b_ix + 1];
      tmp_1[b_ix] = s * S + rtb_Subtract_idx_2;
      tmp_1[b_ix + 1] = d * S + rtb_Subtract_idx_0;
    }

    rtb_Subtract_idx_1 = VIRTUAL_self_driving_stack_v_DW.A[2];
    rtb_poseRateCorrection = VIRTUAL_self_driving_stack_v_DW.A[0];
    s = VIRTUAL_self_driving_stack_v_DW.A[3];
    d = VIRTUAL_self_driving_stack_v_DW.A[1];
    for (maxmn = 0; maxmn <= 0; maxmn += 2) {
      tmp_6 = _mm_loadu_pd(&tmp_1[maxmn + 2]);
      tmp_4 = _mm_loadu_pd(&tmp_1[maxmn]);
      _mm_storeu_pd(&VIRTUAL_self_driving_stack_v_DW.P_m[maxmn], _mm_add_pd
                    (_mm_add_pd(_mm_mul_pd(tmp_6, _mm_set1_pd(rtb_Subtract_idx_1)),
        _mm_mul_pd(tmp_4, _mm_set1_pd(rtb_poseRateCorrection))), _mm_loadu_pd
                     (&VIRTUAL_self_driving_stack_v2_P.GyroKF_Q[maxmn])));
      _mm_storeu_pd(&VIRTUAL_self_driving_stack_v_DW.P_m[maxmn + 2], _mm_add_pd
                    (_mm_add_pd(_mm_mul_pd(tmp_6, _mm_set1_pd(s)), _mm_mul_pd
        (tmp_4, _mm_set1_pd(d))), _mm_loadu_pd
                     (&VIRTUAL_self_driving_stack_v2_P.GyroKF_Q[maxmn + 2])));
    }

    if (VIRTUAL_self_driving_stack_v2_B.TmpRTBAtHeadingKalmanFilterInpo) {
      /* '<S49>:1:23' */
      /* '<S49>:1:24' */
      _mm_storeu_pd(&P_times_CTransposed[0], _mm_mul_pd(_mm_set_pd
        (VIRTUAL_self_driving_stack_v_DW.C[0],
         VIRTUAL_self_driving_stack_v_DW.P_m[0]), _mm_set_pd
        (VIRTUAL_self_driving_stack_v_DW.P_m[1],
         VIRTUAL_self_driving_stack_v_DW.C[0])));
      tmp_6 = _mm_add_pd(_mm_mul_pd(_mm_set1_pd
        (VIRTUAL_self_driving_stack_v_DW.C[1]), _mm_loadu_pd
        (&VIRTUAL_self_driving_stack_v_DW.P_m[2])), _mm_loadu_pd
                         (&P_times_CTransposed[0]));
      _mm_storeu_pd(&P_times_CTransposed[0], tmp_6);

      /* '<S49>:1:25' */
      /* '<S49>:1:26' */
      /* '<S49>:1:28' */
      tmp_6 = _mm_div_pd(_mm_loadu_pd(&P_times_CTransposed[0]), _mm_set1_pd
                         ((VIRTUAL_self_driving_stack_v_DW.C[0] *
                           P_times_CTransposed[0] +
                           VIRTUAL_self_driving_stack_v_DW.C[1] *
                           P_times_CTransposed[1]) +
                          VIRTUAL_self_driving_stack_v2_P.GyroKF_R));
      _mm_storeu_pd(&P_times_CTransposed[0], tmp_6);
      b = VIRTUAL_self_driving_stack_v2_B.CalibrationBias[2] -
        (VIRTUAL_self_driving_stack_v_DW.C[0] *
         VIRTUAL_self_driving_stack_v_DW.X_hat_b[0] +
         VIRTUAL_self_driving_stack_v_DW.C[1] *
         VIRTUAL_self_driving_stack_v_DW.X_hat_b[1]);
      VIRTUAL_self_driving_s_wrapToPi(&b);

      /* '<S49>:1:30' */
      tmp_6 = _mm_add_pd(_mm_mul_pd(_mm_loadu_pd(&P_times_CTransposed[0]),
        _mm_set1_pd(b)), _mm_loadu_pd(&VIRTUAL_self_driving_stack_v_DW.X_hat_b[0]));
      _mm_storeu_pd(&VIRTUAL_self_driving_stack_v_DW.X_hat_b[0], tmp_6);

      /* '<S49>:1:31' */
      VIRTUAL_self_driving_s_wrapToPi(&VIRTUAL_self_driving_stack_v_DW.X_hat_b[0]);

      /* '<S49>:1:33' */
      rtb_Subtract_idx_1 = VIRTUAL_self_driving_stack_v_DW.I_i[0] -
        P_times_CTransposed[0] * VIRTUAL_self_driving_stack_v_DW.C[0];
      tmp_1[0] = 0.0;
      rtb_poseRateCorrection = VIRTUAL_self_driving_stack_v_DW.I_i[1] -
        VIRTUAL_self_driving_stack_v_DW.C[0] * P_times_CTransposed[1];
      tmp_1[1] = 0.0;
      s = VIRTUAL_self_driving_stack_v_DW.I_i[2] - P_times_CTransposed[0] *
        VIRTUAL_self_driving_stack_v_DW.C[1];
      tmp_1[2] = 0.0;
      d = VIRTUAL_self_driving_stack_v_DW.I_i[3] - P_times_CTransposed[1] *
        VIRTUAL_self_driving_stack_v_DW.C[1];
      tmp_1[3] = 0.0;
      for (maxmn = 0; maxmn < 2; maxmn++) {
        b_ix = maxmn << 1;
        S = VIRTUAL_self_driving_stack_v_DW.P_m[b_ix];
        rtb_Subtract_idx_2 = rtb_Subtract_idx_1 * S + tmp_1[b_ix];
        rtb_Subtract_idx_0 = tmp_1[b_ix + 1] + rtb_poseRateCorrection * S;
        S = VIRTUAL_self_driving_stack_v_DW.P_m[b_ix + 1];
        tmp_1[b_ix] = s * S + rtb_Subtract_idx_2;
        tmp_1[b_ix + 1] = d * S + rtb_Subtract_idx_0;
      }

      VIRTUAL_self_driving_stack_v_DW.P_m[0] = tmp_1[0];
      VIRTUAL_self_driving_stack_v_DW.P_m[1] = tmp_1[1];
      VIRTUAL_self_driving_stack_v_DW.P_m[2] = tmp_1[2];
      VIRTUAL_self_driving_stack_v_DW.P_m[3] = tmp_1[3];
    }

    /* RateTransition generated from: '<S39>/QCar EKF' */
    /* '<S49>:1:36' */
    /* '<S49>:1:37' */
    if (rtb_Equal1) {
      /* RateTransition generated from: '<S39>/QCar EKF' */
      VIRTUAL_self_driving_stack_v2_B.TmpRTBAtQCarEKFInport6 =
        VIRTUAL_self_driving_stack_v_DW.TmpRTBAtQCarEKFInport6_Buffer0;
    }

    /* MATLAB Function: '<S39>/QCar EKF' incorporates:
     *  MATLAB Function: '<S39>/Heading Kalman Filter'
     *  Memory: '<S11>/Memory1'
     */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_n = VIRTUAL_self_driving_CALL_EVENT;

    /* MATLAB Function 'stateEstimation/Gyro KF + EKF/QCar EKF': '<S50>:1' */
    /* '<S50>:1:27' */
    if (!VIRTUAL_self_driving_stack_v_DW.X_hat_not_empty) {
      /* '<S50>:1:7' */
      VIRTUAL_self_driving_stack_v_DW.X_hat_not_empty = true;

      /* '<S50>:1:10' */
      memcpy(&VIRTUAL_self_driving_stack_v_DW.P[0],
             &VIRTUAL_self_driving_stack_v2_P.QCarEKF_P0[0], 9U * sizeof(real_T));
      VIRTUAL_self_driving_stack_v_DW.P_not_empty = true;
      VIRTUAL_self_driving_stack_v_DW.I_not_empty = true;
      VIRTUAL_self_driving_stack_v_DW.C_heading_not_empty = true;
      VIRTUAL_self_driving_stack_v_DW.C_combined_not_empty = true;
    }

    /* '<S50>:1:22' */
    /* '<S50>:1:25' */
    F[0] = 1.0;
    F[3] = 0.0;
    F[6] = -VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time *
      VIRTUAL_self_driving_stack_v2_B.wheelspeedms * sin
      (VIRTUAL_self_driving_stack_v_DW.X_hat[2]);
    F[1] = 0.0;
    F[4] = 1.0;
    F[7] = VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time *
      VIRTUAL_self_driving_stack_v2_B.wheelspeedms * cos
      (VIRTUAL_self_driving_stack_v_DW.X_hat[2]);

    /* '<S50>:1:28' */
    for (maxmn = 0; maxmn < 3; maxmn++) {
      F_tmp = 3 * maxmn + 2;
      F[F_tmp] = p[maxmn];
      F_0[3 * maxmn] = 0.0;
      F_0[3 * maxmn + 1] = 0.0;
      F_0[F_tmp] = 0.0;
    }

    for (maxmn = 0; maxmn < 3; maxmn++) {
      S = F_0[3 * maxmn];
      F_tmp = 3 * maxmn + 1;
      rtb_Subtract_idx_2 = F_0[F_tmp];
      F_tmp_0 = 3 * maxmn + 2;
      rtb_Subtract_idx_0 = F_0[F_tmp_0];
      for (b_ix = 0; b_ix < 3; b_ix++) {
        i = 3 * maxmn + b_ix;
        tmp_6 = _mm_add_pd(_mm_mul_pd(_mm_loadu_pd(&F[3 * b_ix]), _mm_set1_pd
          (VIRTUAL_self_driving_stack_v_DW.P[i])), _mm_set_pd(rtb_Subtract_idx_2,
          S));
        _mm_storeu_pd(&tmp_5[0], tmp_6);
        S = tmp_5[0];
        rtb_Subtract_idx_2 = tmp_5[1];
        rtb_Subtract_idx_0 += F[3 * b_ix + 2] *
          VIRTUAL_self_driving_stack_v_DW.P[i];
      }

      F_0[F_tmp_0] = rtb_Subtract_idx_0;
      F_0[F_tmp] = rtb_Subtract_idx_2;
      F_0[3 * maxmn] = S;
    }

    for (maxmn = 0; maxmn < 3; maxmn++) {
      S = F_0[maxmn + 3];
      rtb_Subtract_idx_2 = F_0[maxmn];
      rtb_Subtract_idx_0 = F_0[maxmn + 6];
      for (b_ix = 0; b_ix < 3; b_ix++) {
        i = 3 * b_ix + maxmn;
        VIRTUAL_self_driving_stack_v_DW.P[i] = ((F[b_ix + 3] * S +
          rtb_Subtract_idx_2 * F[b_ix]) + F[b_ix + 6] * rtb_Subtract_idx_0) +
          b_QCarEKF_Q[i];
      }
    }

    /* '<S50>:1:30' */
    rtb_poseRateCorrection =
      VIRTUAL_self_driving_stack_v2_P.Controller_Sample_Time *
      VIRTUAL_self_driving_stack_v2_B.wheelspeedms;
    S = VIRTUAL_self_driving_stack_v_DW.X_hat[0];
    rtb_Subtract_idx_2 = VIRTUAL_self_driving_stack_v_DW.X_hat[2];
    rtb_Subtract_idx_0 = VIRTUAL_self_driving_stack_v_DW.X_hat[1];
    rtb_Subtract_idx_1 = VIRTUAL_self_driving_stack_v_DW.X_hat[2];
    s = VIRTUAL_self_driving_stack_v_DW.X_hat[2];
    VIRTUAL_self_driving_stack_v_DW.X_hat[0] = rtb_poseRateCorrection * cos
      (rtb_Subtract_idx_2) + S;
    VIRTUAL_self_driving_stack_v_DW.X_hat[1] = rtb_poseRateCorrection * sin
      (rtb_Subtract_idx_1) + rtb_Subtract_idx_0;
    VIRTUAL_self_driving_stack_v_DW.X_hat[2] = tan
      (VIRTUAL_self_driving_stack_v_DW.Memory1_PreviousInput) /
      VIRTUAL_self_driving_stack_v2_P.QCarEKF_L * rtb_poseRateCorrection + s;
    if (VIRTUAL_self_driving_stack_v2_B.TmpRTBAtQCarEKFInport6) {
      /* '<S50>:1:36' */
      /* '<S50>:1:37' */
      y_size = 3;
      y_data[0] = VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0];
      y_data[1] = VIRTUAL_self_driving_stack_v2_B.CalibrationBias[1];
      y_data[2] = VIRTUAL_self_driving_stack_v_DW.X_hat_b[0];

      /* '<S50>:1:38' */
      C_size[0] = 3;
      C_size[1] = 3;

      /* '<S50>:1:39' */
      R_size[0] = 3;
      R_size[1] = 3;
      memcpy(&C_data[0], &VIRTUAL_self_driving_stack_v_DW.C_combined[0], 9U *
             sizeof(real_T));
      memcpy(&F[0], &VIRTUAL_self_driving_stack_v2_P.QCarEKF_R_combined[0], 9U *
             sizeof(real_T));
    } else {
      /* '<S50>:1:42' */
      y_size = 1;
      y_data[0] = VIRTUAL_self_driving_stack_v_DW.X_hat_b[0];

      /* '<S50>:1:43' */
      C_size[0] = 1;
      C_size[1] = 3;
      C_data[0] = VIRTUAL_self_driving_stack_v_DW.C_heading[0];
      C_data[1] = VIRTUAL_self_driving_stack_v_DW.C_heading[1];
      C_data[2] = VIRTUAL_self_driving_stack_v_DW.C_heading[2];

      /* '<S50>:1:44' */
      R_size[0] = 1;
      R_size[1] = 1;
      F[0] = 0.1;
    }

    /* '<S50>:1:47' */
    loop_ub = C_size[0];
    P_times_CTransposed_size[0] = 3;
    P_times_CTransposed_size[1] = C_size[0];
    for (maxmn = 0; maxmn < loop_ub; maxmn++) {
      S = 0.0;
      rtb_Subtract_idx_2 = 0.0;
      rtb_Subtract_idx_0 = 0.0;
      for (b_ix = 0; b_ix < 3; b_ix++) {
        rtb_Subtract_idx_1 = C_data[C_size[0] * b_ix + maxmn];
        tmp_6 = _mm_add_pd(_mm_mul_pd(_mm_loadu_pd
          (&VIRTUAL_self_driving_stack_v_DW.P[3 * b_ix]), _mm_set1_pd
          (rtb_Subtract_idx_1)), _mm_set_pd(rtb_Subtract_idx_2, S));
        _mm_storeu_pd(&tmp_5[0], tmp_6);
        S = tmp_5[0];
        rtb_Subtract_idx_2 = tmp_5[1];
        rtb_Subtract_idx_0 += VIRTUAL_self_driving_stack_v_DW.P[3 * b_ix + 2] *
          rtb_Subtract_idx_1;
      }

      P_times_CTransposed_data[2 + 3 * maxmn] = rtb_Subtract_idx_0;
      P_times_CTransposed_data[1 + 3 * maxmn] = rtb_Subtract_idx_2;
      P_times_CTransposed_data[3 * maxmn] = S;
    }

    /* '<S50>:1:48' */
    if ((C_size[0] == R_size[0]) && (C_size[0] == R_size[1])) {
      R_size[0] = C_size[0];
      R_size[1] = C_size[0];
      for (maxmn = 0; maxmn < loop_ub; maxmn++) {
        for (b_ix = 0; b_ix < loop_ub; b_ix++) {
          F_tmp = R_size[0] * b_ix + maxmn;
          F[F_tmp] += (P_times_CTransposed_data[3 * b_ix + 1] * C_data[maxmn +
                       C_size[0]] + P_times_CTransposed_data[3 * b_ix] *
                       C_data[maxmn]) + C_data[(C_size[0] << 1) + maxmn] *
            P_times_CTransposed_data[3 * b_ix + 2];
        }
      }
    } else {
      VIRTUAL_self_binary_expand_op_1(F, R_size, C_data, C_size,
        P_times_CTransposed_data, P_times_CTransposed_size);
    }

    /* '<S50>:1:49' */
    if (R_size[0] == 0) {
      P_times_CTransposed_size[1] = 0;
    } else if (R_size[0] == R_size[1]) {
      i = R_size[1];
      jpvt_data[0] = 1;
      maxmn = 1;
      for (m = 2; m <= i; m++) {
        maxmn++;
        jpvt_data[m - 1] = maxmn;
      }

      if (R_size[1] - 1 <= R_size[1]) {
        F_tmp = R_size[1] - 1;
      } else {
        F_tmp = 1;
      }

      for (F_tmp_0 = 0; F_tmp_0 < F_tmp; F_tmp_0++) {
        loop_ub = i - F_tmp_0;
        mmj = loop_ub - 1;
        m = (i + 1) * F_tmp_0;
        if (loop_ub - 1 < 0) {
          minmn = -1;
        } else {
          minmn = 0;
          if (loop_ub - 1 > 0) {
            S = fabs(F[m]);
            for (b_ix = 2; b_ix <= mmj + 1; b_ix++) {
              s = fabs(F[(m + b_ix) - 1]);
              if (s > S) {
                minmn = b_ix - 1;
                S = s;
              }
            }
          }
        }

        if (F[m + minmn] != 0.0) {
          if (minmn != 0) {
            mmj = F_tmp_0 + minmn;
            jpvt_data[F_tmp_0] = mmj + 1;
            for (minmn = 0; minmn < i; minmn++) {
              scalarLB = minmn * i;
              S_tmp = scalarLB + F_tmp_0;
              S = F[S_tmp];
              b_ix = scalarLB + mmj;
              F[S_tmp] = F[b_ix];
              F[b_ix] = S;
            }
          }

          b_ix = m + loop_ub;
          scalarLB = (((((b_ix - m) - 1) / 2) << 1) + m) + 2;
          mmj = scalarLB - 2;
          for (minmn = m + 2; minmn <= mmj; minmn += 2) {
            tmp_6 = _mm_loadu_pd(&F[minmn - 1]);
            _mm_storeu_pd(&F[minmn - 1], _mm_div_pd(tmp_6, _mm_set1_pd(F[m])));
          }

          for (minmn = scalarLB; minmn <= b_ix; minmn++) {
            F[minmn - 1] /= F[m];
          }
        }

        maxmn = m + i;
        minmn = maxmn + 2;
        for (mmj = 0; mmj <= loop_ub - 2; mmj++) {
          S = F[mmj * i + maxmn];
          if (S != 0.0) {
            b_ix = (loop_ub + minmn) - 1;
            for (S_tmp = minmn; S_tmp < b_ix; S_tmp++) {
              F[S_tmp - 1] += F[((m + S_tmp) - minmn) + 1] * -S;
            }
          }

          minmn += i;
        }
      }

      F_tmp = R_size[1];
      for (F_tmp_0 = 0; F_tmp_0 < F_tmp; F_tmp_0++) {
        mmj = 3 * F_tmp_0;
        m = i * F_tmp_0;
        for (b_ix = 0; b_ix < F_tmp_0; b_ix++) {
          minmn = 3 * b_ix;
          S = F[b_ix + m];
          if (S != 0.0) {
            P_times_CTransposed_data[mmj] -= S * P_times_CTransposed_data[minmn];
            P_times_CTransposed_data[mmj + 1] -= P_times_CTransposed_data[minmn
              + 1] * S;
            P_times_CTransposed_data[mmj + 2] -= P_times_CTransposed_data[minmn
              + 2] * S;
          }
        }

        S = 1.0 / F[F_tmp_0 + m];
        P_times_CTransposed_data[mmj] *= S;
        P_times_CTransposed_data[mmj + 1] *= S;
        P_times_CTransposed_data[mmj + 2] *= S;
      }

      for (F_tmp_0 = i; F_tmp_0 >= 1; F_tmp_0--) {
        mmj = (F_tmp_0 - 1) * 3;
        m = (F_tmp_0 - 1) * i - 1;
        for (b_ix = F_tmp_0 + 1; b_ix <= i; b_ix++) {
          minmn = (b_ix - 1) * 3;
          S = F[b_ix + m];
          if (S != 0.0) {
            P_times_CTransposed_data[mmj] -= S * P_times_CTransposed_data[minmn];
            P_times_CTransposed_data[mmj + 1] -= P_times_CTransposed_data[minmn
              + 1] * S;
            P_times_CTransposed_data[mmj + 2] -= P_times_CTransposed_data[minmn
              + 2] * S;
          }
        }
      }

      i = R_size[1] - 1;
      for (minmn = i; minmn >= 1; minmn--) {
        maxmn = jpvt_data[minmn - 1];
        if (maxmn != minmn) {
          mmj = (minmn - 1) * 3;
          S = P_times_CTransposed_data[mmj];
          loop_ub = (maxmn - 1) * 3;
          P_times_CTransposed_data[mmj] = P_times_CTransposed_data[loop_ub];
          P_times_CTransposed_data[loop_ub] = S;
          S = P_times_CTransposed_data[1 + mmj];
          P_times_CTransposed_data[1 + mmj] = P_times_CTransposed_data[1 +
            loop_ub];
          P_times_CTransposed_data[1 + loop_ub] = S;
          S = P_times_CTransposed_data[2 + mmj];
          P_times_CTransposed_data[2 + mmj] = P_times_CTransposed_data[2 +
            loop_ub];
          P_times_CTransposed_data[2 + loop_ub] = S;
        }
      }
    } else {
      loop_ub = C_size[0];
      b_B_size_idx_0 = C_size[0];
      for (maxmn = 0; maxmn < 3; maxmn++) {
        for (b_ix = 0; b_ix < loop_ub; b_ix++) {
          F_0[b_ix + b_B_size_idx_0 * maxmn] = P_times_CTransposed_data[3 * b_ix
            + maxmn];
        }
      }

      loop_ub = R_size[1];
      i = R_size[1];
      F_tmp = R_size[0];
      F_tmp_0 = R_size[0];
      for (maxmn = 0; maxmn < F_tmp; maxmn++) {
        for (b_ix = 0; b_ix < loop_ub; b_ix++) {
          P_times_CTransposed_data[b_ix + i * maxmn] = F[R_size[0] * b_ix +
            maxmn];
        }
      }

      R_size[0] = R_size[1];
      R_size[1] = F_tmp;
      loop_ub = i * F_tmp_0;
      if (loop_ub - 1 >= 0) {
        memcpy(&F[0], &P_times_CTransposed_data[0], (uint32_T)loop_ub * sizeof
               (real_T));
      }

      VIRTUAL_self_driving_sta_xgeqp3(F, R_size, tau_data, &maxmn, jpvt_data,
        jpvt_size);
      i = 0;
      if (R_size[0] < R_size[1]) {
        minmn = R_size[0];
        maxmn = R_size[1];
      } else {
        minmn = R_size[1];
        maxmn = R_size[0];
      }

      if (minmn > 0) {
        while ((i < minmn) && (!(fabs(F[R_size[0] * i + i]) <=
                 2.2204460492503131E-15 * (real_T)maxmn * fabs(F[0])))) {
          i++;
        }
      }

      loop_ub = R_size[1];
      b_ix = R_size[1];
      F_tmp = R_size[1] * 3;
      if (F_tmp - 1 >= 0) {
        memset(&Y_data[0], 0, (uint32_T)F_tmp * sizeof(real_T));
      }

      if (R_size[0] <= R_size[1]) {
        minmn = R_size[0];
      } else {
        minmn = R_size[1];
      }

      for (maxmn = 0; maxmn < minmn; maxmn++) {
        m = R_size[0];
        if (tau_data[maxmn] != 0.0) {
          for (F_tmp = 0; F_tmp < 3; F_tmp++) {
            S_tmp = b_B_size_idx_0 * F_tmp;
            mmj = maxmn + S_tmp;
            rtb_Subtract_idx_2 = F_0[mmj];
            S = rtb_Subtract_idx_2;
            for (F_tmp_0 = maxmn + 2; F_tmp_0 <= m; F_tmp_0++) {
              S += F[(R_size[0] * maxmn + F_tmp_0) - 1] * F_0[(F_tmp_0 + S_tmp)
                - 1];
            }

            S *= tau_data[maxmn];
            if (S != 0.0) {
              F_0[mmj] = rtb_Subtract_idx_2 - S;
              scalarLB = (((((m - maxmn) - 1) / 2) << 1) + maxmn) + 2;
              mmj = scalarLB - 2;
              for (F_tmp_0 = maxmn + 2; F_tmp_0 <= mmj; F_tmp_0 += 2) {
                tmp_6 = _mm_loadu_pd(&F[(R_size[0] * maxmn + F_tmp_0) - 1]);
                tmp_7 = (F_tmp_0 + S_tmp) - 1;
                tmp_4 = _mm_loadu_pd(&F_0[tmp_7]);
                _mm_storeu_pd(&F_0[tmp_7], _mm_sub_pd(tmp_4, _mm_mul_pd(tmp_6,
                  _mm_set1_pd(S))));
              }

              for (F_tmp_0 = scalarLB; F_tmp_0 <= m; F_tmp_0++) {
                mmj = (F_tmp_0 + S_tmp) - 1;
                F_0[mmj] -= F[(R_size[0] * maxmn + F_tmp_0) - 1] * S;
              }
            }
          }
        }
      }

      for (F_tmp = 0; F_tmp < 3; F_tmp++) {
        for (minmn = 0; minmn < i; minmn++) {
          Y_data[(jpvt_data[minmn] + b_ix * F_tmp) - 1] = F_0[b_B_size_idx_0 *
            F_tmp + minmn];
        }

        for (mmj = i; mmj >= 1; mmj--) {
          maxmn = b_ix * F_tmp;
          minmn = (jpvt_data[mmj - 1] + maxmn) - 1;
          m = (mmj - 1) * R_size[0];
          Y_data[minmn] /= F[(mmj + m) - 1];
          for (F_tmp_0 = 0; F_tmp_0 <= mmj - 2; F_tmp_0++) {
            S_tmp = (jpvt_data[F_tmp_0] + maxmn) - 1;
            Y_data[S_tmp] -= F[F_tmp_0 + m] * Y_data[minmn];
          }
        }
      }

      P_times_CTransposed_size[1] = R_size[1];
      for (maxmn = 0; maxmn < loop_ub; maxmn++) {
        P_times_CTransposed_data[3 * maxmn] = Y_data[maxmn];
        P_times_CTransposed_data[1 + 3 * maxmn] = Y_data[maxmn + b_ix];
        P_times_CTransposed_data[2 + 3 * maxmn] = Y_data[(b_ix << 1) + maxmn];
      }
    }

    /* '<S50>:1:51' */
    if (y_size == C_size[0]) {
      loop_ub = C_size[0];
      b_B_size_idx_0 = C_size[0];
      scalarLB = (C_size[0] / 2) << 1;
      mmj = scalarLB - 2;
      for (maxmn = 0; maxmn <= mmj; maxmn += 2) {
        tmp_6 = _mm_loadu_pd(&C_data[maxmn]);
        tmp_4 = _mm_loadu_pd(&C_data[maxmn + C_size[0]]);
        tmp_2 = _mm_loadu_pd(&C_data[(C_size[0] << 1) + maxmn]);
        tmp_3 = _mm_loadu_pd(&y_data[maxmn]);
        _mm_storeu_pd(&z_data[maxmn], _mm_sub_pd(tmp_3, _mm_add_pd(_mm_add_pd
          (_mm_mul_pd(tmp_6, _mm_set1_pd(VIRTUAL_self_driving_stack_v_DW.X_hat[0])),
           _mm_mul_pd(tmp_4, _mm_set1_pd(VIRTUAL_self_driving_stack_v_DW.X_hat[1]))),
          _mm_mul_pd(tmp_2, _mm_set1_pd(VIRTUAL_self_driving_stack_v_DW.X_hat[2])))));
      }

      for (maxmn = scalarLB; maxmn < loop_ub; maxmn++) {
        z_data[maxmn] = y_data[maxmn] - ((C_data[maxmn + C_size[0]] *
          VIRTUAL_self_driving_stack_v_DW.X_hat[1] + C_data[maxmn] *
          VIRTUAL_self_driving_stack_v_DW.X_hat[0]) + C_data[(C_size[0] << 1) +
          maxmn] * VIRTUAL_self_driving_stack_v_DW.X_hat[2]);
      }
    } else {
      VIRTUAL_self_d_binary_expand_op(z_data, &b_B_size_idx_0, y_data, &y_size,
        C_data, C_size, VIRTUAL_self_driving_stack_v_DW.X_hat);
    }

    if (VIRTUAL_self_driving_stack_v2_B.TmpRTBAtQCarEKFInport6) {
      /* '<S50>:1:52' */
      /* '<S50>:1:53' */
      VIRTUAL_self_driving_s_wrapToPi(&z_data[2]);
    } else {
      /* '<S50>:1:55' */
      F_tmp = 0;
      for (i = 0; i < b_B_size_idx_0; i++) {
        rtb_Subtract_idx_2 = z_data[i];
        if ((rtb_Subtract_idx_2 < -3.1415926535897931) || (rtb_Subtract_idx_2 >
             3.1415926535897931)) {
          F_tmp++;
        }
      }

      F_tmp_0 = 0;
      for (i = 0; i < b_B_size_idx_0; i++) {
        rtb_Subtract_idx_2 = z_data[i];
        if ((rtb_Subtract_idx_2 < -3.1415926535897931) || (rtb_Subtract_idx_2 >
             3.1415926535897931)) {
          o_data[F_tmp_0] = (int8_T)i;
          F_tmp_0++;
        }
      }

      F_tmp_0 = 0;
      for (i = 0; i < b_B_size_idx_0; i++) {
        rtb_Subtract_idx_2 = z_data[i];
        if ((rtb_Subtract_idx_2 < -3.1415926535897931) || (rtb_Subtract_idx_2 >
             3.1415926535897931)) {
          if (rtIsInf(rtb_Subtract_idx_2 + 3.1415926535897931)) {
            S = (rtNaN);
          } else {
            S = fabs((rtb_Subtract_idx_2 + 3.1415926535897931) /
                     6.2831853071795862);
            if (fabs(S - floor(S + 0.5)) > 2.2204460492503131E-16 * S) {
              S = fmod(rtb_Subtract_idx_2 + 3.1415926535897931,
                       6.2831853071795862);
            } else {
              S = 0.0;
            }

            if (S == 0.0) {
              S = 0.0;
            } else if (S < 0.0) {
              S += 6.2831853071795862;
            }
          }

          tau_data[F_tmp_0] = S;
          F_tmp_0++;
        }
      }

      for (i = 0; i < F_tmp; i++) {
        rtb_Subtract_idx_2 = z_data[o_data[i]] + 3.1415926535897931;
        if (rtIsNaN(rtb_Subtract_idx_2) || rtIsInf(rtb_Subtract_idx_2)) {
          S = (rtNaN);
        } else {
          S = fabs(rtb_Subtract_idx_2 / 6.2831853071795862);
          if (fabs(S - floor(S + 0.5)) > 2.2204460492503131E-16 * S) {
            S = fmod(rtb_Subtract_idx_2, 6.2831853071795862);
          } else {
            S = 0.0;
          }

          if (S == 0.0) {
            S = 0.0;
          } else if (S < 0.0) {
            S += 6.2831853071795862;
          }
        }

        if ((S == 0.0) && (rtb_Subtract_idx_2 > 0.0)) {
          tau_data[i] = 6.2831853071795862;
        }
      }

      F_tmp_0 = 0;
      for (i = 0; i < b_B_size_idx_0; i++) {
        rtb_Subtract_idx_2 = z_data[i];
        if ((rtb_Subtract_idx_2 < -3.1415926535897931) || (rtb_Subtract_idx_2 >
             3.1415926535897931)) {
          z_data[i] = tau_data[F_tmp_0] - 3.1415926535897931;
          F_tmp_0++;
        }
      }
    }

    /* '<S50>:1:58' */
    loop_ub = P_times_CTransposed_size[1];
    for (maxmn = 0; maxmn < 3; maxmn++) {
      S = 0.0;
      for (b_ix = 0; b_ix < loop_ub; b_ix++) {
        S += P_times_CTransposed_data[3 * b_ix + maxmn] * z_data[b_ix];
      }

      VIRTUAL_self_driving_stack_v_DW.X_hat[maxmn] += S;
    }

    /* '<S50>:1:59' */
    VIRTUAL_self_driving_s_wrapToPi(&VIRTUAL_self_driving_stack_v_DW.X_hat[2]);

    /* '<S50>:1:61' */
    for (maxmn = 0; maxmn < 3; maxmn++) {
      for (b_ix = 0; b_ix < 3; b_ix++) {
        S = 0.0;
        for (i = 0; i < loop_ub; i++) {
          S += P_times_CTransposed_data[3 * i + maxmn] * C_data[C_size[0] * b_ix
            + i];
        }

        i = 3 * b_ix + maxmn;
        F[i] = VIRTUAL_self_driving_stack_v_DW.I[i] - S;
        F_0[b_ix + 3 * maxmn] = 0.0;
      }
    }

    for (maxmn = 0; maxmn < 3; maxmn++) {
      S = F_0[3 * maxmn];
      b_ix = 3 * maxmn + 1;
      rtb_Subtract_idx_2 = F_0[b_ix];
      i = 3 * maxmn + 2;
      rtb_Subtract_idx_0 = F_0[i];
      for (F_tmp = 0; F_tmp < 3; F_tmp++) {
        F_tmp_0 = 3 * maxmn + F_tmp;
        tmp_6 = _mm_add_pd(_mm_mul_pd(_mm_loadu_pd(&F[3 * F_tmp]), _mm_set1_pd
          (VIRTUAL_self_driving_stack_v_DW.P[F_tmp_0])), _mm_set_pd
                           (rtb_Subtract_idx_2, S));
        _mm_storeu_pd(&tmp_5[0], tmp_6);
        S = tmp_5[0];
        rtb_Subtract_idx_2 = tmp_5[1];
        rtb_Subtract_idx_0 += F[3 * F_tmp + 2] *
          VIRTUAL_self_driving_stack_v_DW.P[F_tmp_0];
      }

      F_0[i] = rtb_Subtract_idx_0;
      F_0[b_ix] = rtb_Subtract_idx_2;
      F_0[3 * maxmn] = S;
    }

    memcpy(&VIRTUAL_self_driving_stack_v_DW.P[0], &F_0[0], 9U * sizeof(real_T));

    /* '<S50>:1:63' */
    VIRTUAL_self_driving_stack_v2_B.Xhat[0] =
      VIRTUAL_self_driving_stack_v_DW.X_hat[0];
    VIRTUAL_self_driving_stack_v2_B.Xhat[1] =
      VIRTUAL_self_driving_stack_v_DW.X_hat[1];
    VIRTUAL_self_driving_stack_v2_B.Xhat[2] =
      VIRTUAL_self_driving_stack_v_DW.X_hat[2];

    /* End of MATLAB Function: '<S39>/QCar EKF' */
  }

  /* Integrator: '<S40>/Integrator' */
  rtb_Subtract_idx_0 = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_n[0];
  rtb_Subtract_idx_1 = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_n[1];
  rtb_Subtract_idx_2 = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_n[2];

  /* Bias: '<S41>/Bias1' incorporates:
   *  Bias: '<S41>/Bias'
   *  Constant: '<S41>/Constant1'
   *  Integrator: '<S40>/Integrator'
   *  Math: '<S41>/Mod'
   */
  VIRTUAL_self_driving_stack_v2_B.Bias1 = rt_modd_snf
    (VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_n[2] +
     VIRTUAL_self_driving_stack_v2_P.Bias_Bias,
     VIRTUAL_self_driving_stack_v2_P.Constant1_Value_a) +
    VIRTUAL_self_driving_stack_v2_P.Bias1_Bias;

  /* ManualSwitch: '<S11>/Manual Switch2' incorporates:
   *  Integrator: '<S38>/Integrator'
   */
  if (VIRTUAL_self_driving_stack_v2_P.ManualSwitch2_CurrentSetting == 1) {
    S = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[0];
  } else {
    S = VIRTUAL_self_driving_stack_v2_B.Xhat[0];
  }

  /* Sum: '<S11>/Sum1' incorporates:
   *  Gain: '<S11>/Gain1'
   *  ManualSwitch: '<S11>/Manual Switch2'
   *  Trigonometry: '<S11>/Trigonometric Function'
   */
  VIRTUAL_self_driving_stack_v2_B.Sum1[0] =
    VIRTUAL_self_driving_stack_v2_P.Gain1_Gain * cos
    (VIRTUAL_self_driving_stack_v2_B.Bias1) + S;

  /* ManualSwitch: '<S11>/Manual Switch2' incorporates:
   *  Integrator: '<S38>/Integrator'
   */
  if (VIRTUAL_self_driving_stack_v2_P.ManualSwitch2_CurrentSetting == 1) {
    S = VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[1];
  } else {
    S = VIRTUAL_self_driving_stack_v2_B.Xhat[1];
  }

  /* Sum: '<S11>/Sum1' incorporates:
   *  Gain: '<S11>/Gain1'
   *  ManualSwitch: '<S11>/Manual Switch2'
   *  Trigonometry: '<S11>/Trigonometric Function1'
   */
  VIRTUAL_self_driving_stack_v2_B.Sum1[1] =
    VIRTUAL_self_driving_stack_v2_P.Gain1_Gain * sin
    (VIRTUAL_self_driving_stack_v2_B.Bias1) + S;

  /* ManualSwitch: '<S11>/Manual Switch1' */
  if (VIRTUAL_self_driving_stack_v2_P.ManualSwitch1_CurrentSetting == 1) {
    /* ManualSwitch: '<S11>/Manual Switch1' */
    VIRTUAL_self_driving_stack_v2_B.ManualSwitch1 =
      VIRTUAL_self_driving_stack_v2_B.Bias1;
  } else {
    /* ManualSwitch: '<S11>/Manual Switch1' */
    VIRTUAL_self_driving_stack_v2_B.ManualSwitch1 =
      VIRTUAL_self_driving_stack_v2_B.Xhat[2];
  }

  /* End of ManualSwitch: '<S11>/Manual Switch1' */

  /* Clock: '<Root>/Clock' */
  VIRTUAL_self_driving_stack_v2_B.Clock =
    VIRTUAL_self_driving_stack_v_M->Timing.t[0];

  /* RateTransition generated from: '<Root>/MATLAB Function' */
  if (tmp) {
    if (VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_2) {
      /* RateTransition generated from: '<Root>/MATLAB Function' */
      VIRTUAL_self_driving_stack_v2_B.light_color =
        VIRTUAL_self_driving_stack_v_DW.light_color_Buffer0;

      /* RateTransition generated from: '<Root>/MATLAB Function' */
      VIRTUAL_self_driving_stack_v2_B.sign_type =
        VIRTUAL_self_driving_stack_v_DW.sign_type_Buffer0;

      /* RateTransition generated from: '<Root>/MATLAB Function' */
      VIRTUAL_self_driving_stack_v2_B.lane_offset =
        VIRTUAL_self_driving_stack_v_DW.lane_offset_Buffer0;

      /* RateTransition generated from: '<Root>/MATLAB Function' */
      VIRTUAL_self_driving_stack_v2_B.lane_detected =
        VIRTUAL_self_driving_stack_v_DW.lane_detected_Buffer0;

      /* RateTransition generated from: '<Root>/MATLAB Function' */
      VIRTUAL_self_driving_stack_v2_B.sign_size =
        VIRTUAL_self_driving_stack_v_DW.sign_size_Buffer0;
    }

    /* MATLAB Function: '<Root>/MATLAB Function' incorporates:
     *  SignalConversion generated from: '<S2>/ SFunction '
     */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_mq = VIRTUAL_self_driving_CALL_EVENT;

    /* MATLAB Function 'MATLAB Function': '<S2>:1' */
    /* '<S2>:1:16' */
    /* '<S2>:1:17' */
    /* '<S2>:1:18' */
    /* '<S2>:1:28' */
    /* '<S2>:1:36' */
    /* '<S2>:1:42' */
    /* '<S2>:1:51' */
    /* '<S2>:1:13' */
    /* '<S2>:1:14' */
    /* '<S2>:1:16' */
    /* '<S2>:1:17' */
    /* '<S2>:1:18' */
    /* '<S2>:1:19' */
    /* '<S2>:1:20' */
    /* '<S2>:1:21' */
    /* '<S2>:1:22' */
    /* '<S2>:1:23' */
    /* '<S2>:1:24' */
    /* '<S2>:1:26' */
    P_times_CTransposed[0] = VIRTUAL_self_driving_stack_v2_B.Sum1[0];
    P_times_CTransposed[1] = VIRTUAL_self_driving_stack_v2_B.Sum1[1];

    /* '<S2>:1:27' */
    rtb_Time1 = 1.0;

    /* '<S2>:1:28' */
    switch ((int32_T)VIRTUAL_self_driving_stack_v_DW.state) {
     case 0:
      /* '<S2>:1:33' */
      rtb_Time1 = 0.0;
      if (VIRTUAL_self_driving_stack_v2_B.Clock > 10.0) {
        /* '<S2>:1:34' */
        VIRTUAL_self_driving_stack_v_DW.state = 1.0;
      }
      break;

     case 1:
      /* '<S2>:1:36' */
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&P_times_CTransposed[0]), _mm_set_pd(4.395,
        0.125));
      _mm_storeu_pd(&P_times_CTransposed_0[0], tmp_6);
      if (VIRTUAL_self_driving_stack_norm(P_times_CTransposed_0) < 0.35) {
        /* '<S2>:1:37' */
        /* '<S2>:1:38' */
        VIRTUAL_self_driving_stack_v_DW.state = 2.0;

        /* '<S2>:1:38' */
        VIRTUAL_self_driving_stack_v_DW.stop_timer =
          VIRTUAL_self_driving_stack_v2_B.Clock;
      }
      break;

     case 2:
      /* '<S2>:1:41' */
      rtb_Time1 = 0.0;

      /* '<S2>:1:42' */
      if (VIRTUAL_self_driving_stack_v2_B.Clock -
          VIRTUAL_self_driving_stack_v_DW.stop_timer > 3.0) {
        /* '<S2>:1:43' */
        VIRTUAL_self_driving_stack_v_DW.state = 3.0;
      }
      break;

     case 3:
      /* '<S2>:1:45' */
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&P_times_CTransposed[0]), _mm_set_pd(0.8,
        -0.905));
      _mm_storeu_pd(&P_times_CTransposed_0[0], tmp_6);
      if (VIRTUAL_self_driving_stack_norm(P_times_CTransposed_0) < 0.35) {
        /* '<S2>:1:46' */
        /* '<S2>:1:47' */
        VIRTUAL_self_driving_stack_v_DW.state = 4.0;

        /* '<S2>:1:47' */
        VIRTUAL_self_driving_stack_v_DW.stop_timer =
          VIRTUAL_self_driving_stack_v2_B.Clock;
      }
      break;

     case 4:
      /* '<S2>:1:50' */
      rtb_Time1 = 0.0;

      /* '<S2>:1:51' */
      if (VIRTUAL_self_driving_stack_v2_B.Clock -
          VIRTUAL_self_driving_stack_v_DW.stop_timer > 3.0) {
        /* '<S2>:1:52' */
        VIRTUAL_self_driving_stack_v_DW.state = 5.0;
      }
      break;

     case 5:
      /* '<S2>:1:54' */
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&P_times_CTransposed[0]), _mm_set_pd(-0.83,
        -1.205));
      _mm_storeu_pd(&P_times_CTransposed_0[0], tmp_6);
      if (VIRTUAL_self_driving_stack_norm(P_times_CTransposed_0) < 0.35) {
        /* '<S2>:1:55' */
        VIRTUAL_self_driving_stack_v_DW.state = 6.0;
      }
      break;

     case 6:
      /* '<S2>:1:57' */
      rtb_Time1 = 0.0;
      break;
    }

    if ((VIRTUAL_self_driving_stack_v2_B.Clock > 15.0) && (rtb_Time1 > 0.0)) {
      /* '<S2>:1:61' */
      if (VIRTUAL_self_driving_stack_v2_B.light_color == 1.0) {
        /* '<S2>:1:64' */
        /* '<S2>:1:65' */
        VIRTUAL_self_driving_stack_v_DW.red_light_frames++;
      } else if (VIRTUAL_self_driving_stack_v2_B.light_color == 3.0) {
        /* '<S2>:1:66' */
        /* '<S2>:1:67' */
        VIRTUAL_self_driving_stack_v_DW.red_light_frames = 0.0;
      } else if (VIRTUAL_self_driving_stack_v_DW.red_light_frames > 0.0) {
        /* '<S2>:1:69' */
        /* '<S2>:1:70' */
        VIRTUAL_self_driving_stack_v_DW.red_light_frames--;
      }

      if ((VIRTUAL_self_driving_stack_v_DW.red_light_frames > 30.0) &&
          (VIRTUAL_self_driving_stack_v_DW.red_light_frames < 2500.0)) {
        /* '<S2>:1:74' */
        /* '<S2>:1:75' */
        rtb_Time1 = 0.0;
      }

      if (VIRTUAL_self_driving_stack_v2_B.sign_type == 1.0) {
        /* '<S2>:1:81' */
        /* '<S2>:1:82' */
        VIRTUAL_self_driving_stack_v_DW.sign_frames++;
      } else if (VIRTUAL_self_driving_stack_v2_B.sign_type == 0.0) {
        /* '<S2>:1:83' */
        /* '<S2>:1:84' */
        VIRTUAL_self_driving_stack_v_DW.sign_frames = 0.0;

        /* '<S2>:1:85' */
        VIRTUAL_self_driving_stack_v_DW.sign_stopped = false;

        /* '<S2>:1:86' */
        VIRTUAL_self_driving_stack_v_DW.sign_stop_timer = 0.0;
      }

      if ((VIRTUAL_self_driving_stack_v_DW.sign_frames > 30.0) &&
          (!VIRTUAL_self_driving_stack_v_DW.sign_stopped)) {
        /* '<S2>:1:89' */
        if (VIRTUAL_self_driving_stack_v2_B.sign_size > 4000.0) {
          /* '<S2>:1:90' */
          /* '<S2>:1:91' */
          rtb_Time1 = 0.0;
          if (VIRTUAL_self_driving_stack_v_DW.sign_stop_timer == 0.0) {
            /* '<S2>:1:92' */
            /* '<S2>:1:93' */
            VIRTUAL_self_driving_stack_v_DW.sign_stop_timer =
              VIRTUAL_self_driving_stack_v2_B.Clock;
          }

          if (VIRTUAL_self_driving_stack_v2_B.Clock -
              VIRTUAL_self_driving_stack_v_DW.sign_stop_timer > 2.0) {
            /* '<S2>:1:95' */
            /* '<S2>:1:96' */
            VIRTUAL_self_driving_stack_v_DW.sign_stopped = true;

            /* '<S2>:1:97' */
            VIRTUAL_self_driving_stack_v_DW.sign_stop_timer = 0.0;

            /* '<S2>:1:98' */
            VIRTUAL_self_driving_stack_v_DW.sign_frames = 0.0;
          }
        } else {
          /* '<S2>:1:101' */
          rtb_Time1 = 0.3;
        }
      }

      if ((VIRTUAL_self_driving_stack_v2_B.sign_type == 2.0) ||
          (VIRTUAL_self_driving_stack_v2_B.sign_type == 3.0)) {
        /* '<S2>:1:106' */
        /* '<S2>:1:107' */
        rtb_Time1 = 0.4;
      }
    }

    VIRTUAL_self_driving_stack_v2_B.speed_scale = rtb_Time1;

    /* End of MATLAB Function: '<Root>/MATLAB Function' */
    /* SignalConversion generated from: '<S13>/HIL Write' */
    for (i = 0; i < 16; i++) {
      rtb_TmpSignalConversionAtHILWri[i] = false;
    }

    /* End of SignalConversion generated from: '<S13>/HIL Write' */

    /* Memory: '<S10>/Memory' */
    rtb_Time1 = VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput;

    /* Rounding: '<S19>/Floor' incorporates:
     *  Bias: '<S7>/look ahead bias'
     *  Gain: '<S19>/m->cm'
     *  Gain: '<S7>/Gain2'
     */
    VIRTUAL_self_driving_stack_v2_B.Floor = floor
      ((VIRTUAL_self_driving_stack_v2_P.Gain2_Gain * rtb_Time1 +
        VIRTUAL_self_driving_stack_v2_P.lookaheadbias_Bias) *
       VIRTUAL_self_driving_stack_v2_P.mcm_Gain);

    /* S-Function (time_block): '<S19>/Time' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/pathPlanner/Path 4  Look Ahead Generator/Time (time_block) */
    {
      t_error result;
      t_timeout current_time;
      t_timeout time_difference;
      result = timeout_get_high_resolution_time(&current_time);
      if (result == 0) {
        result = timeout_subtract(&time_difference, &current_time,
          &_high_resolution_start_time);
        rtb_Time = time_difference.seconds + time_difference.nanoseconds * 1e-9;
      }

      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    /* ManualSwitch: '<S19>/Manual Switch' */
    if (VIRTUAL_self_driving_stack_v2_P.ManualSwitch_CurrentSetting == 1) {
      /* ManualSwitch: '<S19>/Manual Switch' incorporates:
       *  Constant: '<S19>/Constant10'
       *  RelationalOperator: '<S19>/GreaterThan'
       */
      VIRTUAL_self_driving_stack_v2_B.ManualSwitch = (rtb_Time <
        VIRTUAL_self_driving_stack_v2_P.Constant10_Value);
    } else {
      /* ManualSwitch: '<S19>/Manual Switch' incorporates:
       *  Constant: '<S19>/Constant11'
       */
      VIRTUAL_self_driving_stack_v2_B.ManualSwitch =
        VIRTUAL_self_driving_stack_v2_P.Constant11_Value;
    }

    /* End of ManualSwitch: '<S19>/Manual Switch' */

    /* Memory: '<S19>/Memory' */
    VIRTUAL_self_driving_stack_v2_B.Memory =
      VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f;
  }

  /* MATLAB Function: '<S19>/Windowed Closest Point Locator *Feedback the location1' incorporates:
   *  Constant: '<S19>/Constant2'
   *  Constant: '<S19>/Constant3'
   *  Constant: '<S19>/Constant5'
   */
  VIRTUAL_self_driving_stack_v_DW.sfEvent_bh = VIRTUAL_self_driving_CALL_EVENT;

  /* MATLAB Function 'pathPlanner/Path 4  Look Ahead Generator/Windowed Closest Point Locator *Feedback the location1': '<S21>:1' */
  /* '<S21>:1:2' */
  S = 1.0E+6;

  /* '<S21>:1:3' */
  s = VIRTUAL_self_driving_stack_v2_B.Memory;

  /* '<S21>:1:4' */
  if (VIRTUAL_self_driving_stack_v2_B.ManualSwitch == 1.0) {
    /* '<S21>:1:6' */
    /* '<S21>:1:9' */
    rtb_poseRateCorrection = VIRTUAL_self_driving_stack_v2_B.Sum1[0];
    b = VIRTUAL_self_driving_stack_v2_B.Sum1[1];
    for (minmn = 0; minmn < 2263; minmn++) {
      /* '<S21>:1:10' */
      _mm_storeu_pd(&tmp_5[0], _mm_sub_pd(_mm_set_pd(b, rtb_poseRateCorrection),
        _mm_set_pd(VIRTUAL_self_driving_stack_v2_P.path_y4[minmn],
                   VIRTUAL_self_driving_stack_v2_P.path_x4[minmn])));
      d = tmp_5[0] * tmp_5[0] + tmp_5[1] * tmp_5[1];
      if (d < S) {
        /* '<S21>:1:11' */
        /* '<S21>:1:12' */
        S = d;

        /* '<S21>:1:13' */
        s = (real_T)minmn + 1.0;
      }
    }
  } else if (VIRTUAL_self_driving_stack_v2_B.Memory +
             VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d > 2263.0) {
    /* '<S21>:1:19' */
    b = VIRTUAL_self_driving_stack_v2_B.Memory -
      VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d;
    i = (int32_T)((1.0 - b) + 2263.0);

    /* '<S21>:1:22' */
    for (F_tmp_0 = 0; F_tmp_0 < i; F_tmp_0++) {
      rtb_poseRateCorrection = b + (real_T)F_tmp_0;

      /* '<S21>:1:23' */
      tmp_7 = (int32_T)rtb_poseRateCorrection - 1;
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_B.Sum1[0]),
                         _mm_set_pd
                         (VIRTUAL_self_driving_stack_v2_P.path_y4[tmp_7],
                          VIRTUAL_self_driving_stack_v2_P.path_x4[tmp_7]));
      _mm_storeu_pd(&tmp_5[0], tmp_6);
      d = tmp_5[0] * tmp_5[0] + tmp_5[1] * tmp_5[1];
      if (d < S) {
        /* '<S21>:1:24' */
        /* '<S21>:1:25' */
        S = d;

        /* '<S21>:1:26' */
        s = rtb_poseRateCorrection;
      }
    }

    F_tmp = (int32_T)((s + VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d) -
                      2263.0);

    /* '<S21>:1:30' */
    for (maxmn = 0; maxmn < F_tmp; maxmn++) {
      /* '<S21>:1:31' */
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_B.Sum1[0]),
                         _mm_set_pd
                         (VIRTUAL_self_driving_stack_v2_P.path_y4[maxmn],
                          VIRTUAL_self_driving_stack_v2_P.path_x4[maxmn]));
      _mm_storeu_pd(&tmp_5[0], tmp_6);
      d = tmp_5[0] * tmp_5[0] + tmp_5[1] * tmp_5[1];
      if (d < S) {
        /* '<S21>:1:32' */
        /* '<S21>:1:33' */
        S = d;

        /* '<S21>:1:34' */
        s = (real_T)maxmn + 1.0;
      }
    }
  } else if (VIRTUAL_self_driving_stack_v2_B.Memory -
             VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d < 1.0) {
    /* '<S21>:1:38' */
    b = (VIRTUAL_self_driving_stack_v2_B.Memory + 2263.0) -
      VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d;
    b_ix = (int32_T)((1.0 - b) + 2263.0);

    /* '<S21>:1:41' */
    for (maxmn = 0; maxmn < b_ix; maxmn++) {
      rtb_poseRateCorrection = b + (real_T)maxmn;

      /* '<S21>:1:42' */
      tmp_7 = (int32_T)rtb_poseRateCorrection - 1;
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_B.Sum1[0]),
                         _mm_set_pd
                         (VIRTUAL_self_driving_stack_v2_P.path_y4[tmp_7],
                          VIRTUAL_self_driving_stack_v2_P.path_x4[tmp_7]));
      _mm_storeu_pd(&tmp_5[0], tmp_6);
      d = tmp_5[0] * tmp_5[0] + tmp_5[1] * tmp_5[1];
      if (d < S) {
        /* '<S21>:1:43' */
        /* '<S21>:1:44' */
        S = d;

        /* '<S21>:1:45' */
        s = rtb_poseRateCorrection;
      }
    }

    b_ix = (int32_T)(s + VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d);

    /* '<S21>:1:49' */
    for (F_tmp = 0; F_tmp < b_ix; F_tmp++) {
      /* '<S21>:1:50' */
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_B.Sum1[0]),
                         _mm_set_pd
                         (VIRTUAL_self_driving_stack_v2_P.path_y4[F_tmp],
                          VIRTUAL_self_driving_stack_v2_P.path_x4[F_tmp]));
      _mm_storeu_pd(&tmp_5[0], tmp_6);
      d = tmp_5[0] * tmp_5[0] + tmp_5[1] * tmp_5[1];
      if (d < S) {
        /* '<S21>:1:51' */
        /* '<S21>:1:52' */
        S = d;

        /* '<S21>:1:53' */
        s = (real_T)F_tmp + 1.0;
      }
    }
  } else {
    b = VIRTUAL_self_driving_stack_v2_B.Memory -
      VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d;
    F_tmp = (int32_T)((VIRTUAL_self_driving_stack_v2_B.Memory +
                       VIRTUAL_self_driving_stack_v2_P.Constant5_Value_d) + (1.0
      - b));

    /* '<S21>:1:59' */
    for (F_tmp_0 = 0; F_tmp_0 < F_tmp; F_tmp_0++) {
      rtb_poseRateCorrection = b + (real_T)F_tmp_0;

      /* '<S21>:1:60' */
      tmp_7 = (int32_T)rtb_poseRateCorrection - 1;
      tmp_6 = _mm_sub_pd(_mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_B.Sum1[0]),
                         _mm_set_pd
                         (VIRTUAL_self_driving_stack_v2_P.path_y4[tmp_7],
                          VIRTUAL_self_driving_stack_v2_P.path_x4[tmp_7]));
      _mm_storeu_pd(&tmp_5[0], tmp_6);
      d = tmp_5[0] * tmp_5[0] + tmp_5[1] * tmp_5[1];
      if (d < S) {
        /* '<S21>:1:61' */
        /* '<S21>:1:62' */
        S = d;

        /* '<S21>:1:63' */
        s = rtb_poseRateCorrection;
      }
    }
  }

  /* '<S21>:1:69' */
  VIRTUAL_self_driving_stack_v2_B.distance = sqrt(S);
  VIRTUAL_self_driving_stack_v2_B.location = s;

  /* End of MATLAB Function: '<S19>/Windowed Closest Point Locator *Feedback the location1' */

  /* Bias: '<S19>/Bias3' incorporates:
   *  Constant: '<S19>/Constant1'
   *  Math: '<S19>/Mod'
   *  Sum: '<S19>/Sum'
   */
  S = rt_modd_snf(VIRTUAL_self_driving_stack_v2_B.Floor +
                  VIRTUAL_self_driving_stack_v2_B.location,
                  VIRTUAL_self_driving_stack_v2_P.Constant1_Value_ak) +
    VIRTUAL_self_driving_stack_v2_P.Bias3_Bias;

  /* Selector: '<S19>/Selector1' incorporates:
   *  Constant: '<S19>/Constant'
   */
  VIRTUAL_self_driving_stack_v2_B.Selector1 =
    VIRTUAL_self_driving_stack_v2_P.path_x4[(int32_T)S - 1];

  /* Selector: '<S19>/Selector2' incorporates:
   *  Constant: '<S19>/Constant4'
   *  Selector: '<S19>/Selector1'
   */
  VIRTUAL_self_driving_stack_v2_B.Selector2 =
    VIRTUAL_self_driving_stack_v2_P.path_y4[(int32_T)S - 1];
  if (tmp) {
    /* S-Function (time_block): '<S12>/Time' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/steeringCommander/Time (time_block) */
    {
      t_error result;
      t_timeout current_time;
      t_timeout time_difference;
      result = timeout_get_high_resolution_time(&current_time);
      if (result == 0) {
        result = timeout_subtract(&time_difference, &current_time,
          &_high_resolution_start_time);
        rtb_Gain_k = time_difference.seconds + time_difference.nanoseconds *
          1e-9;
      }

      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    /* RelationalOperator: '<S52>/Compare' incorporates:
     *  Constant: '<S52>/Constant'
     */
    VIRTUAL_self_driving_stack_v2_B.Compare = (rtb_Gain_k >
      VIRTUAL_self_driving_stack_v2_P.Initialization_Time + 1.0);

    /* Outputs for Enabled SubSystem: '<S12>/Steering Based on LiDAR' incorporates:
     *  EnablePort: '<S55>/Enable'
     */
    if (tmp_0) {
      if (VIRTUAL_self_driving_stack_v2_B.Compare) {
        if (!VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_MODE) {
          (void) memset(&(VIRTUAL_self_driving_stack_XDis.GyroFilter_CSTATE), 0,
                        1*sizeof(boolean_T));
          VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_MODE = true;
        }
      } else {
        if (VIRTUAL_self_driving_stack_v_M->Timing.t[1] == rtmGetTStart
            (VIRTUAL_self_driving_stack_v_M)) {
          (void) memset(&(VIRTUAL_self_driving_stack_XDis.GyroFilter_CSTATE), 1,
                        1*sizeof(boolean_T));
        }

        if (VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_MODE) {
          (void) memset(&(VIRTUAL_self_driving_stack_XDis.GyroFilter_CSTATE), 1,
                        1*sizeof(boolean_T));

          /* Disable for If: '<S55>/If' */
          rtsiSetBlockStateForSolverChangedAtMajorStep
            (&VIRTUAL_self_driving_stack_v_M->solverInfo, true);
          VIRTUAL_self_driving_stack_v_DW.If_ActiveSubsystem = -1;
          VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_MODE = false;
        }
      }
    }

    /* End of Outputs for SubSystem: '<S12>/Steering Based on LiDAR' */
  }

  /* Outputs for Enabled SubSystem: '<S12>/Steering Based on LiDAR' incorporates:
   *  EnablePort: '<S55>/Enable'
   */
  if (VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_MODE) {
    /* Gain: '<S55>/D' incorporates:
     *  TransferFcn: '<S55>/Gyro Filter'
     */
    rtb_poseRateCorrection = VIRTUAL_self_driving_stack_v2_P.GyroFilter_C *
      VIRTUAL_self_driving_stack_v2_X.GyroFilter_CSTATE *
      VIRTUAL_self_driving_stack_v2_P.steering_Kd;

    /* Sum: '<S55>/Sum' */
    tmp_6 = _mm_sub_pd(_mm_set_pd(VIRTUAL_self_driving_stack_v2_B.Selector2,
      VIRTUAL_self_driving_stack_v2_B.Selector1), _mm_loadu_pd
                       (&VIRTUAL_self_driving_stack_v2_B.Sum1[0]));
    _mm_storeu_pd(&P_times_CTransposed[0], tmp_6);

    /* Sum: '<S55>/Sum3' incorporates:
     *  Trigonometry: '<S55>/Trigonometric Function'
     */
    rtb_steering_angle = rt_atan2d_snf(P_times_CTransposed[1],
      P_times_CTransposed[0]) - VIRTUAL_self_driving_stack_v2_B.ManualSwitch1;

    /* If: '<S55>/If' */
    rtPrevAction = VIRTUAL_self_driving_stack_v_DW.If_ActiveSubsystem;
    if (tmp_0) {
      if (rtb_steering_angle < -3.1415926535897931) {
        rtAction = 0;
      } else if (rtb_steering_angle > 3.1415926535897931) {
        rtAction = 1;
      } else {
        rtAction = 2;
      }

      VIRTUAL_self_driving_stack_v_DW.If_ActiveSubsystem = rtAction;
    } else {
      rtAction = VIRTUAL_self_driving_stack_v_DW.If_ActiveSubsystem;
    }

    if (rtPrevAction != rtAction) {
      rtsiSetBlockStateForSolverChangedAtMajorStep
        (&VIRTUAL_self_driving_stack_v_M->solverInfo, true);
    }

    switch (rtAction) {
     case 0:
      /* Outputs for IfAction SubSystem: '<S55>/If Action Subsystem' incorporates:
       *  ActionPort: '<S57>/Action Port'
       */
      VIRTUAL_s_IfActionSubsystem(rtb_steering_angle, &rtb_wrappedoutput,
        &VIRTUAL_self_driving_stack_v2_P.IfActionSubsystem);
      if (tmp_0) {
        srUpdateBC
          (VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem.IfActionSubsystem_SubsysRanBC);
      }

      /* End of Outputs for SubSystem: '<S55>/If Action Subsystem' */
      break;

     case 1:
      /* Outputs for IfAction SubSystem: '<S55>/If Action Subsystem1' incorporates:
       *  ActionPort: '<S58>/Action Port'
       */
      VIRTUAL_s_IfActionSubsystem(rtb_steering_angle, &rtb_wrappedoutput,
        &VIRTUAL_self_driving_stack_v2_P.IfActionSubsystem1);
      if (tmp_0) {
        srUpdateBC
          (VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem1.IfActionSubsystem_SubsysRanBC);
      }

      /* End of Outputs for SubSystem: '<S55>/If Action Subsystem1' */
      break;

     default:
      /* Outputs for IfAction SubSystem: '<S55>/If Action Subsystem2' incorporates:
       *  ActionPort: '<S59>/Action Port'
       */
      VIRTUAL_s_IfActionSubsystem(rtb_steering_angle, &rtb_wrappedoutput,
        &VIRTUAL_self_driving_stack_v2_P.IfActionSubsystem2);
      if (tmp_0) {
        srUpdateBC
          (VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem2.IfActionSubsystem_SubsysRanBC);
      }

      /* End of Outputs for SubSystem: '<S55>/If Action Subsystem2' */
      break;
    }

    /* Sum: '<S55>/Sum1' incorporates:
     *  Gain: '<S55>/P'
     */
    VIRTUAL_self_driving_stack_v2_B.Sum1_b =
      VIRTUAL_self_driving_stack_v2_P.steering_Kp * rtb_wrappedoutput -
      rtb_poseRateCorrection;
    if (tmp_0) {
      srUpdateBC(VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_SubsysRanB);
    }
  }

  /* End of Outputs for SubSystem: '<S12>/Steering Based on LiDAR' */
  if (tmp) {
    /* Memory: '<S53>/Memory1' */
    rtb_Gain_k = VIRTUAL_self_driving_stack_v_DW.Memory1_PreviousInput_k;

    /* RelationalOperator: '<S53>/Equal1' incorporates:
     *  Constant: '<S7>/desiredPath'
     */
    rtb_Equal1 = (rtb_Gain_k !=
                  VIRTUAL_self_driving_stack_v2_P.desiredPath_Value);

    /* S-Function (time_block): '<S53>/Time1' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/steeringCommander/Cross Track Controller/Time1 (time_block) */
    {
      t_error result;
      t_timeout current_time;
      t_timeout time_difference;
      result = timeout_get_high_resolution_time(&current_time);
      if (result == 0) {
        result = timeout_subtract(&time_difference, &current_time,
          &_high_resolution_start_time);
        rtb_Gain_k = time_difference.seconds + time_difference.nanoseconds *
          1e-9;
      }

      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    /* Logic: '<S53>/OR' incorporates:
     *  Constant: '<S53>/Constant'
     *  Constant: '<S53>/Constant6'
     *  RelationalOperator: '<S53>/Equal'
     *  RelationalOperator: '<S53>/GreaterThan'
     */
    VIRTUAL_self_driving_stack_v2_B.OR = ((rtb_Time1 ==
      VIRTUAL_self_driving_stack_v2_P.Constant_Value_er) || rtb_Equal1 ||
      (rtb_Gain_k < VIRTUAL_self_driving_stack_v2_P.Initialization_Time + 1.0));
  }

  /* Integrator: '<S53>/Integrator' */
  /* Limited  Integrator  */
  if (tmp_0) {
    rtb_Equal1 = (((VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE_h ==
                    POS_ZCSIG) != (int32_T)VIRTUAL_self_driving_stack_v2_B.OR) &&
                  (VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE_h !=
                   UNINITIALIZED_ZCSIG));
    VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE_h =
      VIRTUAL_self_driving_stack_v2_B.OR;

    /* evaluate zero-crossings and the level of the reset signal */
    if (rtb_Equal1 || VIRTUAL_self_driving_stack_v2_B.OR) {
      VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h =
        VIRTUAL_self_driving_stack_v2_P.Integrator_IC_o;
    }
  }

  if (VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h >=
      VIRTUAL_self_driving_stack_v2_P.Integrator_UpperSat) {
    VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h =
      VIRTUAL_self_driving_stack_v2_P.Integrator_UpperSat;
  } else if (VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h <=
             VIRTUAL_self_driving_stack_v2_P.Integrator_LowerSat) {
    VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h =
      VIRTUAL_self_driving_stack_v2_P.Integrator_LowerSat;
  }

  /* Integrator: '<S53>/Integrator' */
  VIRTUAL_self_driving_stack_v2_B.Integrator =
    VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h;

  /* Selector: '<S19>/Selector4' incorporates:
   *  Bias: '<S19>/indexBias'
   *  Constant: '<S19>/Constant6'
   *  Constant: '<S19>/Constant7'
   *  Constant: '<S19>/Constant8'
   *  Math: '<S19>/Mod1'
   *  Selector: '<S19>/Selector3'
   *  Sum: '<S53>/Sum'
   */
  tmp_7 = (int32_T)(rt_modd_snf(VIRTUAL_self_driving_stack_v2_B.location,
    VIRTUAL_self_driving_stack_v2_P.Constant7_Value) +
                    VIRTUAL_self_driving_stack_v2_P.indexBias_Bias) - 1;
  tmp_6 = _mm_sub_pd(_mm_set_pd(VIRTUAL_self_driving_stack_v2_P.path_y4[tmp_7],
    VIRTUAL_self_driving_stack_v2_P.path_x4[tmp_7]), _mm_loadu_pd
                     (&VIRTUAL_self_driving_stack_v2_B.Sum1[0]));

  /* Sum: '<S53>/Sum' */
  _mm_storeu_pd(&P_times_CTransposed[0], tmp_6);

  /* Sum: '<S56>/Sum3' incorporates:
   *  Product: '<S56>/Product3'
   *  Product: '<S56>/Product6'
   *  Trigonometry: '<S53>/Cos'
   *  Trigonometry: '<S53>/Cos1'
   */
  S = cos(VIRTUAL_self_driving_stack_v2_B.ManualSwitch1) * P_times_CTransposed[1]
    - sin(VIRTUAL_self_driving_stack_v2_B.ManualSwitch1) * P_times_CTransposed[0];

  /* Signum: '<S53>/Sign' */
  if (rtIsNaN(S)) {
    S = (rtNaN);
  } else if (S < 0.0) {
    S = -1.0;
  } else {
    S = (S > 0.0);
  }

  /* Product: '<S53>/Product3' incorporates:
   *  Signum: '<S53>/Sign'
   */
  rtb_poseRateCorrection = S * VIRTUAL_self_driving_stack_v2_B.distance;

  /* Integrator: '<S53>/Integrator1' */
  /* Limited  Integrator  */
  if (tmp_0) {
    rtb_Equal1 = (((VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE ==
                    POS_ZCSIG) != (int32_T)VIRTUAL_self_driving_stack_v2_B.OR) &&
                  (VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE !=
                   UNINITIALIZED_ZCSIG));
    VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE =
      VIRTUAL_self_driving_stack_v2_B.OR;

    /* evaluate zero-crossings and the level of the reset signal */
    if (rtb_Equal1 || VIRTUAL_self_driving_stack_v2_B.OR) {
      VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE =
        VIRTUAL_self_driving_stack_v2_P.Integrator1_IC;
    }
  }

  if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE >=
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat) {
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat;
  } else if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE <=
             VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat) {
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat;
  }

  /* Product: '<S53>/Product' incorporates:
   *  Gain: '<S53>/Gain3'
   *  Integrator: '<S53>/Integrator1'
   */
  S = VIRTUAL_self_driving_stack_v2_P.Gain3_Gain * rtb_poseRateCorrection *
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE;

  /* Saturate: '<S53>/Saturation1' */
  if (S > VIRTUAL_self_driving_stack_v2_P.Saturation1_UpperSat) {
    /* Saturate: '<S53>/Saturation1' */
    VIRTUAL_self_driving_stack_v2_B.Saturation1 =
      VIRTUAL_self_driving_stack_v2_P.Saturation1_UpperSat;
  } else if (S < VIRTUAL_self_driving_stack_v2_P.Saturation1_LowerSat) {
    /* Saturate: '<S53>/Saturation1' */
    VIRTUAL_self_driving_stack_v2_B.Saturation1 =
      VIRTUAL_self_driving_stack_v2_P.Saturation1_LowerSat;
  } else {
    /* Saturate: '<S53>/Saturation1' */
    VIRTUAL_self_driving_stack_v2_B.Saturation1 = S;
  }

  /* End of Saturate: '<S53>/Saturation1' */

  /* Sum: '<S53>/Sum2' */
  VIRTUAL_self_driving_stack_v2_B.Sum2 =
    VIRTUAL_self_driving_stack_v2_B.Integrator +
    VIRTUAL_self_driving_stack_v2_B.Saturation1;

  /* Sum: '<S12>/Sum' */
  VIRTUAL_self_driving_stack_v2_B.final = VIRTUAL_self_driving_stack_v2_B.Sum1_b
    + VIRTUAL_self_driving_stack_v2_B.Sum2;

  /* Integrator: '<S54>/Integrator1' */
  if (VIRTUAL_self_driving_stack_v_DW.Integrator1_DWORK1) {
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_g =
      VIRTUAL_self_driving_stack_v2_B.final;
  }

  /* Integrator: '<S54>/Integrator1' */
  VIRTUAL_self_driving_stack_v2_B.Integrator1 =
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_g;

  /* Saturate: '<S12>/Saturation' */
  if (VIRTUAL_self_driving_stack_v2_B.Integrator1 >
      VIRTUAL_self_driving_stack_v2_P.Saturation_UpperSat) {
    /* Saturate: '<S12>/Saturation' */
    VIRTUAL_self_driving_stack_v2_B.Saturation =
      VIRTUAL_self_driving_stack_v2_P.Saturation_UpperSat;
  } else if (VIRTUAL_self_driving_stack_v2_B.Integrator1 <
             VIRTUAL_self_driving_stack_v2_P.Saturation_LowerSat) {
    /* Saturate: '<S12>/Saturation' */
    VIRTUAL_self_driving_stack_v2_B.Saturation =
      VIRTUAL_self_driving_stack_v2_P.Saturation_LowerSat;
  } else {
    /* Saturate: '<S12>/Saturation' */
    VIRTUAL_self_driving_stack_v2_B.Saturation =
      VIRTUAL_self_driving_stack_v2_B.Integrator1;
  }

  /* End of Saturate: '<S12>/Saturation' */

  /* Gain: '<S13>/Gain' incorporates:
   *  Bias: '<S13>/Steering Bias'
   */
  S = (VIRTUAL_self_driving_stack_v2_B.Saturation +
       VIRTUAL_self_driving_stack_v2_P.SteeringBias_Bias) *
    VIRTUAL_self_driving_stack_v2_P.Gain_Gain;

  /* Saturate: '<S13>/steering sat' */
  if (S > VIRTUAL_self_driving_stack_v2_P.steeringsat_UpperSat) {
    /* Saturate: '<S13>/steering sat' */
    VIRTUAL_self_driving_stack_v2_B.steeringsat =
      VIRTUAL_self_driving_stack_v2_P.steeringsat_UpperSat;
  } else if (S < VIRTUAL_self_driving_stack_v2_P.steeringsat_LowerSat) {
    /* Saturate: '<S13>/steering sat' */
    VIRTUAL_self_driving_stack_v2_B.steeringsat =
      VIRTUAL_self_driving_stack_v2_P.steeringsat_LowerSat;
  } else {
    /* Saturate: '<S13>/steering sat' */
    VIRTUAL_self_driving_stack_v2_B.steeringsat = S;
  }

  /* End of Saturate: '<S13>/steering sat' */
  if (tmp) {
    /* SampleTimeMath: '<S31>/sample time'
     *
     * About '<S31>/sample time':
     *  y = K where K = ( w * Ts )
     *   */
    rtb_sampletime = VIRTUAL_self_driving_stack_v2_P.sampletime_WtEt;

    /* Product: '<S31>/delta rise limit' incorporates:
     *  Constant: '<S10>/accLimit'
     *  SampleTimeMath: '<S31>/sample time'
     *
     * About '<S31>/sample time':
     *  y = K where K = ( w * Ts )
     *   */
    rtb_Gain_k = VIRTUAL_self_driving_stack_v2_P.accLimit_Value_f *
      VIRTUAL_self_driving_stack_v2_P.sampletime_WtEt;

    /* ManualSwitch: '<S10>/Manual Switch' incorporates:
     *  Constant: '<S10>/Constant'
     */
    if (VIRTUAL_self_driving_stack_v2_P.ManualSwitch_CurrentSetting_b == 1) {
      S = VIRTUAL_self_driving_stack_v2_P.Constant_Value_a;
    } else {
      S = 0.0;
    }

    /* End of ManualSwitch: '<S10>/Manual Switch' */

    /* Product: '<Root>/Product1' incorporates:
     *  Constant: '<Root>/targetSpeed'
     */
    s = VIRTUAL_self_driving_stack_v2_P.targetSpeed_Value *
      VIRTUAL_self_driving_stack_v2_B.speed_scale;

    /* MATLAB Function: '<S32>/MATLAB Function' incorporates:
     *  Constant: '<S32>/Constant'
     *  Constant: '<S32>/Constant2'
     */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_b = VIRTUAL_self_driving_CALL_EVENT;

    /* MATLAB Function 'speedController/realsenseObstacleDetectionSpeedAdjust/MATLAB Function': '<S36>:1' */
    /* '<S36>:1:3' */
    if (S < VIRTUAL_self_driving_stack_v2_P.Constant_Value_j) {
      /* '<S36>:1:5' */
      /* '<S36>:1:6' */
      if (s > 0.0) {
        /* '<S36>:1:15' */
        /* '<S36>:1:16' */
        s = 0.0;
      } else if (s < -1.0) {
        /* '<S36>:1:17' */
        /* '<S36>:1:18' */
        s = -1.0;
      } else {
        /* '<S36>:1:20' */
      }
    } else if (S < VIRTUAL_self_driving_stack_v2_P.Constant2_Value) {
      /* '<S36>:1:8' */
      /* '<S36>:1:9' */
      s = s / (VIRTUAL_self_driving_stack_v2_P.Constant2_Value -
               VIRTUAL_self_driving_stack_v2_P.Constant_Value_j) * S - s /
        (VIRTUAL_self_driving_stack_v2_P.Constant2_Value -
         VIRTUAL_self_driving_stack_v2_P.Constant_Value_j) *
        VIRTUAL_self_driving_stack_v2_P.Constant_Value_j;
    }

    /* End of MATLAB Function: '<S32>/MATLAB Function' */

    /* Saturate: '<S10>/motorSat' */
    if (s > VIRTUAL_self_driving_stack_v2_P.motorSat_UpperSat) {
      /* Saturate: '<S10>/motorSat' */
      VIRTUAL_self_driving_stack_v2_B.motorSat =
        VIRTUAL_self_driving_stack_v2_P.motorSat_UpperSat;
    } else if (s < VIRTUAL_self_driving_stack_v2_P.motorSat_LowerSat) {
      /* Saturate: '<S10>/motorSat' */
      VIRTUAL_self_driving_stack_v2_B.motorSat =
        VIRTUAL_self_driving_stack_v2_P.motorSat_LowerSat;
    } else {
      /* Saturate: '<S10>/motorSat' */
      VIRTUAL_self_driving_stack_v2_B.motorSat = s;
    }

    /* End of Saturate: '<S10>/motorSat' */

    /* RateTransition generated from: '<Root>/Sum' */
    if (VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_2) {
      /* RateTransition generated from: '<Root>/Sum' */
      VIRTUAL_self_driving_stack_v2_B.steer_correction =
        VIRTUAL_self_driving_stack_v_DW.steer_correction_Buffer0;
    }

    /* End of RateTransition generated from: '<Root>/Sum' */
  }

  /* Sum: '<Root>/Sum' */
  S = VIRTUAL_self_driving_stack_v2_B.Saturation +
    VIRTUAL_self_driving_stack_v2_B.steer_correction;

  /* Saturate: '<S10>/steeringSat' */
  if (S > VIRTUAL_self_driving_stack_v2_P.steeringSat_UpperSat) {
    S = VIRTUAL_self_driving_stack_v2_P.steeringSat_UpperSat;
  } else if (S < VIRTUAL_self_driving_stack_v2_P.steeringSat_LowerSat) {
    S = VIRTUAL_self_driving_stack_v2_P.steeringSat_LowerSat;
  }

  /* Trigonometry: '<S34>/Cos' incorporates:
   *  Saturate: '<S10>/steeringSat'
   */
  S = cos(S);

  /* Math: '<S34>/Square' incorporates:
   *  Constant: '<S10>/turningAttenuation'
   */
  if ((S < 0.0) && (VIRTUAL_self_driving_stack_v2_P.turningAttenuation_Value >
                    floor
                    (VIRTUAL_self_driving_stack_v2_P.turningAttenuation_Value)))
  {
    S = -rt_powd_snf(-S,
                     VIRTUAL_self_driving_stack_v2_P.turningAttenuation_Value);
  } else {
    S = rt_powd_snf(S, VIRTUAL_self_driving_stack_v2_P.turningAttenuation_Value);
  }

  /* Saturate: '<S34>/attenuationLimits' incorporates:
   *  Math: '<S34>/Square'
   */
  if (S > VIRTUAL_self_driving_stack_v2_P.attenuationLimits_UpperSat) {
    S = VIRTUAL_self_driving_stack_v2_P.attenuationLimits_UpperSat;
  } else if (S < VIRTUAL_self_driving_stack_v2_P.attenuationLimits_LowerSat) {
    S = VIRTUAL_self_driving_stack_v2_P.attenuationLimits_LowerSat;
  }

  /* Product: '<S34>/Product' incorporates:
   *  Saturate: '<S34>/attenuationLimits'
   */
  VIRTUAL_self_driving_stack_v2_B.Product =
    VIRTUAL_self_driving_stack_v2_B.motorSat * S;
  if (tmp) {
    /* Delay: '<S31>/Delay' incorporates:
     *  ZeroOrderHold: '<S31>/Zero-Order Hold'
     */
    if (VIRTUAL_self_driving_stack_v_DW.icLoad) {
      VIRTUAL_self_driving_stack_v_DW.Delay_DSTATE =
        VIRTUAL_self_driving_stack_v2_B.Product;
    }

    /* Sum: '<S31>/Difference Inputs1' incorporates:
     *  Delay: '<S31>/Delay'
     *  ZeroOrderHold: '<S31>/Zero-Order Hold'
     */
    S = VIRTUAL_self_driving_stack_v2_B.Product -
      VIRTUAL_self_driving_stack_v_DW.Delay_DSTATE;

    /* Switch: '<S35>/Switch2' incorporates:
     *  RelationalOperator: '<S35>/LowerRelop1'
     */
    if (!(S > rtb_Gain_k)) {
      /* Product: '<S31>/delta fall limit' incorporates:
       *  Constant: '<S10>/-accLimit'
       */
      rtb_Gain_k = rtb_sampletime *
        VIRTUAL_self_driving_stack_v2_P.accLimit_Value;

      /* Switch: '<S35>/Switch' incorporates:
       *  RelationalOperator: '<S35>/UpperRelop'
       */
      if (!(S < rtb_Gain_k)) {
        rtb_Gain_k = S;
      }

      /* End of Switch: '<S35>/Switch' */
    }

    /* End of Switch: '<S35>/Switch2' */

    /* Sum: '<S31>/Difference Inputs2' incorporates:
     *  Delay: '<S31>/Delay'
     */
    VIRTUAL_self_driving_stack_v2_B.DifferenceInputs2 = rtb_Gain_k +
      VIRTUAL_self_driving_stack_v_DW.Delay_DSTATE;

    /* Saturate: '<S33>/command saturation' */
    if (VIRTUAL_self_driving_stack_v2_B.DifferenceInputs2 >
        VIRTUAL_self_driving_stack_v2_P.commandsaturation_UpperSat) {
      rtb_Gain_k = VIRTUAL_self_driving_stack_v2_P.commandsaturation_UpperSat;
    } else if (VIRTUAL_self_driving_stack_v2_B.DifferenceInputs2 <
               VIRTUAL_self_driving_stack_v2_P.commandsaturation_LowerSat) {
      rtb_Gain_k = VIRTUAL_self_driving_stack_v2_P.commandsaturation_LowerSat;
    } else {
      rtb_Gain_k = VIRTUAL_self_driving_stack_v2_B.DifferenceInputs2;
    }

    /* End of Saturate: '<S33>/command saturation' */

    /* RateTransition generated from: '<S6>/Product' */
    if (VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_4) {
      /* RateTransition generated from: '<S6>/Product' */
      VIRTUAL_self_driving_stack_v2_B.TmpRTBAtProductInport1 =
        VIRTUAL_self_driving_stack_v_DW.TmpRTBAtProductInport1_Buffer0;
    }

    /* End of RateTransition generated from: '<S6>/Product' */

    /* S-Function (time_block): '<S6>/Time1' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarLocalization/Time1 (time_block) */
    {
      t_error result;
      t_timeout current_time;
      t_timeout time_difference;
      result = timeout_get_high_resolution_time(&current_time);
      if (result == 0) {
        result = timeout_subtract(&time_difference, &current_time,
          &_high_resolution_start_time);
        rtb_Time1 = time_difference.seconds + time_difference.nanoseconds * 1e-9;
      }

      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    /* Product: '<S6>/Product' incorporates:
     *  Constant: '<S6>/Constant6'
     *  RelationalOperator: '<S6>/GreaterThan'
     */
    VIRTUAL_self_driving_stack_v2_B.Product_o = (real_T)(rtb_Time1 >
      VIRTUAL_self_driving_stack_v2_P.Initialization_Time) *
      VIRTUAL_self_driving_stack_v2_B.TmpRTBAtProductInport1;

    /* Product: '<S33>/Multiply1' */
    VIRTUAL_self_driving_stack_v2_B.desired = rtb_Gain_k *
      VIRTUAL_self_driving_stack_v2_B.Product_o;

    /* Gain: '<S33>/Kff  (% // m//s)' */
    VIRTUAL_self_driving_stack_v2_B.Kffms =
      VIRTUAL_self_driving_stack_v2_P.Kffms_Gain *
      VIRTUAL_self_driving_stack_v2_B.desired;

    /* Product: '<S33>/Multiply' */
    VIRTUAL_self_driving_stack_v2_B.measured =
      VIRTUAL_self_driving_stack_v2_B.wheelspeedms *
      VIRTUAL_self_driving_stack_v2_B.Product_o;

    /* Sum: '<S33>/Sum' */
    rtb_Gain_k = VIRTUAL_self_driving_stack_v2_B.desired -
      VIRTUAL_self_driving_stack_v2_B.measured;

    /* Gain: '<S33>/Kp (% // m//s)' */
    VIRTUAL_self_driving_stack_v2_B.Kpms =
      VIRTUAL_self_driving_stack_v2_P.Kpms_Gain * rtb_Gain_k;

    /* RelationalOperator: '<S37>/Compare' incorporates:
     *  Constant: '<S37>/Constant'
     */
    VIRTUAL_self_driving_stack_v2_B.Compare_e =
      (VIRTUAL_self_driving_stack_v2_B.desired ==
       VIRTUAL_self_driving_stack_v2_P.Constant_Value_k);
  }

  /* Integrator: '<S33>/Integrator1' */
  /* Limited  Integrator  */
  if (tmp_0) {
    rtb_Equal1 = (((VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE_c ==
                    POS_ZCSIG) != (int32_T)
                   VIRTUAL_self_driving_stack_v2_B.Compare_e) &&
                  (VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE_c !=
                   UNINITIALIZED_ZCSIG));
    VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE_c =
      VIRTUAL_self_driving_stack_v2_B.Compare_e;

    /* evaluate zero-crossings */
    if (rtb_Equal1) {
      VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k =
        VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_f;
    }
  }

  if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k >=
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_l) {
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_l;
  } else if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k <=
             VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_d) {
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_d;
  }

  /* Product: '<S33>/Multiply2' incorporates:
   *  Integrator: '<S33>/Integrator1'
   *  Sum: '<S33>/Add'
   *  Sum: '<S33>/Add1'
   */
  S = ((VIRTUAL_self_driving_stack_v2_B.Kpms +
        VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k) +
       VIRTUAL_self_driving_stack_v2_B.Kffms) *
    VIRTUAL_self_driving_stack_v2_B.Product_o;

  /* Saturate: '<S13>/motor sat' */
  if (S > VIRTUAL_self_driving_stack_v2_P.motorsat_UpperSat) {
    /* Saturate: '<S13>/motor sat' */
    VIRTUAL_self_driving_stack_v2_B.motorsat =
      VIRTUAL_self_driving_stack_v2_P.motorsat_UpperSat;
  } else if (S < VIRTUAL_self_driving_stack_v2_P.motorsat_LowerSat) {
    /* Saturate: '<S13>/motor sat' */
    VIRTUAL_self_driving_stack_v2_B.motorsat =
      VIRTUAL_self_driving_stack_v2_P.motorsat_LowerSat;
  } else {
    /* Saturate: '<S13>/motor sat' */
    VIRTUAL_self_driving_stack_v2_B.motorsat = S;
  }

  /* End of Saturate: '<S13>/motor sat' */
  if (tmp) {
    /* SignalConversion generated from: '<S13>/HIL Write' */
    P_times_CTransposed[0] = VIRTUAL_self_driving_stack_v2_B.steeringsat;
    P_times_CTransposed[1] = VIRTUAL_self_driving_stack_v2_B.motorsat;

    /* S-Function (hil_write_block): '<S13>/HIL Write' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/writeToQCarDAC/HIL Write (hil_write_block) */
    {
      t_error result;
      result = hil_write(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
                         NULL, 0U,
                         NULL, 0U,
                         VIRTUAL_self_driving_stack_v2_P.HILWrite_digital_channels,
                         16U,
                         VIRTUAL_self_driving_stack_v2_P.HILWrite_other_channels,
                         2U,
                         NULL,
                         NULL,
                         (t_boolean *) &rtb_TmpSignalConversionAtHILWri[0],
                         &P_times_CTransposed[0]
                         );
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      }
    }

    /* RateTransition: '<S6>/Rate Transition1' incorporates:
     *  Memory: '<S6>/Memory'
     */
    if (VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_4) {
      VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer[0] =
        VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[0];
      VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer[1] =
        VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[1];
      VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer[2] =
        VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[2];
    }

    /* End of RateTransition: '<S6>/Rate Transition1' */

    /* RateTransition: '<S20>/Rate Transition1' */
    if (VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_5) {
      VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_m[0] =
        VIRTUAL_self_driving_stack_v2_B.Selector1;
      VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_m[1] =
        VIRTUAL_self_driving_stack_v2_B.Selector2;

      /* RateTransition: '<S20>/Rate Transition2' */
      VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer[0] =
        VIRTUAL_self_driving_stack_v2_B.Sum1[0];
      VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer[1] =
        VIRTUAL_self_driving_stack_v2_B.Sum1[1];
    }

    /* End of RateTransition: '<S20>/Rate Transition1' */
    /* Gain: '<S33>/Ki (% // m)  ' */
    VIRTUAL_self_driving_stack_v2_B.Kim =
      VIRTUAL_self_driving_stack_v2_P.Kim_Gain * rtb_Gain_k;
  }

  /* Bias: '<S42>/Bias1' incorporates:
   *  Bias: '<S42>/Bias'
   *  Constant: '<S42>/Constant1'
   *  Math: '<S42>/Mod'
   */
  VIRTUAL_self_driving_stack_v2_B.Bias1_e = rt_modd_snf(rtb_Integrator1_idx_2 +
    VIRTUAL_self_driving_stack_v2_P.Bias_Bias_a,
    VIRTUAL_self_driving_stack_v2_P.Constant1_Value_g) +
    VIRTUAL_self_driving_stack_v2_P.Bias1_Bias_h;
  if (tmp) {
    /* Gain: '<S38>/m_to_mm1' */
    tmp_6 = _mm_mul_pd(_mm_set1_pd(VIRTUAL_self_driving_stack_v2_P.m_to_mm1_Gain),
                       _mm_loadu_pd
                       (&VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0]));

    /* Gain: '<S38>/m_to_mm1' */
    _mm_storeu_pd(&P_times_CTransposed[0], tmp_6);

    /* RateTransition: '<S38>/RT' incorporates:
     *  Gain: '<S47>/Gain'
     */
    VIRTUAL_self_driving_stack_v2_B.RT_a[2] =
      VIRTUAL_self_driving_stack_v2_P.Gain_Gain_p *
      VIRTUAL_self_driving_stack_v2_B.CalibrationBias[2];
    VIRTUAL_self_driving_stack_v2_B.RT_a[0] = P_times_CTransposed[0];
    VIRTUAL_self_driving_stack_v2_B.RT_a[1] = P_times_CTransposed[1];

    /* Selector: '<S38>/LiDAR' incorporates:
     *  Constant: '<S38>/Constant'
     */
    VIRTUAL_self_driving_stack_v2_B.LiDAR =
      VIRTUAL_self_driving_stack_v2_B.RT_a[(int32_T)
      VIRTUAL_self_driving_stack_v2_P.Constant_Value_k1 - 1];
  }

  /* Gain: '<S38>/m_to_mm' */
  VIRTUAL_self_driving_stack_v2_B.m_to_mm[0] =
    VIRTUAL_self_driving_stack_v2_P.m_to_mm_Gain * rtb_Integrator1_idx_0;
  VIRTUAL_self_driving_stack_v2_B.m_to_mm[1] =
    VIRTUAL_self_driving_stack_v2_P.m_to_mm_Gain * rtb_Integrator1_idx_1;

  /* Gain: '<S46>/Gain' */
  VIRTUAL_self_driving_stack_v2_B.Gain =
    VIRTUAL_self_driving_stack_v2_P.Gain_Gain_b * rtb_Integrator1_idx_2;

  /* Gain: '<S48>/Gain' */
  VIRTUAL_self_driving_stack_v2_B.Gain_l =
    VIRTUAL_self_driving_stack_v2_P.Gain_Gain_n * rtb_Subtract_idx_2;

  /* SignalConversion generated from: '<S38>/Kalman' */
  y_data[2] = VIRTUAL_self_driving_stack_v2_B.Gain;

  /* Gain: '<S38>/m_to_mm2' */
  rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.m_to_mm2_Gain * rtb_Subtract_idx_0;
  VIRTUAL_self_driving_stack_v2_B.m_to_mm2[0] = rtb_Time1;

  /* SignalConversion generated from: '<S38>/Kalman' */
  y_data[0] = VIRTUAL_self_driving_stack_v2_B.m_to_mm[0];

  /* SignalConversion generated from: '<S38>/LiDAR1' */
  tau_data[0] = rtb_Time1;

  /* Gain: '<S38>/m_to_mm2' */
  rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.m_to_mm2_Gain * rtb_Subtract_idx_1;
  VIRTUAL_self_driving_stack_v2_B.m_to_mm2[1] = rtb_Time1;

  /* SignalConversion generated from: '<S38>/Kalman' */
  y_data[1] = VIRTUAL_self_driving_stack_v2_B.m_to_mm[1];

  /* SignalConversion generated from: '<S38>/LiDAR1' */
  tau_data[1] = rtb_Time1;
  tau_data[2] = VIRTUAL_self_driving_stack_v2_B.Gain_l;

  /* Bias: '<S45>/Bias1' incorporates:
   *  Bias: '<S45>/Bias'
   *  Constant: '<S38>/Constant'
   *  Constant: '<S45>/Constant1'
   *  Math: '<S45>/Mod'
   *  Selector: '<S38>/Kalman'
   *  Selector: '<S38>/LiDAR1'
   */
  VIRTUAL_self_driving_stack_v2_B.Bias1_ej[0] = rt_modd_snf(y_data[(int32_T)
    VIRTUAL_self_driving_stack_v2_P.Constant_Value_k1 - 1] +
    VIRTUAL_self_driving_stack_v2_P.Bias_Bias_e,
    VIRTUAL_self_driving_stack_v2_P.Constant1_Value_d) +
    VIRTUAL_self_driving_stack_v2_P.Bias1_Bias_g;
  VIRTUAL_self_driving_stack_v2_B.Bias1_ej[1] = rt_modd_snf
    (VIRTUAL_self_driving_stack_v2_B.LiDAR +
     VIRTUAL_self_driving_stack_v2_P.Bias_Bias_e,
     VIRTUAL_self_driving_stack_v2_P.Constant1_Value_d) +
    VIRTUAL_self_driving_stack_v2_P.Bias1_Bias_g;
  VIRTUAL_self_driving_stack_v2_B.Bias1_ej[2] = rt_modd_snf(tau_data[(int32_T)
    VIRTUAL_self_driving_stack_v2_P.Constant_Value_k1 - 1] +
    VIRTUAL_self_driving_stack_v2_P.Bias_Bias_e,
    VIRTUAL_self_driving_stack_v2_P.Constant1_Value_d) +
    VIRTUAL_self_driving_stack_v2_P.Bias1_Bias_g;
  if (tmp) {
  }

  /* TransferFcn: '<S43>/Transfer Fcn' */
  VIRTUAL_self_driving_stack_v2_B.TransferFcn = 0.0;
  VIRTUAL_self_driving_stack_v2_B.TransferFcn +=
    VIRTUAL_self_driving_stack_v2_P.TransferFcn_C *
    VIRTUAL_self_driving_stack_v2_X.TransferFcn_CSTATE;

  /* Sum: '<S43>/Add' incorporates:
   *  Constant: '<S43>/Lr'
   *  Constant: '<S43>/wheelbase'
   *  Product: '<S43>/Divide'
   *  Product: '<S43>/Product2'
   *  Trigonometry: '<S43>/Trigonometric Function2'
   *  Trigonometry: '<S43>/Trigonometric Function3'
   */
  S = atan(tan(VIRTUAL_self_driving_stack_v2_B.TransferFcn) *
           VIRTUAL_self_driving_stack_v2_P.Lr_Value /
           VIRTUAL_self_driving_stack_v2_P.wheelbase_Value) +
    VIRTUAL_self_driving_stack_v2_B.Bias1_e;

  /* SignalConversion generated from: '<S38>/Integrator' incorporates:
   *  Product: '<S43>/Product'
   *  Product: '<S43>/Product1'
   *  Trigonometry: '<S43>/Trigonometric Function'
   *  Trigonometry: '<S43>/Trigonometric Function1'
   */
  VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[0] =
    VIRTUAL_self_driving_stack_v2_B.wheelspeedms * cos(S);
  VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[1] = sin(S) *
    VIRTUAL_self_driving_stack_v2_B.wheelspeedms;
  VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[2] =
    VIRTUAL_self_driving_stack_v2_B.z;
  if (tmp) {
    /* MATLAB Function: '<S40>/MATLAB Function' incorporates:
     *  Constant: '<S40>/Constant1'
     *  Constant: '<S40>/Constant2'
     */
    VIRTUAL_self_driving_stack_v_DW.sfEvent = VIRTUAL_self_driving_CALL_EVENT;

    /* MATLAB Function 'stateEstimation/Sensor Fusion -  Complementary Filter/MATLAB Function': '<S51>:1' */
    /* '<S51>:1:2' */
    VIRTUAL_self_driving_stack_v2_B.correction_weight = 1.0 -
      VIRTUAL_self_driving_stack_v2_P.Constant1_Value_n *
      VIRTUAL_self_driving_stack_v2_B.wheelspeedms;
    if (VIRTUAL_self_driving_stack_v2_B.correction_weight <
        VIRTUAL_self_driving_stack_v2_P.Constant2_Value_c) {
      /* '<S51>:1:3' */
      /* '<S51>:1:4' */
      VIRTUAL_self_driving_stack_v2_B.correction_weight =
        VIRTUAL_self_driving_stack_v2_P.Constant2_Value_c;
    }

    /* End of MATLAB Function: '<S40>/MATLAB Function' */
    /* ManualSwitch: '<S40>/Manual Switch' */
    if (VIRTUAL_self_driving_stack_v2_P.ManualSwitch_CurrentSetting_n == 1) {
      /* ManualSwitch: '<S40>/Manual Switch' incorporates:
       *  Constant: '<S40>/Constant'
       */
      VIRTUAL_self_driving_stack_v2_B.ManualSwitch_f =
        VIRTUAL_self_driving_stack_v2_P.Constant_Value_l;
    } else {
      /* ManualSwitch: '<S40>/Manual Switch' */
      VIRTUAL_self_driving_stack_v2_B.ManualSwitch_f = 0.0;
    }

    /* End of ManualSwitch: '<S40>/Manual Switch' */
  }

  /* Sum: '<S40>/Subtract' */
  tmp_6 = _mm_sub_pd(_mm_set_pd(rtb_Subtract_idx_1, rtb_Subtract_idx_0),
                     _mm_loadu_pd
                     (&VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0]));
  _mm_storeu_pd(&tmp_5[0], tmp_6);

  /* Sum: '<S40>/Subtract' */
  rtb_Subtract_idx_2 -= VIRTUAL_self_driving_stack_v2_B.CalibrationBias[2];

  /* Integrator: '<S40>/Integrator1' */
  /* Limited  Integrator  */
  if (tmp_0) {
    zcEvent = rt_ZCFcn(ANY_ZERO_CROSSING,
                       &VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE_e,
                       (VIRTUAL_self_driving_stack_v2_B.ManualSwitch_f));

    /* evaluate zero-crossings and the level of the reset signal */
    if ((zcEvent != NO_ZCEVENT) ||
        (VIRTUAL_self_driving_stack_v2_B.ManualSwitch_f != 0.0)) {
      VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] =
        VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_d;
      VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] =
        VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_d;
      VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] =
        VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_d;
    }
  }

  rtb_Time1 = VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0];
  if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] >=
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[0]) {
    rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[0];
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[0];
  } else if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] <=
             VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[0]) {
    rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[0];
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[0];
  }

  /* Sum: '<S40>/Subtract1' incorporates:
   *  Gain: '<S40>/Gain'
   *  Gain: '<S40>/kp'
   *  Integrator: '<S40>/Integrator1'
   *  Product: '<S40>/Product'
   *  Sum: '<S40>/Subtract2'
   */
  VIRTUAL_self_driving_stack_v2_B.Subtract1[0] =
    VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[0] -
    (VIRTUAL_self_driving_stack_v2_P.kp_Gain[0] * tmp_5[0] + rtb_Time1) *
    VIRTUAL_self_driving_stack_v2_P.Gain_Gain_i[0] *
    VIRTUAL_self_driving_stack_v2_B.correction_weight;

  /* Gain: '<S40>/ki' */
  VIRTUAL_self_driving_stack_v2_B.ki[0] =
    VIRTUAL_self_driving_stack_v2_P.ki_Gain[0] * tmp_5[0];

  /* Integrator: '<S40>/Integrator1' */
  rtb_Time1 = VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1];
  if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] >=
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[1]) {
    rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[1];
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[1];
  } else if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] <=
             VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[1]) {
    rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[1];
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[1];
  }

  /* Sum: '<S40>/Subtract1' incorporates:
   *  Gain: '<S40>/Gain'
   *  Gain: '<S40>/kp'
   *  Integrator: '<S40>/Integrator1'
   *  Product: '<S40>/Product'
   *  Sum: '<S40>/Subtract2'
   */
  VIRTUAL_self_driving_stack_v2_B.Subtract1[1] =
    VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[1] -
    (VIRTUAL_self_driving_stack_v2_P.kp_Gain[1] * tmp_5[1] + rtb_Time1) *
    VIRTUAL_self_driving_stack_v2_P.Gain_Gain_i[1] *
    VIRTUAL_self_driving_stack_v2_B.correction_weight;

  /* Gain: '<S40>/ki' */
  VIRTUAL_self_driving_stack_v2_B.ki[1] =
    VIRTUAL_self_driving_stack_v2_P.ki_Gain[1] * tmp_5[1];

  /* Integrator: '<S40>/Integrator1' */
  rtb_Time1 = VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2];
  if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] >=
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[2]) {
    rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[2];
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[2];
  } else if (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] <=
             VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[2]) {
    rtb_Time1 = VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[2];
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[2];
  }

  /* Sum: '<S40>/Subtract1' incorporates:
   *  Gain: '<S40>/Gain'
   *  Gain: '<S40>/kp'
   *  Integrator: '<S40>/Integrator1'
   *  Product: '<S40>/Product'
   *  Sum: '<S40>/Subtract2'
   */
  VIRTUAL_self_driving_stack_v2_B.Subtract1[2] =
    VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[2] -
    (VIRTUAL_self_driving_stack_v2_P.kp_Gain[2] * rtb_Subtract_idx_2 + rtb_Time1)
    * VIRTUAL_self_driving_stack_v2_P.Gain_Gain_i[2] *
    VIRTUAL_self_driving_stack_v2_B.correction_weight;

  /* Gain: '<S40>/ki' incorporates:
   *  Gain: '<S40>/kp'
   */
  VIRTUAL_self_driving_stack_v2_B.ki[2] =
    VIRTUAL_self_driving_stack_v2_P.ki_Gain[2] * rtb_Subtract_idx_2;
  if (tmp) {
    /* RateTransition: '<S44>/Rate Transition1' */
    if (VIRTUAL_self_driving_stack_v_M->Timing.RateInteraction.TID1_5) {
      VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_n[0] =
        VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0];
      VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_n[1] =
        VIRTUAL_self_driving_stack_v2_B.CalibrationBias[1];

      /* RateTransition: '<S44>/Rate Transition2' */
      VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer_f[0] =
        VIRTUAL_self_driving_stack_v2_B.Sum1[0];
      VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer_f[1] =
        VIRTUAL_self_driving_stack_v2_B.Sum1[1];
    }

    /* End of RateTransition: '<S44>/Rate Transition1' */
  }

  /* Gain: '<S53>/Gain6' */
  VIRTUAL_self_driving_stack_v2_B.Gain6 =
    VIRTUAL_self_driving_stack_v2_P.Gain6_Gain * rtb_poseRateCorrection;

  /* Product: '<S54>/Product' incorporates:
   *  Constant: '<S12>/Constant1'
   *  Constant: '<S12>/Constant3'
   *  Constant: '<S54>/Constant'
   *  Integrator: '<S54>/Integrator2'
   *  Product: '<S54>/Product2'
   *  Sum: '<S54>/Sum'
   *  Sum: '<S54>/Sum1'
   */
  VIRTUAL_self_driving_stack_v2_B.Product_c =
    ((VIRTUAL_self_driving_stack_v2_B.final -
      VIRTUAL_self_driving_stack_v2_B.Integrator1) -
     VIRTUAL_self_driving_stack_v2_X.Integrator2_CSTATE *
     VIRTUAL_self_driving_stack_v2_P.Constant_Value_p *
     VIRTUAL_self_driving_stack_v2_P.Constant3_Value) *
    VIRTUAL_self_driving_stack_v2_P.Constant1_Value_b;

  /* Product: '<S54>/Product1' incorporates:
   *  Constant: '<S12>/Constant1'
   *  Integrator: '<S54>/Integrator2'
   */
  VIRTUAL_self_driving_stack_v2_B.Product1 =
    VIRTUAL_self_driving_stack_v2_P.Constant1_Value_b *
    VIRTUAL_self_driving_stack_v2_X.Integrator2_CSTATE;
  if (tmp) {
    /* S-Function (sample_time_block): '<S23>/Sample Time' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming1/Sample Time (sample_time_block) */
    {
      t_error result;
      t_timeout current_time;
      t_timeout time_difference;
      result = timeout_get_high_resolution_time(&current_time);
      if (result >= 0) {
        result = timeout_subtract(&time_difference, &current_time,
          &VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime);
        VIRTUAL_self_driving_stack_v2_B.SampleTime = time_difference.seconds +
          time_difference.nanoseconds * 1e-9;
        memcpy(&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime,
               &current_time, sizeof(t_timeout));
      }

      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    /* Constant: '<S23>/Constant' */
    VIRTUAL_self_driving_stack_v2_B.Constant =
      VIRTUAL_self_driving_stack_v2_P.Constant_Value_h;

    /* S-Function (computation_time_block): '<S23>/Computation Time' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming1/Computation Time (computation_time_block) */
    {
      VIRTUAL_self_driving_stack_v2_B.ComputationTime =
        VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTime.seconds
        + VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTime.nanoseconds
        * 1e-9;
    }
  }
}

/* Model update function for TID0 */
void VIRTUAL_self_driving_stack_v2_update0(void) /* Sample time: [0.0s, 0.0s] */
{
  if (rtmIsMajorTimeStep(VIRTUAL_self_driving_stack_v_M)) {
    /* Update for Memory: '<S38>/Memory2' */
    VIRTUAL_self_driving_stack_v_DW.Memory2_PreviousInput =
      VIRTUAL_self_driving_stack_v2_B.CalibrationBias[0];

    /* Update for Memory: '<S11>/Memory1' */
    VIRTUAL_self_driving_stack_v_DW.Memory1_PreviousInput =
      VIRTUAL_self_driving_stack_v2_B.Saturation;

    /* Update for Memory: '<S10>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput =
      VIRTUAL_self_driving_stack_v2_B.DifferenceInputs2;

    /* Update for Memory: '<S19>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f =
      VIRTUAL_self_driving_stack_v2_B.location;

    /* Update for Memory: '<S53>/Memory1' incorporates:
     *  Constant: '<S7>/desiredPath'
     */
    VIRTUAL_self_driving_stack_v_DW.Memory1_PreviousInput_k =
      VIRTUAL_self_driving_stack_v2_P.desiredPath_Value;

    /* Update for Delay: '<S31>/Delay' */
    VIRTUAL_self_driving_stack_v_DW.icLoad = false;
    VIRTUAL_self_driving_stack_v_DW.Delay_DSTATE =
      VIRTUAL_self_driving_stack_v2_B.DifferenceInputs2;

    /* Update for Memory: '<S6>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[0] =
      VIRTUAL_self_driving_stack_v2_B.Sum1[0];
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[1] =
      VIRTUAL_self_driving_stack_v2_B.Sum1[1];
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[2] =
      VIRTUAL_self_driving_stack_v2_B.ManualSwitch1;
  }

  /* Update for Integrator: '<S38>/Integrator' */
  VIRTUAL_self_driving_stack_v_DW.Integrator_DWORK1 = false;

  /* Update for Integrator: '<S54>/Integrator1' */
  VIRTUAL_self_driving_stack_v_DW.Integrator1_DWORK1 = false;
  if (rtmIsMajorTimeStep(VIRTUAL_self_driving_stack_v_M)) {
    rt_ertODEUpdateContinuousStates(&VIRTUAL_self_driving_stack_v_M->solverInfo);
  }

  /* Update absolute time */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick0)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH0;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[0] = rtsiGetSolverStopTime
    (&VIRTUAL_self_driving_stack_v_M->solverInfo);

  /* Update absolute time */
  /* The "clockTick1" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick1"
   * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick1 and the high bits
   * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick1)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH1;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[1] =
    VIRTUAL_self_driving_stack_v_M->Timing.clockTick1 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize1 +
    VIRTUAL_self_driving_stack_v_M->Timing.clockTickH1 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize1 * 4294967296.0;
}

/* Derivatives for root system: '<Root>' */
void VIRTUAL_self_driving_stack_v2_derivatives(void)
{
  XDot_VIRTUAL_self_driving_sta_T *_rtXdot;
  boolean_T lsat;
  boolean_T usat;
  _rtXdot = ((XDot_VIRTUAL_self_driving_sta_T *)
             VIRTUAL_self_driving_stack_v_M->derivs);

  /* Derivatives for Integrator: '<S38>/Integrator' */
  if (!VIRTUAL_self_driving_stack_v2_B.RelationalOperator1) {
    _rtXdot->Integrator_CSTATE[0] =
      VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[0];
    _rtXdot->Integrator_CSTATE[1] =
      VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[1];
    _rtXdot->Integrator_CSTATE[2] =
      VIRTUAL_self_driving_stack_v2_B.TmpSignalConversionAtIntegrator[2];
  } else {
    /* level reset is active */
    _rtXdot->Integrator_CSTATE[0] = 0.0;
    _rtXdot->Integrator_CSTATE[1] = 0.0;
    _rtXdot->Integrator_CSTATE[2] = 0.0;
  }

  /* End of Derivatives for Integrator: '<S38>/Integrator' */

  /* Derivatives for Integrator: '<S40>/Integrator' */
  _rtXdot->Integrator_CSTATE_n[0] = VIRTUAL_self_driving_stack_v2_B.Subtract1[0];
  _rtXdot->Integrator_CSTATE_n[1] = VIRTUAL_self_driving_stack_v2_B.Subtract1[1];
  _rtXdot->Integrator_CSTATE_n[2] = VIRTUAL_self_driving_stack_v2_B.Subtract1[2];

  /* Derivatives for Enabled SubSystem: '<S12>/Steering Based on LiDAR' */
  if (VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_MODE) {
    /* Derivatives for TransferFcn: '<S55>/Gyro Filter' */
    _rtXdot->GyroFilter_CSTATE = 0.0;
    _rtXdot->GyroFilter_CSTATE += VIRTUAL_self_driving_stack_v2_P.GyroFilter_A *
      VIRTUAL_self_driving_stack_v2_X.GyroFilter_CSTATE;
    _rtXdot->GyroFilter_CSTATE += VIRTUAL_self_driving_stack_v2_B.z;
  } else {
    ((XDot_VIRTUAL_self_driving_sta_T *) VIRTUAL_self_driving_stack_v_M->derivs
      )->GyroFilter_CSTATE = 0.0;
  }

  /* End of Derivatives for SubSystem: '<S12>/Steering Based on LiDAR' */

  /* Derivatives for Integrator: '<S53>/Integrator' */
  lsat = (VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h <=
          VIRTUAL_self_driving_stack_v2_P.Integrator_LowerSat);
  usat = (VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h >=
          VIRTUAL_self_driving_stack_v2_P.Integrator_UpperSat);
  if ((!VIRTUAL_self_driving_stack_v2_B.OR) && (((!lsat) && (!usat)) || (lsat &&
        (VIRTUAL_self_driving_stack_v2_B.Gain6 > 0.0)) || (usat &&
        (VIRTUAL_self_driving_stack_v2_B.Gain6 < 0.0)))) {
    _rtXdot->Integrator_CSTATE_h = VIRTUAL_self_driving_stack_v2_B.Gain6;
  } else {
    /* in saturation or level reset is active */
    _rtXdot->Integrator_CSTATE_h = 0.0;
  }

  /* End of Derivatives for Integrator: '<S53>/Integrator' */

  /* Derivatives for Integrator: '<S53>/Integrator1' incorporates:
   *  Constant: '<S53>/Constant1'
   */
  lsat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE <=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat);
  usat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE >=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat);
  if ((!VIRTUAL_self_driving_stack_v2_B.OR) && (((!lsat) && (!usat)) || (lsat &&
        (VIRTUAL_self_driving_stack_v2_P.Constant1_Value_k > 0.0)) || (usat &&
        (VIRTUAL_self_driving_stack_v2_P.Constant1_Value_k < 0.0)))) {
    _rtXdot->Integrator1_CSTATE =
      VIRTUAL_self_driving_stack_v2_P.Constant1_Value_k;
  } else {
    /* in saturation or level reset is active */
    _rtXdot->Integrator1_CSTATE = 0.0;
  }

  /* End of Derivatives for Integrator: '<S53>/Integrator1' */

  /* Derivatives for Integrator: '<S54>/Integrator1' */
  _rtXdot->Integrator1_CSTATE_g = VIRTUAL_self_driving_stack_v2_B.Product1;

  /* Derivatives for Integrator: '<S33>/Integrator1' */
  lsat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k <=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_d);
  usat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k >=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_l);
  if (((!lsat) && (!usat)) || (lsat && (VIRTUAL_self_driving_stack_v2_B.Kim >
        0.0)) || (usat && (VIRTUAL_self_driving_stack_v2_B.Kim < 0.0))) {
    _rtXdot->Integrator1_CSTATE_k = VIRTUAL_self_driving_stack_v2_B.Kim;
  } else {
    /* in saturation */
    _rtXdot->Integrator1_CSTATE_k = 0.0;
  }

  /* End of Derivatives for Integrator: '<S33>/Integrator1' */

  /* Derivatives for TransferFcn: '<S43>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE = 0.0;
  _rtXdot->TransferFcn_CSTATE += VIRTUAL_self_driving_stack_v2_P.TransferFcn_A *
    VIRTUAL_self_driving_stack_v2_X.TransferFcn_CSTATE;
  _rtXdot->TransferFcn_CSTATE += VIRTUAL_self_driving_stack_v2_B.Saturation;

  /* Derivatives for Integrator: '<S40>/Integrator1' */
  lsat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] <=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[0]);
  usat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] >=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[0]);
  if ((VIRTUAL_self_driving_stack_v2_B.ManualSwitch_f == 0.0) && (((!lsat) &&
        (!usat)) || (lsat && (VIRTUAL_self_driving_stack_v2_B.ki[0] > 0.0)) ||
       (usat && (VIRTUAL_self_driving_stack_v2_B.ki[0] < 0.0)))) {
    _rtXdot->Integrator1_CSTATE_c[0] = VIRTUAL_self_driving_stack_v2_B.ki[0];
  } else {
    /* in saturation or level reset is active */
    _rtXdot->Integrator1_CSTATE_c[0] = 0.0;
  }

  lsat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] <=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[1]);
  usat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] >=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[1]);
  if ((VIRTUAL_self_driving_stack_v2_B.ManualSwitch_f == 0.0) && (((!lsat) &&
        (!usat)) || (lsat && (VIRTUAL_self_driving_stack_v2_B.ki[1] > 0.0)) ||
       (usat && (VIRTUAL_self_driving_stack_v2_B.ki[1] < 0.0)))) {
    _rtXdot->Integrator1_CSTATE_c[1] = VIRTUAL_self_driving_stack_v2_B.ki[1];
  } else {
    /* in saturation or level reset is active */
    _rtXdot->Integrator1_CSTATE_c[1] = 0.0;
  }

  lsat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] <=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_LowerSat_o[2]);
  usat = (VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] >=
          VIRTUAL_self_driving_stack_v2_P.Integrator1_UpperSat_h[2]);
  if ((VIRTUAL_self_driving_stack_v2_B.ManualSwitch_f == 0.0) && (((!lsat) &&
        (!usat)) || (lsat && (VIRTUAL_self_driving_stack_v2_B.ki[2] > 0.0)) ||
       (usat && (VIRTUAL_self_driving_stack_v2_B.ki[2] < 0.0)))) {
    _rtXdot->Integrator1_CSTATE_c[2] = VIRTUAL_self_driving_stack_v2_B.ki[2];
  } else {
    /* in saturation or level reset is active */
    _rtXdot->Integrator1_CSTATE_c[2] = 0.0;
  }

  /* End of Derivatives for Integrator: '<S40>/Integrator1' */

  /* Derivatives for Integrator: '<S54>/Integrator2' */
  _rtXdot->Integrator2_CSTATE = VIRTUAL_self_driving_stack_v2_B.Product_c;
}

/* Model output function for TID2 */
void VIRTUAL_self_driving_stack_v2_output2(void) /* Sample time: [0.032s, 0.0s] */
{
  real_T G;
  real_T bot_cnt;
  real_T grn_cnt;
  real_T red_cnt;
  real_T row_red;
  real_T rtb_sign_size;
  real_T yel_cnt;
  int32_T H_tmp;
  int32_T bb_h;
  int32_T bb_w;
  int32_T f_c;
  int32_T max_idx;
  int32_T row_pos;
  int32_T sign_type;
  int32_T sr_max_c;
  int32_T sr_max_r;
  int32_T sr_min_c;

  /* RateTransition generated from: '<Root>/MATLAB Function1' */
  H_tmp = VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport1_ *
    921600;
  for (sign_type = 0; sign_type < 921600; sign_type++) {
    VIRTUAL_self_driving_stack_v2_B.TmpRTBAtMATLABFunction1Inpo[sign_type] =
      VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport_f[sign_type
      + H_tmp];
  }

  /* End of RateTransition generated from: '<Root>/MATLAB Function1' */

  /* MATLAB Function: '<Root>/MATLAB Function1' incorporates:
   *  RateTransition generated from: '<Root>/MATLAB Function1'
   */
  VIRTUAL_self_driving_stack_v_DW.sfEvent_g = VIRTUAL_self_driving_CALL_EVENT;

  /* MATLAB Function 'MATLAB Function1': '<S3>:1' */
  /* '<S3>:1:5' */
  VIRTUAL_self_driving_stack_v2_B.light_color_e = 0.0;

  /* '<S3>:1:6' */
  /* '<S3>:1:7' */
  /* '<S3>:1:8' */
  sign_type = 0;

  /* '<S3>:1:9' */
  rtb_sign_size = 0.0;

  /* '<S3>:1:17' */
  /* '<S3>:1:18' */
  /* '<S3>:1:19' */
  /* '<S3>:1:21' */
  /* '<S3>:1:22' */
  /* '<S3>:1:23' */
  /* '<S3>:1:27' */
  /* '<S3>:1:25' */
  /* '<S3>:1:26' */
  /* '<S3>:1:29' */
  /* '<S3>:1:30' */
  for (max_idx = 0; max_idx < 307200; max_idx++) {
    red_cnt = (real_T)
      VIRTUAL_self_driving_stack_v2_B.TmpRTBAtMATLABFunction1Inpo[max_idx] /
      255.0;
    G = (real_T)
      VIRTUAL_self_driving_stack_v2_B.TmpRTBAtMATLABFunction1Inpo[max_idx +
      307200] / 255.0;
    bot_cnt = (real_T)
      VIRTUAL_self_driving_stack_v2_B.TmpRTBAtMATLABFunction1Inpo[max_idx +
      614400] / 255.0;
    grn_cnt = fmax(fmax(red_cnt, G), bot_cnt);
    yel_cnt = grn_cnt - fmin(fmin(red_cnt, G), bot_cnt);
    VIRTUAL_self_driving_stack_v2_B.V[max_idx] = grn_cnt * 255.0;
    if (yel_cnt < 0.001) {
      /* '<S3>:1:31' */
      /* '<S3>:1:32' */
      G = 0.0;
      VIRTUAL_self_driving_stack_v2_B.H[max_idx] = 0.0;
    } else if (grn_cnt == red_cnt) {
      /* '<S3>:1:33' */
      /* '<S3>:1:34' */
      red_cnt = fmod((G - bot_cnt) / yel_cnt, 6.0);
      if (red_cnt == 0.0) {
        red_cnt = 0.0;
      } else if (red_cnt < 0.0) {
        red_cnt += 6.0;
      }

      G = 30.0 * red_cnt;
      VIRTUAL_self_driving_stack_v2_B.H[max_idx] = G;
    } else if (grn_cnt == G) {
      /* '<S3>:1:35' */
      /* '<S3>:1:36' */
      G = ((bot_cnt - red_cnt) / yel_cnt + 2.0) * 30.0;
      VIRTUAL_self_driving_stack_v2_B.H[max_idx] = G;
    } else {
      /* '<S3>:1:38' */
      G = ((red_cnt - G) / yel_cnt + 4.0) * 30.0;
      VIRTUAL_self_driving_stack_v2_B.H[max_idx] = G;
    }

    if (G < 0.0) {
      /* '<S3>:1:40' */
      /* '<S3>:1:41' */
      VIRTUAL_self_driving_stack_v2_B.H[max_idx] = G + 180.0;
    }

    if (grn_cnt < 0.001) {
      /* '<S3>:1:43' */
      /* '<S3>:1:44' */
      VIRTUAL_self_driving_stack_v2_B.S[max_idx] = 0.0;
    } else {
      /* '<S3>:1:46' */
      VIRTUAL_self_driving_stack_v2_B.S[max_idx] = yel_cnt / grn_cnt * 255.0;
    }
  }

  /* '<S3>:1:55' */
  red_cnt = 0.0;

  /* '<S3>:1:55' */
  grn_cnt = 0.0;

  /* '<S3>:1:55' */
  yel_cnt = 0.0;

  /* '<S3>:1:57' */
  for (max_idx = 0; max_idx < 192; max_idx++) {
    /* '<S3>:1:58' */
    for (sr_min_c = 0; sr_min_c < 449; sr_min_c++) {
      /* '<S3>:1:59' */
      H_tmp = (sr_min_c + 95) * 480 + max_idx;
      if ((VIRTUAL_self_driving_stack_v2_B.S[H_tmp] > 200.0) &&
          (VIRTUAL_self_driving_stack_v2_B.V[H_tmp] > 230.0)) {
        /* '<S3>:1:60' */
        G = VIRTUAL_self_driving_stack_v2_B.H[H_tmp];
        if ((G <= 10.0) || (G >= 170.0)) {
          /* '<S3>:1:61' */
          /* '<S3>:1:62' */
          red_cnt++;
        } else if ((G >= 20.0) && (G <= 30.0)) {
          /* '<S3>:1:63' */
          /* '<S3>:1:64' */
          yel_cnt++;
        } else if ((G >= 35.0) && (G <= 90.0)) {
          /* '<S3>:1:65' */
          /* '<S3>:1:66' */
          grn_cnt++;
        }
      }
    }
  }

  /* '<S3>:1:73' */
  /* '<S3>:1:74' */
  /* '<S3>:1:75' */
  max_idx = 1;

  /* '<S3>:1:76' */
  if (yel_cnt > red_cnt) {
    /* '<S3>:1:77' */
    /* '<S3>:1:78' */
    red_cnt = yel_cnt;

    /* '<S3>:1:79' */
    max_idx = 2;
  }

  if (grn_cnt > red_cnt) {
    /* '<S3>:1:77' */
    /* '<S3>:1:78' */
    red_cnt = grn_cnt;

    /* '<S3>:1:79' */
    max_idx = 3;
  }

  if (red_cnt > 30.0) {
    /* '<S3>:1:82' */
    /* '<S3>:1:83' */
    VIRTUAL_self_driving_stack_v2_B.light_color_e = max_idx;
  }

  /* '<S3>:1:91' */
  max_idx = 479;

  /* '<S3>:1:91' */
  sr_max_r = 1;

  /* '<S3>:1:92' */
  sr_min_c = 640;

  /* '<S3>:1:92' */
  sr_max_c = 1;

  /* '<S3>:1:93' */
  red_cnt = 0.0;

  /* '<S3>:1:95' */
  for (bb_h = 0; bb_h < 169; bb_h++) {
    /* '<S3>:1:96' */
    for (bb_w = 0; bb_w < 257; bb_w++) {
      /* '<S3>:1:97' */
      H_tmp = ((bb_w + 191) * 480 + bb_h) + 95;
      G = VIRTUAL_self_driving_stack_v2_B.H[H_tmp];
      if (((G <= 10.0) || (G >= 168.0)) &&
          (VIRTUAL_self_driving_stack_v2_B.S[H_tmp] >= 100.0)) {
        /* '<S3>:1:98' */
        G = VIRTUAL_self_driving_stack_v2_B.V[H_tmp];
        if ((G >= 60.0) && (G < 240.0)) {
          /* '<S3>:1:98' */
          /* '<S3>:1:99' */
          red_cnt++;
          if (bb_h + 96 < max_idx + 1) {
            /* '<S3>:1:100' */
            max_idx = bb_h + 95;
          }

          if (bb_h + 96 > sr_max_r) {
            /* '<S3>:1:101' */
            sr_max_r = bb_h + 96;
          }

          if (bb_w + 192 < sr_min_c) {
            /* '<S3>:1:102' */
            sr_min_c = bb_w + 192;
          }

          if (bb_w + 192 > sr_max_c) {
            /* '<S3>:1:103' */
            sr_max_c = bb_w + 192;
          }
        }
      }
    }
  }

  if ((red_cnt > 200.0) && (sr_max_r > max_idx + 1) && (sr_max_c > sr_min_c)) {
    /* '<S3>:1:109' */
    /* '<S3>:1:110' */
    sr_max_r -= max_idx;

    /* '<S3>:1:111' */
    sr_max_c -= sr_min_c;
    if ((sr_max_r >= 15) && (sr_max_c + 1 >= 15)) {
      /* '<S3>:1:114' */
      /* '<S3>:1:115' */
      rtb_sign_size = red_cnt / (real_T)((sr_max_c + 1) * sr_max_r);

      /* '<S3>:1:118' */
      bb_h = (int32_T)rt_roundd_snf((real_T)sr_max_r / 3.0);

      /* '<S3>:1:119' */
      grn_cnt = 0.0;

      /* '<S3>:1:120' */
      yel_cnt = 0.0;

      /* '<S3>:1:121' */
      bot_cnt = 0.0;

      /* '<S3>:1:123' */
      for (bb_w = 0; bb_w < sr_max_r; bb_w++) {
        row_pos = max_idx + bb_w;

        /* '<S3>:1:124' */
        row_red = 0.0;

        /* '<S3>:1:125' */
        for (f_c = 0; f_c <= sr_max_c; f_c++) {
          /* '<S3>:1:126' */
          H_tmp = ((sr_min_c + f_c) - 1) * 480 + row_pos;
          G = VIRTUAL_self_driving_stack_v2_B.H[H_tmp];
          if (((G <= 10.0) || (G >= 168.0)) &&
              (VIRTUAL_self_driving_stack_v2_B.S[H_tmp] >= 100.0)) {
            /* '<S3>:1:127' */
            G = VIRTUAL_self_driving_stack_v2_B.V[H_tmp];
            if ((G >= 60.0) && (G < 240.0)) {
              /* '<S3>:1:127' */
              /* '<S3>:1:128' */
              row_red++;
            }
          }
        }

        /* '<S3>:1:131' */
        row_pos = (row_pos - max_idx) + 1;
        if (row_pos <= bb_h) {
          /* '<S3>:1:132' */
          /* '<S3>:1:133' */
          grn_cnt += row_red;
        } else if (row_pos <= (bb_h << 1)) {
          /* '<S3>:1:134' */
          /* '<S3>:1:135' */
          yel_cnt += row_red;
        } else {
          /* '<S3>:1:137' */
          bot_cnt += row_red;
        }
      }

      /* '<S3>:1:141' */
      max_idx = (sr_max_c + 1) * bb_h;

      /* '<S3>:1:143' */
      grn_cnt /= (real_T)max_idx;

      /* '<S3>:1:144' */
      yel_cnt /= (real_T)max_idx;

      /* '<S3>:1:145' */
      bot_cnt /= (real_T)max_idx;

      /* '<S3>:1:147' */
      row_red = (real_T)(sr_max_c + 1) / (real_T)sr_max_r;
      if ((rtb_sign_size > 0.45) && (row_red > 0.7) && (row_red < 1.4)) {
        /* '<S3>:1:150' */
        /* '<S3>:1:151' */
        row_red = grn_cnt;
        G = grn_cnt;
        if (grn_cnt < yel_cnt) {
          row_red = yel_cnt;
        }

        if (grn_cnt > yel_cnt) {
          G = yel_cnt;
        }

        if (row_red < bot_cnt) {
          row_red = bot_cnt;
        }

        if (G > bot_cnt) {
          G = bot_cnt;
        }

        if (row_red - G < 0.3) {
          /* '<S3>:1:152' */
          /* '<S3>:1:153' */
          sign_type = 1;
        }
      }

      if ((sign_type == 0) && (rtb_sign_size > 0.2) && (rtb_sign_size < 0.7) &&
          (grn_cnt > bot_cnt * 1.5) && (grn_cnt > 0.3)) {
        /* '<S3>:1:158' */
        /* '<S3>:1:159' */
        /* '<S3>:1:160' */
        sign_type = 2;
      }

      if ((sign_type == 0) && (rtb_sign_size > 0.2) && (rtb_sign_size < 0.7) &&
          (yel_cnt > grn_cnt * 1.3) && (yel_cnt > bot_cnt * 1.3) && (yel_cnt >
           0.3)) {
        /* '<S3>:1:165' */
        /* '<S3>:1:166' */
        /* '<S3>:1:167' */
        sign_type = 3;
      }

      /* '<S3>:1:171' */
      rtb_sign_size = red_cnt;
    }
  }

  VIRTUAL_self_driving_stack_v2_B.sign_type_h = sign_type;

  /* End of MATLAB Function: '<Root>/MATLAB Function1' */

  /* MATLAB Function: '<Root>/MATLAB Function2' */
  VIRTUAL_self_driving_stack_v_DW.sfEvent_h = VIRTUAL_self_driving_CALL_EVENT;

  /* MATLAB Function 'MATLAB Function2': '<S4>:1' */
  /* '<S4>:1:3' */
  VIRTUAL_self_driving_stack_v2_B.steer_correction_p = 0.0;

  /* RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v_DW.lane_detected_Buffer0 = false;

  /* RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v_DW.lane_offset_Buffer0 = 0.0;

  /* RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v_DW.light_color_Buffer0 =
    VIRTUAL_self_driving_stack_v2_B.light_color_e;

  /* RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v_DW.sign_size_Buffer0 = rtb_sign_size;

  /* RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v_DW.sign_type_Buffer0 =
    VIRTUAL_self_driving_stack_v2_B.sign_type_h;

  /* RateTransition generated from: '<Root>/Sum' */
  VIRTUAL_self_driving_stack_v_DW.steer_correction_Buffer0 =
    VIRTUAL_self_driving_stack_v2_B.steer_correction_p;
}

/* Model update function for TID2 */
void VIRTUAL_self_driving_stack_v2_update2(void) /* Sample time: [0.032s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick2" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick2"
   * and "Timing.stepSize2". Size of "clockTick2" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick2 and the high bits
   * Timing.clockTickH2. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick2)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH2;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[2] =
    VIRTUAL_self_driving_stack_v_M->Timing.clockTick2 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize2 +
    VIRTUAL_self_driving_stack_v_M->Timing.clockTickH2 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize2 * 4294967296.0;
}

/* Model output function for TID3 */
void VIRTUAL_self_driving_stack_v2_output3(void) /* Sample time: [0.034s, 0.0s] */
{
  /* local block i/o variables */
  boolean_T rtb_rightCSICamera_o2;
  boolean_T rtb_rearCSICamera_o2;
  boolean_T rtb_leftCSICamera_o2;
  boolean_T rtb_frontCSICamera_o2;
  int32_T i;

  /* S-Function (video_capture_block): '<S1>/rightCSICamera' */
  /* S-Function Block: VIRTUAL_self_driving_stack_v2/CSICameras/rightCSICamera (video_capture_block) */
  {
    t_error result;
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_BacklightCompens,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    video_capture_set_property
      (VIRTUAL_self_driving_stack_v_DW.rightCSICamera_VideoCapture, local_attr,
       ARRAY_LENGTH(local_attr));
    result = video_capture_read
      (VIRTUAL_self_driving_stack_v_DW.rightCSICamera_VideoCapture,
       &VIRTUAL_self_driving_stack_v2_B.rightCSICamera_o1[0]);
    rtb_rightCSICamera_o2 = (result > 0);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* S-Function (video_capture_block): '<S1>/rearCSICamera' */
  /* S-Function Block: VIRTUAL_self_driving_stack_v2/CSICameras/rearCSICamera (video_capture_block) */
  {
    t_error result;
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_BacklightCompensa,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    video_capture_set_property
      (VIRTUAL_self_driving_stack_v_DW.rearCSICamera_VideoCapture, local_attr,
       ARRAY_LENGTH(local_attr));
    result = video_capture_read
      (VIRTUAL_self_driving_stack_v_DW.rearCSICamera_VideoCapture,
       &VIRTUAL_self_driving_stack_v2_B.rearCSICamera_o1[0]);
    rtb_rearCSICamera_o2 = (result > 0);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* S-Function (video_capture_block): '<S1>/leftCSICamera' */
  /* S-Function Block: VIRTUAL_self_driving_stack_v2/CSICameras/leftCSICamera (video_capture_block) */
  {
    t_error result;
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_BacklightCompensa,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    video_capture_set_property
      (VIRTUAL_self_driving_stack_v_DW.leftCSICamera_VideoCapture, local_attr,
       ARRAY_LENGTH(local_attr));
    result = video_capture_read
      (VIRTUAL_self_driving_stack_v_DW.leftCSICamera_VideoCapture,
       &VIRTUAL_self_driving_stack_v2_B.leftCSICamera_o1[0]);
    rtb_leftCSICamera_o2 = (result > 0);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* S-Function (video_capture_block): '<S1>/frontCSICamera' */
  /* S-Function Block: VIRTUAL_self_driving_stack_v2/CSICameras/frontCSICamera (video_capture_block) */
  {
    t_error result;
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_BacklightCompens,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    video_capture_set_property
      (VIRTUAL_self_driving_stack_v_DW.frontCSICamera_VideoCapture, local_attr,
       ARRAY_LENGTH(local_attr));
    result = video_capture_read
      (VIRTUAL_self_driving_stack_v_DW.frontCSICamera_VideoCapture,
       &VIRTUAL_self_driving_stack_v2_B.frontCSICamera_o1[0]);
    rtb_frontCSICamera_o2 = (result > 0);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* RateTransition generated from: '<Root>/MATLAB Function1' incorporates:
   *  S-Function (video_capture_block): '<S1>/frontCSICamera'
   */
  for (i = 0; i < 921600; i++) {
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport_f[i +
      (VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport1_ == 0) *
      921600] = VIRTUAL_self_driving_stack_v2_B.frontCSICamera_o1[i];
  }

  VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport1_ = (int8_T)
    (VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport1_ == 0);

  /* End of RateTransition generated from: '<Root>/MATLAB Function1' */

  /* RateTransition generated from: '<Root>/To Host File' incorporates:
   *  S-Function (video_capture_block): '<S1>/frontCSICamera'
   */
  for (i = 0; i < 921600; i++) {
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_Buffe[i +
      (VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_semap == 0) *
      921600] = VIRTUAL_self_driving_stack_v2_B.frontCSICamera_o1[i];
  }

  VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_Activ = (int8_T)
    (VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_semap == 0);

  /* End of RateTransition generated from: '<Root>/To Host File' */

  /* S-Function (sample_time_block): '<S22>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming/Sample Time (sample_time_block) */
  {
    t_error result;
    t_timeout current_time;
    t_timeout time_difference;
    result = timeout_get_high_resolution_time(&current_time);
    if (result >= 0) {
      result = timeout_subtract(&time_difference, &current_time,
        &VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_c);
      VIRTUAL_self_driving_stack_v2_B.SampleTime_f = time_difference.seconds +
        time_difference.nanoseconds * 1e-9;
      memcpy(&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_c,
             &current_time, sizeof(t_timeout));
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Constant: '<S22>/Constant' */
  VIRTUAL_self_driving_stack_v2_B.Constant_i =
    VIRTUAL_self_driving_stack_v2_P.CSI_Sample_Time;

  /* S-Function (computation_time_block): '<S22>/Computation Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming/Computation Time (computation_time_block) */
  {
    VIRTUAL_self_driving_stack_v2_B.ComputationTime_h =
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_n.seconds +
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_n.nanoseconds
      * 1e-9;
  }

  /* S-Function (sample_time_block): '<S24>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming2/Sample Time (sample_time_block) */
  {
    t_error result;
    t_timeout current_time;
    t_timeout time_difference;
    result = timeout_get_high_resolution_time(&current_time);
    if (result >= 0) {
      result = timeout_subtract(&time_difference, &current_time,
        &VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_d);
      VIRTUAL_self_driving_stack_v2_B.SampleTime_fc = time_difference.seconds +
        time_difference.nanoseconds * 1e-9;
      memcpy(&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_d,
             &current_time, sizeof(t_timeout));
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Constant: '<S24>/Constant' */
  VIRTUAL_self_driving_stack_v2_B.Constant_f =
    VIRTUAL_self_driving_stack_v2_P.RealSense_Sample_Time;

  /* S-Function (computation_time_block): '<S24>/Computation Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming2/Computation Time (computation_time_block) */
  {
    VIRTUAL_self_driving_stack_v2_B.ComputationTime_b =
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_e.seconds +
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_e.nanoseconds
      * 1e-9;
  }
}

/* Model update function for TID3 */
void VIRTUAL_self_driving_stack_v2_update3(void) /* Sample time: [0.034s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick3" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick3"
   * and "Timing.stepSize3". Size of "clockTick3" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick3 and the high bits
   * Timing.clockTickH3. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick3)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH3;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[3] =
    VIRTUAL_self_driving_stack_v_M->Timing.clockTick3 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize3 +
    VIRTUAL_self_driving_stack_v_M->Timing.clockTickH3 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize3 * 4294967296.0;
}

/* Model output function for TID4 */
void VIRTUAL_self_driving_stack_v2_output4(void) /* Sample time: [0.068s, 0.0s] */
{
  /* local block i/o variables */
  real_T rtb_InverseModulus1;
  real32_T rtb_LIDARScanMatch_o3[9];
  int32_T rtb_LIDARScanMatch_o4;
  __m128d tmp_0;
  real_T rtb_Time_l;
  int32_T ii_data[1000];
  int32_T d_size;
  int32_T i;
  int32_T loop_ub;
  int32_T scalarLB;
  int32_T vectorUB;
  real32_T rtb_Gain_m[3];
  boolean_T x_data[1000];
  boolean_T exitg1;
  boolean_T rtb_GreaterThan1;
  boolean_T tmp;

  /* Reset subsysRan breadcrumbs */
  srClearBC(VIRTUAL_self_driving_stack_v_DW.MatchScans_SubsysRanBC);

  /* Reset subsysRan breadcrumbs */
  srClearBC(VIRTUAL_self_driving_stack_v_DW.LatchInput_SubsysRanBC);

  /* S-Function (ranging_sensor_block): '<S5>/Ranging Sensor' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarCapture/Ranging Sensor (ranging_sensor_block) */
  {
    t_ranging_sensor_information info;
    t_error result;
    result = rplidar_read(VIRTUAL_self_driving_stack_v_DW.RangingSensor_Sensor,
                          RANGING_MEASUREMENT_MODE_NORMAL,
                          VIRTUAL_self_driving_stack_v2_P.RangingSensor_MaxInterpolationD,
                          VIRTUAL_self_driving_stack_v2_P.RangingSensor_MaxInterpolationA,
                          &VIRTUAL_self_driving_stack_v_DW.RangingSensor_Measurements
                          [0], 1000);
    VIRTUAL_self_driving_stack_v2_B.RangingSensor_o5 = (result >= 0);
    if (result >= 0) {
      {
        int_T i1;
        real_T *y0 = &VIRTUAL_self_driving_stack_v2_B.RangingSensor_o1[0];
        real_T *y1 = &VIRTUAL_self_driving_stack_v2_B.RangingSensor_o2[0];
        real_T *y2 = &VIRTUAL_self_driving_stack_v2_B.RangingSensor_o3[0];
        real_T *y3 = &VIRTUAL_self_driving_stack_v2_B.RangingSensor_o4[0];
        uint16_T *y6 = &VIRTUAL_self_driving_stack_v2_B.RangingSensor_o7[0];
        uint16_T *y7 = &VIRTUAL_self_driving_stack_v2_B.RangingSensor_o8[0];
        t_ranging_measurement *dw_Measurements =
          &VIRTUAL_self_driving_stack_v_DW.RangingSensor_Measurements[0];
        for (i1=0; i1 < 1000; i1++) {
          y0[i1] = dw_Measurements[i1].distance;
          y2[i1] = dw_Measurements[i1].heading;
          y3[i1] = dw_Measurements[i1].quality / 100.0;
        }
      }

      VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1 = result;
      ;
      VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS2 = result;
      ;
      VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS3 = result;
      ;
      VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS4 = result;
      ;
    } else {
      if (result != -QERR_WOULD_BLOCK) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      }
    }

    result = rplidar_get_device_information
      (VIRTUAL_self_driving_stack_v_DW.RangingSensor_Sensor, &info);
    if (result >= 0) {
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o6 = info.model;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o7[0] =
        info.hardware_version.major;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o7[1] =
        info.hardware_version.minor;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o7[2] =
        info.hardware_version.release;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o7[3] =
        info.hardware_version.build;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o8[0] =
        info.firmware_version.major;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o8[1] =
        info.firmware_version.minor;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o8[2] =
        info.firmware_version.release;
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o8[3] =
        info.firmware_version.build;
    }
  }

  /* Bias: '<S6>/Bias' incorporates:
   *  Bias: '<S5>/virtualLidarToPhysicalLidarOffset'
   *  S-Function (ranging_sensor_block): '<S5>/Ranging Sensor'
   */
  VIRTUAL_self_driving_stack_v_DW.Bias_DIMS1 =
    VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS3;
  loop_ub = VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS3;
  scalarLB = (VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS3 / 2) << 1;
  vectorUB = scalarLB - 2;
  for (i = 0; i <= vectorUB; i += 2) {
    tmp_0 = _mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_B.RangingSensor_o3[i]);
    _mm_storeu_pd(&VIRTUAL_self_driving_stack_v2_B.Bias[i], _mm_add_pd
                  (_mm_add_pd(tmp_0, _mm_set1_pd
      (VIRTUAL_self_driving_stack_v2_P.qcar2_virtual_to_physical_lidar_rotation)),
                   _mm_set1_pd
                   (VIRTUAL_self_driving_stack_v2_P.qcar2_lidar_to_body_rotation)));
  }

  for (i = scalarLB; i < loop_ub; i++) {
    VIRTUAL_self_driving_stack_v2_B.Bias[i] =
      (VIRTUAL_self_driving_stack_v2_B.RangingSensor_o3[i] +
       VIRTUAL_self_driving_stack_v2_P.qcar2_virtual_to_physical_lidar_rotation)
      + VIRTUAL_self_driving_stack_v2_P.qcar2_lidar_to_body_rotation;
  }

  /* End of Bias: '<S6>/Bias' */
  for (i = 0; i <= 382; i += 2) {
    /* Constant: '<S6>/Constant1' */
    _mm_storeu_pd(&VIRTUAL_self_driving_stack_v2_B.Constant1[i], _mm_loadu_pd
                  (&VIRTUAL_self_driving_stack_v2_P.range_qcar2[i]));

    /* Bias: '<S6>/Bias2' incorporates:
     *  Constant: '<S6>/Constant1'
     *  Constant: '<S6>/Constant4'
     */
    _mm_storeu_pd(&VIRTUAL_self_driving_stack_v2_B.Bias2[i], _mm_add_pd
                  (_mm_loadu_pd(&VIRTUAL_self_driving_stack_v2_P.angles_qcar2[i]),
                   _mm_set1_pd
                   (VIRTUAL_self_driving_stack_v2_P.qcar2_lidar_to_map_rotation)));
  }

  /* S-Function (time_block): '<S6>/Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarLocalization/Time (time_block) */
  {
    t_error result;
    t_timeout current_time;
    t_timeout time_difference;
    result = timeout_get_high_resolution_time(&current_time);
    if (result == 0) {
      result = timeout_subtract(&time_difference, &current_time,
        &_high_resolution_start_time);
      rtb_Time_l = time_difference.seconds + time_difference.nanoseconds * 1e-9;
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Outputs for Triggered SubSystem: '<S16>/Latch Input' incorporates:
   *  TriggerPort: '<S18>/Trigger'
   */
  /* Outputs for Enabled SubSystem: '<S6>/Match Scans' incorporates:
   *  EnablePort: '<S14>/Enable'
   */
  tmp = rtsiIsModeUpdateTimeStep(&VIRTUAL_self_driving_stack_v_M->solverInfo);

  /* End of Outputs for SubSystem: '<S16>/Latch Input' */
  if (tmp) {
    VIRTUAL_self_driving_stack_v_DW.MatchScans_MODE =
      VIRTUAL_self_driving_stack_v2_B.RangingSensor_o5;
  }

  if (VIRTUAL_self_driving_stack_v_DW.MatchScans_MODE) {
    /* Switch: '<S14>/Switch' incorporates:
     *  Constant: '<S6>/Constant10'
     *  RelationalOperator: '<S6>/GreaterThan1'
     */
    if (rtb_Time_l < VIRTUAL_self_driving_stack_v2_P.Initialization_Time) {
      /* Switch: '<S14>/Switch' incorporates:
       *  Constant: '<S14>/Constant'
       */
      VIRTUAL_self_driving_stack_v2_B.Switch[0] =
        VIRTUAL_self_driving_stack_v2_P.Constant_Value[0];
      VIRTUAL_self_driving_stack_v2_B.Switch[1] =
        VIRTUAL_self_driving_stack_v2_P.Constant_Value[1];
      VIRTUAL_self_driving_stack_v2_B.Switch[2] =
        VIRTUAL_self_driving_stack_v2_P.Constant_Value[2];
    } else {
      /* Switch: '<S14>/Switch' incorporates:
       *  Constant: '<S14>/Constant1'
       */
      VIRTUAL_self_driving_stack_v2_B.Switch[0] =
        VIRTUAL_self_driving_stack_v2_P.Constant1_Value[0];
      VIRTUAL_self_driving_stack_v2_B.Switch[1] =
        VIRTUAL_self_driving_stack_v2_P.Constant1_Value[1];
      VIRTUAL_self_driving_stack_v2_B.Switch[2] =
        VIRTUAL_self_driving_stack_v2_P.Constant1_Value[2];
    }

    /* End of Switch: '<S14>/Switch' */

    /* MATLAB Function: '<S14>/MATLAB Function' incorporates:
     *  Bias: '<S6>/Bias'
     *  S-Function (ranging_sensor_block): '<S5>/Ranging Sensor'
     */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_m = VIRTUAL_self_driving_CALL_EVENT;

    /* MATLAB Function 'lidarLocalization/Match Scans/MATLAB Function': '<S17>:1' */
    /* '<S17>:1:2' */
    loop_ub = VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1;
    for (i = 0; i < loop_ub; i++) {
      x_data[i] = (VIRTUAL_self_driving_stack_v2_B.RangingSensor_o1[i] == 0.0);
    }

    i = 0;
    scalarLB = VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1;
    loop_ub = 0;
    exitg1 = false;
    while ((!exitg1) && (loop_ub <=
                         VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1 - 1))
    {
      if (x_data[loop_ub]) {
        i++;
        ii_data[i - 1] = loop_ub + 1;
        if (i >= VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1) {
          exitg1 = true;
        } else {
          loop_ub++;
        }
      } else {
        loop_ub++;
      }
    }

    if (VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1 == 1) {
      if (i == 0) {
        scalarLB = 0;
      }
    } else if (i < 1) {
      scalarLB = 0;
    } else {
      scalarLB = i;
    }

    /* '<S17>:1:5' */
    d_size = VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1;
    loop_ub = VIRTUAL_self_driving_stack_v_DW.RangingSensor_DIMS1;
    if (loop_ub - 1 >= 0) {
      memcpy(&VIRTUAL_self_driving_stack_v2_B.d_data[0],
             &VIRTUAL_self_driving_stack_v2_B.RangingSensor_o1[0], (uint32_T)
             loop_ub * sizeof(real_T));
    }

    VIRTUAL_self_dri_nullAssignment(VIRTUAL_self_driving_stack_v2_B.d_data,
      &d_size, ii_data, &scalarLB);
    loop_ub = d_size;
    VIRTUAL_self_driving_stack_v_DW.SFunction_DIMS2 = loop_ub;
    if (loop_ub - 1 >= 0) {
      memcpy(&VIRTUAL_self_driving_stack_v2_B.new_range[0],
             &VIRTUAL_self_driving_stack_v2_B.d_data[0], (uint32_T)loop_ub *
             sizeof(real_T));
    }

    /* '<S17>:1:6' */
    d_size = VIRTUAL_self_driving_stack_v_DW.Bias_DIMS1;
    loop_ub = VIRTUAL_self_driving_stack_v_DW.Bias_DIMS1;
    if (loop_ub - 1 >= 0) {
      memcpy(&VIRTUAL_self_driving_stack_v2_B.d_data[0],
             &VIRTUAL_self_driving_stack_v2_B.Bias[0], (uint32_T)loop_ub *
             sizeof(real_T));
    }

    VIRTUAL_self_dri_nullAssignment(VIRTUAL_self_driving_stack_v2_B.d_data,
      &d_size, ii_data, &scalarLB);
    loop_ub = d_size;
    VIRTUAL_self_driving_stack_v_DW.SFunction_DIMS3 = loop_ub;
    if (loop_ub - 1 >= 0) {
      memcpy(&VIRTUAL_self_driving_stack_v2_B.new_angles[0],
             &VIRTUAL_self_driving_stack_v2_B.d_data[0], (uint32_T)loop_ub *
             sizeof(real_T));
    }

    /* End of MATLAB Function: '<S14>/MATLAB Function' */

    /* Gain: '<S14>/Gain1' incorporates:
     *  Bias: '<S6>/Bias3'
     *  DataTypeConversion: '<S14>/Data Type Conversion1'
     *  RateTransition: '<S6>/Rate Transition1'
     */
    rtb_Gain_m[0] = (real32_T)
      (VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer[0] -
       VIRTUAL_self_driving_stack_v2_P.cal_pos[0]) *
      VIRTUAL_self_driving_stack_v2_P.Gain1_Gain_n[0];
    rtb_Gain_m[1] = (real32_T)
      (VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer[1] -
       VIRTUAL_self_driving_stack_v2_P.cal_pos[1]) *
      VIRTUAL_self_driving_stack_v2_P.Gain1_Gain_n[1];
    rtb_Gain_m[2] = (real32_T)
      (VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer[2] -
       VIRTUAL_self_driving_stack_v2_P.cal_pos[2]) *
      VIRTUAL_self_driving_stack_v2_P.Gain1_Gain_n[2];

    /* S-Function (lidar_scan_match_block): '<S14>/LIDAR Scan Match' */

    /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarLocalization/Match Scans/LIDAR Scan Match (lidar_scan_match_block) */
    {
      int_T cur_width = (VIRTUAL_self_driving_stack_v_DW.SFunction_DIMS2 <
                         VIRTUAL_self_driving_stack_v_DW.SFunction_DIMS3) ?
        VIRTUAL_self_driving_stack_v_DW.SFunction_DIMS2 :
        VIRTUAL_self_driving_stack_v_DW.SFunction_DIMS3;
      t_error result = 0;
      real32_T* w_ref_ranges =
        &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[0];
      real32_T* w_ref_angles =
        &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[384];

      {
        int_T i1;
        const real_T *u2 = &VIRTUAL_self_driving_stack_v2_B.Constant1[0];
        for (i1=0; i1 < 384; i1++) {
          w_ref_ranges[i1] = (real32_T)u2[i1];
        }
      }

      {
        int_T i1;
        const real_T *u3 = &VIRTUAL_self_driving_stack_v2_B.Bias2[0];
        for (i1=0; i1 < 384; i1++) {
          w_ref_angles[i1] = (real32_T)u3[i1];
        }
      }

      real32_T* w_cur_ranges =
        &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[768];
      real32_T* w_cur_angles =
        &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[1768];
      t_range_single translation_range = { (real32_T)
        VIRTUAL_self_driving_stack_v2_B.Switch[0], (real32_T)
        VIRTUAL_self_driving_stack_v2_B.Switch[1] };

      {
        int_T i1;
        const real_T *u0 = &VIRTUAL_self_driving_stack_v2_B.new_range[0];
        for (i1=0; i1 < 1000; i1++) {
          w_cur_ranges[i1] = (real32_T)u0[i1];
        }
      }

      {
        int_T i1;
        const real_T *u1 = &VIRTUAL_self_driving_stack_v2_B.new_angles[0];
        for (i1=0; i1 < 1000; i1++) {
          w_cur_angles[i1] = (real32_T)u1[i1];
        }
      }

      result = lidar2d_match_scans_grid_match
        (VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Matcher,
         &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[0],
         &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[384], 384,
         &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[768],
         &VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Scan[1768], cur_width,
         &rtb_Gain_m[0], &translation_range, (float)
         VIRTUAL_self_driving_stack_v2_B.Switch[2],
         &VIRTUAL_self_driving_stack_v2_B.pose[0],
         &VIRTUAL_self_driving_stack_v2_B.LIDARScanMatch_o2,
         &rtb_LIDARScanMatch_o3[0]);
      rtb_LIDARScanMatch_o4 = result;
    }

    /* Sum: '<S14>/Subtract' incorporates:
     *  Memory: '<S14>/Memory'
     */
    VIRTUAL_self_driving_stack_v2_B.Subtract[0] =
      VIRTUAL_self_driving_stack_v2_B.pose[0] -
      VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[0];
    VIRTUAL_self_driving_stack_v2_B.Subtract[1] =
      VIRTUAL_self_driving_stack_v2_B.pose[1] -
      VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[1];
    VIRTUAL_self_driving_stack_v2_B.Subtract[2] =
      VIRTUAL_self_driving_stack_v2_B.pose[2] -
      VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[2];

    /* DataTypeConversion: '<S14>/Data Type Conversion' incorporates:
     *  Gain: '<S14>/Gain'
     */
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[0] =
      VIRTUAL_self_driving_stack_v2_P.Gain_Gain_l[0] *
      VIRTUAL_self_driving_stack_v2_B.pose[0];
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[1] =
      VIRTUAL_self_driving_stack_v2_P.Gain_Gain_l[1] *
      VIRTUAL_self_driving_stack_v2_B.pose[1];
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[2] =
      VIRTUAL_self_driving_stack_v2_P.Gain_Gain_l[2] *
      VIRTUAL_self_driving_stack_v2_B.pose[2];
    if (tmp) {
      srUpdateBC(VIRTUAL_self_driving_stack_v_DW.MatchScans_SubsysRanBC);
    }
  }

  /* End of Outputs for SubSystem: '<S6>/Match Scans' */

  /* S-Function (inverse_modulus_block): '<S6>/Inverse Modulus1' */
  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarLocalization/Inverse Modulus1 (inverse_modulus_block) */
  {
    static const real_T sampling_period = 0.068;
    real_T half_range = VIRTUAL_self_driving_stack_v2_P.InverseModulus1_Modulus /
      2.0;
    real_T du, dy;
    if (VIRTUAL_self_driving_stack_v_DW.InverseModulus1_FirstSample) {
      VIRTUAL_self_driving_stack_v_DW.InverseModulus1_FirstSample = false;
      VIRTUAL_self_driving_stack_v_DW.InverseModulus1_PreviousInput =
        VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[2];
    }

    du = (real_T) VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[2] -
      VIRTUAL_self_driving_stack_v_DW.InverseModulus1_PreviousInput;
    if (du > half_range) {
      VIRTUAL_self_driving_stack_v_DW.InverseModulus1_Revolutions =
        VIRTUAL_self_driving_stack_v_DW.InverseModulus1_Revolutions - 1;
      dy = du - VIRTUAL_self_driving_stack_v2_P.InverseModulus1_Modulus;
    } else if (du < -half_range) {
      VIRTUAL_self_driving_stack_v_DW.InverseModulus1_Revolutions =
        VIRTUAL_self_driving_stack_v_DW.InverseModulus1_Revolutions + 1;
      dy = du + VIRTUAL_self_driving_stack_v2_P.InverseModulus1_Modulus;
    } else {
      dy = du;
    }

    rtb_InverseModulus1 = VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[2]
      + VIRTUAL_self_driving_stack_v_DW.InverseModulus1_Revolutions *
      VIRTUAL_self_driving_stack_v2_P.InverseModulus1_Modulus;
    VIRTUAL_self_driving_stack_v_DW.InverseModulus1_PreviousInput =
      VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[2];
  }

  /* RateTransition: '<S6>/Rate Transition' */
  VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[0] =
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[0];
  VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[1] =
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[1];
  VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[2] =
    rtb_InverseModulus1;

  /* Logic: '<S15>/Logical Operator1' incorporates:
   *  Logic: '<S15>/Logical Operator2'
   *  Memory: '<S15>/Memory'
   */
  rtb_GreaterThan1 = (VIRTUAL_self_driving_stack_v2_B.RangingSensor_o5 &&
                      (!VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_g));

  /* Outputs for Triggered SubSystem: '<S16>/Latch Input' incorporates:
   *  TriggerPort: '<S18>/Trigger'
   */
  if (tmp) {
    if (rtb_GreaterThan1 && (VIRTUAL_self_driving_st_PrevZCX.LatchInput_Trig_ZCE
         != POS_ZCSIG)) {
      /* SignalConversion generated from: '<S18>/Input' incorporates:
       *  Constant: '<S6>/Constant3'
       */
      VIRTUAL_self_driving_stack_v2_B.Input =
        VIRTUAL_self_driving_stack_v2_P.Constant3_Value_h;

      /* Constant: '<S18>/Constant' */
      VIRTUAL_self_driving_stack_v2_B.Constant_l =
        VIRTUAL_self_driving_stack_v2_P.Constant_Value_e;

      /* SignalConversion generated from: '<S18>/Executed' */
      VIRTUAL_self_driving_stack_v2_B.OutportBufferForExecuted =
        VIRTUAL_self_driving_stack_v2_B.Constant_l;
      VIRTUAL_self_driving_stack_v_DW.LatchInput_SubsysRanBC = 4;
    }

    VIRTUAL_self_driving_st_PrevZCX.LatchInput_Trig_ZCE = rtb_GreaterThan1;
  }

  /* End of Outputs for SubSystem: '<S16>/Latch Input' */

  /* Switch: '<S16>/Switch' */
  if (VIRTUAL_self_driving_stack_v2_B.OutportBufferForExecuted >=
      VIRTUAL_self_driving_stack_v2_P.Switch_Threshold) {
    /* RateTransition generated from: '<S6>/Product' */
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtProductInport1_Buffer0 =
      VIRTUAL_self_driving_stack_v2_B.Input;
  } else {
    /* RateTransition generated from: '<S6>/Product' incorporates:
     *  Constant: '<S6>/Constant5'
     */
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtProductInport1_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.Constant5_Value;
  }

  /* End of Switch: '<S16>/Switch' */

  /* RateTransition generated from: '<S39>/Heading Kalman Filter' */
  VIRTUAL_self_driving_stack_v_DW.TmpRTBAtHeadingKalmanFilterInpo =
    VIRTUAL_self_driving_stack_v2_B.RangingSensor_o5;

  /* RateTransition generated from: '<S39>/QCar EKF' */
  VIRTUAL_self_driving_stack_v_DW.TmpRTBAtQCarEKFInport6_Buffer0 =
    VIRTUAL_self_driving_stack_v2_B.RangingSensor_o5;

  /* S-Function (sample_time_block): '<S26>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming5/Sample Time (sample_time_block) */
  {
    t_error result;
    t_timeout current_time;
    t_timeout time_difference;
    result = timeout_get_high_resolution_time(&current_time);
    if (result >= 0) {
      result = timeout_subtract(&time_difference, &current_time,
        &VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_i);
      VIRTUAL_self_driving_stack_v2_B.SampleTime_l = time_difference.seconds +
        time_difference.nanoseconds * 1e-9;
      memcpy(&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_i,
             &current_time, sizeof(t_timeout));
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Constant: '<S26>/Constant' */
  VIRTUAL_self_driving_stack_v2_B.Constant_ip =
    VIRTUAL_self_driving_stack_v2_P.LiDAR_Sample_Time;

  /* S-Function (computation_time_block): '<S26>/Computation Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming5/Computation Time (computation_time_block) */
  {
    VIRTUAL_self_driving_stack_v2_B.ComputationTime_i =
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_g.seconds +
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_g.nanoseconds
      * 1e-9;
  }
}

/* Model update function for TID4 */
void VIRTUAL_self_driving_stack_v2_update4(void) /* Sample time: [0.068s, 0.0s] */
{
  /* Update for Enabled SubSystem: '<S6>/Match Scans' incorporates:
   *  EnablePort: '<S14>/Enable'
   */
  if (VIRTUAL_self_driving_stack_v_DW.MatchScans_MODE) {
    /* Update for Memory: '<S14>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[0] =
      VIRTUAL_self_driving_stack_v2_B.pose[0];
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[1] =
      VIRTUAL_self_driving_stack_v2_B.pose[1];
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[2] =
      VIRTUAL_self_driving_stack_v2_B.pose[2];
  }

  /* End of Update for SubSystem: '<S6>/Match Scans' */

  /* Update for Memory: '<S15>/Memory' */
  VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_g =
    VIRTUAL_self_driving_stack_v2_B.RangingSensor_o5;

  /* Update absolute time */
  /* The "clockTick4" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick4"
   * and "Timing.stepSize4". Size of "clockTick4" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick4 and the high bits
   * Timing.clockTickH4. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick4)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH4;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[4] =
    VIRTUAL_self_driving_stack_v_M->Timing.clockTick4 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize4 +
    VIRTUAL_self_driving_stack_v_M->Timing.clockTickH4 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize4 * 4294967296.0;
}

/* Model output function for TID5 */
void VIRTUAL_self_driving_stack_v2_output5(void) /* Sample time: [0.1s, 0.0s] */
{
  /* RateTransition: '<S20>/Rate Transition1' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition1[0] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_m[0];

  /* RateTransition: '<S20>/Rate Transition2' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition2[0] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer[0];

  /* RateTransition: '<S20>/Rate Transition1' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition1[1] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_m[1];

  /* RateTransition: '<S20>/Rate Transition2' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition2[1] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer[1];

  /* RateTransition: '<S44>/Rate Transition1' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition1_l[0] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_n[0];

  /* RateTransition: '<S44>/Rate Transition2' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition2_j[0] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer_f[0];

  /* RateTransition: '<S44>/Rate Transition1' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition1_l[1] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition1_Buffer_n[1];

  /* RateTransition: '<S44>/Rate Transition2' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition2_j[1] =
    VIRTUAL_self_driving_stack_v_DW.RateTransition2_Buffer_f[1];

  /* S-Function (sample_time_block): '<S25>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming3/Sample Time (sample_time_block) */
  {
    t_error result;
    t_timeout current_time;
    t_timeout time_difference;
    result = timeout_get_high_resolution_time(&current_time);
    if (result >= 0) {
      result = timeout_subtract(&time_difference, &current_time,
        &VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_n);
      VIRTUAL_self_driving_stack_v2_B.SampleTime_i = time_difference.seconds +
        time_difference.nanoseconds * 1e-9;
      memcpy(&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_n,
             &current_time, sizeof(t_timeout));
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Constant: '<S25>/Constant' */
  VIRTUAL_self_driving_stack_v2_B.Constant_m =
    VIRTUAL_self_driving_stack_v2_P.ImageDisplay_Sample_Time;

  /* S-Function (computation_time_block): '<S25>/Computation Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming3/Computation Time (computation_time_block) */
  {
    VIRTUAL_self_driving_stack_v2_B.ComputationTime_it =
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_c.seconds +
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_c.nanoseconds
      * 1e-9;
  }
}

/* Model update function for TID5 */
void VIRTUAL_self_driving_stack_v2_update5(void) /* Sample time: [0.1s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick5" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick5"
   * and "Timing.stepSize5". Size of "clockTick5" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick5 and the high bits
   * Timing.clockTickH5. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick5)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH5;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[5] =
    VIRTUAL_self_driving_stack_v_M->Timing.clockTick5 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize5 +
    VIRTUAL_self_driving_stack_v_M->Timing.clockTickH5 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize5 * 4294967296.0;
}

/* Model output function for TID6 */
void VIRTUAL_self_driving_stack_v2_output6(void) /* Sample time: [0.6s, 0.0s] */
{
  int32_T i;
  int32_T tmp;

  /* RateTransition generated from: '<Root>/To Host File' */
  VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_semap =
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_Activ;
  tmp = VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_semap * 921600;
  for (i = 0; i < 921600; i++) {
    /* RateTransition generated from: '<Root>/To Host File' */
    VIRTUAL_self_driving_stack_v2_B.TmpRTBAtToHostFileInport1[i] =
      VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_Buffe[i + tmp];
  }
}

/* Model update function for TID6 */
void VIRTUAL_self_driving_stack_v2_update6(void) /* Sample time: [0.6s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick6" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick6"
   * and "Timing.stepSize6". Size of "clockTick6" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick6 and the high bits
   * Timing.clockTickH6. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick6)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH6;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[6] =
    VIRTUAL_self_driving_stack_v_M->Timing.clockTick6 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize6 +
    VIRTUAL_self_driving_stack_v_M->Timing.clockTickH6 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize6 * 4294967296.0;
}

/* Model output function for TID7 */
void VIRTUAL_self_driving_stack_v2_output7(void) /* Sample time: [1.0s, 0.0s] */
{
  /* S-Function (sample_time_block): '<S27>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming7/Sample Time (sample_time_block) */
  {
    t_error result;
    t_timeout current_time;
    t_timeout time_difference;
    result = timeout_get_high_resolution_time(&current_time);
    if (result >= 0) {
      result = timeout_subtract(&time_difference, &current_time,
        &VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_k);
      VIRTUAL_self_driving_stack_v2_B.SampleTime_ij = time_difference.seconds +
        time_difference.nanoseconds * 1e-9;
      memcpy(&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_k,
             &current_time, sizeof(t_timeout));
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Constant: '<S27>/Constant' */
  VIRTUAL_self_driving_stack_v2_B.Constant_a =
    VIRTUAL_self_driving_stack_v2_P.Constant_Value_lc;

  /* S-Function (computation_time_block): '<S27>/Computation Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming7/Computation Time (computation_time_block) */
  {
    VIRTUAL_self_driving_stack_v2_B.ComputationTime_g =
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_d.seconds +
      VIRTUAL_self_driving_stack_v_DW.ComputationTime_ComputationTi_d.nanoseconds
      * 1e-9;
  }
}

/* Model update function for TID7 */
void VIRTUAL_self_driving_stack_v2_update7(void) /* Sample time: [1.0s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick7" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick7"
   * and "Timing.stepSize7". Size of "clockTick7" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick7 and the high bits
   * Timing.clockTickH7. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++VIRTUAL_self_driving_stack_v_M->Timing.clockTick7)) {
    ++VIRTUAL_self_driving_stack_v_M->Timing.clockTickH7;
  }

  VIRTUAL_self_driving_stack_v_M->Timing.t[7] =
    VIRTUAL_self_driving_stack_v_M->Timing.clockTick7 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize7 +
    VIRTUAL_self_driving_stack_v_M->Timing.clockTickH7 *
    VIRTUAL_self_driving_stack_v_M->Timing.stepSize7 * 4294967296.0;
}

/* Use this function only if you need to maintain compatibility with an existing static main program. */
void VIRTUAL_self_driving_stack_v2_output(int_T tid)
{
  switch (tid) {
   case 0 :
    VIRTUAL_self_driving_stack_v2_output0();
    break;

   case 2 :
    VIRTUAL_self_driving_stack_v2_output2();
    break;

   case 3 :
    VIRTUAL_self_driving_stack_v2_output3();
    break;

   case 4 :
    VIRTUAL_self_driving_stack_v2_output4();
    break;

   case 5 :
    VIRTUAL_self_driving_stack_v2_output5();
    break;

   case 6 :
    VIRTUAL_self_driving_stack_v2_output6();
    break;

   case 7 :
    VIRTUAL_self_driving_stack_v2_output7();
    break;

   default :
    /* do nothing */
    break;
  }
}

/* Use this function only if you need to maintain compatibility with an existing static main program. */
void VIRTUAL_self_driving_stack_v2_update(int_T tid)
{
  switch (tid) {
   case 0 :
    VIRTUAL_self_driving_stack_v2_update0();
    break;

   case 2 :
    VIRTUAL_self_driving_stack_v2_update2();
    break;

   case 3 :
    VIRTUAL_self_driving_stack_v2_update3();
    break;

   case 4 :
    VIRTUAL_self_driving_stack_v2_update4();
    break;

   case 5 :
    VIRTUAL_self_driving_stack_v2_update5();
    break;

   case 6 :
    VIRTUAL_self_driving_stack_v2_update6();
    break;

   case 7 :
    VIRTUAL_self_driving_stack_v2_update7();
    break;

   default :
    /* do nothing */
    break;
  }
}

/* Model initialize function */
void VIRTUAL_self_driving_stack_v2_initialize(void)
{
  /* Start for S-Function (hil_initialize_block): '<S9>/HIL Initialize' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/readQCarDAC/HIL Initialize (hil_initialize_block) */
  {
    t_int result;
    t_boolean is_switching;
    result = hil_open("qcar2", "0@tcpip://localhost:18960",
                      &VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }

    is_switching = false;
    result = hil_set_card_specific_options
      (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
       "gyro_fs=250;gyro_rate=500;gyro_bw=125;gyro_ord=3;accel_fs=4;accel_rate=500;accel_bw=250;accel_ord=3;temp_bw=4000;enc0_dir=0;enc1_dir=0;enc2_dir=0;steer_bias=0.05;",
       163);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }

    result = hil_watchdog_clear
      (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card);
    if (result < 0 && result != -QERR_HIL_WATCHDOG_CLEAR) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_AIPStart && !is_switching)
        || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_AIPEnter &&
            is_switching)) {
      {
        int_T i1;
        real_T *dw_AIMinimums =
          &VIRTUAL_self_driving_stack_v_DW.HILInitialize_AIMinimums[0];
        for (i1=0; i1 < 5; i1++) {
          dw_AIMinimums[i1] =
            VIRTUAL_self_driving_stack_v2_P.HILInitialize_AILow;
        }
      }

      {
        int_T i1;
        real_T *dw_AIMaximums =
          &VIRTUAL_self_driving_stack_v_DW.HILInitialize_AIMaximums[0];
        for (i1=0; i1 < 5; i1++) {
          dw_AIMaximums[i1] =
            VIRTUAL_self_driving_stack_v2_P.HILInitialize_AIHigh;
        }
      }

      result = hil_set_analog_input_ranges
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_AIChannels, 5U,
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_AIMinimums[0],
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_AIMaximums[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    result = hil_set_digital_directions
      (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
       VIRTUAL_self_driving_stack_v2_P.HILInitialize_DIChannels, 15U,
       VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOChannels, 16U);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOStart && !is_switching)
        || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOEnter &&
            is_switching)) {
      {
        int_T i1;
        boolean_T *dw_DOBits =
          &VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOBits[0];
        for (i1=0; i1 < 16; i1++) {
          dw_DOBits[i1] =
            VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOInitial;
        }
      }

      result = hil_write_digital
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOChannels, 16U,
         (t_boolean *) &VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOBits[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if (VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOReset) {
      {
        int_T i1;
        int32_T *dw_DOStates =
          &VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOStates[0];
        for (i1=0; i1 < 16; i1++) {
          dw_DOStates[i1] =
            VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOWatchdog;
        }
      }

      result = hil_watchdog_set_digital_expiration_state
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOChannels, 16U, (const
          t_digital_state *)
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOStates[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIPStart && !is_switching)
        || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIPEnter &&
            is_switching)) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_QuadratureModes[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIQuadrature;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_QuadratureModes[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIQuadrature;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_QuadratureModes[2] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIQuadrature;
      result = hil_set_encoder_quadrature_mode
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIChannels, 3U,
         (t_encoder_quadrature_mode *)
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_QuadratureModes[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }

      VIRTUAL_self_driving_stack_v_DW.HILInitialize_FilterFrequency[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIFrequency;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_FilterFrequency[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIFrequency;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_FilterFrequency[2] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIFrequency;
      result = hil_set_encoder_filter_frequency
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIChannels, 3U,
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_FilterFrequency[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIStart && !is_switching)
        || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIEnter &&
            is_switching)) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_InitialEICounts[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIInitial;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_InitialEICounts[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIInitial;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_InitialEICounts[2] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIInitial;
      result = hil_set_encoder_counts
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_EIChannels, 3U,
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_InitialEICounts[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_POPStart && !is_switching)
        || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POPEnter &&
            is_switching)) {
      uint32_T num_duty_cycle_modes = 0;
      uint32_T num_frequency_modes = 0;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POModes;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POModes;
      result = hil_set_pwm_mode
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels, 2U,
         (t_pwm_mode *)
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }

      if (VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0] ==
          PWM_DUTY_CYCLE_MODE ||
          VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0] ==
          PWM_ONE_SHOT_MODE ||
          VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0] ==
          PWM_TIME_MODE ||
          VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0] ==
          PWM_RAW_MODE) {
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedChans[num_duty_cycle_modes]
          = (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels[0]);
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedFreqs[num_duty_cycle_modes]
          = VIRTUAL_self_driving_stack_v2_P.HILInitialize_POFrequency;
        num_duty_cycle_modes++;
      } else {
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedChans[1U -
          num_frequency_modes] =
          (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels[0]);
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedFreqs[1U -
          num_frequency_modes] =
          VIRTUAL_self_driving_stack_v2_P.HILInitialize_POFrequency;
        num_frequency_modes++;
      }

      if (VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[1] ==
          PWM_DUTY_CYCLE_MODE ||
          VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[1] ==
          PWM_ONE_SHOT_MODE ||
          VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[1] ==
          PWM_TIME_MODE ||
          VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[1] ==
          PWM_RAW_MODE) {
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedChans[num_duty_cycle_modes]
          = (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels[1]);
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedFreqs[num_duty_cycle_modes]
          = VIRTUAL_self_driving_stack_v2_P.HILInitialize_POFrequency;
        num_duty_cycle_modes++;
      } else {
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedChans[1U -
          num_frequency_modes] =
          (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels[1]);
        VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedFreqs[1U -
          num_frequency_modes] =
          VIRTUAL_self_driving_stack_v2_P.HILInitialize_POFrequency;
        num_frequency_modes++;
      }

      if (num_duty_cycle_modes > 0) {
        result = hil_set_pwm_frequency
          (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
           &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedChans[0],
           num_duty_cycle_modes,
           &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedFreqs[0]);
        if (result < 0) {
          msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
            (_rt_error_message));
          rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
          return;
        }
      }

      if (num_frequency_modes > 0) {
        result = hil_set_pwm_duty_cycle
          (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
           &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedChans[num_duty_cycle_modes],
           num_frequency_modes,
           &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POSortedFreqs[num_duty_cycle_modes]);
        if (result < 0) {
          msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
            (_rt_error_message));
          rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
          return;
        }
      }

      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POConfiguration;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POConfiguration;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POAlignValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POAlignment;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POAlignValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POAlignment;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POPolarityVals[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POPolarity;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POPolarityVals[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POPolarity;
      result = hil_set_pwm_configuration
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels, 2U,
         (t_pwm_configuration *)
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POModeValues[0],
         (t_pwm_alignment *)
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POAlignValues[0],
         (t_pwm_polarity *)
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POPolarityVals[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_POStart && !is_switching)
        || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POEnter &&
            is_switching)) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POInitial;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POInitial;
      result = hil_write_pwm(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels, 2U,
        &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POReset) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POWatchdog;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POWatchdog;
      result = hil_watchdog_set_pwm_expiration_state
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels, 2U,
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOStart && !is_switching)
        || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOEnter &&
            is_switching)) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOInitial;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOInitial;
      result = hil_write_other
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOChannels, 2U,
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }

    if (VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOReset) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOWatchdog;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOWatchdog;
      result = hil_watchdog_set_other_expiration_state
        (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
         VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOChannels, 2U,
         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        return;
      }
    }
  }

  /* Start for S-Function (hil_read_timebase_block): '<S9>/HIL Read Timebase' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/readQCarDAC/HIL Read Timebase (hil_read_timebase_block) */
  {
    t_error result;
    result = hil_task_create_reader
      (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
       VIRTUAL_self_driving_stack_v2_P.HILReadTimebase_SamplesInBuffer,
       VIRTUAL_self_driving_stack_v2_P.HILReadTimebase_AnalogChannels, 2U,
       &VIRTUAL_self_driving_stack_v2_P.HILReadTimebase_EncoderChannels, 1U,
       NULL, 0U,
       VIRTUAL_self_driving_stack_v2_P.HILReadTimebase_OtherChannels, 7U,
       &VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_Task);
    if (result >= 0) {
      result = hil_task_set_buffer_overflow_mode
        (VIRTUAL_self_driving_stack_v_DW.HILReadTimebase_Task,
         (t_buffer_overflow_mode)
         (VIRTUAL_self_driving_stack_v2_P.HILReadTimebase_OverflowMode - 1));
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* Start for S-Function (inverse_modulus_block): '<S9>/Unwrap 2^24' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/readQCarDAC/Unwrap 2^24 (inverse_modulus_block) */
  {
    VIRTUAL_self_driving_stack_v_DW.Unwrap224_FirstSample = true;
    VIRTUAL_self_driving_stack_v_DW.Unwrap224_Revolutions = 0;
  }

  /* Start for RateTransition: '<S6>/Rate Transition' */
  VIRTUAL_self_driving_stack_v2_B.RateTransition[0] =
    VIRTUAL_self_driving_stack_v2_P.RateTransition_InitialCondition;
  VIRTUAL_self_driving_stack_v2_B.RateTransition[1] =
    VIRTUAL_self_driving_stack_v2_P.RateTransition_InitialCondition;
  VIRTUAL_self_driving_stack_v2_B.RateTransition[2] =
    VIRTUAL_self_driving_stack_v2_P.RateTransition_InitialCondition;

  /* Start for RateTransition generated from: '<S39>/Heading Kalman Filter' */
  VIRTUAL_self_driving_stack_v2_B.TmpRTBAtHeadingKalmanFilterInpo =
    VIRTUAL_self_driving_stack_v2_P.TmpRTBAtHeadingKalmanFilterInpo;

  /* Start for RateTransition generated from: '<S39>/QCar EKF' */
  VIRTUAL_self_driving_stack_v2_B.TmpRTBAtQCarEKFInport6 =
    VIRTUAL_self_driving_stack_v2_P.TmpRTBAtQCarEKFInport6_InitialC;

  /* Start for RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v2_B.light_color =
    VIRTUAL_self_driving_stack_v2_P.light_color_InitialCondition;

  /* Start for RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v2_B.sign_type =
    VIRTUAL_self_driving_stack_v2_P.sign_type_InitialCondition;

  /* Start for RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v2_B.lane_offset =
    VIRTUAL_self_driving_stack_v2_P.lane_offset_InitialCondition;

  /* Start for RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v2_B.lane_detected =
    VIRTUAL_self_driving_stack_v2_P.lane_detected_InitialCondition;

  /* Start for RateTransition generated from: '<Root>/MATLAB Function' */
  VIRTUAL_self_driving_stack_v2_B.sign_size =
    VIRTUAL_self_driving_stack_v2_P.sign_size_InitialCondition;

  /* Start for Enabled SubSystem: '<S12>/Steering Based on LiDAR' */
  VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_MODE = false;
  (void) memset(&(VIRTUAL_self_driving_stack_XDis.GyroFilter_CSTATE), 1,
                1*sizeof(boolean_T));

  /* Start for If: '<S55>/If' */
  VIRTUAL_self_driving_stack_v_DW.If_ActiveSubsystem = -1;

  /* End of Start for SubSystem: '<S12>/Steering Based on LiDAR' */
  /* Start for RateTransition generated from: '<Root>/Sum' */
  VIRTUAL_self_driving_stack_v2_B.steer_correction =
    VIRTUAL_self_driving_stack_v2_P.steer_correction_InitialConditi;

  /* Start for RateTransition generated from: '<S6>/Product' */
  VIRTUAL_self_driving_stack_v2_B.TmpRTBAtProductInport1 =
    VIRTUAL_self_driving_stack_v2_P.TmpRTBAtProductInport1_InitialC;

  /* Start for S-Function (sample_time_block): '<S23>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming1/Sample Time (sample_time_block) */
  {
    t_error result;
    result = timeout_get_high_resolution_time
      (&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Start for S-Function (video_capture_block): '<S1>/rightCSICamera' */
  {
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_BacklightCompens,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rightCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    t_error result;

    /*printf("Opening camera video://localhost:0@tcpip://localhost:18961\n"); fflush(stdout);*/
    result = video_capture_open("video://localhost:0@tcpip://localhost:18961",
      29.411764705882351, 640U, 480U,
      IMAGE_FORMAT_COL_MAJOR_PLANAR_RGB, IMAGE_DATA_TYPE_UINT8,
      &VIRTUAL_self_driving_stack_v_DW.rightCSICamera_VideoCapture,
      local_attr, 18
      );
    if (result >= 0) {
      result = video_capture_start
        (VIRTUAL_self_driving_stack_v_DW.rightCSICamera_VideoCapture);
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* Start for S-Function (video_capture_block): '<S1>/rearCSICamera' */
  {
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_BacklightCompensa,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.rearCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    t_error result;

    /*printf("Opening camera video://localhost:1@tcpip://localhost:18962\n"); fflush(stdout);*/
    result = video_capture_open("video://localhost:1@tcpip://localhost:18962",
      29.411764705882351, 640U, 480U,
      IMAGE_FORMAT_COL_MAJOR_PLANAR_RGB, IMAGE_DATA_TYPE_UINT8,
      &VIRTUAL_self_driving_stack_v_DW.rearCSICamera_VideoCapture,
      local_attr, 18
      );
    if (result >= 0) {
      result = video_capture_start
        (VIRTUAL_self_driving_stack_v_DW.rearCSICamera_VideoCapture);
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* Start for S-Function (video_capture_block): '<S1>/leftCSICamera' */
  {
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_BacklightCompensa,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.leftCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    t_error result;

    /*printf("Opening camera video://localhost:2@tcpip://localhost:18963\n"); fflush(stdout);*/
    result = video_capture_open("video://localhost:2@tcpip://localhost:18963",
      29.411764705882351, 640U, 480U,
      IMAGE_FORMAT_COL_MAJOR_PLANAR_RGB, IMAGE_DATA_TYPE_UINT8,
      &VIRTUAL_self_driving_stack_v_DW.leftCSICamera_VideoCapture,
      local_attr, 18
      );
    if (result >= 0) {
      result = video_capture_start
        (VIRTUAL_self_driving_stack_v_DW.leftCSICamera_VideoCapture);
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* Start for S-Function (video_capture_block): '<S1>/frontCSICamera' */
  {
    t_video_capture_attribute local_attr[18] = {
      { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Brightness,
        VIDEO_CAPTURE_PROPERTY_BRIGHTNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Contrast,
        VIDEO_CAPTURE_PROPERTY_CONTRAST, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Hue,
        VIDEO_CAPTURE_PROPERTY_HUE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Saturation,
        VIDEO_CAPTURE_PROPERTY_SATURATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Sharpness,
        VIDEO_CAPTURE_PROPERTY_SHARPNESS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Gamma,
        VIDEO_CAPTURE_PROPERTY_GAMMA, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_ColorEnable,
        VIDEO_CAPTURE_PROPERTY_COLOREFFECT, (t_boolean) 0, true }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_WhiteBalance,
        VIDEO_CAPTURE_PROPERTY_WHITEBALANCE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_BacklightCompens,
        VIDEO_CAPTURE_PROPERTY_BACKLIGHTCOMPENSATION, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Gain,
        VIDEO_CAPTURE_PROPERTY_GAIN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Pan,
        VIDEO_CAPTURE_PROPERTY_PAN, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Tilt,
        VIDEO_CAPTURE_PROPERTY_TILT, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Roll,
        VIDEO_CAPTURE_PROPERTY_ROLL, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Zoom,
        VIDEO_CAPTURE_PROPERTY_ZOOM, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Exposure,
        VIDEO_CAPTURE_PROPERTY_EXPOSURE, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Iris,
        VIDEO_CAPTURE_PROPERTY_IRIS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Focus,
        VIDEO_CAPTURE_PROPERTY_FOCUS, (t_boolean) 0, false }
      , { VIRTUAL_self_driving_stack_v2_P.frontCSICamera_Mirror,
        VIDEO_CAPTURE_PROPERTY_MIRROR, (t_boolean) 0, true }
    };

    t_error result;

    /*printf("Opening camera video://localhost:3@tcpip://localhost:18964\n"); fflush(stdout);*/
    result = video_capture_open("video://localhost:3@tcpip://localhost:18964",
      29.411764705882351, 640U, 480U,
      IMAGE_FORMAT_COL_MAJOR_PLANAR_RGB, IMAGE_DATA_TYPE_UINT8,
      &VIRTUAL_self_driving_stack_v_DW.frontCSICamera_VideoCapture,
      local_attr, 18
      );
    if (result >= 0) {
      result = video_capture_start
        (VIRTUAL_self_driving_stack_v_DW.frontCSICamera_VideoCapture);
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* Start for S-Function (sample_time_block): '<S22>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming/Sample Time (sample_time_block) */
  {
    t_error result;
    result = timeout_get_high_resolution_time
      (&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_c);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Start for S-Function (sample_time_block): '<S24>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming2/Sample Time (sample_time_block) */
  {
    t_error result;
    result = timeout_get_high_resolution_time
      (&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_d);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Start for S-Function (ranging_sensor_block): '<S5>/Ranging Sensor' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarCapture/Ranging Sensor (ranging_sensor_block) */
  {
    t_error result;
    result = rplidar_open("tcpip://localhost:18966", (t_ranging_distance)
                          (VIRTUAL_self_driving_stack_v2_P.RangingSensor_Range -
      1), &VIRTUAL_self_driving_stack_v_DW.RangingSensor_Sensor);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* Start for Constant: '<S6>/Constant1' */
  memcpy(&VIRTUAL_self_driving_stack_v2_B.Constant1[0],
         &VIRTUAL_self_driving_stack_v2_P.range_qcar2[0], 384U * sizeof(real_T));

  /* Start for Enabled SubSystem: '<S6>/Match Scans' */
  VIRTUAL_self_driving_stack_v_DW.MatchScans_MODE = false;

  /* Start for S-Function (lidar_scan_match_block): '<S14>/LIDAR Scan Match' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarLocalization/Match Scans/LIDAR Scan Match (lidar_scan_match_block) */
  {
    t_error result = lidar2d_match_scans_grid_open
      (&VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Matcher, (float)
       VIRTUAL_self_driving_stack_v2_P.LIDARScanMatch_Resolution, (float)
       VIRTUAL_self_driving_stack_v2_P.LIDARScanMatch_MaxRange);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
    }
  }

  /* End of Start for SubSystem: '<S6>/Match Scans' */

  /* Start for S-Function (inverse_modulus_block): '<S6>/Inverse Modulus1' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarLocalization/Inverse Modulus1 (inverse_modulus_block) */
  {
    VIRTUAL_self_driving_stack_v_DW.InverseModulus1_FirstSample = true;
    VIRTUAL_self_driving_stack_v_DW.InverseModulus1_Revolutions = 0;
  }

  /* Start for Triggered SubSystem: '<S16>/Latch Input' */
  /* Start for Constant: '<S18>/Constant' */
  VIRTUAL_self_driving_stack_v2_B.Constant_l =
    VIRTUAL_self_driving_stack_v2_P.Constant_Value_e;

  /* End of Start for SubSystem: '<S16>/Latch Input' */

  /* Start for S-Function (sample_time_block): '<S26>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming5/Sample Time (sample_time_block) */
  {
    t_error result;
    result = timeout_get_high_resolution_time
      (&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_i);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Start for S-Function (sample_time_block): '<S25>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming3/Sample Time (sample_time_block) */
  {
    t_error result;
    result = timeout_get_high_resolution_time
      (&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_n);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* Start for S-Function (sample_time_block): '<S27>/Sample Time' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/rateTimingPlots/monitorTiming7/Sample Time (sample_time_block) */
  {
    t_error result;
    result = timeout_get_high_resolution_time
      (&VIRTUAL_self_driving_stack_v_DW.SampleTime_PreviousTime_k);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  /* user code (Start function Trailer) */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/pathPlanner/Path 4  Look Ahead Generator/Time (time_block) */
  {
    t_error result;
    result = timeout_get_high_resolution_time(&_high_resolution_start_time);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
      return;
    }
  }

  VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE = UNINITIALIZED_ZCSIG;
  VIRTUAL_self_driving_st_PrevZCX.Integrator_Reset_ZCE_h = UNINITIALIZED_ZCSIG;
  VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE = UNINITIALIZED_ZCSIG;
  VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE_c = UNINITIALIZED_ZCSIG;
  VIRTUAL_self_driving_st_PrevZCX.Integrator1_Reset_ZCE_e = UNINITIALIZED_ZCSIG;
  VIRTUAL_self_driving_st_PrevZCX.LatchInput_Trig_ZCE = POS_ZCSIG;

  {
    int32_T i;

    /* InitializeConditions for Memory: '<S38>/Memory2' */
    VIRTUAL_self_driving_stack_v_DW.Memory2_PreviousInput =
      VIRTUAL_self_driving_stack_v2_P.Memory2_InitialCondition;

    /* InitializeConditions for RateTransition: '<S6>/Rate Transition' */
    VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[0] =
      VIRTUAL_self_driving_stack_v2_P.RateTransition_InitialCondition;
    VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[1] =
      VIRTUAL_self_driving_stack_v2_P.RateTransition_InitialCondition;
    VIRTUAL_self_driving_stack_v_DW.RateTransition_Buffer0[2] =
      VIRTUAL_self_driving_stack_v2_P.RateTransition_InitialCondition;

    /* InitializeConditions for Integrator: '<S38>/Integrator' incorporates:
     *  Integrator: '<S54>/Integrator1'
     */
    if (rtmIsFirstInitCond(VIRTUAL_self_driving_stack_v_M)) {
      VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[0] = 0.0;
      VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[1] = 0.0;
      VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE[2] = 0.0;
      VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_g = 0.0;
    }

    VIRTUAL_self_driving_stack_v_DW.Integrator_DWORK1 = true;

    /* End of InitializeConditions for Integrator: '<S38>/Integrator' */

    /* InitializeConditions for Memory: '<S11>/Memory1' */
    VIRTUAL_self_driving_stack_v_DW.Memory1_PreviousInput =
      VIRTUAL_self_driving_stack_v2_P.Memory1_InitialCondition;

    /* InitializeConditions for RateTransition generated from: '<S39>/Heading Kalman Filter' */
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtHeadingKalmanFilterInpo =
      VIRTUAL_self_driving_stack_v2_P.TmpRTBAtHeadingKalmanFilterInpo;

    /* InitializeConditions for RateTransition generated from: '<S39>/QCar EKF' */
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtQCarEKFInport6_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.TmpRTBAtQCarEKFInport6_InitialC;

    /* InitializeConditions for Integrator: '<S40>/Integrator' */
    VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_n[0] =
      VIRTUAL_self_driving_stack_v2_P.Integrator_IC;
    VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_n[1] =
      VIRTUAL_self_driving_stack_v2_P.Integrator_IC;
    VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_n[2] =
      VIRTUAL_self_driving_stack_v2_P.Integrator_IC;

    /* InitializeConditions for RateTransition generated from: '<Root>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.light_color_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.light_color_InitialCondition;

    /* InitializeConditions for RateTransition generated from: '<Root>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.sign_type_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.sign_type_InitialCondition;

    /* InitializeConditions for RateTransition generated from: '<Root>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.lane_offset_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.lane_offset_InitialCondition;

    /* InitializeConditions for RateTransition generated from: '<Root>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.lane_detected_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.lane_detected_InitialCondition;

    /* InitializeConditions for RateTransition generated from: '<Root>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.sign_size_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.sign_size_InitialCondition;

    /* InitializeConditions for Memory: '<S10>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition;

    /* InitializeConditions for Memory: '<S19>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_o;

    /* InitializeConditions for Memory: '<S53>/Memory1' */
    VIRTUAL_self_driving_stack_v_DW.Memory1_PreviousInput_k =
      VIRTUAL_self_driving_stack_v2_P.Memory1_InitialCondition_f;

    /* InitializeConditions for Integrator: '<S53>/Integrator' */
    VIRTUAL_self_driving_stack_v2_X.Integrator_CSTATE_h =
      VIRTUAL_self_driving_stack_v2_P.Integrator_IC_o;

    /* InitializeConditions for Integrator: '<S53>/Integrator1' */
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_IC;

    /* InitializeConditions for Integrator: '<S54>/Integrator1' */
    VIRTUAL_self_driving_stack_v_DW.Integrator1_DWORK1 = true;

    /* InitializeConditions for RateTransition generated from: '<Root>/Sum' */
    VIRTUAL_self_driving_stack_v_DW.steer_correction_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.steer_correction_InitialConditi;

    /* InitializeConditions for Delay: '<S31>/Delay' */
    VIRTUAL_self_driving_stack_v_DW.icLoad = true;

    /* InitializeConditions for RateTransition generated from: '<S6>/Product' */
    VIRTUAL_self_driving_stack_v_DW.TmpRTBAtProductInport1_Buffer0 =
      VIRTUAL_self_driving_stack_v2_P.TmpRTBAtProductInport1_InitialC;

    /* InitializeConditions for Integrator: '<S33>/Integrator1' */
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_k =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_f;

    /* InitializeConditions for TransferFcn: '<S43>/Transfer Fcn' */
    VIRTUAL_self_driving_stack_v2_X.TransferFcn_CSTATE = 0.0;

    /* InitializeConditions for Memory: '<S6>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[0] =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_f;

    /* InitializeConditions for Integrator: '<S40>/Integrator1' */
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[0] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_d;

    /* InitializeConditions for Memory: '<S6>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[1] =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_f;

    /* InitializeConditions for Integrator: '<S40>/Integrator1' */
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[1] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_d;

    /* InitializeConditions for Memory: '<S6>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_f2[2] =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_f;

    /* InitializeConditions for Integrator: '<S40>/Integrator1' */
    VIRTUAL_self_driving_stack_v2_X.Integrator1_CSTATE_c[2] =
      VIRTUAL_self_driving_stack_v2_P.Integrator1_IC_d;

    /* InitializeConditions for Integrator: '<S54>/Integrator2' */
    VIRTUAL_self_driving_stack_v2_X.Integrator2_CSTATE =
      VIRTUAL_self_driving_stack_v2_P.Integrator2_IC;

    /* InitializeConditions for RateTransition generated from: '<Root>/MATLAB Function1' */
    for (i = 0; i < 921600; i++) {
      VIRTUAL_self_driving_stack_v_DW.TmpRTBAtMATLABFunction1Inport_f[i] =
        VIRTUAL_self_driving_stack_v2_P.TmpRTBAtMATLABFunction1Inport1_;
    }

    /* End of InitializeConditions for RateTransition generated from: '<Root>/MATLAB Function1' */

    /* InitializeConditions for RateTransition generated from: '<Root>/To Host File' */
    for (i = 0; i < 921600; i++) {
      VIRTUAL_self_driving_stack_v_DW.TmpRTBAtToHostFileInport1_Buffe[i] =
        VIRTUAL_self_driving_stack_v2_P.TmpRTBAtToHostFileInport1_Initi;
    }

    /* End of InitializeConditions for RateTransition generated from: '<Root>/To Host File' */

    /* InitializeConditions for Memory: '<S15>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_g =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_p;

    /* SystemInitialize for MATLAB Function: '<Root>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.state = 0.0;
    VIRTUAL_self_driving_stack_v_DW.state_not_empty = true;
    VIRTUAL_self_driving_stack_v_DW.stop_timer = 0.0;
    VIRTUAL_self_driving_stack_v_DW.stop_timer_not_empty = true;
    VIRTUAL_self_driving_stack_v_DW.sign_stop_timer = 0.0;
    VIRTUAL_self_driving_stack_v_DW.sign_stop_timer_not_empty = true;
    VIRTUAL_self_driving_stack_v_DW.sign_stopped = false;
    VIRTUAL_self_driving_stack_v_DW.sign_stopped_not_empty = true;
    VIRTUAL_self_driving_stack_v_DW.red_light_frames = 0.0;
    VIRTUAL_self_driving_stack_v_DW.red_light_frames_not_empty = true;
    VIRTUAL_self_driving_stack_v_DW.sign_frames = 0.0;
    VIRTUAL_self_driving_stack_v_DW.sign_frames_not_empty = true;
    VIRTUAL_self_driving_stack_v_DW.sfEvent_mq = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for MATLAB Function: '<Root>/MATLAB Function1' */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_g = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for MATLAB Function: '<Root>/MATLAB Function2' */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_h = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for Enabled SubSystem: '<S6>/Match Scans' */
    /* SystemInitialize for MATLAB Function: '<S14>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_m = VIRTUAL_self_driving_CALL_EVENT;

    /* InitializeConditions for Memory: '<S14>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[0] =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_h[0];

    /* SystemInitialize for DataTypeConversion: '<S14>/Data Type Conversion' incorporates:
     *  Outport: '<S14>/pose'
     */
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[0] =
      VIRTUAL_self_driving_stack_v2_P.pose_Y0;

    /* InitializeConditions for Memory: '<S14>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[1] =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_h[1];

    /* SystemInitialize for DataTypeConversion: '<S14>/Data Type Conversion' incorporates:
     *  Outport: '<S14>/pose'
     */
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[1] =
      VIRTUAL_self_driving_stack_v2_P.pose_Y0;

    /* InitializeConditions for Memory: '<S14>/Memory' */
    VIRTUAL_self_driving_stack_v_DW.Memory_PreviousInput_e[2] =
      VIRTUAL_self_driving_stack_v2_P.Memory_InitialCondition_h[2];

    /* SystemInitialize for DataTypeConversion: '<S14>/Data Type Conversion' incorporates:
     *  Outport: '<S14>/pose'
     */
    VIRTUAL_self_driving_stack_v2_B.DataTypeConversion[2] =
      VIRTUAL_self_driving_stack_v2_P.pose_Y0;

    /* End of SystemInitialize for SubSystem: '<S6>/Match Scans' */

    /* SystemInitialize for Triggered SubSystem: '<S16>/Latch Input' */
    /* SystemInitialize for SignalConversion generated from: '<S18>/Executed' */
    VIRTUAL_self_driving_stack_v2_B.OutportBufferForExecuted =
      VIRTUAL_self_driving_stack_v2_B.Constant_l;

    /* SystemInitialize for SignalConversion generated from: '<S18>/Input' incorporates:
     *  Outport: '<S18>/Latch'
     */
    VIRTUAL_self_driving_stack_v2_B.Input =
      VIRTUAL_self_driving_stack_v2_P.Latch_Y0;

    /* End of SystemInitialize for SubSystem: '<S16>/Latch Input' */

    /* SystemInitialize for MATLAB Function: '<S19>/Windowed Closest Point Locator *Feedback the location1' */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_bh = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for MATLAB Function: '<S32>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.sfEvent_b = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for MATLAB Function: '<S39>/Heading Kalman Filter' */
    VIRTUAL_self_driving_stack_v_DW.P_m[0] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.P_m[1] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.P_m[2] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.P_m[3] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.X_hat_not_empty_m = false;
    VIRTUAL_self_driving_stack_v_DW.P_not_empty_k = false;
    VIRTUAL_self_driving_stack_v_DW.I_not_empty_n = false;
    VIRTUAL_self_driving_stack_v_DW.A_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.B_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.C_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.X_hat_b[0] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.X_hat_b[1] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.I_i[1] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.I_i[2] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.I_i[0] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.C[0] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.I_i[3] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.C[1] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.sfEvent_j = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for MATLAB Function: '<S39>/QCar EKF' */
    VIRTUAL_self_driving_stack_v_DW.X_hat_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.P_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.I_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.C_heading_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.C_combined_not_empty = false;
    VIRTUAL_self_driving_stack_v_DW.C_heading[0] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.X_hat[0] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.C_heading[1] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.X_hat[1] = 0.0;
    VIRTUAL_self_driving_stack_v_DW.C_heading[2] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.X_hat[2] = 0.0;
    memset(&VIRTUAL_self_driving_stack_v_DW.I[0], 0, 9U * sizeof(real_T));
    memset(&VIRTUAL_self_driving_stack_v_DW.C_combined[0], 0, 9U * sizeof(real_T));
    VIRTUAL_self_driving_stack_v_DW.I[0] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.I[4] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.I[8] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.C_combined[0] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.C_combined[4] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.C_combined[8] = 1.0;
    VIRTUAL_self_driving_stack_v_DW.sfEvent_n = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for MATLAB Function: '<S40>/MATLAB Function' */
    VIRTUAL_self_driving_stack_v_DW.sfEvent = VIRTUAL_self_driving_CALL_EVENT;

    /* SystemInitialize for Enabled SubSystem: '<S12>/Steering Based on LiDAR' */
    /* InitializeConditions for TransferFcn: '<S55>/Gyro Filter' */
    VIRTUAL_self_driving_stack_v2_X.GyroFilter_CSTATE = 0.0;

    /* SystemInitialize for Sum: '<S55>/Sum1' incorporates:
     *  Outport: '<S55>/lidarSteering [1] (rad)'
     */
    VIRTUAL_self_driving_stack_v2_B.Sum1_b =
      VIRTUAL_self_driving_stack_v2_P.lidarSteering1rad_Y0;

    /* End of SystemInitialize for SubSystem: '<S12>/Steering Based on LiDAR' */

    /* set "at time zero" to false */
    if (rtmIsFirstInitCond(VIRTUAL_self_driving_stack_v_M)) {
      rtmSetFirstInitCond(VIRTUAL_self_driving_stack_v_M, 0);
    }
  }
}

/* Model terminate function */
void VIRTUAL_self_driving_stack_v2_terminate(void)
{
  /* Terminate for S-Function (hil_initialize_block): '<S9>/HIL Initialize' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/readQCarDAC/HIL Initialize (hil_initialize_block) */
  {
    t_boolean is_switching;
    t_int result;
    t_uint32 num_final_digital_outputs = 0;
    t_uint32 num_final_pwm_outputs = 0;
    t_uint32 num_final_other_outputs = 0;
    hil_task_stop_all(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card);
    hil_monitor_stop_all(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card);
    is_switching = false;
    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOTerminate &&
         !is_switching) || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOExit
         && is_switching)) {
      {
        int_T i1;
        boolean_T *dw_DOBits =
          &VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOBits[0];
        for (i1=0; i1 < 16; i1++) {
          dw_DOBits[i1] = VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOFinal;
        }
      }

      num_final_digital_outputs = 16U;
    } else {
      num_final_digital_outputs = 0;
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_POTerminate &&
         !is_switching) || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_POExit
         && is_switching)) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POFinal;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_POFinal;
      num_final_pwm_outputs = 2U;
    } else {
      num_final_pwm_outputs = 0;
    }

    if ((VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOTerminate &&
         !is_switching) || (VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOExit
         && is_switching)) {
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[0] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOFinal;
      VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[1] =
        VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOFinal;
      num_final_other_outputs = 2U;
    } else {
      num_final_other_outputs = 0;
    }

    if (0
        || num_final_pwm_outputs > 0
        || num_final_digital_outputs > 0
        || num_final_other_outputs > 0
        ) {
      /* Attempt to write the final outputs atomically (due to firmware issue in old Q2-USB). Otherwise write channels individually */
      result = hil_write(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card
                         , NULL, 0
                         ,
                         VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels,
                         num_final_pwm_outputs
                         ,
                         VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOChannels,
                         num_final_digital_outputs
                         ,
                         VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOChannels,
                         num_final_other_outputs
                         , NULL
                         ,
                         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[
                         0]
                         , (t_boolean *)
                         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOBits[0]
                         ,
                         &VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[
                         0]
                         );
      if (result == -QERR_HIL_WRITE_NOT_SUPPORTED) {
        t_error local_result;
        result = 0;

        /* The hil_write operation is not supported by this card. Write final outputs for each channel type */
        if (num_final_pwm_outputs > 0) {
          local_result = hil_write_pwm
            (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
             VIRTUAL_self_driving_stack_v2_P.HILInitialize_POChannels,
             num_final_pwm_outputs,
             &VIRTUAL_self_driving_stack_v_DW.HILInitialize_POValues[0]);
          if (local_result < 0) {
            result = local_result;
          }
        }

        if (num_final_digital_outputs > 0) {
          local_result = hil_write_digital
            (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
             VIRTUAL_self_driving_stack_v2_P.HILInitialize_DOChannels,
             num_final_digital_outputs, (t_boolean *)
             &VIRTUAL_self_driving_stack_v_DW.HILInitialize_DOBits[0]);
          if (local_result < 0) {
            result = local_result;
          }
        }

        if (num_final_other_outputs > 0) {
          local_result = hil_write_other
            (VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card,
             VIRTUAL_self_driving_stack_v2_P.HILInitialize_OOChannels,
             num_final_other_outputs,
             &VIRTUAL_self_driving_stack_v_DW.HILInitialize_OOValues[0]);
          if (local_result < 0) {
            result = local_result;
          }
        }

        if (result < 0) {
          msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
            (_rt_error_message));
          rtmSetErrorStatus(VIRTUAL_self_driving_stack_v_M, _rt_error_message);
        }
      }
    }

    hil_task_delete_all(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card);
    hil_monitor_delete_all(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card);
    hil_close(VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card);
    VIRTUAL_self_driving_stack_v_DW.HILInitialize_Card = NULL;
  }

  /* Terminate for S-Function (video_capture_block): '<S1>/rightCSICamera' */
  video_capture_stop(VIRTUAL_self_driving_stack_v_DW.rightCSICamera_VideoCapture);
  video_capture_close
    (VIRTUAL_self_driving_stack_v_DW.rightCSICamera_VideoCapture);

  /* Terminate for S-Function (video_capture_block): '<S1>/rearCSICamera' */
  video_capture_stop(VIRTUAL_self_driving_stack_v_DW.rearCSICamera_VideoCapture);
  video_capture_close(VIRTUAL_self_driving_stack_v_DW.rearCSICamera_VideoCapture);

  /* Terminate for S-Function (video_capture_block): '<S1>/leftCSICamera' */
  video_capture_stop(VIRTUAL_self_driving_stack_v_DW.leftCSICamera_VideoCapture);
  video_capture_close(VIRTUAL_self_driving_stack_v_DW.leftCSICamera_VideoCapture);

  /* Terminate for S-Function (video_capture_block): '<S1>/frontCSICamera' */
  video_capture_stop(VIRTUAL_self_driving_stack_v_DW.frontCSICamera_VideoCapture);
  video_capture_close
    (VIRTUAL_self_driving_stack_v_DW.frontCSICamera_VideoCapture);

  /* Terminate for S-Function (ranging_sensor_block): '<S5>/Ranging Sensor' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarCapture/Ranging Sensor (ranging_sensor_block) */
  {
    rplidar_close(VIRTUAL_self_driving_stack_v_DW.RangingSensor_Sensor);
    VIRTUAL_self_driving_stack_v_DW.RangingSensor_Sensor = NULL;
    VIRTUAL_self_driving_stack_v_DW.RangingSensor_Sensor = NULL;
  }

  /* Terminate for Enabled SubSystem: '<S6>/Match Scans' */

  /* Terminate for S-Function (lidar_scan_match_block): '<S14>/LIDAR Scan Match' */

  /* S-Function Block: VIRTUAL_self_driving_stack_v2/lidarLocalization/Match Scans/LIDAR Scan Match (lidar_scan_match_block) */
  {
    lidar2d_match_scans_grid_close
      (VIRTUAL_self_driving_stack_v_DW.LIDARScanMatch_Matcher);
  }

  /* End of Terminate for SubSystem: '<S6>/Match Scans' */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  if (tid == 1)
    tid = 0;
  VIRTUAL_self_driving_stack_v2_output(tid);
}

void MdlUpdate(int_T tid)
{
  if (tid == 1)
    tid = 0;
  VIRTUAL_self_driving_stack_v2_update(tid);
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
  VIRTUAL_self_driving_stack_v2_initialize();
}

void MdlTerminate(void)
{
  VIRTUAL_self_driving_stack_v2_terminate();
}

/* Registration function */
RT_MODEL_VIRTUAL_self_driving_T *VIRTUAL_self_driving_stack_v2(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)VIRTUAL_self_driving_stack_v_M, 0,
                sizeof(RT_MODEL_VIRTUAL_self_driving_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                          &VIRTUAL_self_driving_stack_v_M->Timing.simTimeStep);
    rtsiSetTPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo, &rtmGetTPtr
                (VIRTUAL_self_driving_stack_v_M));
    rtsiSetStepSizePtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                       &VIRTUAL_self_driving_stack_v_M->Timing.stepSize0);
    rtsiSetdXPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                 &VIRTUAL_self_driving_stack_v_M->derivs);
    rtsiSetContStatesPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo, (real_T **)
                         &VIRTUAL_self_driving_stack_v_M->contStates);
    rtsiSetNumContStatesPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
      &VIRTUAL_self_driving_stack_v_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
      &VIRTUAL_self_driving_stack_v_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr
      (&VIRTUAL_self_driving_stack_v_M->solverInfo,
       &VIRTUAL_self_driving_stack_v_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr
      (&VIRTUAL_self_driving_stack_v_M->solverInfo,
       &VIRTUAL_self_driving_stack_v_M->periodicContStateRanges);
    rtsiSetContStateDisabledPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
      (boolean_T**) &VIRTUAL_self_driving_stack_v_M->contStateDisabled);
    rtsiSetErrorStatusPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                          (&rtmGetErrorStatus(VIRTUAL_self_driving_stack_v_M)));
    rtsiSetRTModelPtr(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                      VIRTUAL_self_driving_stack_v_M);
  }

  rtsiSetSimTimeStep(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                     MAJOR_TIME_STEP);
  rtsiSetIsMinorTimeStepWithModeChange
    (&VIRTUAL_self_driving_stack_v_M->solverInfo, false);
  rtsiSetIsContModeFrozen(&VIRTUAL_self_driving_stack_v_M->solverInfo, false);
  VIRTUAL_self_driving_stack_v_M->intgData.f[0] =
    VIRTUAL_self_driving_stack_v_M->odeF[0];
  VIRTUAL_self_driving_stack_v_M->contStates = ((real_T *)
    &VIRTUAL_self_driving_stack_v2_X);
  VIRTUAL_self_driving_stack_v_M->contStateDisabled = ((boolean_T *)
    &VIRTUAL_self_driving_stack_XDis);
  VIRTUAL_self_driving_stack_v_M->Timing.tStart = (0.0);
  rtsiSetSolverData(&VIRTUAL_self_driving_stack_v_M->solverInfo, (void *)
                    &VIRTUAL_self_driving_stack_v_M->intgData);
  rtsiSetSolverName(&VIRTUAL_self_driving_stack_v_M->solverInfo,"ode1");

  /* Initialize timing info */
  {
    int_T *mdlTsMap =
      VIRTUAL_self_driving_stack_v_M->Timing.sampleTimeTaskIDArray;
    int_T i;
    for (i = 0; i < 8; i++) {
      mdlTsMap[i] = i;
    }

    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes =
      (&VIRTUAL_self_driving_stack_v_M->Timing.sampleTimesArray[0]);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes =
      (&VIRTUAL_self_driving_stack_v_M->Timing.offsetTimesArray[0]);

    /* task periods */
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[0] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[1] = (0.002);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[2] = (0.032);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[3] = (0.034);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[4] = (0.068);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[5] = (0.1);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[6] = (0.6);
    VIRTUAL_self_driving_stack_v_M->Timing.sampleTimes[7] = (1.0);

    /* task offsets */
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[0] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[1] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[2] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[3] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[4] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[5] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[6] = (0.0);
    VIRTUAL_self_driving_stack_v_M->Timing.offsetTimes[7] = (0.0);
  }

  rtmSetTPtr(VIRTUAL_self_driving_stack_v_M,
             &VIRTUAL_self_driving_stack_v_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = VIRTUAL_self_driving_stack_v_M->Timing.sampleHitArray;
    int_T *mdlPerTaskSampleHits =
      VIRTUAL_self_driving_stack_v_M->Timing.perTaskSampleHitsArray;
    VIRTUAL_self_driving_stack_v_M->Timing.perTaskSampleHits =
      (&mdlPerTaskSampleHits[0]);
    mdlSampleHits[0] = 1;
    VIRTUAL_self_driving_stack_v_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(VIRTUAL_self_driving_stack_v_M, -1);
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize0 = 0.002;
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize1 = 0.002;
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize2 = 0.032;
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize3 = 0.034;
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize4 = 0.068;
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize5 = 0.1;
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize6 = 0.6;
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize7 = 1.0;
  rtmSetFirstInitCond(VIRTUAL_self_driving_stack_v_M, 1);

  /* External mode info */
  VIRTUAL_self_driving_stack_v_M->Sizes.checksums[0] = (2405321652U);
  VIRTUAL_self_driving_stack_v_M->Sizes.checksums[1] = (4266049009U);
  VIRTUAL_self_driving_stack_v_M->Sizes.checksums[2] = (273322960U);
  VIRTUAL_self_driving_stack_v_M->Sizes.checksums[3] = (2894182929U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[24];
    VIRTUAL_self_driving_stack_v_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = &rtAlwaysEnabled;
    systemRan[4] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.MatchScans_SubsysRanBC;
    systemRan[5] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.MatchScans_SubsysRanBC;
    systemRan[6] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.MatchScans_SubsysRanBC;
    systemRan[7] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.MatchScans_SubsysRanBC;
    systemRan[8] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.LatchInput_SubsysRanBC;
    systemRan[9] = &rtAlwaysEnabled;
    systemRan[10] = &rtAlwaysEnabled;
    systemRan[11] = &rtAlwaysEnabled;
    systemRan[12] = &rtAlwaysEnabled;
    systemRan[13] = &rtAlwaysEnabled;
    systemRan[14] = &rtAlwaysEnabled;
    systemRan[15] = &rtAlwaysEnabled;
    systemRan[16] = &rtAlwaysEnabled;
    systemRan[17] = &rtAlwaysEnabled;
    systemRan[18] = &rtAlwaysEnabled;
    systemRan[19] = &rtAlwaysEnabled;
    systemRan[20] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem.IfActionSubsystem_SubsysRanBC;
    systemRan[21] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem1.IfActionSubsystem_SubsysRanBC;
    systemRan[22] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.IfActionSubsystem2.IfActionSubsystem_SubsysRanBC;
    systemRan[23] = (sysRanDType *)
      &VIRTUAL_self_driving_stack_v_DW.SteeringBasedonLiDAR_SubsysRanB;
    rteiSetModelMappingInfoPtr(VIRTUAL_self_driving_stack_v_M->extModeInfo,
      &VIRTUAL_self_driving_stack_v_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(VIRTUAL_self_driving_stack_v_M->extModeInfo,
                        VIRTUAL_self_driving_stack_v_M->Sizes.checksums);
    rteiSetTPtr(VIRTUAL_self_driving_stack_v_M->extModeInfo, rtmGetTPtr
                (VIRTUAL_self_driving_stack_v_M));
  }

  VIRTUAL_self_driving_stack_v_M->solverInfoPtr =
    (&VIRTUAL_self_driving_stack_v_M->solverInfo);
  VIRTUAL_self_driving_stack_v_M->Timing.stepSize = (0.002);
  rtsiSetFixedStepSize(&VIRTUAL_self_driving_stack_v_M->solverInfo, 0.002);
  rtsiSetSolverMode(&VIRTUAL_self_driving_stack_v_M->solverInfo,
                    SOLVER_MODE_MULTITASKING);

  /* block I/O */
  VIRTUAL_self_driving_stack_v_M->blockIO = ((void *)
    &VIRTUAL_self_driving_stack_v2_B);
  (void) memset(((void *) &VIRTUAL_self_driving_stack_v2_B), 0,
                sizeof(B_VIRTUAL_self_driving_stack__T));

  /* parameters */
  VIRTUAL_self_driving_stack_v_M->defaultParam = ((real_T *)
    &VIRTUAL_self_driving_stack_v2_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &VIRTUAL_self_driving_stack_v2_X;
    VIRTUAL_self_driving_stack_v_M->contStates = (x);
    (void) memset((void *)&VIRTUAL_self_driving_stack_v2_X, 0,
                  sizeof(X_VIRTUAL_self_driving_stack__T));
  }

  /* disabled states */
  {
    boolean_T *xdis = (boolean_T *) &VIRTUAL_self_driving_stack_XDis;
    VIRTUAL_self_driving_stack_v_M->contStateDisabled = (xdis);
    (void) memset((void *)&VIRTUAL_self_driving_stack_XDis, 0,
                  sizeof(XDis_VIRTUAL_self_driving_sta_T));
  }

  /* states (dwork) */
  VIRTUAL_self_driving_stack_v_M->dwork = ((void *)
    &VIRTUAL_self_driving_stack_v_DW);
  (void) memset((void *)&VIRTUAL_self_driving_stack_v_DW, 0,
                sizeof(DW_VIRTUAL_self_driving_stack_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    VIRTUAL_self_driving_stack_v_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 27;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  VIRTUAL_self_driving_stack_v_M->Sizes.numContStates = (16);/* Number of continuous states */
  VIRTUAL_self_driving_stack_v_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  VIRTUAL_self_driving_stack_v_M->Sizes.numY = (0);/* Number of model outputs */
  VIRTUAL_self_driving_stack_v_M->Sizes.numU = (0);/* Number of model inputs */
  VIRTUAL_self_driving_stack_v_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  VIRTUAL_self_driving_stack_v_M->Sizes.numSampTimes = (8);/* Number of sample times */
  VIRTUAL_self_driving_stack_v_M->Sizes.numBlocks = (343);/* Number of blocks */
  VIRTUAL_self_driving_stack_v_M->Sizes.numBlockIO = (116);/* Number of block outputs */
  VIRTUAL_self_driving_stack_v_M->Sizes.numBlockPrms = (6024);/* Sum of parameter "widths" */
  return VIRTUAL_self_driving_stack_v_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
