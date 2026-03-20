/*
 * VIRTUAL_data_collection.h
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

#ifndef VIRTUAL_data_collection_h_
#define VIRTUAL_data_collection_h_
#ifndef VIRTUAL_data_collection_COMMON_INCLUDES_
#define VIRTUAL_data_collection_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_nonfinite.h"
#include "math.h"
#include "dt_info.h"
#include "ext_work.h"
#include "quanser_lidar_match_scans.h"
#include "quanser_messages.h"
#include "quanser_memory.h"
#include "quanser_string.h"
#include "quanser_host.h"
#include "quanser_section.h"
#include "quanser_stream.h"
#include "quanser_thread.h"
#include "hil.h"
#include "quanser_types.h"
#include "quanser_host_game_controller.h"
#include "quanser_start_time.h"
#include "quanser_extern.h"
#include "quanser_time.h"
#include "quanser_video3d.h"
#include "quanser_video.h"
#include "quanser_clamp.h"
#include "quanser_ranging_sensor.h"
#endif                            /* VIRTUAL_data_collection_COMMON_INCLUDES_ */

#include "VIRTUAL_data_collection_types.h"
#include <string.h>
#include "rt_zcfcn.h"
#include "rtGetInf.h"
#include "rtGetNaN.h"
#include "rt_defines.h"
#include "zero_crossing_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetBlockIO
#define rtmGetBlockIO(rtm)             ((rtm)->blockIO)
#endif

#ifndef rtmSetBlockIO
#define rtmSetBlockIO(rtm, val)        ((rtm)->blockIO = (val))
#endif

#ifndef rtmGetChecksums
#define rtmGetChecksums(rtm)           ((rtm)->Sizes.checksums)
#endif

#ifndef rtmSetChecksums
#define rtmSetChecksums(rtm, val)      ((rtm)->Sizes.checksums = (val))
#endif

#ifndef rtmGetConstBlockIO
#define rtmGetConstBlockIO(rtm)        ((rtm)->constBlockIO)
#endif

#ifndef rtmSetConstBlockIO
#define rtmSetConstBlockIO(rtm, val)   ((rtm)->constBlockIO = (val))
#endif

#ifndef rtmGetContStateDisabled
#define rtmGetContStateDisabled(rtm)   ((rtm)->contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
#define rtmSetContStateDisabled(rtm, val) ((rtm)->contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
#define rtmGetContStates(rtm)          ((rtm)->contStates)
#endif

#ifndef rtmSetContStates
#define rtmSetContStates(rtm, val)     ((rtm)->contStates = (val))
#endif

#ifndef rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm) ((rtm)->CTOutputIncnstWithState)
#endif

#ifndef rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm, val) ((rtm)->CTOutputIncnstWithState = (val))
#endif

#ifndef rtmGetCtrlRateMdlRefTiming
#define rtmGetCtrlRateMdlRefTiming(rtm) ()
#endif

#ifndef rtmSetCtrlRateMdlRefTiming
#define rtmSetCtrlRateMdlRefTiming(rtm, val) ()
#endif

#ifndef rtmGetCtrlRateMdlRefTimingPtr
#define rtmGetCtrlRateMdlRefTimingPtr(rtm) ()
#endif

#ifndef rtmSetCtrlRateMdlRefTimingPtr
#define rtmSetCtrlRateMdlRefTimingPtr(rtm, val) ()
#endif

#ifndef rtmGetCtrlRateNumTicksToNextHit
#define rtmGetCtrlRateNumTicksToNextHit(rtm) ()
#endif

#ifndef rtmSetCtrlRateNumTicksToNextHit
#define rtmSetCtrlRateNumTicksToNextHit(rtm, val) ()
#endif

#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm)         ()
#endif

#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val)    ()
#endif

#ifndef rtmGetDefaultParam
#define rtmGetDefaultParam(rtm)        ((rtm)->defaultParam)
#endif

#ifndef rtmSetDefaultParam
#define rtmSetDefaultParam(rtm, val)   ((rtm)->defaultParam = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
#define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
#define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetDirectFeedThrough
#define rtmGetDirectFeedThrough(rtm)   ((rtm)->Sizes.sysDirFeedThru)
#endif

#ifndef rtmSetDirectFeedThrough
#define rtmSetDirectFeedThrough(rtm, val) ((rtm)->Sizes.sysDirFeedThru = (val))
#endif

#ifndef rtmGetErrorStatusFlag
#define rtmGetErrorStatusFlag(rtm)     ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatusFlag
#define rtmSetErrorStatusFlag(rtm, val) ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetFinalTime
#define rtmSetFinalTime(rtm, val)      ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetFirstInitCondFlag
#define rtmGetFirstInitCondFlag(rtm)   ((rtm)->Timing.firstInitCondFlag)
#endif

#ifndef rtmSetFirstInitCondFlag
#define rtmSetFirstInitCondFlag(rtm, val) ((rtm)->Timing.firstInitCondFlag = (val))
#endif

#ifndef rtmGetIntgData
#define rtmGetIntgData(rtm)            ((rtm)->intgData)
#endif

#ifndef rtmSetIntgData
#define rtmSetIntgData(rtm, val)       ((rtm)->intgData = (val))
#endif

#ifndef rtmGetMdlRefGlobalRuntimeEventIndices
#define rtmGetMdlRefGlobalRuntimeEventIndices(rtm) ()
#endif

#ifndef rtmSetMdlRefGlobalRuntimeEventIndices
#define rtmSetMdlRefGlobalRuntimeEventIndices(rtm, val) ()
#endif

#ifndef rtmGetMdlRefGlobalTID
#define rtmGetMdlRefGlobalTID(rtm)     ()
#endif

#ifndef rtmSetMdlRefGlobalTID
#define rtmSetMdlRefGlobalTID(rtm, val) ()
#endif

#ifndef rtmGetMdlRefGlobalTimerIndices
#define rtmGetMdlRefGlobalTimerIndices(rtm) ()
#endif

#ifndef rtmSetMdlRefGlobalTimerIndices
#define rtmSetMdlRefGlobalTimerIndices(rtm, val) ()
#endif

#ifndef rtmGetMdlRefTriggerTID
#define rtmGetMdlRefTriggerTID(rtm)    ()
#endif

#ifndef rtmSetMdlRefTriggerTID
#define rtmSetMdlRefTriggerTID(rtm, val) ()
#endif

#ifndef rtmGetModelMappingInfo
#define rtmGetModelMappingInfo(rtm)    ((rtm)->SpecialInfo.mappingInfo)
#endif

#ifndef rtmSetModelMappingInfo
#define rtmSetModelMappingInfo(rtm, val) ((rtm)->SpecialInfo.mappingInfo = (val))
#endif

#ifndef rtmGetModelName
#define rtmGetModelName(rtm)           ((rtm)->modelName)
#endif

#ifndef rtmSetModelName
#define rtmSetModelName(rtm, val)      ((rtm)->modelName = (val))
#endif

#ifndef rtmGetNonInlinedSFcns
#define rtmGetNonInlinedSFcns(rtm)     ()
#endif

#ifndef rtmSetNonInlinedSFcns
#define rtmSetNonInlinedSFcns(rtm, val) ()
#endif

#ifndef rtmGetNumBlockIO
#define rtmGetNumBlockIO(rtm)          ((rtm)->Sizes.numBlockIO)
#endif

#ifndef rtmSetNumBlockIO
#define rtmSetNumBlockIO(rtm, val)     ((rtm)->Sizes.numBlockIO = (val))
#endif

#ifndef rtmGetNumBlockParams
#define rtmGetNumBlockParams(rtm)      ((rtm)->Sizes.numBlockPrms)
#endif

#ifndef rtmSetNumBlockParams
#define rtmSetNumBlockParams(rtm, val) ((rtm)->Sizes.numBlockPrms = (val))
#endif

#ifndef rtmGetNumBlocks
#define rtmGetNumBlocks(rtm)           ((rtm)->Sizes.numBlocks)
#endif

#ifndef rtmSetNumBlocks
#define rtmSetNumBlocks(rtm, val)      ((rtm)->Sizes.numBlocks = (val))
#endif

#ifndef rtmGetNumContStates
#define rtmGetNumContStates(rtm)       ((rtm)->Sizes.numContStates)
#endif

#ifndef rtmSetNumContStates
#define rtmSetNumContStates(rtm, val)  ((rtm)->Sizes.numContStates = (val))
#endif

#ifndef rtmGetNumDWork
#define rtmGetNumDWork(rtm)            ((rtm)->Sizes.numDwork)
#endif

#ifndef rtmSetNumDWork
#define rtmSetNumDWork(rtm, val)       ((rtm)->Sizes.numDwork = (val))
#endif

#ifndef rtmGetNumInputPorts
#define rtmGetNumInputPorts(rtm)       ((rtm)->Sizes.numIports)
#endif

#ifndef rtmSetNumInputPorts
#define rtmSetNumInputPorts(rtm, val)  ((rtm)->Sizes.numIports = (val))
#endif

#ifndef rtmGetNumNonSampledZCs
#define rtmGetNumNonSampledZCs(rtm)    ((rtm)->Sizes.numNonSampZCs)
#endif

#ifndef rtmSetNumNonSampledZCs
#define rtmSetNumNonSampledZCs(rtm, val) ((rtm)->Sizes.numNonSampZCs = (val))
#endif

#ifndef rtmGetNumOutputPorts
#define rtmGetNumOutputPorts(rtm)      ((rtm)->Sizes.numOports)
#endif

#ifndef rtmSetNumOutputPorts
#define rtmSetNumOutputPorts(rtm, val) ((rtm)->Sizes.numOports = (val))
#endif

#ifndef rtmGetNumPeriodicContStates
#define rtmGetNumPeriodicContStates(rtm) ((rtm)->Sizes.numPeriodicContStates)
#endif

#ifndef rtmSetNumPeriodicContStates
#define rtmSetNumPeriodicContStates(rtm, val) ((rtm)->Sizes.numPeriodicContStates = (val))
#endif

#ifndef rtmGetNumSFcnParams
#define rtmGetNumSFcnParams(rtm)       ((rtm)->Sizes.numSFcnPrms)
#endif

#ifndef rtmSetNumSFcnParams
#define rtmSetNumSFcnParams(rtm, val)  ((rtm)->Sizes.numSFcnPrms = (val))
#endif

#ifndef rtmGetNumSFunctions
#define rtmGetNumSFunctions(rtm)       ((rtm)->Sizes.numSFcns)
#endif

#ifndef rtmSetNumSFunctions
#define rtmSetNumSFunctions(rtm, val)  ((rtm)->Sizes.numSFcns = (val))
#endif

#ifndef rtmGetNumSampleTimes
#define rtmGetNumSampleTimes(rtm)      ((rtm)->Sizes.numSampTimes)
#endif

#ifndef rtmSetNumSampleTimes
#define rtmSetNumSampleTimes(rtm, val) ((rtm)->Sizes.numSampTimes = (val))
#endif

#ifndef rtmGetNumU
#define rtmGetNumU(rtm)                ((rtm)->Sizes.numU)
#endif

#ifndef rtmSetNumU
#define rtmSetNumU(rtm, val)           ((rtm)->Sizes.numU = (val))
#endif

#ifndef rtmGetNumY
#define rtmGetNumY(rtm)                ((rtm)->Sizes.numY)
#endif

#ifndef rtmSetNumY
#define rtmSetNumY(rtm, val)           ((rtm)->Sizes.numY = (val))
#endif

#ifndef rtmGetOdeF
#define rtmGetOdeF(rtm)                ((rtm)->odeF)
#endif

#ifndef rtmSetOdeF
#define rtmSetOdeF(rtm, val)           ((rtm)->odeF = (val))
#endif

#ifndef rtmGetOdeY
#define rtmGetOdeY(rtm)                ()
#endif

#ifndef rtmSetOdeY
#define rtmSetOdeY(rtm, val)           ()
#endif

#ifndef rtmGetOffsetTimeArray
#define rtmGetOffsetTimeArray(rtm)     ((rtm)->Timing.offsetTimesArray)
#endif

#ifndef rtmSetOffsetTimeArray
#define rtmSetOffsetTimeArray(rtm, val) ((rtm)->Timing.offsetTimesArray = (val))
#endif

#ifndef rtmGetOffsetTimePtr
#define rtmGetOffsetTimePtr(rtm)       ((rtm)->Timing.offsetTimes)
#endif

#ifndef rtmSetOffsetTimePtr
#define rtmSetOffsetTimePtr(rtm, val)  ((rtm)->Timing.offsetTimes = (val))
#endif

#ifndef rtmGetOptions
#define rtmGetOptions(rtm)             ((rtm)->Sizes.options)
#endif

#ifndef rtmSetOptions
#define rtmSetOptions(rtm, val)        ((rtm)->Sizes.options = (val))
#endif

#ifndef rtmGetParamIsMalloced
#define rtmGetParamIsMalloced(rtm)     ()
#endif

#ifndef rtmSetParamIsMalloced
#define rtmSetParamIsMalloced(rtm, val) ()
#endif

#ifndef rtmGetPath
#define rtmGetPath(rtm)                ((rtm)->path)
#endif

#ifndef rtmSetPath
#define rtmSetPath(rtm, val)           ((rtm)->path = (val))
#endif

#ifndef rtmGetPerTaskSampleHits
#define rtmGetPerTaskSampleHits(rtm)   ((rtm)->Timing.RateInteraction)
#endif

#ifndef rtmSetPerTaskSampleHits
#define rtmSetPerTaskSampleHits(rtm, val) ((rtm)->Timing.RateInteraction = (val))
#endif

#ifndef rtmGetPerTaskSampleHitsArray
#define rtmGetPerTaskSampleHitsArray(rtm) ((rtm)->Timing.perTaskSampleHitsArray)
#endif

#ifndef rtmSetPerTaskSampleHitsArray
#define rtmSetPerTaskSampleHitsArray(rtm, val) ((rtm)->Timing.perTaskSampleHitsArray = (val))
#endif

#ifndef rtmGetPerTaskSampleHitsPtr
#define rtmGetPerTaskSampleHitsPtr(rtm) ((rtm)->Timing.perTaskSampleHits)
#endif

#ifndef rtmSetPerTaskSampleHitsPtr
#define rtmSetPerTaskSampleHitsPtr(rtm, val) ((rtm)->Timing.perTaskSampleHits = (val))
#endif

#ifndef rtmGetPeriodicContStateIndices
#define rtmGetPeriodicContStateIndices(rtm) ((rtm)->periodicContStateIndices)
#endif

#ifndef rtmSetPeriodicContStateIndices
#define rtmSetPeriodicContStateIndices(rtm, val) ((rtm)->periodicContStateIndices = (val))
#endif

#ifndef rtmGetPeriodicContStateRanges
#define rtmGetPeriodicContStateRanges(rtm) ((rtm)->periodicContStateRanges)
#endif

#ifndef rtmSetPeriodicContStateRanges
#define rtmSetPeriodicContStateRanges(rtm, val) ((rtm)->periodicContStateRanges = (val))
#endif

#ifndef rtmGetPrevZCSigState
#define rtmGetPrevZCSigState(rtm)      ((rtm)->prevZCSigState)
#endif

#ifndef rtmSetPrevZCSigState
#define rtmSetPrevZCSigState(rtm, val) ((rtm)->prevZCSigState = (val))
#endif

#ifndef rtmGetProxyFunctions
#define rtmGetProxyFunctions(rtm)      ()
#endif

#ifndef rtmSetProxyFunctions
#define rtmSetProxyFunctions(rtm, val) ()
#endif

#ifndef rtmGetRTWExtModeInfo
#define rtmGetRTWExtModeInfo(rtm)      ((rtm)->extModeInfo)
#endif

#ifndef rtmSetRTWExtModeInfo
#define rtmSetRTWExtModeInfo(rtm, val) ((rtm)->extModeInfo = (val))
#endif

#ifndef rtmGetRTWGeneratedSFcn
#define rtmGetRTWGeneratedSFcn(rtm)    ((rtm)->Sizes.rtwGenSfcn)
#endif

#ifndef rtmSetRTWGeneratedSFcn
#define rtmSetRTWGeneratedSFcn(rtm, val) ((rtm)->Sizes.rtwGenSfcn = (val))
#endif

#ifndef rtmGetRTWLogInfo
#define rtmGetRTWLogInfo(rtm)          ()
#endif

#ifndef rtmSetRTWLogInfo
#define rtmSetRTWLogInfo(rtm, val)     ()
#endif

#ifndef rtmGetRTWRTModelMethodsInfo
#define rtmGetRTWRTModelMethodsInfo(rtm) ()
#endif

#ifndef rtmSetRTWRTModelMethodsInfo
#define rtmSetRTWRTModelMethodsInfo(rtm, val) ()
#endif

#ifndef rtmGetRTWSfcnInfo
#define rtmGetRTWSfcnInfo(rtm)         ((rtm)->sfcnInfo)
#endif

#ifndef rtmSetRTWSfcnInfo
#define rtmSetRTWSfcnInfo(rtm, val)    ((rtm)->sfcnInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfo
#define rtmGetRTWSolverInfo(rtm)       ((rtm)->solverInfo)
#endif

#ifndef rtmSetRTWSolverInfo
#define rtmSetRTWSolverInfo(rtm, val)  ((rtm)->solverInfo = (val))
#endif

#ifndef rtmGetRTWSolverInfoPtr
#define rtmGetRTWSolverInfoPtr(rtm)    ((rtm)->solverInfoPtr)
#endif

#ifndef rtmSetRTWSolverInfoPtr
#define rtmSetRTWSolverInfoPtr(rtm, val) ((rtm)->solverInfoPtr = (val))
#endif

#ifndef rtmGetReservedForXPC
#define rtmGetReservedForXPC(rtm)      ((rtm)->SpecialInfo.xpcData)
#endif

#ifndef rtmSetReservedForXPC
#define rtmSetReservedForXPC(rtm, val) ((rtm)->SpecialInfo.xpcData = (val))
#endif

#ifndef rtmGetRootDWork
#define rtmGetRootDWork(rtm)           ((rtm)->dwork)
#endif

#ifndef rtmSetRootDWork
#define rtmSetRootDWork(rtm, val)      ((rtm)->dwork = (val))
#endif

#ifndef rtmGetSFunctions
#define rtmGetSFunctions(rtm)          ((rtm)->childSfunctions)
#endif

#ifndef rtmSetSFunctions
#define rtmSetSFunctions(rtm, val)     ((rtm)->childSfunctions = (val))
#endif

#ifndef rtmGetSampleHitArray
#define rtmGetSampleHitArray(rtm)      ((rtm)->Timing.sampleHitArray)
#endif

#ifndef rtmSetSampleHitArray
#define rtmSetSampleHitArray(rtm, val) ((rtm)->Timing.sampleHitArray = (val))
#endif

#ifndef rtmGetSampleHitPtr
#define rtmGetSampleHitPtr(rtm)        ((rtm)->Timing.sampleHits)
#endif

#ifndef rtmSetSampleHitPtr
#define rtmSetSampleHitPtr(rtm, val)   ((rtm)->Timing.sampleHits = (val))
#endif

#ifndef rtmGetSampleTimeArray
#define rtmGetSampleTimeArray(rtm)     ((rtm)->Timing.sampleTimesArray)
#endif

#ifndef rtmSetSampleTimeArray
#define rtmSetSampleTimeArray(rtm, val) ((rtm)->Timing.sampleTimesArray = (val))
#endif

#ifndef rtmGetSampleTimePtr
#define rtmGetSampleTimePtr(rtm)       ((rtm)->Timing.sampleTimes)
#endif

#ifndef rtmSetSampleTimePtr
#define rtmSetSampleTimePtr(rtm, val)  ((rtm)->Timing.sampleTimes = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDArray
#define rtmGetSampleTimeTaskIDArray(rtm) ((rtm)->Timing.sampleTimeTaskIDArray)
#endif

#ifndef rtmSetSampleTimeTaskIDArray
#define rtmSetSampleTimeTaskIDArray(rtm, val) ((rtm)->Timing.sampleTimeTaskIDArray = (val))
#endif

#ifndef rtmGetSampleTimeTaskIDPtr
#define rtmGetSampleTimeTaskIDPtr(rtm) ((rtm)->Timing.sampleTimeTaskIDPtr)
#endif

#ifndef rtmSetSampleTimeTaskIDPtr
#define rtmSetSampleTimeTaskIDPtr(rtm, val) ((rtm)->Timing.sampleTimeTaskIDPtr = (val))
#endif

#ifndef rtmGetSelf
#define rtmGetSelf(rtm)                ()
#endif

#ifndef rtmSetSelf
#define rtmSetSelf(rtm, val)           ()
#endif

#ifndef rtmGetSimMode
#define rtmGetSimMode(rtm)             ((rtm)->simMode)
#endif

#ifndef rtmSetSimMode
#define rtmSetSimMode(rtm, val)        ((rtm)->simMode = (val))
#endif

#ifndef rtmGetSimTimeStep
#define rtmGetSimTimeStep(rtm)         ((rtm)->Timing.simTimeStep)
#endif

#ifndef rtmSetSimTimeStep
#define rtmSetSimTimeStep(rtm, val)    ((rtm)->Timing.simTimeStep = (val))
#endif

#ifndef rtmGetStartTime
#define rtmGetStartTime(rtm)           ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetStartTime
#define rtmSetStartTime(rtm, val)      ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmGetStepSize
#define rtmGetStepSize(rtm)            ((rtm)->Timing.stepSize)
#endif

#ifndef rtmSetStepSize
#define rtmSetStepSize(rtm, val)       ((rtm)->Timing.stepSize = (val))
#endif

#ifndef rtmGetStopRequestedFlag
#define rtmGetStopRequestedFlag(rtm)   ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequestedFlag
#define rtmSetStopRequestedFlag(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStubFunctions
#define rtmGetStubFunctions(rtm)       ()
#endif

#ifndef rtmSetStubFunctions
#define rtmSetStubFunctions(rtm, val)  ()
#endif

#ifndef rtmGetTaskCounters
#define rtmGetTaskCounters(rtm)        ((rtm)->Timing.TaskCounters)
#endif

#ifndef rtmSetTaskCounters
#define rtmSetTaskCounters(rtm, val)   ((rtm)->Timing.TaskCounters = (val))
#endif

#ifndef rtmGetTaskTimeArray
#define rtmGetTaskTimeArray(rtm)       ((rtm)->Timing.tArray)
#endif

#ifndef rtmSetTaskTimeArray
#define rtmSetTaskTimeArray(rtm, val)  ((rtm)->Timing.tArray = (val))
#endif

#ifndef rtmGetTimePtr
#define rtmGetTimePtr(rtm)             ((rtm)->Timing.t)
#endif

#ifndef rtmSetTimePtr
#define rtmSetTimePtr(rtm, val)        ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTimingData
#define rtmGetTimingData(rtm)          ((rtm)->Timing.timingData)
#endif

#ifndef rtmSetTimingData
#define rtmSetTimingData(rtm, val)     ((rtm)->Timing.timingData = (val))
#endif

#ifndef rtmGetU
#define rtmGetU(rtm)                   ((rtm)->inputs)
#endif

#ifndef rtmSetU
#define rtmSetU(rtm, val)              ((rtm)->inputs = (val))
#endif

#ifndef rtmGetVarNextHitTimesListPtr
#define rtmGetVarNextHitTimesListPtr(rtm) ((rtm)->Timing.varNextHitTimesList)
#endif

#ifndef rtmSetVarNextHitTimesListPtr
#define rtmSetVarNextHitTimesListPtr(rtm, val) ((rtm)->Timing.varNextHitTimesList = (val))
#endif

#ifndef rtmGetY
#define rtmGetY(rtm)                   ((rtm)->outputs)
#endif

#ifndef rtmSetY
#define rtmSetY(rtm, val)              ((rtm)->outputs = (val))
#endif

#ifndef rtmGetZCCacheNeedsReset
#define rtmGetZCCacheNeedsReset(rtm)   ((rtm)->zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
#define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetZCSignalValues
#define rtmGetZCSignalValues(rtm)      ((rtm)->zcSignalValues)
#endif

#ifndef rtmSetZCSignalValues
#define rtmSetZCSignalValues(rtm, val) ((rtm)->zcSignalValues = (val))
#endif

#ifndef rtmGet_TimeOfLastOutput
#define rtmGet_TimeOfLastOutput(rtm)   ((rtm)->Timing.timeOfLastOutput)
#endif

#ifndef rtmSet_TimeOfLastOutput
#define rtmSet_TimeOfLastOutput(rtm, val) ((rtm)->Timing.timeOfLastOutput = (val))
#endif

#ifndef rtmGetdX
#define rtmGetdX(rtm)                  ((rtm)->derivs)
#endif

#ifndef rtmSetdX
#define rtmSetdX(rtm, val)             ((rtm)->derivs = (val))
#endif

#ifndef rtmGettimingBridge
#define rtmGettimingBridge(rtm)        ()
#endif

#ifndef rtmSettimingBridge
#define rtmSettimingBridge(rtm, val)   ()
#endif

#ifndef rtmGetChecksumVal
#define rtmGetChecksumVal(rtm, idx)    ((rtm)->Sizes.checksums[idx])
#endif

#ifndef rtmSetChecksumVal
#define rtmSetChecksumVal(rtm, idx, val) ((rtm)->Sizes.checksums[idx] = (val))
#endif

#ifndef rtmGetDWork
#define rtmGetDWork(rtm, idx)          ((rtm)->dwork[idx])
#endif

#ifndef rtmSetDWork
#define rtmSetDWork(rtm, idx, val)     ((rtm)->dwork[idx] = (val))
#endif

#ifndef rtmGetOffsetTime
#define rtmGetOffsetTime(rtm, idx)     ((rtm)->Timing.offsetTimes[idx])
#endif

#ifndef rtmSetOffsetTime
#define rtmSetOffsetTime(rtm, idx, val) ((rtm)->Timing.offsetTimes[idx] = (val))
#endif

#ifndef rtmGetSFunction
#define rtmGetSFunction(rtm, idx)      ((rtm)->childSfunctions[idx])
#endif

#ifndef rtmSetSFunction
#define rtmSetSFunction(rtm, idx, val) ((rtm)->childSfunctions[idx] = (val))
#endif

#ifndef rtmGetSampleTime
#define rtmGetSampleTime(rtm, idx)     ((rtm)->Timing.sampleTimes[idx])
#endif

#ifndef rtmSetSampleTime
#define rtmSetSampleTime(rtm, idx, val) ((rtm)->Timing.sampleTimes[idx] = (val))
#endif

#ifndef rtmGetSampleTimeTaskID
#define rtmGetSampleTimeTaskID(rtm, idx) ((rtm)->Timing.sampleTimeTaskIDPtr[idx])
#endif

#ifndef rtmSetSampleTimeTaskID
#define rtmSetSampleTimeTaskID(rtm, idx, val) ((rtm)->Timing.sampleTimeTaskIDPtr[idx] = (val))
#endif

#ifndef rtmGetVarNextHitTimeList
#define rtmGetVarNextHitTimeList(rtm, idx) ((rtm)->Timing.varNextHitTimesList[idx])
#endif

#ifndef rtmSetVarNextHitTimeList
#define rtmSetVarNextHitTimeList(rtm, idx, val) ((rtm)->Timing.varNextHitTimesList[idx] = (val))
#endif

#ifndef rtmIsContinuousTask
#define rtmIsContinuousTask(rtm, tid)  ((tid) <= 1)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmSetFirstInitCond
#define rtmSetFirstInitCond(rtm, val)  ((rtm)->Timing.firstInitCondFlag = (val))
#endif

#ifndef rtmIsFirstInitCond
#define rtmIsFirstInitCond(rtm)        ((rtm)->Timing.firstInitCondFlag)
#endif

#ifndef rtmIsMajorTimeStep
#define rtmIsMajorTimeStep(rtm)        (((rtm)->Timing.simTimeStep) == MAJOR_TIME_STEP)
#endif

#ifndef rtmIsMinorTimeStep
#define rtmIsMinorTimeStep(rtm)        (((rtm)->Timing.simTimeStep) == MINOR_TIME_STEP)
#endif

#ifndef rtmIsSampleHit
#define rtmIsSampleHit(rtm, sti, tid)  (((rtm)->Timing.sampleTimeTaskIDPtr[sti] == (tid)))
#endif

#ifndef rtmStepTask
#define rtmStepTask(rtm, idx)          ((rtm)->Timing.TaskCounters.TID[(idx)] == 0)
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmSetT
#define rtmSetT(rtm, val)                                        /* Do Nothing */
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmSetTFinal
#define rtmSetTFinal(rtm, val)         ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                ((rtm)->Timing.t)
#endif

#ifndef rtmSetTPtr
#define rtmSetTPtr(rtm, val)           ((rtm)->Timing.t = (val))
#endif

#ifndef rtmGetTStart
#define rtmGetTStart(rtm)              ((rtm)->Timing.tStart)
#endif

#ifndef rtmSetTStart
#define rtmSetTStart(rtm, val)         ((rtm)->Timing.tStart = (val))
#endif

#ifndef rtmTaskCounter
#define rtmTaskCounter(rtm, idx)       ((rtm)->Timing.TaskCounters.TID[(idx)])
#endif

#ifndef rtmGetTaskTime
#define rtmGetTaskTime(rtm, sti)       (rtmGetTPtr((rtm))[(rtm)->Timing.sampleTimeTaskIDPtr[sti]])
#endif

#ifndef rtmSetTaskTime
#define rtmSetTaskTime(rtm, sti, val)  (rtmGetTPtr((rtm))[sti] = (val))
#endif

#ifndef rtmGetTimeOfLastOutput
#define rtmGetTimeOfLastOutput(rtm)    ((rtm)->Timing.timeOfLastOutput)
#endif

#ifdef rtmGetRTWSolverInfo
#undef rtmGetRTWSolverInfo
#endif

#define rtmGetRTWSolverInfo(rtm)       &((rtm)->solverInfo)

/* Definition for use in the target main file */
#define VIRTUAL_data_collection_rtModel RT_MODEL_VIRTUAL_data_collect_T

/* Block states (default storage) for system '<S56>/If Action Subsystem' */
typedef struct {
  int8_T IfActionSubsystem_SubsysRanBC;/* '<S56>/If Action Subsystem' */
} DW_IfActionSubsystem_VIRTUAL__T;

/* Block signals (default storage) */
typedef struct {
  real_T H[307200];
  real_T S[307200];
  real_T V[307200];
  uint8_T TmpRTBAtMATLABFunction1Inpo[921600];
  t_uint64 realsenseDepthCapture_o2;   /* '<S10>/realsenseDepthCapture' */
  real_T encodercounts;                /* '<S9>/HIL Read Timebase' */
  real_T z;                            /* '<S9>/HIL Read Timebase' */
  real_T wheelspeedms;                 /* '<S30>/wheel radius' */
  real_T RateTransition[3];            /* '<S6>/Rate Transition' */
  real_T CalibrationBias[3];           /* '<S6>/Calibration Bias' */
  real_T Bias1;                        /* '<S42>/Bias1' */
  real_T Sum1[2];                      /* '<S12>/Sum1' */
  real_T ManualSwitch1;                /* '<S12>/Manual Switch1' */
  real_T Clock;                        /* '<Root>/Clock' */
  real_T light_color;
  real_T sign_type;
  real_T lane_offset;
  real_T sign_size;
  real_T HostGameController_o3[2];     /* '<Root>/Host Game Controller' */
  real_T HostGameController_o4;        /* '<Root>/Host Game Controller' */
  real_T Gain2;                        /* '<Root>/Gain2' */
  real_T motorSat;                     /* '<S11>/motorSat' */
  real_T Product;                      /* '<S35>/Product' */
  real_T DifferenceInputs2;            /* '<S32>/Difference Inputs2' */
  real_T TmpRTBAtProductInport1;       /* '<S6>/rising edge latch' */
  real_T Product_o;                    /* '<S6>/Product' */
  real_T desired;                      /* '<S34>/Multiply1' */
  real_T Kffms;                        /* '<S34>/Kff  (% // m//s)' */
  real_T measured;                     /* '<S34>/Multiply' */
  real_T Kpms;                         /* '<S34>/Kp (% // m//s)' */
  real_T motorsat;                     /* '<S14>/motor sat' */
  real_T Floor;                        /* '<S20>/Floor' */
  real_T ManualSwitch;                 /* '<S20>/Manual Switch' */
  real_T Memory;                       /* '<S20>/Memory' */
  real_T Selector1;                    /* '<S20>/Selector1' */
  real_T Selector2;                    /* '<S20>/Selector2' */
  real_T Kim;                          /* '<S34>/Ki (% // m)  ' */
  real_T Bias1_e;                      /* '<S43>/Bias1' */
  real_T m_to_mm[2];                   /* '<S39>/m_to_mm' */
  real_T Gain;                         /* '<S47>/Gain' */
  real_T RT_a[3];                      /* '<S39>/RT' */
  real_T LiDAR;                        /* '<S39>/LiDAR' */
  real_T m_to_mm2[2];                  /* '<S39>/m_to_mm2' */
  real_T Gain_l;                       /* '<S49>/Gain' */
  real_T Bias1_ej[3];                  /* '<S46>/Bias1' */
  real_T TransferFcn;                  /* '<S44>/Transfer Fcn' */
  real_T TmpSignalConversionAtIntegrator[3];
  real_T ManualSwitch_f;               /* '<S41>/Manual Switch' */
  real_T Subtract1[3];                 /* '<S41>/Subtract1' */
  real_T ki[3];                        /* '<S41>/ki' */
  real_T Integrator;                   /* '<S54>/Integrator' */
  real_T Cos;                          /* '<S54>/Cos' */
  real_T Cos1;                         /* '<S54>/Cos1' */
  real_T Saturation1;                  /* '<S54>/Saturation1' */
  real_T Sum2;                         /* '<S54>/Sum2' */
  real_T final;                        /* '<S13>/Sum' */
  real_T Integrator1;                  /* '<S55>/Integrator1' */
  real_T Gain6;                        /* '<S54>/Gain6' */
  real_T Product_c;                    /* '<S55>/Product' */
  real_T Product1;                     /* '<S55>/Product1' */
  real_T SampleTime;                   /* '<S24>/Sample Time' */
  real_T Constant;                     /* '<S24>/Constant' */
  real_T ComputationTime;              /* '<S24>/Computation Time' */
  real_T realsenseDepthCapture_o3;     /* '<S10>/realsenseDepthCapture' */
  real_T SampleTime_f;                 /* '<S23>/Sample Time' */
  real_T Constant_i;                   /* '<S23>/Constant' */
  real_T ComputationTime_h;            /* '<S23>/Computation Time' */
  real_T SampleTime_fc;                /* '<S25>/Sample Time' */
  real_T Constant_f;                   /* '<S25>/Constant' */
  real_T ComputationTime_b;            /* '<S25>/Computation Time' */
  real_T RangingSensor_o1[1000];       /* '<S5>/Ranging Sensor' */
  real_T RangingSensor_o2[1000];       /* '<S5>/Ranging Sensor' */
  real_T RangingSensor_o3[1000];       /* '<S5>/Ranging Sensor' */
  real_T RangingSensor_o4[1000];       /* '<S5>/Ranging Sensor' */
  real_T Bias[1000];                   /* '<S6>/Bias' */
  real_T d_data[1000];
  real_T new_range[1000];              /* '<S15>/MATLAB Function' */
  real_T new_angles[1000];             /* '<S15>/MATLAB Function' */
  real_T Constant1[384];               /* '<S6>/Constant1' */
  real_T Bias2[384];                   /* '<S6>/Bias2' */
  real_T SampleTime_l;                 /* '<S27>/Sample Time' */
  real_T Constant_ip;                  /* '<S27>/Constant' */
  real_T ComputationTime_i;            /* '<S27>/Computation Time' */
  real_T RateTransition1[2];           /* '<S21>/Rate Transition1' */
  real_T RateTransition2[2];           /* '<S21>/Rate Transition2' */
  real_T RateTransition1_l[2];         /* '<S45>/Rate Transition1' */
  real_T RateTransition2_j[2];         /* '<S45>/Rate Transition2' */
  real_T SampleTime_i;                 /* '<S26>/Sample Time' */
  real_T Constant_m;                   /* '<S26>/Constant' */
  real_T ComputationTime_it;           /* '<S26>/Computation Time' */
  real_T SampleTime_ij;                /* '<S28>/Sample Time' */
  real_T Constant_a;                   /* '<S28>/Constant' */
  real_T ComputationTime_g;            /* '<S28>/Computation Time' */
  real_T Sum1_b;                       /* '<S56>/Sum1' */
  real_T correction_weight;            /* '<S41>/MATLAB Function' */
  real_T Xhat[3];                      /* '<S40>/QCar EKF' */
  real_T location;
            /* '<S20>/Windowed Closest Point Locator *Feedback the location1' */
  real_T distance;
            /* '<S20>/Windowed Closest Point Locator *Feedback the location1' */
  real_T Input;                        /* '<S19>/Input' */
  real_T OutportBufferForExecuted;     /* '<S19>/Constant' */
  real_T Switch[3];                    /* '<S15>/Switch' */
  real_T DataTypeConversion[3];        /* '<S15>/Data Type Conversion' */
  real_T steer_correction;             /* '<Root>/MATLAB Function2' */
  real_T light_color_e;                /* '<Root>/MATLAB Function1' */
  real_T sign_type_h;                  /* '<Root>/MATLAB Function1' */
  real_T speed_scale;                  /* '<Root>/MATLAB Function' */
  real_T Constant_l;                   /* '<S19>/Constant' */
  real32_T realsenseDepthCapture_o1[307200];/* '<S10>/realsenseDepthCapture' */
  real32_T pose[3];                    /* '<S15>/LIDAR Scan Match' */
  real32_T LIDARScanMatch_o2;          /* '<S15>/LIDAR Scan Match' */
  real32_T Subtract[3];                /* '<S15>/Subtract' */
  int32_T HostInitialize_o2;           /* '<Root>/Host Initialize' */
  uint16_T RangingSensor_o6;           /* '<S5>/Ranging Sensor' */
  uint16_T RangingSensor_o7[4];        /* '<S5>/Ranging Sensor' */
  uint16_T RangingSensor_o8[4];        /* '<S5>/Ranging Sensor' */
  uint8_T HostInitialize_o1;           /* '<Root>/Host Initialize' */
  uint8_T rightCSICamera_o1[921600];   /* '<S1>/rightCSICamera' */
  uint8_T rearCSICamera_o1[921600];    /* '<S1>/rearCSICamera' */
  uint8_T leftCSICamera_o1[921600];    /* '<S1>/leftCSICamera' */
  uint8_T frontCSICamera_o1[921600];   /* '<S1>/frontCSICamera' */
  uint8_T TmpRTBAtToWorkspaceInport1[921600];/* '<Root>/CSICameras' */
  boolean_T RelationalOperator1;       /* '<S39>/Relational Operator1' */
  boolean_T TmpRTBAtHeadingKalmanFilterInpo;
  boolean_T TmpRTBAtQCarEKFInport6;
  boolean_T lane_detected;
  boolean_T Compare;                   /* '<S38>/Compare' */
  boolean_T Compare_e;                 /* '<S53>/Compare' */
  boolean_T OR;                        /* '<S54>/OR' */
  boolean_T RangingSensor_o5;          /* '<S5>/Ranging Sensor' */
} B_VIRTUAL_data_collection_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  t_game_controller_states HostGameController_ControllerSt;/* '<Root>/Host Game Controller' */
  qthread_section_t HostGameController_Lock;/* '<Root>/Host Game Controller' */
  t_ranging_measurement RangingSensor_Measurements[1000];/* '<S5>/Ranging Sensor' */
  t_timeout Time1_Timeout;             /* '<S6>/Time1' */
  t_timeout Time_Timeout;              /* '<S20>/Time' */
  t_timeout Time_Timeout_c;            /* '<S13>/Time' */
  t_timeout Time1_Timeout_p;           /* '<S54>/Time1' */
  t_timeout SampleTime_PreviousTime;   /* '<S24>/Sample Time' */
  t_timeout ComputationTime_BeginTime; /* '<S24>/Computation Time' */
  t_timeout ComputationTime_ComputationTime;/* '<S24>/Computation Time' */
  t_timeout SampleTime_PreviousTime_c; /* '<S23>/Sample Time' */
  t_timeout ComputationTime_BeginTime_d;/* '<S23>/Computation Time' */
  t_timeout ComputationTime_ComputationTi_n;/* '<S23>/Computation Time' */
  t_timeout SampleTime_PreviousTime_d; /* '<S25>/Sample Time' */
  t_timeout ComputationTime_BeginTime_c;/* '<S25>/Computation Time' */
  t_timeout ComputationTime_ComputationTi_e;/* '<S25>/Computation Time' */
  t_timeout Time_Timeout_i;            /* '<S6>/Time' */
  t_timeout SampleTime_PreviousTime_i; /* '<S27>/Sample Time' */
  t_timeout ComputationTime_BeginTime_f;/* '<S27>/Computation Time' */
  t_timeout ComputationTime_ComputationTi_g;/* '<S27>/Computation Time' */
  t_timeout SampleTime_PreviousTime_n; /* '<S26>/Sample Time' */
  t_timeout ComputationTime_BeginTime_o;/* '<S26>/Computation Time' */
  t_timeout ComputationTime_ComputationTi_c;/* '<S26>/Computation Time' */
  t_timeout SampleTime_PreviousTime_k; /* '<S28>/Sample Time' */
  t_timeout ComputationTime_BeginTime_f4;/* '<S28>/Computation Time' */
  t_timeout ComputationTime_ComputationTi_d;/* '<S28>/Computation Time' */
  real_T Delay_DSTATE;                 /* '<S32>/Delay' */
  real_T HILInitialize_AIMinimums[5];  /* '<S9>/HIL Initialize' */
  real_T HILInitialize_AIMaximums[5];  /* '<S9>/HIL Initialize' */
  real_T HILInitialize_FilterFrequency[3];/* '<S9>/HIL Initialize' */
  real_T HILInitialize_POSortedFreqs[2];/* '<S9>/HIL Initialize' */
  real_T HILInitialize_POValues[2];    /* '<S9>/HIL Initialize' */
  real_T HILInitialize_OOValues[2];    /* '<S9>/HIL Initialize' */
  real_T HILReadTimebase_AnalogBuffer[2];/* '<S9>/HIL Read Timebase' */
  real_T HILReadTimebase_OtherBuffer[7];/* '<S9>/HIL Read Timebase' */
  real_T Unwrap224_PreviousInput;      /* '<S9>/Unwrap 2^24' */
  real_T Unwrap224_Revolutions;        /* '<S9>/Unwrap 2^24' */
  real_T Memory2_PreviousInput;        /* '<S39>/Memory2' */
  real_T RateTransition_Buffer0[3];    /* '<S6>/Rate Transition' */
  real_T Memory1_PreviousInput;        /* '<S12>/Memory1' */
  real_T light_color_Buffer0;          /* synthesized block */
  real_T sign_type_Buffer0;            /* synthesized block */
  real_T lane_offset_Buffer0;          /* synthesized block */
  real_T sign_size_Buffer0;            /* synthesized block */
  real_T TmpRTBAtProductInport1_Buffer0;/* synthesized block */
  real_T Memory_PreviousInput[3];      /* '<S6>/Memory' */
  real_T RateTransition1_Buffer[3];    /* '<S6>/Rate Transition1' */
  real_T Memory_PreviousInput_f;       /* '<S11>/Memory' */
  real_T Memory_PreviousInput_f2;      /* '<S20>/Memory' */
  real_T RateTransition1_Buffer_m[2];  /* '<S21>/Rate Transition1' */
  real_T RateTransition2_Buffer[2];    /* '<S21>/Rate Transition2' */
  real_T RateTransition1_Buffer_n[2];  /* '<S45>/Rate Transition1' */
  real_T RateTransition2_Buffer_f[2];  /* '<S45>/Rate Transition2' */
  real_T Memory1_PreviousInput_k;      /* '<S54>/Memory1' */
  real_T BodyFrame_XBuffer[1000];      /* '<S6>/Body Frame' */
  real_T BodyFrame_YBuffer[1000];      /* '<S6>/Body Frame' */
  real_T FixedFrame_XBuffer[384];      /* '<S6>/Fixed Frame' */
  real_T FixedFrame_YBuffer[384];      /* '<S6>/Fixed Frame' */
  real_T InverseModulus1_PreviousInput;/* '<S6>/Inverse Modulus1' */
  real_T InverseModulus1_Revolutions;  /* '<S6>/Inverse Modulus1' */
  real_T XYPlot_XBuffer[200];          /* '<S7>/XY Plot' */
  real_T XYPlot_YBuffer[200];          /* '<S7>/XY Plot' */
  real_T XYPlot_XBuffer_b[200];        /* '<S12>/XY Plot' */
  real_T XYPlot_YBuffer_h[200];        /* '<S12>/XY Plot' */
  real_T X_hat[3];                     /* '<S40>/QCar EKF' */
  real_T P[9];                         /* '<S40>/QCar EKF' */
  real_T I[9];                         /* '<S40>/QCar EKF' */
  real_T C_heading[3];                 /* '<S40>/QCar EKF' */
  real_T C_combined[9];                /* '<S40>/QCar EKF' */
  real_T X_hat_b[2];                   /* '<S40>/Heading Kalman Filter' */
  real_T P_m[4];                       /* '<S40>/Heading Kalman Filter' */
  real_T I_i[4];                       /* '<S40>/Heading Kalman Filter' */
  real_T A[4];                         /* '<S40>/Heading Kalman Filter' */
  real_T B[2];                         /* '<S40>/Heading Kalman Filter' */
  real_T C[2];                         /* '<S40>/Heading Kalman Filter' */
  real_T state;                        /* '<Root>/MATLAB Function' */
  real_T stop_timer;                   /* '<Root>/MATLAB Function' */
  real_T sign_stop_timer;              /* '<Root>/MATLAB Function' */
  real_T red_light_frames;             /* '<Root>/MATLAB Function' */
  real_T sign_frames;                  /* '<Root>/MATLAB Function' */
  t_video_capture rightCSICamera_VideoCapture;/* '<S1>/rightCSICamera' */
  t_video_capture rearCSICamera_VideoCapture;/* '<S1>/rearCSICamera' */
  t_video_capture leftCSICamera_VideoCapture;/* '<S1>/leftCSICamera' */
  t_video_capture frontCSICamera_VideoCapture;/* '<S1>/frontCSICamera' */
  t_host_remote_interface HostInitialize_ConnectedHandle;/* '<Root>/Host Initialize' */
  t_ranging_sensor RangingSensor_Sensor;/* '<S5>/Ranging Sensor' */
  t_video3d Video3DInitialize_Video3D; /* '<S10>/Video3D Initialize' */
  t_video3d realsenseDepthCapture_Video3D;/* '<S10>/realsenseDepthCapture' */
  t_video3d_stream realsenseDepthCapture_Stream;/* '<S10>/realsenseDepthCapture' */
  t_lidar2d_scan_matcher LIDARScanMatch_Matcher;/* '<S15>/LIDAR Scan Match' */
  t_card HILInitialize_Card;           /* '<S9>/HIL Initialize' */
  t_task HILReadTimebase_Task;         /* '<S9>/HIL Read Timebase' */
  void *HostInitialize_PWORK[2];       /* '<Root>/Host Initialize' */
  void *HILWrite_PWORK;                /* '<S14>/HIL Write' */
  struct {
    void *LoggedData[2];
  } Speed_Tracking_PWORK;              /* '<S34>/Speed_Tracking' */

  struct {
    void *LoggedData[2];
  } SpeedComparison_PWORK;             /* '<S35>/Speed Comparison' */

  struct {
    void *LoggedData[3];
  } HeadingComparison_PWORK;           /* '<S12>/Heading Comparison' */

  struct {
    void *LoggedData;
  } Heading_PWORK;                     /* '<S39>/Heading' */

  struct {
    void *LoggedData[3];
  } Scope_PWORK;                       /* '<S39>/Scope' */

  struct {
    void *LoggedData;
  } Correction_Weight_PWORK;           /* '<S41>/Correction_Weight' */

  struct {
    void *LoggedData[2];
  } steeringservodynamics_PWORK;       /* '<S44>/steering  servo dynamics' */

  struct {
    void *LoggedData[4];
  } steering_PWORK;                    /* '<S13>/steering' */

  struct {
    void *LoggedData;
  } distanceToPath_PWORK;              /* '<S54>/distanceToPath' */

  struct {
    void *LoggedData;
  } Control_PWORK;                     /* '<S8>/Control' */

  struct {
    void *LoggedData;
  } CSI_PWORK;                         /* '<S8>/CSI' */

  struct {
    void *LoggedData;
  } RealSense_PWORK;                   /* '<S8>/RealSense' */

  struct {
    void *LoggedData;
  } Scope_PWORK_f;                     /* '<S6>/Scope' */

  struct {
    void *LoggedData;
  } newLidar_PWORK;                    /* '<S6>/newLidar' */

  struct {
    void *LoggedData;
  } LiDAR_PWORK;                       /* '<S8>/LiDAR' */

  struct {
    void *LoggedData;
  } ImageDisplays_PWORK;               /* '<S8>/Image Displays' */

  struct {
    void *LoggedData;
  } LCD_PWORK;                         /* '<S8>/LCD' */

  struct {
    void *LoggedData;
  } PoseDeltas_PWORK;                  /* '<S15>/Pose Deltas' */

  real32_T LIDARScanMatch_Scan[2770];  /* '<S15>/LIDAR Scan Match' */
  real32_T Memory_PreviousInput_e[3];  /* '<S15>/Memory' */
  int32_T HILInitialize_DOStates[16];  /* '<S9>/HIL Initialize' */
  int32_T HILInitialize_QuadratureModes[3];/* '<S9>/HIL Initialize' */
  int32_T HILInitialize_InitialEICounts[3];/* '<S9>/HIL Initialize' */
  int32_T HILInitialize_POModeValues[2];/* '<S9>/HIL Initialize' */
  int32_T HILInitialize_POAlignValues[2];/* '<S9>/HIL Initialize' */
  int32_T HILInitialize_POPolarityVals[2];/* '<S9>/HIL Initialize' */
  int32_T HILReadTimebase_EncoderBuffer;/* '<S9>/HIL Read Timebase' */
  int32_T RangingSensor_DIMS1;         /* '<S5>/Ranging Sensor' */
  int32_T RangingSensor_DIMS2;         /* '<S5>/Ranging Sensor' */
  int32_T RangingSensor_DIMS3;         /* '<S5>/Ranging Sensor' */
  int32_T RangingSensor_DIMS4;         /* '<S5>/Ranging Sensor' */
  int32_T Bias_DIMS1;                  /* '<S6>/Bias' */
  int32_T sfEvent;                     /* '<S41>/MATLAB Function' */
  int32_T sfEvent_n;                   /* '<S40>/QCar EKF' */
  int32_T sfEvent_j;                   /* '<S40>/Heading Kalman Filter' */
  int32_T sfEvent_b;                   /* '<S33>/MATLAB Function' */
  int32_T sfEvent_bh;
            /* '<S20>/Windowed Closest Point Locator *Feedback the location1' */
  int32_T sfEvent_m;                   /* '<S15>/MATLAB Function' */
  int32_T SFunction_DIMS2;             /* '<S15>/MATLAB Function' */
  int32_T SFunction_DIMS3;             /* '<S15>/MATLAB Function' */
  int32_T sfEvent_h;                   /* '<Root>/MATLAB Function2' */
  int32_T sfEvent_g;                   /* '<Root>/MATLAB Function1' */
  int32_T sfEvent_mq;                  /* '<Root>/MATLAB Function' */
  uint32_T HILInitialize_POSortedChans[2];/* '<S9>/HIL Initialize' */
  int_T BodyFrame_IWORK[2];            /* '<S6>/Body Frame' */
  int_T FixedFrame_IWORK[2];           /* '<S6>/Fixed Frame' */
  int_T XYPlot_IWORK[2];               /* '<S7>/XY Plot' */
  int_T XYPlot_IWORK_o[2];             /* '<S12>/XY Plot' */
  volatile int8_T TmpRTBAtMATLABFunction1Inport1_;/* synthesized block */
  volatile int8_T TmpRTBAtToWorkspaceInport1_Acti;/* synthesized block */
  volatile int8_T TmpRTBAtToWorkspaceInport1_sema;/* synthesized block */
  int8_T SteeringBasedonLiDAR_SubsysRanB;/* '<S13>/Steering Based on LiDAR' */
  int8_T If_ActiveSubsystem;           /* '<S56>/If' */
  int8_T LatchInput_SubsysRanBC;       /* '<S17>/Latch Input' */
  int8_T MatchScans_SubsysRanBC;       /* '<S6>/Match Scans' */
  volatile uint8_T TmpRTBAtMATLABFunction1Inport_f[1843200];/* synthesized block */
  volatile uint8_T TmpRTBAtToWorkspaceInport1_Buff[1843200];/* synthesized block */
  boolean_T HILInitialize_DOBits[16];  /* '<S9>/HIL Initialize' */
  boolean_T Unwrap224_FirstSample;     /* '<S9>/Unwrap 2^24' */
  boolean_T Integrator_DWORK1;         /* '<S39>/Integrator' */
  boolean_T TmpRTBAtHeadingKalmanFilterInpo;/* synthesized block */
  boolean_T TmpRTBAtQCarEKFInport6_Buffer0;/* synthesized block */
  boolean_T lane_detected_Buffer0;     /* synthesized block */
  boolean_T HostGameController_NewData;/* '<Root>/Host Game Controller' */
  boolean_T icLoad;                    /* '<S32>/Delay' */
  boolean_T Time1_Owner;               /* '<S6>/Time1' */
  boolean_T Time_Owner;                /* '<S20>/Time' */
  boolean_T Time_Owner_l;              /* '<S13>/Time' */
  boolean_T Time1_Owner_i;             /* '<S54>/Time1' */
  boolean_T Integrator1_DWORK1;        /* '<S55>/Integrator1' */
  boolean_T BodyFrame_IsFull;          /* '<S6>/Body Frame' */
  boolean_T FixedFrame_IsFull;         /* '<S6>/Fixed Frame' */
  boolean_T Time_Owner_le;             /* '<S6>/Time' */
  boolean_T InverseModulus1_FirstSample;/* '<S6>/Inverse Modulus1' */
  boolean_T Memory_PreviousInput_g;    /* '<S16>/Memory' */
  boolean_T XYPlot_IsFull;             /* '<S7>/XY Plot' */
  boolean_T XYPlot_IsFull_h;           /* '<S12>/XY Plot' */
  boolean_T doneDoubleBufferReInit;    /* '<S41>/MATLAB Function' */
  boolean_T doneDoubleBufferReInit_f;  /* '<S40>/QCar EKF' */
  boolean_T X_hat_not_empty;           /* '<S40>/QCar EKF' */
  boolean_T P_not_empty;               /* '<S40>/QCar EKF' */
  boolean_T I_not_empty;               /* '<S40>/QCar EKF' */
  boolean_T C_heading_not_empty;       /* '<S40>/QCar EKF' */
  boolean_T C_combined_not_empty;      /* '<S40>/QCar EKF' */
  boolean_T doneDoubleBufferReInit_j;  /* '<S40>/Heading Kalman Filter' */
  boolean_T X_hat_not_empty_m;         /* '<S40>/Heading Kalman Filter' */
  boolean_T P_not_empty_k;             /* '<S40>/Heading Kalman Filter' */
  boolean_T I_not_empty_n;             /* '<S40>/Heading Kalman Filter' */
  boolean_T A_not_empty;               /* '<S40>/Heading Kalman Filter' */
  boolean_T B_not_empty;               /* '<S40>/Heading Kalman Filter' */
  boolean_T C_not_empty;               /* '<S40>/Heading Kalman Filter' */
  boolean_T doneDoubleBufferReInit_d;  /* '<S33>/MATLAB Function' */
  boolean_T doneDoubleBufferReInit_e;
            /* '<S20>/Windowed Closest Point Locator *Feedback the location1' */
  boolean_T doneDoubleBufferReInit_jt; /* '<S15>/MATLAB Function' */
  boolean_T doneDoubleBufferReInit_c;  /* '<Root>/MATLAB Function2' */
  boolean_T doneDoubleBufferReInit_c3; /* '<Root>/MATLAB Function1' */
  boolean_T doneDoubleBufferReInit_m;  /* '<Root>/MATLAB Function' */
  boolean_T state_not_empty;           /* '<Root>/MATLAB Function' */
  boolean_T stop_timer_not_empty;      /* '<Root>/MATLAB Function' */
  boolean_T sign_stop_timer_not_empty; /* '<Root>/MATLAB Function' */
  boolean_T sign_stopped;              /* '<Root>/MATLAB Function' */
  boolean_T sign_stopped_not_empty;    /* '<Root>/MATLAB Function' */
  boolean_T red_light_frames_not_empty;/* '<Root>/MATLAB Function' */
  boolean_T sign_frames_not_empty;     /* '<Root>/MATLAB Function' */
  boolean_T SteeringBasedonLiDAR_MODE; /* '<S13>/Steering Based on LiDAR' */
  boolean_T MatchScans_MODE;           /* '<S6>/Match Scans' */
  DW_IfActionSubsystem_VIRTUAL__T IfActionSubsystem2;/* '<S56>/If Action Subsystem2' */
  DW_IfActionSubsystem_VIRTUAL__T IfActionSubsystem1;/* '<S56>/If Action Subsystem1' */
  DW_IfActionSubsystem_VIRTUAL__T IfActionSubsystem;/* '<S56>/If Action Subsystem' */
} DW_VIRTUAL_data_collection_T;

/* Continuous states (default storage) */
typedef struct {
  real_T Integrator_CSTATE[3];         /* '<S39>/Integrator' */
  real_T Integrator_CSTATE_n[3];       /* '<S41>/Integrator' */
  real_T Integrator1_CSTATE;           /* '<S34>/Integrator1' */
  real_T TransferFcn_CSTATE;           /* '<S44>/Transfer Fcn' */
  real_T Integrator1_CSTATE_c[3];      /* '<S41>/Integrator1' */
  real_T Integrator_CSTATE_h;          /* '<S54>/Integrator' */
  real_T Integrator1_CSTATE_d;         /* '<S54>/Integrator1' */
  real_T Integrator1_CSTATE_g;         /* '<S55>/Integrator1' */
  real_T Integrator2_CSTATE;           /* '<S55>/Integrator2' */
  real_T GyroFilter_CSTATE;            /* '<S56>/Gyro Filter' */
} X_VIRTUAL_data_collection_T;

/* State derivatives (default storage) */
typedef struct {
  real_T Integrator_CSTATE[3];         /* '<S39>/Integrator' */
  real_T Integrator_CSTATE_n[3];       /* '<S41>/Integrator' */
  real_T Integrator1_CSTATE;           /* '<S34>/Integrator1' */
  real_T TransferFcn_CSTATE;           /* '<S44>/Transfer Fcn' */
  real_T Integrator1_CSTATE_c[3];      /* '<S41>/Integrator1' */
  real_T Integrator_CSTATE_h;          /* '<S54>/Integrator' */
  real_T Integrator1_CSTATE_d;         /* '<S54>/Integrator1' */
  real_T Integrator1_CSTATE_g;         /* '<S55>/Integrator1' */
  real_T Integrator2_CSTATE;           /* '<S55>/Integrator2' */
  real_T GyroFilter_CSTATE;            /* '<S56>/Gyro Filter' */
} XDot_VIRTUAL_data_collection_T;

/* State disabled  */
typedef struct {
  boolean_T Integrator_CSTATE[3];      /* '<S39>/Integrator' */
  boolean_T Integrator_CSTATE_n[3];    /* '<S41>/Integrator' */
  boolean_T Integrator1_CSTATE;        /* '<S34>/Integrator1' */
  boolean_T TransferFcn_CSTATE;        /* '<S44>/Transfer Fcn' */
  boolean_T Integrator1_CSTATE_c[3];   /* '<S41>/Integrator1' */
  boolean_T Integrator_CSTATE_h;       /* '<S54>/Integrator' */
  boolean_T Integrator1_CSTATE_d;      /* '<S54>/Integrator1' */
  boolean_T Integrator1_CSTATE_g;      /* '<S55>/Integrator1' */
  boolean_T Integrator2_CSTATE;        /* '<S55>/Integrator2' */
  boolean_T GyroFilter_CSTATE;         /* '<S56>/Gyro Filter' */
} XDis_VIRTUAL_data_collection_T;

/* Zero-crossing (trigger) state */
typedef struct {
  ZCSigState Integrator_Reset_ZCE;     /* '<S39>/Integrator' */
  ZCSigState Integrator1_Reset_ZCE;    /* '<S34>/Integrator1' */
  ZCSigState Integrator1_Reset_ZCE_e;  /* '<S41>/Integrator1' */
  ZCSigState Integrator_Reset_ZCE_h;   /* '<S54>/Integrator' */
  ZCSigState Integrator1_Reset_ZCE_h;  /* '<S54>/Integrator1' */
  ZCSigState LatchInput_Trig_ZCE;      /* '<S17>/Latch Input' */
} PrevZCX_VIRTUAL_data_collecti_T;

#ifndef ODE1_INTG
#define ODE1_INTG

/* ODE1 Integration Data */
typedef struct {
  real_T *f[1];                        /* derivatives */
} ODE1_IntgData;

#endif

/* Backward compatible GRT Identifiers */
#define rtB                            VIRTUAL_data_collection_B
#define BlockIO                        B_VIRTUAL_data_collection_T
#define rtX                            VIRTUAL_data_collection_X
#define ContinuousStates               X_VIRTUAL_data_collection_T
#define rtXdot                         VIRTUAL_data_collection_XDot
#define StateDerivatives               XDot_VIRTUAL_data_collection_T
#define tXdis                          VIRTUAL_data_collection_XDis
#define StateDisabled                  XDis_VIRTUAL_data_collection_T
#define rtP                            VIRTUAL_data_collection_P
#define Parameters                     P_VIRTUAL_data_collection_T
#define rtDWork                        VIRTUAL_data_collection_DW
#define D_Work                         DW_VIRTUAL_data_collection_T
#define rtPrevZCSigState               VIRTUAL_data_collection_PrevZCX
#define PrevZCSigStates                PrevZCX_VIRTUAL_data_collecti_T

/* Parameters for system: '<S56>/If Action Subsystem' */
struct P_IfActionSubsystem_VIRTUAL_d_T_ {
  real_T Bias_Bias;                    /* Expression: 2*pi
                                        * Referenced by: '<S58>/Bias'
                                        */
};

/* Parameters (default storage) */
struct P_VIRTUAL_data_collection_T_ {
  real_T CSI_Sample_Time;              /* Variable: CSI_Sample_Time
                                        * Referenced by: '<S23>/Constant'
                                        */
  real_T Controller_Sample_Time;       /* Variable: Controller_Sample_Time
                                        * Referenced by:
                                        *   '<S40>/Heading Kalman Filter'
                                        *   '<S40>/QCar EKF'
                                        */
  real_T GyroKF_Q[4];                  /* Variable: GyroKF_Q
                                        * Referenced by: '<S40>/Heading Kalman Filter'
                                        */
  real_T GyroKF_R;                     /* Variable: GyroKF_R
                                        * Referenced by: '<S40>/Heading Kalman Filter'
                                        */
  real_T ImageDisplay_Sample_Time;     /* Variable: ImageDisplay_Sample_Time
                                        * Referenced by: '<S26>/Constant'
                                        */
  real_T Initialization_Time;          /* Variable: Initialization_Time
                                        * Referenced by:
                                        *   '<S6>/Constant10'
                                        *   '<S6>/Constant6'
                                        *   '<S53>/Constant'
                                        *   '<S54>/Constant6'
                                        */
  real_T LiDAR_Sample_Time;            /* Variable: LiDAR_Sample_Time
                                        * Referenced by: '<S27>/Constant'
                                        */
  real_T QCarEKF_L;                    /* Variable: QCarEKF_L
                                        * Referenced by: '<S40>/QCar EKF'
                                        */
  real_T QCarEKF_P0[9];                /* Variable: QCarEKF_P0
                                        * Referenced by: '<S40>/QCar EKF'
                                        */
  real_T QCarEKF_R_combined[9];        /* Variable: QCarEKF_R_combined
                                        * Referenced by: '<S40>/QCar EKF'
                                        */
  real_T RealSense_Sample_Time;        /* Variable: RealSense_Sample_Time
                                        * Referenced by: '<S25>/Constant'
                                        */
  real_T angles_qcar2[384];            /* Variable: angles_qcar2
                                        * Referenced by: '<S6>/Constant4'
                                        */
  real_T cal_pos[3];                   /* Variable: cal_pos
                                        * Referenced by:
                                        *   '<S6>/Bias3'
                                        *   '<S6>/Calibration Bias'
                                        */
  real_T path_x4[2263];                /* Variable: path_x4
                                        * Referenced by:
                                        *   '<S20>/Constant'
                                        *   '<S20>/Constant2'
                                        *   '<S20>/Constant6'
                                        */
  real_T path_y4[2263];                /* Variable: path_y4
                                        * Referenced by:
                                        *   '<S20>/Constant3'
                                        *   '<S20>/Constant4'
                                        *   '<S20>/Constant8'
                                        */
  real_T qcar2_lidar_to_body_rotation; /* Variable: qcar2_lidar_to_body_rotation
                                        * Referenced by: '<S6>/Bias'
                                        */
  real_T qcar2_lidar_to_map_rotation;  /* Variable: qcar2_lidar_to_map_rotation
                                        * Referenced by: '<S6>/Bias2'
                                        */
  real_T qcar2_virtual_to_physical_lidar_rotation;
                           /* Variable: qcar2_virtual_to_physical_lidar_rotation
                            * Referenced by: '<S5>/virtualLidarToPhysicalLidarOffset'
                            */
  real_T range_qcar2[384];             /* Variable: range_qcar2
                                        * Referenced by: '<S6>/Constant1'
                                        */
  real_T steering_Kd;                  /* Variable: steering_Kd
                                        * Referenced by: '<S56>/D'
                                        */
  real_T steering_Kp;                  /* Variable: steering_Kp
                                        * Referenced by: '<S56>/P'
                                        */
  real_T BodyFrame_maximum_rho;        /* Mask Parameter: BodyFrame_maximum_rho
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T FixedFrame_maximum_rho;       /* Mask Parameter: FixedFrame_maximum_rho
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T BodyFrame_maximum_theta;     /* Mask Parameter: BodyFrame_maximum_theta
                                       * Referenced by: '<S6>/Body Frame'
                                       */
  real_T FixedFrame_maximum_theta;   /* Mask Parameter: FixedFrame_maximum_theta
                                      * Referenced by: '<S6>/Fixed Frame'
                                      */
  real_T XYPlot_maximum_x;             /* Mask Parameter: XYPlot_maximum_x
                                        * Referenced by: '<S7>/XY Plot'
                                        */
  real_T XYPlot_maximum_x_l;           /* Mask Parameter: XYPlot_maximum_x_l
                                        * Referenced by: '<S12>/XY Plot'
                                        */
  real_T XYPlot_maximum_y;             /* Mask Parameter: XYPlot_maximum_y
                                        * Referenced by: '<S7>/XY Plot'
                                        */
  real_T XYPlot_maximum_y_o;           /* Mask Parameter: XYPlot_maximum_y_o
                                        * Referenced by: '<S12>/XY Plot'
                                        */
  real_T BodyFrame_minimum_rho;        /* Mask Parameter: BodyFrame_minimum_rho
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T FixedFrame_minimum_rho;       /* Mask Parameter: FixedFrame_minimum_rho
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T BodyFrame_minimum_theta;     /* Mask Parameter: BodyFrame_minimum_theta
                                       * Referenced by: '<S6>/Body Frame'
                                       */
  real_T FixedFrame_minimum_theta;   /* Mask Parameter: FixedFrame_minimum_theta
                                      * Referenced by: '<S6>/Fixed Frame'
                                      */
  real_T XYPlot_minimum_x;             /* Mask Parameter: XYPlot_minimum_x
                                        * Referenced by: '<S7>/XY Plot'
                                        */
  real_T XYPlot_minimum_x_j;           /* Mask Parameter: XYPlot_minimum_x_j
                                        * Referenced by: '<S12>/XY Plot'
                                        */
  real_T XYPlot_minimum_y;             /* Mask Parameter: XYPlot_minimum_y
                                        * Referenced by: '<S7>/XY Plot'
                                        */
  real_T XYPlot_minimum_y_n;           /* Mask Parameter: XYPlot_minimum_y_n
                                        * Referenced by: '<S12>/XY Plot'
                                        */
  int32_T BodyFrame_direction;         /* Mask Parameter: BodyFrame_direction
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T FixedFrame_direction;        /* Mask Parameter: FixedFrame_direction
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  int32_T BodyFrame_update_rate;       /* Mask Parameter: BodyFrame_update_rate
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T FixedFrame_update_rate;      /* Mask Parameter: FixedFrame_update_rate
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  int32_T XYPlot_update_rate;          /* Mask Parameter: XYPlot_update_rate
                                        * Referenced by: '<S7>/XY Plot'
                                        */
  int32_T XYPlot_update_rate_m;        /* Mask Parameter: XYPlot_update_rate_m
                                        * Referenced by: '<S12>/XY Plot'
                                        */
  int32_T BodyFrame_zero_location;    /* Mask Parameter: BodyFrame_zero_location
                                       * Referenced by: '<S6>/Body Frame'
                                       */
  int32_T FixedFrame_zero_location;  /* Mask Parameter: FixedFrame_zero_location
                                      * Referenced by: '<S6>/Fixed Frame'
                                      */
  uint32_T HILWrite_digital_channels[16];
                                    /* Mask Parameter: HILWrite_digital_channels
                                     * Referenced by: '<S14>/HIL Write'
                                     */
  uint32_T HILWrite_other_channels[2];/* Mask Parameter: HILWrite_other_channels
                                       * Referenced by: '<S14>/HIL Write'
                                       */
  uint32_T realsenseDepthCapture_stream_in;
                              /* Mask Parameter: realsenseDepthCapture_stream_in
                               * Referenced by: '<S10>/realsenseDepthCapture'
                               */
  boolean_T Video3DInitialize_active;/* Mask Parameter: Video3DInitialize_active
                                      * Referenced by: '<S10>/Video3D Initialize'
                                      */
  real_T Constant_Value[3];            /* Expression: [6 6 2*pi]
                                        * Referenced by: '<S15>/Constant'
                                        */
  real_T Constant1_Value[3];           /* Expression: [1 1 pi/2]
                                        * Referenced by: '<S15>/Constant1'
                                        */
  real_T pose_Y0;                      /* Computed Parameter: pose_Y0
                                        * Referenced by: '<S15>/pose'
                                        */
  real_T LIDARScanMatch_Resolution;    /* Expression: resolution
                                        * Referenced by: '<S15>/LIDAR Scan Match'
                                        */
  real_T LIDARScanMatch_MaxRange;      /* Expression: max_range
                                        * Referenced by: '<S15>/LIDAR Scan Match'
                                        */
  real_T Latch_Y0;                     /* Computed Parameter: Latch_Y0
                                        * Referenced by: '<S19>/Latch'
                                        */
  real_T Constant_Value_e;             /* Expression: 1
                                        * Referenced by: '<S19>/Constant'
                                        */
  real_T Constant5_Value;              /* Expression: 0
                                        * Referenced by: '<S6>/Constant5'
                                        */
  real_T Constant10_Value;             /* Expression: 10
                                        * Referenced by: '<S20>/Constant10'
                                        */
  real_T Constant11_Value;             /* Expression: 1
                                        * Referenced by: '<S20>/Constant11'
                                        */
  real_T Constant_Value_a;             /* Expression: 1
                                        * Referenced by: '<S11>/Constant'
                                        */
  real_T accLimit_Value;               /* Expression: -inf
                                        * Referenced by: '<S11>/-accLimit'
                                        */
  real_T Constant_Value_l;             /* Expression: 1
                                        * Referenced by: '<S41>/Constant'
                                        */
  real_T lidarSteering1rad_Y0;       /* Computed Parameter: lidarSteering1rad_Y0
                                      * Referenced by: '<S56>/lidarSteering [1] (rad)'
                                      */
  real_T GyroFilter_A;                 /* Computed Parameter: GyroFilter_A
                                        * Referenced by: '<S56>/Gyro Filter'
                                        */
  real_T GyroFilter_C;                 /* Computed Parameter: GyroFilter_C
                                        * Referenced by: '<S56>/Gyro Filter'
                                        */
  real_T Constant_Value_k;             /* Expression: 0
                                        * Referenced by: '<S38>/Constant'
                                        */
  real_T HILInitialize_OOTerminate;/* Expression: set_other_outputs_at_terminate
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  real_T HILInitialize_OOExit;    /* Expression: set_other_outputs_at_switch_out
                                   * Referenced by: '<S9>/HIL Initialize'
                                   */
  real_T HILInitialize_OOStart;        /* Expression: set_other_outputs_at_start
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_OOEnter;    /* Expression: set_other_outputs_at_switch_in
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  real_T HILInitialize_POFinal;        /* Expression: final_pwm_outputs
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_OOFinal;        /* Expression: final_other_outputs
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_AIHigh;         /* Expression: analog_input_maximums
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_AILow;          /* Expression: analog_input_minimums
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_EIFrequency;    /* Expression: encoder_filter_frequency
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_POFrequency;    /* Expression: pwm_frequency
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_POInitial;      /* Expression: initial_pwm_outputs
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_POWatchdog;     /* Expression: watchdog_pwm_outputs
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_OOInitial;      /* Expression: initial_other_outputs
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T HILInitialize_OOWatchdog;     /* Expression: watchdog_other_outputs
                                        * Referenced by: '<S9>/HIL Initialize'
                                        */
  real_T Unwrap224_Modulus;            /* Expression: modulus
                                        * Referenced by: '<S9>/Unwrap 2^24'
                                        */
  real_T countstorotations_Gain;       /* Expression: 1/720/4
                                        * Referenced by: '<S30>/counts to rotations'
                                        */
  real_T gearratios_Gain;              /* Expression: (13*19)/(70*37)
                                        * Referenced by: '<S30>/gear ratios'
                                        */
  real_T rotstorads_Gain;              /* Expression: 2*pi
                                        * Referenced by: '<S30>/rot//s to rad//s'
                                        */
  real_T wheelradius_Gain;             /* Expression: 0.0342
                                        * Referenced by: '<S30>/wheel radius'
                                        */
  real_T Memory2_InitialCondition;     /* Expression: 0
                                        * Referenced by: '<S39>/Memory2'
                                        */
  real_T RateTransition_InitialCondition;/* Expression: 0
                                          * Referenced by: '<S6>/Rate Transition'
                                          */
  real_T Memory1_InitialCondition;     /* Expression: 0
                                        * Referenced by: '<S12>/Memory1'
                                        */
  real_T Integrator_IC;                /* Expression: 0
                                        * Referenced by: '<S41>/Integrator'
                                        */
  real_T Bias_Bias;                    /* Expression: pi
                                        * Referenced by: '<S42>/Bias'
                                        */
  real_T Constant1_Value_a;            /* Expression: 2*pi
                                        * Referenced by: '<S42>/Constant1'
                                        */
  real_T Bias1_Bias;                   /* Expression: -pi
                                        * Referenced by: '<S42>/Bias1'
                                        */
  real_T Gain1_Gain;                   /* Expression: .11537*1
                                        * Referenced by: '<S12>/Gain1'
                                        */
  real_T light_color_InitialCondition; /* Expression: 0
                                        * Referenced by:
                                        */
  real_T sign_type_InitialCondition;   /* Expression: 0
                                        * Referenced by:
                                        */
  real_T lane_offset_InitialCondition; /* Expression: 0
                                        * Referenced by:
                                        */
  real_T sign_size_InitialCondition;   /* Expression: 0
                                        * Referenced by:
                                        */
  real_T Gain2_Gain;                   /* Expression: 0.7
                                        * Referenced by: '<Root>/Gain2'
                                        */
  real_T SteeringBias_Bias;            /* Expression: -0.05
                                        * Referenced by: '<S14>/Steering Bias'
                                        */
  real_T Gain_Gain;                    /* Expression: 1
                                        * Referenced by: '<S14>/Gain'
                                        */
  real_T steeringsat_UpperSat;         /* Expression: 0.5
                                        * Referenced by: '<S14>/steering sat'
                                        */
  real_T steeringsat_LowerSat;         /* Expression: -0.5
                                        * Referenced by: '<S14>/steering sat'
                                        */
  real_T accLimit_Value_f;             /* Expression: 10
                                        * Referenced by: '<S11>/accLimit'
                                        */
  real_T sampletime_WtEt;              /* Computed Parameter: sampletime_WtEt
                                        * Referenced by: '<S32>/sample time'
                                        */
  real_T Constant_Value_j;             /* Expression: 0.375
                                        * Referenced by: '<S33>/Constant'
                                        */
  real_T Constant2_Value;              /* Expression: 0.6
                                        * Referenced by: '<S33>/Constant2'
                                        */
  real_T motorSat_UpperSat;            /* Expression: 3
                                        * Referenced by: '<S11>/motorSat'
                                        */
  real_T motorSat_LowerSat;            /* Expression: -3
                                        * Referenced by: '<S11>/motorSat'
                                        */
  real_T steeringSat_UpperSat;         /* Expression: 0.6
                                        * Referenced by: '<S11>/steeringSat'
                                        */
  real_T steeringSat_LowerSat;         /* Expression: -0.6
                                        * Referenced by: '<S11>/steeringSat'
                                        */
  real_T turningAttenuation_Value;     /* Expression: 5
                                        * Referenced by: '<S11>/turningAttenuation'
                                        */
  real_T attenuationLimits_UpperSat;   /* Expression: 1
                                        * Referenced by: '<S35>/attenuationLimits'
                                        */
  real_T attenuationLimits_LowerSat;   /* Expression: .3
                                        * Referenced by: '<S35>/attenuationLimits'
                                        */
  real_T commandsaturation_UpperSat;   /* Expression: 5
                                        * Referenced by: '<S34>/command saturation'
                                        */
  real_T commandsaturation_LowerSat;   /* Expression: -5
                                        * Referenced by: '<S34>/command saturation'
                                        */
  real_T TmpRTBAtProductInport1_InitialC;/* Expression: 0
                                          * Referenced by:
                                          */
  real_T Kffms_Gain;                   /* Expression: 0.1
                                        * Referenced by: '<S34>/Kff  (% // m//s)'
                                        */
  real_T Kpms_Gain;                    /* Expression: .3
                                        * Referenced by: '<S34>/Kp (% // m//s)'
                                        */
  real_T Integrator1_IC;               /* Expression: 0
                                        * Referenced by: '<S34>/Integrator1'
                                        */
  real_T Integrator1_UpperSat;         /* Expression: 0.4
                                        * Referenced by: '<S34>/Integrator1'
                                        */
  real_T Integrator1_LowerSat;         /* Expression: -0.4
                                        * Referenced by: '<S34>/Integrator1'
                                        */
  real_T motorsat_UpperSat;            /* Expression: .6
                                        * Referenced by: '<S14>/motor sat'
                                        */
  real_T motorsat_LowerSat;            /* Expression: -0.6
                                        * Referenced by: '<S14>/motor sat'
                                        */
  real_T Memory_InitialCondition;      /* Expression: 0
                                        * Referenced by: '<S6>/Memory'
                                        */
  real_T desiredPath_Value;            /* Expression: 4
                                        * Referenced by: '<S7>/desiredPath'
                                        */
  real_T Memory_InitialCondition_e;    /* Expression: 0
                                        * Referenced by: '<S11>/Memory'
                                        */
  real_T Gain2_Gain_m;                 /* Expression: 0.4
                                        * Referenced by: '<S7>/Gain2'
                                        */
  real_T lookaheadbias_Bias;           /* Expression: 0.3
                                        * Referenced by: '<S7>/look ahead bias'
                                        */
  real_T mcm_Gain;                     /* Expression: 100
                                        * Referenced by: '<S20>/m->cm'
                                        */
  real_T Constant5_Value_d;            /* Expression: 100
                                        * Referenced by: '<S20>/Constant5'
                                        */
  real_T Memory_InitialCondition_o;    /* Expression: 1
                                        * Referenced by: '<S20>/Memory'
                                        */
  real_T Constant1_Value_ak;           /* Expression: length(path_x4)
                                        * Referenced by: '<S20>/Constant1'
                                        */
  real_T Bias3_Bias;                   /* Expression: 1
                                        * Referenced by: '<S20>/Bias3'
                                        */
  real_T Constant7_Value;              /* Expression: length(path_x4)
                                        * Referenced by: '<S20>/Constant7'
                                        */
  real_T indexBias_Bias;               /* Expression: 1
                                        * Referenced by: '<S20>/indexBias'
                                        */
  real_T Kim_Gain;                     /* Expression: 1
                                        * Referenced by: '<S34>/Ki (% // m)  '
                                        */
  real_T Bias_Bias_a;                  /* Expression: pi
                                        * Referenced by: '<S43>/Bias'
                                        */
  real_T Constant1_Value_g;            /* Expression: 2*pi
                                        * Referenced by: '<S43>/Constant1'
                                        */
  real_T Bias1_Bias_h;                 /* Expression: -pi
                                        * Referenced by: '<S43>/Bias1'
                                        */
  real_T m_to_mm_Gain;                 /* Expression: 1e3
                                        * Referenced by: '<S39>/m_to_mm'
                                        */
  real_T Gain_Gain_b;                  /* Expression: 180/pi
                                        * Referenced by: '<S47>/Gain'
                                        */
  real_T Constant_Value_k1;            /* Expression: 3
                                        * Referenced by: '<S39>/Constant'
                                        */
  real_T m_to_mm1_Gain;                /* Expression: 1e3
                                        * Referenced by: '<S39>/m_to_mm1'
                                        */
  real_T Gain_Gain_p;                  /* Expression: 180/pi
                                        * Referenced by: '<S48>/Gain'
                                        */
  real_T m_to_mm2_Gain;                /* Expression: 1e3
                                        * Referenced by: '<S39>/m_to_mm2'
                                        */
  real_T Gain_Gain_n;                  /* Expression: 180/pi
                                        * Referenced by: '<S49>/Gain'
                                        */
  real_T Bias_Bias_e;                  /* Expression: 180
                                        * Referenced by: '<S46>/Bias'
                                        */
  real_T Constant1_Value_d;            /* Expression: 360
                                        * Referenced by: '<S46>/Constant1'
                                        */
  real_T Bias1_Bias_g;                 /* Expression: -180
                                        * Referenced by: '<S46>/Bias1'
                                        */
  real_T TransferFcn_A;                /* Computed Parameter: TransferFcn_A
                                        * Referenced by: '<S44>/Transfer Fcn'
                                        */
  real_T TransferFcn_C;                /* Computed Parameter: TransferFcn_C
                                        * Referenced by: '<S44>/Transfer Fcn'
                                        */
  real_T Lr_Value;                     /* Expression: 0.128
                                        * Referenced by: '<S44>/Lr'
                                        */
  real_T wheelbase_Value;              /* Expression: 0.256
                                        * Referenced by: '<S44>/wheelbase'
                                        */
  real_T Constant1_Value_n;            /* Expression: 5
                                        * Referenced by: '<S41>/Constant1'
                                        */
  real_T Constant2_Value_c;            /* Expression: .1
                                        * Referenced by: '<S41>/Constant2'
                                        */
  real_T kp_Gain[3];                   /* Expression: [1 1 1]*.400*1
                                        * Referenced by: '<S41>/kp'
                                        */
  real_T Integrator1_IC_d;             /* Expression: 0
                                        * Referenced by: '<S41>/Integrator1'
                                        */
  real_T Integrator1_UpperSat_h[3];    /* Expression: .05*[1 1 1]*1
                                        * Referenced by: '<S41>/Integrator1'
                                        */
  real_T Integrator1_LowerSat_o[3];    /* Expression: -.05*[1 1 1]*1
                                        * Referenced by: '<S41>/Integrator1'
                                        */
  real_T Gain_Gain_i[3];               /* Expression: [100 100 1]
                                        * Referenced by: '<S41>/Gain'
                                        */
  real_T ki_Gain[3];                   /* Expression: [4 4 4]*1
                                        * Referenced by: '<S41>/ki'
                                        */
  real_T Constant_Value_er;            /* Expression: 0
                                        * Referenced by: '<S54>/Constant'
                                        */
  real_T Memory1_InitialCondition_f;   /* Expression: 6
                                        * Referenced by: '<S54>/Memory1'
                                        */
  real_T Integrator_IC_o;              /* Expression: 0
                                        * Referenced by: '<S54>/Integrator'
                                        */
  real_T Integrator_UpperSat;          /* Expression: .2
                                        * Referenced by: '<S54>/Integrator'
                                        */
  real_T Integrator_LowerSat;          /* Expression: -.2
                                        * Referenced by: '<S54>/Integrator'
                                        */
  real_T Gain3_Gain;                   /* Expression: 1
                                        * Referenced by: '<S54>/Gain3'
                                        */
  real_T Integrator1_IC_h;             /* Expression: 0
                                        * Referenced by: '<S54>/Integrator1'
                                        */
  real_T Integrator1_UpperSat_d;       /* Expression: 1
                                        * Referenced by: '<S54>/Integrator1'
                                        */
  real_T Integrator1_LowerSat_m;       /* Expression: 0
                                        * Referenced by: '<S54>/Integrator1'
                                        */
  real_T Saturation1_UpperSat;         /* Expression: .2
                                        * Referenced by: '<S54>/Saturation1'
                                        */
  real_T Saturation1_LowerSat;         /* Expression: -.2
                                        * Referenced by: '<S54>/Saturation1'
                                        */
  real_T Constant1_Value_b;            /* Expression: 25
                                        * Referenced by: '<S13>/Constant1'
                                        */
  real_T Constant3_Value;              /* Expression: 1
                                        * Referenced by: '<S13>/Constant3'
                                        */
  real_T Constant1_Value_k;            /* Expression: 1
                                        * Referenced by: '<S54>/Constant1'
                                        */
  real_T Gain6_Gain;                   /* Expression: 3
                                        * Referenced by: '<S54>/Gain6'
                                        */
  real_T Constant_Value_p;             /* Expression: 2
                                        * Referenced by: '<S55>/Constant'
                                        */
  real_T Integrator2_IC;               /* Expression: 0
                                        * Referenced by: '<S55>/Integrator2'
                                        */
  real_T Constant_Value_h;             /* Expression: qc_get_step_size
                                        * Referenced by: '<S24>/Constant'
                                        */
  real_T realsenseDepthCapture_Brightnes;/* Expression: d_brightness
                                          * Referenced by: '<S10>/realsenseDepthCapture'
                                          */
  real_T realsenseDepthCapture_Contrast;/* Expression: d_contrast
                                         * Referenced by: '<S10>/realsenseDepthCapture'
                                         */
  real_T realsenseDepthCapture_Hue;    /* Expression: d_hue
                                        * Referenced by: '<S10>/realsenseDepthCapture'
                                        */
  real_T realsenseDepthCapture_Saturatio;/* Expression: d_saturation
                                          * Referenced by: '<S10>/realsenseDepthCapture'
                                          */
  real_T realsenseDepthCapture_Sharpness;/* Expression: d_sharpness
                                          * Referenced by: '<S10>/realsenseDepthCapture'
                                          */
  real_T realsenseDepthCapture_Gamma;  /* Expression: d_gamma
                                        * Referenced by: '<S10>/realsenseDepthCapture'
                                        */
  real_T realsenseDepthCapture_WhiteBala;/* Expression: d_whitebalance
                                          * Referenced by: '<S10>/realsenseDepthCapture'
                                          */
  real_T realsenseDepthCapture_Backlight;/* Expression: d_backlightcompensation
                                          * Referenced by: '<S10>/realsenseDepthCapture'
                                          */
  real_T realsenseDepthCapture_Gain;   /* Expression: d_gain
                                        * Referenced by: '<S10>/realsenseDepthCapture'
                                        */
  real_T realsenseDepthCapture_Exposure;/* Expression: d_exposure
                                         * Referenced by: '<S10>/realsenseDepthCapture'
                                         */
  real_T realsenseDepthCapture_Emitter;/* Expression: emitter
                                        * Referenced by: '<S10>/realsenseDepthCapture'
                                        */
  real_T rightCSICamera_Brightness;    /* Expression: d_brightness
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Contrast;      /* Expression: d_contrast
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Hue;           /* Expression: d_hue
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Saturation;    /* Expression: d_saturation
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Sharpness;     /* Expression: d_sharpness
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Gamma;         /* Expression: d_gamma
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_ColorEnable;   /* Expression: d_coloreffect
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_WhiteBalance;  /* Expression: d_whitebalance
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_BacklightCompens;/* Expression: d_backlightcompensation
                                          * Referenced by: '<S1>/rightCSICamera'
                                          */
  real_T rightCSICamera_Gain;          /* Expression: d_gain
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Pan;           /* Expression: d_pan
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Tilt;          /* Expression: d_tilt
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Roll;          /* Expression: d_roll
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Zoom;          /* Expression: d_zoom
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Exposure;      /* Expression: d_exposure
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Iris;          /* Expression: d_iris
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Focus;         /* Expression: d_focus
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rightCSICamera_Mirror;        /* Expression: d_mirror
                                        * Referenced by: '<S1>/rightCSICamera'
                                        */
  real_T rearCSICamera_Brightness;     /* Expression: d_brightness
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Contrast;       /* Expression: d_contrast
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Hue;            /* Expression: d_hue
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Saturation;     /* Expression: d_saturation
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Sharpness;      /* Expression: d_sharpness
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Gamma;          /* Expression: d_gamma
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_ColorEnable;    /* Expression: d_coloreffect
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_WhiteBalance;   /* Expression: d_whitebalance
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_BacklightCompensa;/* Expression: d_backlightcompensation
                                          * Referenced by: '<S1>/rearCSICamera'
                                          */
  real_T rearCSICamera_Gain;           /* Expression: d_gain
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Pan;            /* Expression: d_pan
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Tilt;           /* Expression: d_tilt
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Roll;           /* Expression: d_roll
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Zoom;           /* Expression: d_zoom
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Exposure;       /* Expression: d_exposure
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Iris;           /* Expression: d_iris
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Focus;          /* Expression: d_focus
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T rearCSICamera_Mirror;         /* Expression: d_mirror
                                        * Referenced by: '<S1>/rearCSICamera'
                                        */
  real_T leftCSICamera_Brightness;     /* Expression: d_brightness
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Contrast;       /* Expression: d_contrast
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Hue;            /* Expression: d_hue
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Saturation;     /* Expression: d_saturation
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Sharpness;      /* Expression: d_sharpness
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Gamma;          /* Expression: d_gamma
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_ColorEnable;    /* Expression: d_coloreffect
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_WhiteBalance;   /* Expression: d_whitebalance
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_BacklightCompensa;/* Expression: d_backlightcompensation
                                          * Referenced by: '<S1>/leftCSICamera'
                                          */
  real_T leftCSICamera_Gain;           /* Expression: d_gain
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Pan;            /* Expression: d_pan
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Tilt;           /* Expression: d_tilt
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Roll;           /* Expression: d_roll
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Zoom;           /* Expression: d_zoom
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Exposure;       /* Expression: d_exposure
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Iris;           /* Expression: d_iris
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Focus;          /* Expression: d_focus
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T leftCSICamera_Mirror;         /* Expression: d_mirror
                                        * Referenced by: '<S1>/leftCSICamera'
                                        */
  real_T frontCSICamera_Brightness;    /* Expression: d_brightness
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Contrast;      /* Expression: d_contrast
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Hue;           /* Expression: d_hue
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Saturation;    /* Expression: d_saturation
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Sharpness;     /* Expression: d_sharpness
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Gamma;         /* Expression: d_gamma
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_ColorEnable;   /* Expression: d_coloreffect
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_WhiteBalance;  /* Expression: d_whitebalance
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_BacklightCompens;/* Expression: d_backlightcompensation
                                          * Referenced by: '<S1>/frontCSICamera'
                                          */
  real_T frontCSICamera_Gain;          /* Expression: d_gain
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Pan;           /* Expression: d_pan
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Tilt;          /* Expression: d_tilt
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Roll;          /* Expression: d_roll
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Zoom;          /* Expression: d_zoom
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Exposure;      /* Expression: d_exposure
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Iris;          /* Expression: d_iris
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Focus;         /* Expression: d_focus
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T frontCSICamera_Mirror;        /* Expression: d_mirror
                                        * Referenced by: '<S1>/frontCSICamera'
                                        */
  real_T RangingSensor_Budget;         /* Expression: timing_budget
                                        * Referenced by: '<S5>/Ranging Sensor'
                                        */
  real_T RangingSensor_Period;         /* Expression: measurement_period
                                        * Referenced by: '<S5>/Ranging Sensor'
                                        */
  real_T RangingSensor_MaxInterpolationD;/* Expression: max_interpolated_distance
                                          * Referenced by: '<S5>/Ranging Sensor'
                                          */
  real_T RangingSensor_MaxInterpolationA;/* Expression: max_interpolated_angle
                                          * Referenced by: '<S5>/Ranging Sensor'
                                          */
  real_T BodyFrame_L1Width;            /* Expression: line1_width
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L1Color[3];         /* Expression: line1_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L1MSize;            /* Expression: marker1_size
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L1MEdgeColor[3];    /* Expression: marker1_edge_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L1MFaceColor[3];    /* Expression: marker1_face_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L2Width;            /* Expression: line2_width
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L2Color[3];         /* Expression: line2_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L2MSize;            /* Expression: marker2_size
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L2MEdgeColor[3];    /* Expression: marker2_edge_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L2MFaceColor[3];    /* Expression: marker2_face_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L3Width;            /* Expression: line3_width
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L3Color[3];         /* Expression: line3_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L3MSize;            /* Expression: marker3_size
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L3MEdgeColor[3];    /* Expression: marker3_edge_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L3MFaceColor[3];    /* Expression: marker3_face_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L4Width;            /* Expression: line4_width
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L4Color[3];         /* Expression: line4_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L4MSize;            /* Expression: marker4_size
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L4MEdgeColor[3];    /* Expression: marker4_edge_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L4MFaceColor[3];    /* Expression: marker4_face_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L5Width;            /* Expression: line5_width
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L5Color[3];         /* Expression: line5_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L5MSize;            /* Expression: marker5_size
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L5MEdgeColor[3];    /* Expression: marker5_edge_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T BodyFrame_L5MFaceColor[3];    /* Expression: marker5_face_color
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  real_T FixedFrame_L1Width;           /* Expression: line1_width
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L1Color[3];        /* Expression: line1_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L1MSize;           /* Expression: marker1_size
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L1MEdgeColor[3];   /* Expression: marker1_edge_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L1MFaceColor[3];   /* Expression: marker1_face_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L2Width;           /* Expression: line2_width
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L2Color[3];        /* Expression: line2_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L2MSize;           /* Expression: marker2_size
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L2MEdgeColor[3];   /* Expression: marker2_edge_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L2MFaceColor[3];   /* Expression: marker2_face_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L3Width;           /* Expression: line3_width
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L3Color[3];        /* Expression: line3_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L3MSize;           /* Expression: marker3_size
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L3MEdgeColor[3];   /* Expression: marker3_edge_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L3MFaceColor[3];   /* Expression: marker3_face_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L4Width;           /* Expression: line4_width
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L4Color[3];        /* Expression: line4_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L4MSize;           /* Expression: marker4_size
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L4MEdgeColor[3];   /* Expression: marker4_edge_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L4MFaceColor[3];   /* Expression: marker4_face_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L5Width;           /* Expression: line5_width
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L5Color[3];        /* Expression: line5_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L5MSize;           /* Expression: marker5_size
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L5MEdgeColor[3];   /* Expression: marker5_edge_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T FixedFrame_L5MFaceColor[3];   /* Expression: marker5_face_color
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  real_T Constant3_Value_h;            /* Expression: 1
                                        * Referenced by: '<S6>/Constant3'
                                        */
  real_T InverseModulus1_Modulus;      /* Expression: modulus
                                        * Referenced by: '<S6>/Inverse Modulus1'
                                        */
  real_T Switch_Threshold;             /* Expression: 0.5
                                        * Referenced by: '<S17>/Switch'
                                        */
  real_T Constant_Value_lc;            /* Expression: 1
                                        * Referenced by: '<S28>/Constant'
                                        */
  int32_T HostInitialize_SendBufferSize;
                            /* Computed Parameter: HostInitialize_SendBufferSize
                             * Referenced by: '<Root>/Host Initialize'
                             */
  int32_T HostInitialize_ReceiveBufferSiz;
                          /* Computed Parameter: HostInitialize_ReceiveBufferSiz
                           * Referenced by: '<Root>/Host Initialize'
                           */
  int32_T HostInitialize_ThreadPriority;
                            /* Computed Parameter: HostInitialize_ThreadPriority
                             * Referenced by: '<Root>/Host Initialize'
                             */
  int32_T HILInitialize_DOWatchdog;
                                 /* Computed Parameter: HILInitialize_DOWatchdog
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  int32_T HILInitialize_EIInitial;/* Computed Parameter: HILInitialize_EIInitial
                                   * Referenced by: '<S9>/HIL Initialize'
                                   */
  int32_T HILInitialize_POModes;    /* Computed Parameter: HILInitialize_POModes
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  int32_T HILInitialize_POConfiguration;
                            /* Computed Parameter: HILInitialize_POConfiguration
                             * Referenced by: '<S9>/HIL Initialize'
                             */
  int32_T HILInitialize_POAlignment;
                                /* Computed Parameter: HILInitialize_POAlignment
                                 * Referenced by: '<S9>/HIL Initialize'
                                 */
  int32_T HILInitialize_POPolarity;
                                 /* Computed Parameter: HILInitialize_POPolarity
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  int32_T HILReadTimebase_Clock;    /* Computed Parameter: HILReadTimebase_Clock
                                     * Referenced by: '<S9>/HIL Read Timebase'
                                     */
  int32_T HostGameController_BufferSize;
                            /* Computed Parameter: HostGameController_BufferSize
                             * Referenced by: '<Root>/Host Game Controller'
                             */
  int32_T BodyFrame_L1Style;           /* Computed Parameter: BodyFrame_L1Style
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L1Marker;          /* Computed Parameter: BodyFrame_L1Marker
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L2Style;           /* Computed Parameter: BodyFrame_L2Style
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L2Marker;          /* Computed Parameter: BodyFrame_L2Marker
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L3Style;           /* Computed Parameter: BodyFrame_L3Style
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L3Marker;          /* Computed Parameter: BodyFrame_L3Marker
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L4Style;           /* Computed Parameter: BodyFrame_L4Style
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L4Marker;          /* Computed Parameter: BodyFrame_L4Marker
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L5Style;           /* Computed Parameter: BodyFrame_L5Style
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T BodyFrame_L5Marker;          /* Computed Parameter: BodyFrame_L5Marker
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  int32_T FixedFrame_L1Style;          /* Computed Parameter: FixedFrame_L1Style
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  int32_T FixedFrame_L1Marker;        /* Computed Parameter: FixedFrame_L1Marker
                                       * Referenced by: '<S6>/Fixed Frame'
                                       */
  int32_T FixedFrame_L2Style;          /* Computed Parameter: FixedFrame_L2Style
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  int32_T FixedFrame_L2Marker;        /* Computed Parameter: FixedFrame_L2Marker
                                       * Referenced by: '<S6>/Fixed Frame'
                                       */
  int32_T FixedFrame_L3Style;          /* Computed Parameter: FixedFrame_L3Style
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  int32_T FixedFrame_L3Marker;        /* Computed Parameter: FixedFrame_L3Marker
                                       * Referenced by: '<S6>/Fixed Frame'
                                       */
  int32_T FixedFrame_L4Style;          /* Computed Parameter: FixedFrame_L4Style
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  int32_T FixedFrame_L4Marker;        /* Computed Parameter: FixedFrame_L4Marker
                                       * Referenced by: '<S6>/Fixed Frame'
                                       */
  int32_T FixedFrame_L5Style;          /* Computed Parameter: FixedFrame_L5Style
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  int32_T FixedFrame_L5Marker;        /* Computed Parameter: FixedFrame_L5Marker
                                       * Referenced by: '<S6>/Fixed Frame'
                                       */
  real32_T Gain1_Gain_n[3];            /* Computed Parameter: Gain1_Gain_n
                                        * Referenced by: '<S15>/Gain1'
                                        */
  real32_T Memory_InitialCondition_h[3];
                                /* Computed Parameter: Memory_InitialCondition_h
                                 * Referenced by: '<S15>/Memory'
                                 */
  real32_T Gain_Gain_l[3];             /* Computed Parameter: Gain_Gain_l
                                        * Referenced by: '<S15>/Gain'
                                        */
  uint32_T HILInitialize_AIChannels[5];
                                 /* Computed Parameter: HILInitialize_AIChannels
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  uint32_T HILInitialize_DIChannels[15];
                                 /* Computed Parameter: HILInitialize_DIChannels
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  uint32_T HILInitialize_DOChannels[16];
                                 /* Computed Parameter: HILInitialize_DOChannels
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  uint32_T HILInitialize_EIChannels[3];
                                 /* Computed Parameter: HILInitialize_EIChannels
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  uint32_T HILInitialize_EIQuadrature;
                               /* Computed Parameter: HILInitialize_EIQuadrature
                                * Referenced by: '<S9>/HIL Initialize'
                                */
  uint32_T HILInitialize_POChannels[2];
                                 /* Computed Parameter: HILInitialize_POChannels
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  uint32_T HILInitialize_OOChannels[2];
                                 /* Computed Parameter: HILInitialize_OOChannels
                                  * Referenced by: '<S9>/HIL Initialize'
                                  */
  uint32_T HILReadTimebase_SamplesInBuffer;
                          /* Computed Parameter: HILReadTimebase_SamplesInBuffer
                           * Referenced by: '<S9>/HIL Read Timebase'
                           */
  uint32_T HILReadTimebase_AnalogChannels[2];
                           /* Computed Parameter: HILReadTimebase_AnalogChannels
                            * Referenced by: '<S9>/HIL Read Timebase'
                            */
  uint32_T HILReadTimebase_EncoderChannels;
                          /* Computed Parameter: HILReadTimebase_EncoderChannels
                           * Referenced by: '<S9>/HIL Read Timebase'
                           */
  uint32_T HILReadTimebase_OtherChannels[7];
                            /* Computed Parameter: HILReadTimebase_OtherChannels
                             * Referenced by: '<S9>/HIL Read Timebase'
                             */
  uint32_T realsenseDepthCapture_Preset;
                             /* Computed Parameter: realsenseDepthCapture_Preset
                              * Referenced by: '<S10>/realsenseDepthCapture'
                              */
  uint32_T RangingSensor_Range;       /* Computed Parameter: RangingSensor_Range
                                       * Referenced by: '<S5>/Ranging Sensor'
                                       */
  boolean_T HostInitialize_RunClient;
                                 /* Computed Parameter: HostInitialize_RunClient
                                  * Referenced by: '<Root>/Host Initialize'
                                  */
  boolean_T HostInitialize_UseWindow;
                                 /* Computed Parameter: HostInitialize_UseWindow
                                  * Referenced by: '<Root>/Host Initialize'
                                  */
  boolean_T HostInitialize_Active;  /* Computed Parameter: HostInitialize_Active
                                     * Referenced by: '<Root>/Host Initialize'
                                     */
  boolean_T HILInitialize_Active;    /* Computed Parameter: HILInitialize_Active
                                      * Referenced by: '<S9>/HIL Initialize'
                                      */
  boolean_T HILInitialize_AOTerminate;
                                /* Computed Parameter: HILInitialize_AOTerminate
                                 * Referenced by: '<S9>/HIL Initialize'
                                 */
  boolean_T HILInitialize_AOExit;    /* Computed Parameter: HILInitialize_AOExit
                                      * Referenced by: '<S9>/HIL Initialize'
                                      */
  boolean_T HILInitialize_DOTerminate;
                                /* Computed Parameter: HILInitialize_DOTerminate
                                 * Referenced by: '<S9>/HIL Initialize'
                                 */
  boolean_T HILInitialize_DOExit;    /* Computed Parameter: HILInitialize_DOExit
                                      * Referenced by: '<S9>/HIL Initialize'
                                      */
  boolean_T HILInitialize_POTerminate;
                                /* Computed Parameter: HILInitialize_POTerminate
                                 * Referenced by: '<S9>/HIL Initialize'
                                 */
  boolean_T HILInitialize_POExit;    /* Computed Parameter: HILInitialize_POExit
                                      * Referenced by: '<S9>/HIL Initialize'
                                      */
  boolean_T HILInitialize_CKPStart;/* Computed Parameter: HILInitialize_CKPStart
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_CKPEnter;/* Computed Parameter: HILInitialize_CKPEnter
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_CKStart;  /* Computed Parameter: HILInitialize_CKStart
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_CKEnter;  /* Computed Parameter: HILInitialize_CKEnter
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_AIPStart;/* Computed Parameter: HILInitialize_AIPStart
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_AIPEnter;/* Computed Parameter: HILInitialize_AIPEnter
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_AOPStart;/* Computed Parameter: HILInitialize_AOPStart
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_AOPEnter;/* Computed Parameter: HILInitialize_AOPEnter
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_AOStart;  /* Computed Parameter: HILInitialize_AOStart
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_AOEnter;  /* Computed Parameter: HILInitialize_AOEnter
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_AOReset;  /* Computed Parameter: HILInitialize_AOReset
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_DOPStart;/* Computed Parameter: HILInitialize_DOPStart
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_DOPEnter;/* Computed Parameter: HILInitialize_DOPEnter
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_DOStart;  /* Computed Parameter: HILInitialize_DOStart
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_DOEnter;  /* Computed Parameter: HILInitialize_DOEnter
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_DOReset;  /* Computed Parameter: HILInitialize_DOReset
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_EIPStart;/* Computed Parameter: HILInitialize_EIPStart
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_EIPEnter;/* Computed Parameter: HILInitialize_EIPEnter
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_EIStart;  /* Computed Parameter: HILInitialize_EIStart
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_EIEnter;  /* Computed Parameter: HILInitialize_EIEnter
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_POPStart;/* Computed Parameter: HILInitialize_POPStart
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_POPEnter;/* Computed Parameter: HILInitialize_POPEnter
                                    * Referenced by: '<S9>/HIL Initialize'
                                    */
  boolean_T HILInitialize_POStart;  /* Computed Parameter: HILInitialize_POStart
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_POEnter;  /* Computed Parameter: HILInitialize_POEnter
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_POReset;  /* Computed Parameter: HILInitialize_POReset
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_OOReset;  /* Computed Parameter: HILInitialize_OOReset
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_DOFinal;  /* Computed Parameter: HILInitialize_DOFinal
                                     * Referenced by: '<S9>/HIL Initialize'
                                     */
  boolean_T HILInitialize_DOInitial;
                                  /* Computed Parameter: HILInitialize_DOInitial
                                   * Referenced by: '<S9>/HIL Initialize'
                                   */
  boolean_T HILReadTimebase_Active;/* Computed Parameter: HILReadTimebase_Active
                                    * Referenced by: '<S9>/HIL Read Timebase'
                                    */
  boolean_T TmpRTBAtHeadingKalmanFilterInpo;
                          /* Computed Parameter: TmpRTBAtHeadingKalmanFilterInpo
                           * Referenced by:
                           */
  boolean_T TmpRTBAtQCarEKFInport6_InitialC;
                          /* Computed Parameter: TmpRTBAtQCarEKFInport6_InitialC
                           * Referenced by:
                           */
  boolean_T lane_detected_InitialCondition;
                           /* Computed Parameter: lane_detected_InitialCondition
                            * Referenced by:
                            */
  boolean_T HostGameController_AutoCenter;
                            /* Computed Parameter: HostGameController_AutoCenter
                             * Referenced by: '<Root>/Host Game Controller'
                             */
  boolean_T HostGameController_Enabled;
                               /* Computed Parameter: HostGameController_Enabled
                                * Referenced by: '<Root>/Host Game Controller'
                                */
  boolean_T HostGameController_DebugMode;
                             /* Computed Parameter: HostGameController_DebugMode
                              * Referenced by: '<Root>/Host Game Controller'
                              */
  boolean_T HILWrite_Active;           /* Computed Parameter: HILWrite_Active
                                        * Referenced by: '<S14>/HIL Write'
                                        */
  boolean_T RangingSensor_Active;    /* Computed Parameter: RangingSensor_Active
                                      * Referenced by: '<S5>/Ranging Sensor'
                                      */
  boolean_T Memory_InitialCondition_p;
                                /* Computed Parameter: Memory_InitialCondition_p
                                 * Referenced by: '<S16>/Memory'
                                 */
  int8_T HostGameController_Controller;
                            /* Computed Parameter: HostGameController_Controller
                             * Referenced by: '<Root>/Host Game Controller'
                             */
  uint8_T HostInitialize_URI[24];      /* Expression: uri_argument
                                        * Referenced by: '<Root>/Host Initialize'
                                        */
  uint8_T HILReadTimebase_OverflowMode;
                             /* Computed Parameter: HILReadTimebase_OverflowMode
                              * Referenced by: '<S9>/HIL Read Timebase'
                              */
  uint8_T ManualSwitch2_CurrentSetting;
                             /* Computed Parameter: ManualSwitch2_CurrentSetting
                              * Referenced by: '<S12>/Manual Switch2'
                              */
  uint8_T ManualSwitch1_CurrentSetting;
                             /* Computed Parameter: ManualSwitch1_CurrentSetting
                              * Referenced by: '<S12>/Manual Switch1'
                              */
  uint8_T ManualSwitch_CurrentSetting;
                              /* Computed Parameter: ManualSwitch_CurrentSetting
                               * Referenced by: '<S11>/Manual Switch'
                               */
  uint8_T ManualSwitch_CurrentSetting_n;
                            /* Computed Parameter: ManualSwitch_CurrentSetting_n
                             * Referenced by: '<S20>/Manual Switch'
                             */
  uint8_T ManualSwitch_CurrentSetting_nu;
                           /* Computed Parameter: ManualSwitch_CurrentSetting_nu
                            * Referenced by: '<S41>/Manual Switch'
                            */
  uint8_T TmpRTBAtMATLABFunction1Inport1_;
                          /* Computed Parameter: TmpRTBAtMATLABFunction1Inport1_
                           * Referenced by:
                           */
  uint8_T TmpRTBAtToWorkspaceInport1_Init;
                          /* Computed Parameter: TmpRTBAtToWorkspaceInport1_Init
                           * Referenced by:
                           */
  uint8_T BodyFrame_Mode;              /* Computed Parameter: BodyFrame_Mode
                                        * Referenced by: '<S6>/Body Frame'
                                        */
  uint8_T FixedFrame_Mode;             /* Computed Parameter: FixedFrame_Mode
                                        * Referenced by: '<S6>/Fixed Frame'
                                        */
  uint8_T XYPlot_Mode;                 /* Computed Parameter: XYPlot_Mode
                                        * Referenced by: '<S7>/XY Plot'
                                        */
  uint8_T XYPlot_Mode_g;               /* Computed Parameter: XYPlot_Mode_g
                                        * Referenced by: '<S12>/XY Plot'
                                        */
  P_IfActionSubsystem_VIRTUAL_d_T IfActionSubsystem2;/* '<S56>/If Action Subsystem2' */
  P_IfActionSubsystem_VIRTUAL_d_T IfActionSubsystem1;/* '<S56>/If Action Subsystem1' */
  P_IfActionSubsystem_VIRTUAL_d_T IfActionSubsystem;/* '<S56>/If Action Subsystem' */
};

/* Real-time Model Data Structure */
struct tag_RTM_VIRTUAL_data_collecti_T {
  const char_T *path;
  const char_T *modelName;
  struct SimStruct_tag * *childSfunctions;
  const char_T *errorStatus;
  SS_SimMode simMode;
  RTWExtModeInfo *extModeInfo;
  RTWSolverInfo solverInfo;
  RTWSolverInfo *solverInfoPtr;
  void *sfcnInfo;
  void *blockIO;
  const void *constBlockIO;
  void *defaultParam;
  ZCSigState *prevZCSigState;
  real_T *contStates;
  int_T *periodicContStateIndices;
  real_T *periodicContStateRanges;
  real_T *derivs;
  void *zcSignalValues;
  void *inputs;
  void *outputs;
  boolean_T *contStateDisabled;
  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;
  real_T odeF[1][16];
  ODE1_IntgData intgData;
  void *dwork;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
    uint32_T options;
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numU;
    int_T numY;
    int_T numSampTimes;
    int_T numBlocks;
    int_T numBlockIO;
    int_T numBlockPrms;
    int_T numDwork;
    int_T numSFcnPrms;
    int_T numSFcns;
    int_T numIports;
    int_T numOports;
    int_T numNonSampZCs;
    int_T sysDirFeedThru;
    int_T rtwGenSfcn;
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
    void *xpcData;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T stepSize;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T stepSize1;
    uint32_T clockTick2;
    uint32_T clockTickH2;
    time_T stepSize2;
    uint32_T clockTick3;
    uint32_T clockTickH3;
    time_T stepSize3;
    uint32_T clockTick4;
    uint32_T clockTickH4;
    time_T stepSize4;
    uint32_T clockTick5;
    uint32_T clockTickH5;
    time_T stepSize5;
    uint32_T clockTick6;
    uint32_T clockTickH6;
    time_T stepSize6;
    uint32_T clockTick7;
    uint32_T clockTickH7;
    time_T stepSize7;
    boolean_T firstInitCondFlag;
    struct {
      uint16_T TID[8];
    } TaskCounters;

    struct {
      boolean_T TID1_2;
      boolean_T TID1_4;
      boolean_T TID1_5;
    } RateInteraction;

    time_T tStart;
    time_T tFinal;
    time_T timeOfLastOutput;
    void *timingData;
    real_T *varNextHitTimesList;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *sampleTimes;
    time_T *offsetTimes;
    int_T *sampleTimeTaskIDPtr;
    int_T *sampleHits;
    int_T *perTaskSampleHits;
    time_T *t;
    time_T sampleTimesArray[8];
    time_T offsetTimesArray[8];
    int_T sampleTimeTaskIDArray[8];
    int_T sampleHitArray[8];
    int_T perTaskSampleHitsArray[64];
    time_T tArray[8];
  } Timing;
};

/* Block parameters (default storage) */
extern P_VIRTUAL_data_collection_T VIRTUAL_data_collection_P;

/* Block signals (default storage) */
extern B_VIRTUAL_data_collection_T VIRTUAL_data_collection_B;

/* Continuous states (default storage) */
extern X_VIRTUAL_data_collection_T VIRTUAL_data_collection_X;

/* Disabled states (default storage) */
extern XDis_VIRTUAL_data_collection_T VIRTUAL_data_collection_XDis;

/* Block states (default storage) */
extern DW_VIRTUAL_data_collection_T VIRTUAL_data_collection_DW;

/* Zero-crossing (trigger) state */
extern PrevZCX_VIRTUAL_data_collecti_T VIRTUAL_data_collection_PrevZCX;

/* External function called from main */
extern time_T rt_SimUpdateDiscreteEvents(
  int_T rtmNumSampTimes, void *rtmTimingData, int_T *rtmSampleHitPtr, int_T
  *rtmPerTaskSampleHits )
  ;

/* Model entry point functions */
extern void VIRTUAL_data_collection_initialize(void);
extern void VIRTUAL_data_collection_output0(void);
extern void VIRTUAL_data_collection_update0(void);
extern void VIRTUAL_data_collection_output2(void);
extern void VIRTUAL_data_collection_update2(void);
extern void VIRTUAL_data_collection_output3(void);
extern void VIRTUAL_data_collection_update3(void);
extern void VIRTUAL_data_collection_output4(void);
extern void VIRTUAL_data_collection_update4(void);
extern void VIRTUAL_data_collection_output5(void);
extern void VIRTUAL_data_collection_update5(void);
extern void VIRTUAL_data_collection_output6(void);
extern void VIRTUAL_data_collection_update6(void);
extern void VIRTUAL_data_collection_output7(void);
extern void VIRTUAL_data_collection_update7(void);
extern void VIRTUAL_data_collection_terminate(void);

/*====================*
 * External functions *
 *====================*/
extern VIRTUAL_data_collection_rtModel *VIRTUAL_data_collection(void);
extern void MdlInitializeSizes(void);
extern void MdlInitializeSampleTimes(void);
extern void MdlInitialize(void);
extern void MdlStart(void);
extern void MdlOutputs(int_T tid);
extern void MdlUpdate(int_T tid);
extern void MdlTerminate(void);

/* Real-time Model object */
extern RT_MODEL_VIRTUAL_data_collect_T *const VIRTUAL_data_collection_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'VIRTUAL_data_collection'
 * '<S1>'   : 'VIRTUAL_data_collection/CSICameras'
 * '<S2>'   : 'VIRTUAL_data_collection/MATLAB Function'
 * '<S3>'   : 'VIRTUAL_data_collection/MATLAB Function1'
 * '<S4>'   : 'VIRTUAL_data_collection/MATLAB Function2'
 * '<S5>'   : 'VIRTUAL_data_collection/lidarCapture'
 * '<S6>'   : 'VIRTUAL_data_collection/lidarLocalization'
 * '<S7>'   : 'VIRTUAL_data_collection/pathPlanner'
 * '<S8>'   : 'VIRTUAL_data_collection/rateTimingPlots'
 * '<S9>'   : 'VIRTUAL_data_collection/readQCarDAC'
 * '<S10>'  : 'VIRTUAL_data_collection/realsenseCapture'
 * '<S11>'  : 'VIRTUAL_data_collection/speedController'
 * '<S12>'  : 'VIRTUAL_data_collection/stateEstimation'
 * '<S13>'  : 'VIRTUAL_data_collection/steeringCommander'
 * '<S14>'  : 'VIRTUAL_data_collection/writeToQCarDAC'
 * '<S15>'  : 'VIRTUAL_data_collection/lidarLocalization/Match Scans'
 * '<S16>'  : 'VIRTUAL_data_collection/lidarLocalization/RisingEdge'
 * '<S17>'  : 'VIRTUAL_data_collection/lidarLocalization/rising edge latch'
 * '<S18>'  : 'VIRTUAL_data_collection/lidarLocalization/Match Scans/MATLAB Function'
 * '<S19>'  : 'VIRTUAL_data_collection/lidarLocalization/rising edge latch/Latch Input'
 * '<S20>'  : 'VIRTUAL_data_collection/pathPlanner/Path 4  Look Ahead Generator'
 * '<S21>'  : 'VIRTUAL_data_collection/pathPlanner/rateAligner'
 * '<S22>'  : 'VIRTUAL_data_collection/pathPlanner/Path 4  Look Ahead Generator/Windowed Closest Point Locator *Feedback the location1'
 * '<S23>'  : 'VIRTUAL_data_collection/rateTimingPlots/monitorTiming'
 * '<S24>'  : 'VIRTUAL_data_collection/rateTimingPlots/monitorTiming1'
 * '<S25>'  : 'VIRTUAL_data_collection/rateTimingPlots/monitorTiming2'
 * '<S26>'  : 'VIRTUAL_data_collection/rateTimingPlots/monitorTiming3'
 * '<S27>'  : 'VIRTUAL_data_collection/rateTimingPlots/monitorTiming5'
 * '<S28>'  : 'VIRTUAL_data_collection/rateTimingPlots/monitorTiming7'
 * '<S29>'  : 'VIRTUAL_data_collection/readQCarDAC/counts to meters'
 * '<S30>'  : 'VIRTUAL_data_collection/readQCarDAC/counts//s to m//s'
 * '<S31>'  : 'VIRTUAL_data_collection/readQCarDAC/powerConsumptionMonitor'
 * '<S32>'  : 'VIRTUAL_data_collection/speedController/limitAcceleration'
 * '<S33>'  : 'VIRTUAL_data_collection/speedController/realsenseObstacleDetectionSpeedAdjust'
 * '<S34>'  : 'VIRTUAL_data_collection/speedController/speedController'
 * '<S35>'  : 'VIRTUAL_data_collection/speedController/turnSpeedHandler'
 * '<S36>'  : 'VIRTUAL_data_collection/speedController/limitAcceleration/Saturation Dynamic'
 * '<S37>'  : 'VIRTUAL_data_collection/speedController/realsenseObstacleDetectionSpeedAdjust/MATLAB Function'
 * '<S38>'  : 'VIRTUAL_data_collection/speedController/speedController/Compare To Zero'
 * '<S39>'  : 'VIRTUAL_data_collection/stateEstimation/Fusion Comparison & Kalman Estimator'
 * '<S40>'  : 'VIRTUAL_data_collection/stateEstimation/Gyro KF + EKF'
 * '<S41>'  : 'VIRTUAL_data_collection/stateEstimation/Sensor Fusion -  Complementary Filter'
 * '<S42>'  : 'VIRTUAL_data_collection/stateEstimation/Subsystem'
 * '<S43>'  : 'VIRTUAL_data_collection/stateEstimation/Subsystem1'
 * '<S44>'  : 'VIRTUAL_data_collection/stateEstimation/bicycleModel'
 * '<S45>'  : 'VIRTUAL_data_collection/stateEstimation/xy signal maker'
 * '<S46>'  : 'VIRTUAL_data_collection/stateEstimation/Fusion Comparison & Kalman Estimator/Angle mod1'
 * '<S47>'  : 'VIRTUAL_data_collection/stateEstimation/Fusion Comparison & Kalman Estimator/Radians to Degrees'
 * '<S48>'  : 'VIRTUAL_data_collection/stateEstimation/Fusion Comparison & Kalman Estimator/Radians to Degrees2'
 * '<S49>'  : 'VIRTUAL_data_collection/stateEstimation/Fusion Comparison & Kalman Estimator/Radians to Degrees3'
 * '<S50>'  : 'VIRTUAL_data_collection/stateEstimation/Gyro KF + EKF/Heading Kalman Filter'
 * '<S51>'  : 'VIRTUAL_data_collection/stateEstimation/Gyro KF + EKF/QCar EKF'
 * '<S52>'  : 'VIRTUAL_data_collection/stateEstimation/Sensor Fusion -  Complementary Filter/MATLAB Function'
 * '<S53>'  : 'VIRTUAL_data_collection/steeringCommander/Compare To Constant'
 * '<S54>'  : 'VIRTUAL_data_collection/steeringCommander/Cross Track Controller'
 * '<S55>'  : 'VIRTUAL_data_collection/steeringCommander/Second-Order Low-Pass Filter'
 * '<S56>'  : 'VIRTUAL_data_collection/steeringCommander/Steering Based on LiDAR'
 * '<S57>'  : 'VIRTUAL_data_collection/steeringCommander/Cross Track Controller/Cross Product'
 * '<S58>'  : 'VIRTUAL_data_collection/steeringCommander/Steering Based on LiDAR/If Action Subsystem'
 * '<S59>'  : 'VIRTUAL_data_collection/steeringCommander/Steering Based on LiDAR/If Action Subsystem1'
 * '<S60>'  : 'VIRTUAL_data_collection/steeringCommander/Steering Based on LiDAR/If Action Subsystem2'
 */
#endif                                 /* VIRTUAL_data_collection_h_ */
