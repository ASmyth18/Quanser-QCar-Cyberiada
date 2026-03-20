    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 14;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (VIRTUAL_data_collection_P)
        ;%
            section.nData     = 37;
            section.data(37)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.CSI_Sample_Time
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.Controller_Sample_Time
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_P.GyroKF_Q
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_P.GyroKF_R
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_P.ImageDisplay_Sample_Time
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 7;

                    ;% VIRTUAL_data_collection_P.Initialization_Time
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 8;

                    ;% VIRTUAL_data_collection_P.LiDAR_Sample_Time
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 9;

                    ;% VIRTUAL_data_collection_P.QCarEKF_L
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 10;

                    ;% VIRTUAL_data_collection_P.QCarEKF_P0
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 11;

                    ;% VIRTUAL_data_collection_P.QCarEKF_R_combined
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_P.RealSense_Sample_Time
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_P.angles_qcar2
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_P.cal_pos
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 414;

                    ;% VIRTUAL_data_collection_P.path_x4
                    section.data(14).logicalSrcIdx = 13;
                    section.data(14).dtTransOffset = 417;

                    ;% VIRTUAL_data_collection_P.path_y4
                    section.data(15).logicalSrcIdx = 14;
                    section.data(15).dtTransOffset = 2680;

                    ;% VIRTUAL_data_collection_P.qcar2_lidar_to_body_rotation
                    section.data(16).logicalSrcIdx = 15;
                    section.data(16).dtTransOffset = 4943;

                    ;% VIRTUAL_data_collection_P.qcar2_lidar_to_map_rotation
                    section.data(17).logicalSrcIdx = 16;
                    section.data(17).dtTransOffset = 4944;

                    ;% VIRTUAL_data_collection_P.qcar2_virtual_to_physical_lidar_rotation
                    section.data(18).logicalSrcIdx = 17;
                    section.data(18).dtTransOffset = 4945;

                    ;% VIRTUAL_data_collection_P.range_qcar2
                    section.data(19).logicalSrcIdx = 18;
                    section.data(19).dtTransOffset = 4946;

                    ;% VIRTUAL_data_collection_P.steering_Kd
                    section.data(20).logicalSrcIdx = 19;
                    section.data(20).dtTransOffset = 5330;

                    ;% VIRTUAL_data_collection_P.steering_Kp
                    section.data(21).logicalSrcIdx = 20;
                    section.data(21).dtTransOffset = 5331;

                    ;% VIRTUAL_data_collection_P.BodyFrame_maximum_rho
                    section.data(22).logicalSrcIdx = 21;
                    section.data(22).dtTransOffset = 5332;

                    ;% VIRTUAL_data_collection_P.FixedFrame_maximum_rho
                    section.data(23).logicalSrcIdx = 22;
                    section.data(23).dtTransOffset = 5333;

                    ;% VIRTUAL_data_collection_P.BodyFrame_maximum_theta
                    section.data(24).logicalSrcIdx = 23;
                    section.data(24).dtTransOffset = 5334;

                    ;% VIRTUAL_data_collection_P.FixedFrame_maximum_theta
                    section.data(25).logicalSrcIdx = 24;
                    section.data(25).dtTransOffset = 5335;

                    ;% VIRTUAL_data_collection_P.XYPlot_maximum_x
                    section.data(26).logicalSrcIdx = 25;
                    section.data(26).dtTransOffset = 5336;

                    ;% VIRTUAL_data_collection_P.XYPlot_maximum_x_l
                    section.data(27).logicalSrcIdx = 26;
                    section.data(27).dtTransOffset = 5337;

                    ;% VIRTUAL_data_collection_P.XYPlot_maximum_y
                    section.data(28).logicalSrcIdx = 27;
                    section.data(28).dtTransOffset = 5338;

                    ;% VIRTUAL_data_collection_P.XYPlot_maximum_y_o
                    section.data(29).logicalSrcIdx = 28;
                    section.data(29).dtTransOffset = 5339;

                    ;% VIRTUAL_data_collection_P.BodyFrame_minimum_rho
                    section.data(30).logicalSrcIdx = 29;
                    section.data(30).dtTransOffset = 5340;

                    ;% VIRTUAL_data_collection_P.FixedFrame_minimum_rho
                    section.data(31).logicalSrcIdx = 30;
                    section.data(31).dtTransOffset = 5341;

                    ;% VIRTUAL_data_collection_P.BodyFrame_minimum_theta
                    section.data(32).logicalSrcIdx = 31;
                    section.data(32).dtTransOffset = 5342;

                    ;% VIRTUAL_data_collection_P.FixedFrame_minimum_theta
                    section.data(33).logicalSrcIdx = 32;
                    section.data(33).dtTransOffset = 5343;

                    ;% VIRTUAL_data_collection_P.XYPlot_minimum_x
                    section.data(34).logicalSrcIdx = 33;
                    section.data(34).dtTransOffset = 5344;

                    ;% VIRTUAL_data_collection_P.XYPlot_minimum_x_j
                    section.data(35).logicalSrcIdx = 34;
                    section.data(35).dtTransOffset = 5345;

                    ;% VIRTUAL_data_collection_P.XYPlot_minimum_y
                    section.data(36).logicalSrcIdx = 35;
                    section.data(36).dtTransOffset = 5346;

                    ;% VIRTUAL_data_collection_P.XYPlot_minimum_y_n
                    section.data(37).logicalSrcIdx = 36;
                    section.data(37).dtTransOffset = 5347;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 8;
            section.data(8)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.BodyFrame_direction
                    section.data(1).logicalSrcIdx = 37;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.FixedFrame_direction
                    section.data(2).logicalSrcIdx = 38;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_P.BodyFrame_update_rate
                    section.data(3).logicalSrcIdx = 39;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_P.FixedFrame_update_rate
                    section.data(4).logicalSrcIdx = 40;
                    section.data(4).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_P.XYPlot_update_rate
                    section.data(5).logicalSrcIdx = 41;
                    section.data(5).dtTransOffset = 4;

                    ;% VIRTUAL_data_collection_P.XYPlot_update_rate_m
                    section.data(6).logicalSrcIdx = 42;
                    section.data(6).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_P.BodyFrame_zero_location
                    section.data(7).logicalSrcIdx = 43;
                    section.data(7).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_P.FixedFrame_zero_location
                    section.data(8).logicalSrcIdx = 44;
                    section.data(8).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.HILWrite_digital_channels
                    section.data(1).logicalSrcIdx = 45;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.HILWrite_other_channels
                    section.data(2).logicalSrcIdx = 46;
                    section.data(2).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_stream_in
                    section.data(3).logicalSrcIdx = 47;
                    section.data(3).dtTransOffset = 18;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.Video3DInitialize_active
                    section.data(1).logicalSrcIdx = 48;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section

            section.nData     = 271;
            section.data(271)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.Constant_Value
                    section.data(1).logicalSrcIdx = 49;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.Constant1_Value
                    section.data(2).logicalSrcIdx = 50;
                    section.data(2).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_P.pose_Y0
                    section.data(3).logicalSrcIdx = 51;
                    section.data(3).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_P.LIDARScanMatch_Resolution
                    section.data(4).logicalSrcIdx = 52;
                    section.data(4).dtTransOffset = 7;

                    ;% VIRTUAL_data_collection_P.LIDARScanMatch_MaxRange
                    section.data(5).logicalSrcIdx = 53;
                    section.data(5).dtTransOffset = 8;

                    ;% VIRTUAL_data_collection_P.Latch_Y0
                    section.data(6).logicalSrcIdx = 54;
                    section.data(6).dtTransOffset = 9;

                    ;% VIRTUAL_data_collection_P.Constant_Value_e
                    section.data(7).logicalSrcIdx = 55;
                    section.data(7).dtTransOffset = 10;

                    ;% VIRTUAL_data_collection_P.Constant5_Value
                    section.data(8).logicalSrcIdx = 56;
                    section.data(8).dtTransOffset = 11;

                    ;% VIRTUAL_data_collection_P.Constant10_Value
                    section.data(9).logicalSrcIdx = 57;
                    section.data(9).dtTransOffset = 12;

                    ;% VIRTUAL_data_collection_P.Constant11_Value
                    section.data(10).logicalSrcIdx = 58;
                    section.data(10).dtTransOffset = 13;

                    ;% VIRTUAL_data_collection_P.Constant_Value_a
                    section.data(11).logicalSrcIdx = 59;
                    section.data(11).dtTransOffset = 14;

                    ;% VIRTUAL_data_collection_P.accLimit_Value
                    section.data(12).logicalSrcIdx = 60;
                    section.data(12).dtTransOffset = 15;

                    ;% VIRTUAL_data_collection_P.Constant_Value_l
                    section.data(13).logicalSrcIdx = 61;
                    section.data(13).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_P.lidarSteering1rad_Y0
                    section.data(14).logicalSrcIdx = 62;
                    section.data(14).dtTransOffset = 17;

                    ;% VIRTUAL_data_collection_P.GyroFilter_A
                    section.data(15).logicalSrcIdx = 63;
                    section.data(15).dtTransOffset = 18;

                    ;% VIRTUAL_data_collection_P.GyroFilter_C
                    section.data(16).logicalSrcIdx = 64;
                    section.data(16).dtTransOffset = 19;

                    ;% VIRTUAL_data_collection_P.Constant_Value_k
                    section.data(17).logicalSrcIdx = 65;
                    section.data(17).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOTerminate
                    section.data(18).logicalSrcIdx = 66;
                    section.data(18).dtTransOffset = 21;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOExit
                    section.data(19).logicalSrcIdx = 67;
                    section.data(19).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOStart
                    section.data(20).logicalSrcIdx = 68;
                    section.data(20).dtTransOffset = 23;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOEnter
                    section.data(21).logicalSrcIdx = 69;
                    section.data(21).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POFinal
                    section.data(22).logicalSrcIdx = 70;
                    section.data(22).dtTransOffset = 25;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOFinal
                    section.data(23).logicalSrcIdx = 71;
                    section.data(23).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AIHigh
                    section.data(24).logicalSrcIdx = 72;
                    section.data(24).dtTransOffset = 27;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AILow
                    section.data(25).logicalSrcIdx = 73;
                    section.data(25).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIFrequency
                    section.data(26).logicalSrcIdx = 74;
                    section.data(26).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POFrequency
                    section.data(27).logicalSrcIdx = 75;
                    section.data(27).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POInitial
                    section.data(28).logicalSrcIdx = 76;
                    section.data(28).dtTransOffset = 31;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POWatchdog
                    section.data(29).logicalSrcIdx = 77;
                    section.data(29).dtTransOffset = 32;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOInitial
                    section.data(30).logicalSrcIdx = 78;
                    section.data(30).dtTransOffset = 33;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOWatchdog
                    section.data(31).logicalSrcIdx = 79;
                    section.data(31).dtTransOffset = 34;

                    ;% VIRTUAL_data_collection_P.Unwrap224_Modulus
                    section.data(32).logicalSrcIdx = 80;
                    section.data(32).dtTransOffset = 35;

                    ;% VIRTUAL_data_collection_P.countstorotations_Gain
                    section.data(33).logicalSrcIdx = 81;
                    section.data(33).dtTransOffset = 36;

                    ;% VIRTUAL_data_collection_P.gearratios_Gain
                    section.data(34).logicalSrcIdx = 82;
                    section.data(34).dtTransOffset = 37;

                    ;% VIRTUAL_data_collection_P.rotstorads_Gain
                    section.data(35).logicalSrcIdx = 83;
                    section.data(35).dtTransOffset = 38;

                    ;% VIRTUAL_data_collection_P.wheelradius_Gain
                    section.data(36).logicalSrcIdx = 84;
                    section.data(36).dtTransOffset = 39;

                    ;% VIRTUAL_data_collection_P.Memory2_InitialCondition
                    section.data(37).logicalSrcIdx = 85;
                    section.data(37).dtTransOffset = 40;

                    ;% VIRTUAL_data_collection_P.RateTransition_InitialCondition
                    section.data(38).logicalSrcIdx = 86;
                    section.data(38).dtTransOffset = 41;

                    ;% VIRTUAL_data_collection_P.Memory1_InitialCondition
                    section.data(39).logicalSrcIdx = 87;
                    section.data(39).dtTransOffset = 42;

                    ;% VIRTUAL_data_collection_P.Integrator_IC
                    section.data(40).logicalSrcIdx = 88;
                    section.data(40).dtTransOffset = 43;

                    ;% VIRTUAL_data_collection_P.Bias_Bias
                    section.data(41).logicalSrcIdx = 89;
                    section.data(41).dtTransOffset = 44;

                    ;% VIRTUAL_data_collection_P.Constant1_Value_a
                    section.data(42).logicalSrcIdx = 90;
                    section.data(42).dtTransOffset = 45;

                    ;% VIRTUAL_data_collection_P.Bias1_Bias
                    section.data(43).logicalSrcIdx = 91;
                    section.data(43).dtTransOffset = 46;

                    ;% VIRTUAL_data_collection_P.Gain1_Gain
                    section.data(44).logicalSrcIdx = 92;
                    section.data(44).dtTransOffset = 47;

                    ;% VIRTUAL_data_collection_P.light_color_InitialCondition
                    section.data(45).logicalSrcIdx = 93;
                    section.data(45).dtTransOffset = 48;

                    ;% VIRTUAL_data_collection_P.sign_type_InitialCondition
                    section.data(46).logicalSrcIdx = 94;
                    section.data(46).dtTransOffset = 49;

                    ;% VIRTUAL_data_collection_P.lane_offset_InitialCondition
                    section.data(47).logicalSrcIdx = 95;
                    section.data(47).dtTransOffset = 50;

                    ;% VIRTUAL_data_collection_P.sign_size_InitialCondition
                    section.data(48).logicalSrcIdx = 96;
                    section.data(48).dtTransOffset = 51;

                    ;% VIRTUAL_data_collection_P.Gain2_Gain
                    section.data(49).logicalSrcIdx = 97;
                    section.data(49).dtTransOffset = 52;

                    ;% VIRTUAL_data_collection_P.SteeringBias_Bias
                    section.data(50).logicalSrcIdx = 98;
                    section.data(50).dtTransOffset = 53;

                    ;% VIRTUAL_data_collection_P.Gain_Gain
                    section.data(51).logicalSrcIdx = 99;
                    section.data(51).dtTransOffset = 54;

                    ;% VIRTUAL_data_collection_P.steeringsat_UpperSat
                    section.data(52).logicalSrcIdx = 100;
                    section.data(52).dtTransOffset = 55;

                    ;% VIRTUAL_data_collection_P.steeringsat_LowerSat
                    section.data(53).logicalSrcIdx = 101;
                    section.data(53).dtTransOffset = 56;

                    ;% VIRTUAL_data_collection_P.accLimit_Value_f
                    section.data(54).logicalSrcIdx = 102;
                    section.data(54).dtTransOffset = 57;

                    ;% VIRTUAL_data_collection_P.sampletime_WtEt
                    section.data(55).logicalSrcIdx = 103;
                    section.data(55).dtTransOffset = 58;

                    ;% VIRTUAL_data_collection_P.Constant_Value_j
                    section.data(56).logicalSrcIdx = 104;
                    section.data(56).dtTransOffset = 59;

                    ;% VIRTUAL_data_collection_P.Constant2_Value
                    section.data(57).logicalSrcIdx = 105;
                    section.data(57).dtTransOffset = 60;

                    ;% VIRTUAL_data_collection_P.motorSat_UpperSat
                    section.data(58).logicalSrcIdx = 106;
                    section.data(58).dtTransOffset = 61;

                    ;% VIRTUAL_data_collection_P.motorSat_LowerSat
                    section.data(59).logicalSrcIdx = 107;
                    section.data(59).dtTransOffset = 62;

                    ;% VIRTUAL_data_collection_P.steeringSat_UpperSat
                    section.data(60).logicalSrcIdx = 108;
                    section.data(60).dtTransOffset = 63;

                    ;% VIRTUAL_data_collection_P.steeringSat_LowerSat
                    section.data(61).logicalSrcIdx = 109;
                    section.data(61).dtTransOffset = 64;

                    ;% VIRTUAL_data_collection_P.turningAttenuation_Value
                    section.data(62).logicalSrcIdx = 110;
                    section.data(62).dtTransOffset = 65;

                    ;% VIRTUAL_data_collection_P.attenuationLimits_UpperSat
                    section.data(63).logicalSrcIdx = 111;
                    section.data(63).dtTransOffset = 66;

                    ;% VIRTUAL_data_collection_P.attenuationLimits_LowerSat
                    section.data(64).logicalSrcIdx = 112;
                    section.data(64).dtTransOffset = 67;

                    ;% VIRTUAL_data_collection_P.commandsaturation_UpperSat
                    section.data(65).logicalSrcIdx = 113;
                    section.data(65).dtTransOffset = 68;

                    ;% VIRTUAL_data_collection_P.commandsaturation_LowerSat
                    section.data(66).logicalSrcIdx = 114;
                    section.data(66).dtTransOffset = 69;

                    ;% VIRTUAL_data_collection_P.TmpRTBAtProductInport1_InitialC
                    section.data(67).logicalSrcIdx = 115;
                    section.data(67).dtTransOffset = 70;

                    ;% VIRTUAL_data_collection_P.Kffms_Gain
                    section.data(68).logicalSrcIdx = 116;
                    section.data(68).dtTransOffset = 71;

                    ;% VIRTUAL_data_collection_P.Kpms_Gain
                    section.data(69).logicalSrcIdx = 117;
                    section.data(69).dtTransOffset = 72;

                    ;% VIRTUAL_data_collection_P.Integrator1_IC
                    section.data(70).logicalSrcIdx = 118;
                    section.data(70).dtTransOffset = 73;

                    ;% VIRTUAL_data_collection_P.Integrator1_UpperSat
                    section.data(71).logicalSrcIdx = 119;
                    section.data(71).dtTransOffset = 74;

                    ;% VIRTUAL_data_collection_P.Integrator1_LowerSat
                    section.data(72).logicalSrcIdx = 120;
                    section.data(72).dtTransOffset = 75;

                    ;% VIRTUAL_data_collection_P.motorsat_UpperSat
                    section.data(73).logicalSrcIdx = 121;
                    section.data(73).dtTransOffset = 76;

                    ;% VIRTUAL_data_collection_P.motorsat_LowerSat
                    section.data(74).logicalSrcIdx = 122;
                    section.data(74).dtTransOffset = 77;

                    ;% VIRTUAL_data_collection_P.Memory_InitialCondition
                    section.data(75).logicalSrcIdx = 123;
                    section.data(75).dtTransOffset = 78;

                    ;% VIRTUAL_data_collection_P.desiredPath_Value
                    section.data(76).logicalSrcIdx = 124;
                    section.data(76).dtTransOffset = 79;

                    ;% VIRTUAL_data_collection_P.Memory_InitialCondition_e
                    section.data(77).logicalSrcIdx = 125;
                    section.data(77).dtTransOffset = 80;

                    ;% VIRTUAL_data_collection_P.Gain2_Gain_m
                    section.data(78).logicalSrcIdx = 126;
                    section.data(78).dtTransOffset = 81;

                    ;% VIRTUAL_data_collection_P.lookaheadbias_Bias
                    section.data(79).logicalSrcIdx = 127;
                    section.data(79).dtTransOffset = 82;

                    ;% VIRTUAL_data_collection_P.mcm_Gain
                    section.data(80).logicalSrcIdx = 128;
                    section.data(80).dtTransOffset = 83;

                    ;% VIRTUAL_data_collection_P.Constant5_Value_d
                    section.data(81).logicalSrcIdx = 129;
                    section.data(81).dtTransOffset = 84;

                    ;% VIRTUAL_data_collection_P.Memory_InitialCondition_o
                    section.data(82).logicalSrcIdx = 130;
                    section.data(82).dtTransOffset = 85;

                    ;% VIRTUAL_data_collection_P.Constant1_Value_ak
                    section.data(83).logicalSrcIdx = 131;
                    section.data(83).dtTransOffset = 86;

                    ;% VIRTUAL_data_collection_P.Bias3_Bias
                    section.data(84).logicalSrcIdx = 132;
                    section.data(84).dtTransOffset = 87;

                    ;% VIRTUAL_data_collection_P.Constant7_Value
                    section.data(85).logicalSrcIdx = 133;
                    section.data(85).dtTransOffset = 88;

                    ;% VIRTUAL_data_collection_P.indexBias_Bias
                    section.data(86).logicalSrcIdx = 134;
                    section.data(86).dtTransOffset = 89;

                    ;% VIRTUAL_data_collection_P.Kim_Gain
                    section.data(87).logicalSrcIdx = 135;
                    section.data(87).dtTransOffset = 90;

                    ;% VIRTUAL_data_collection_P.Bias_Bias_a
                    section.data(88).logicalSrcIdx = 136;
                    section.data(88).dtTransOffset = 91;

                    ;% VIRTUAL_data_collection_P.Constant1_Value_g
                    section.data(89).logicalSrcIdx = 137;
                    section.data(89).dtTransOffset = 92;

                    ;% VIRTUAL_data_collection_P.Bias1_Bias_h
                    section.data(90).logicalSrcIdx = 138;
                    section.data(90).dtTransOffset = 93;

                    ;% VIRTUAL_data_collection_P.m_to_mm_Gain
                    section.data(91).logicalSrcIdx = 139;
                    section.data(91).dtTransOffset = 94;

                    ;% VIRTUAL_data_collection_P.Gain_Gain_b
                    section.data(92).logicalSrcIdx = 140;
                    section.data(92).dtTransOffset = 95;

                    ;% VIRTUAL_data_collection_P.Constant_Value_k1
                    section.data(93).logicalSrcIdx = 141;
                    section.data(93).dtTransOffset = 96;

                    ;% VIRTUAL_data_collection_P.m_to_mm1_Gain
                    section.data(94).logicalSrcIdx = 142;
                    section.data(94).dtTransOffset = 97;

                    ;% VIRTUAL_data_collection_P.Gain_Gain_p
                    section.data(95).logicalSrcIdx = 143;
                    section.data(95).dtTransOffset = 98;

                    ;% VIRTUAL_data_collection_P.m_to_mm2_Gain
                    section.data(96).logicalSrcIdx = 144;
                    section.data(96).dtTransOffset = 99;

                    ;% VIRTUAL_data_collection_P.Gain_Gain_n
                    section.data(97).logicalSrcIdx = 145;
                    section.data(97).dtTransOffset = 100;

                    ;% VIRTUAL_data_collection_P.Bias_Bias_e
                    section.data(98).logicalSrcIdx = 146;
                    section.data(98).dtTransOffset = 101;

                    ;% VIRTUAL_data_collection_P.Constant1_Value_d
                    section.data(99).logicalSrcIdx = 147;
                    section.data(99).dtTransOffset = 102;

                    ;% VIRTUAL_data_collection_P.Bias1_Bias_g
                    section.data(100).logicalSrcIdx = 148;
                    section.data(100).dtTransOffset = 103;

                    ;% VIRTUAL_data_collection_P.TransferFcn_A
                    section.data(101).logicalSrcIdx = 149;
                    section.data(101).dtTransOffset = 104;

                    ;% VIRTUAL_data_collection_P.TransferFcn_C
                    section.data(102).logicalSrcIdx = 150;
                    section.data(102).dtTransOffset = 105;

                    ;% VIRTUAL_data_collection_P.Lr_Value
                    section.data(103).logicalSrcIdx = 151;
                    section.data(103).dtTransOffset = 106;

                    ;% VIRTUAL_data_collection_P.wheelbase_Value
                    section.data(104).logicalSrcIdx = 152;
                    section.data(104).dtTransOffset = 107;

                    ;% VIRTUAL_data_collection_P.Constant1_Value_n
                    section.data(105).logicalSrcIdx = 153;
                    section.data(105).dtTransOffset = 108;

                    ;% VIRTUAL_data_collection_P.Constant2_Value_c
                    section.data(106).logicalSrcIdx = 154;
                    section.data(106).dtTransOffset = 109;

                    ;% VIRTUAL_data_collection_P.kp_Gain
                    section.data(107).logicalSrcIdx = 155;
                    section.data(107).dtTransOffset = 110;

                    ;% VIRTUAL_data_collection_P.Integrator1_IC_d
                    section.data(108).logicalSrcIdx = 156;
                    section.data(108).dtTransOffset = 113;

                    ;% VIRTUAL_data_collection_P.Integrator1_UpperSat_h
                    section.data(109).logicalSrcIdx = 157;
                    section.data(109).dtTransOffset = 114;

                    ;% VIRTUAL_data_collection_P.Integrator1_LowerSat_o
                    section.data(110).logicalSrcIdx = 158;
                    section.data(110).dtTransOffset = 117;

                    ;% VIRTUAL_data_collection_P.Gain_Gain_i
                    section.data(111).logicalSrcIdx = 159;
                    section.data(111).dtTransOffset = 120;

                    ;% VIRTUAL_data_collection_P.ki_Gain
                    section.data(112).logicalSrcIdx = 160;
                    section.data(112).dtTransOffset = 123;

                    ;% VIRTUAL_data_collection_P.Constant_Value_er
                    section.data(113).logicalSrcIdx = 161;
                    section.data(113).dtTransOffset = 126;

                    ;% VIRTUAL_data_collection_P.Memory1_InitialCondition_f
                    section.data(114).logicalSrcIdx = 162;
                    section.data(114).dtTransOffset = 127;

                    ;% VIRTUAL_data_collection_P.Integrator_IC_o
                    section.data(115).logicalSrcIdx = 163;
                    section.data(115).dtTransOffset = 128;

                    ;% VIRTUAL_data_collection_P.Integrator_UpperSat
                    section.data(116).logicalSrcIdx = 164;
                    section.data(116).dtTransOffset = 129;

                    ;% VIRTUAL_data_collection_P.Integrator_LowerSat
                    section.data(117).logicalSrcIdx = 165;
                    section.data(117).dtTransOffset = 130;

                    ;% VIRTUAL_data_collection_P.Gain3_Gain
                    section.data(118).logicalSrcIdx = 166;
                    section.data(118).dtTransOffset = 131;

                    ;% VIRTUAL_data_collection_P.Integrator1_IC_h
                    section.data(119).logicalSrcIdx = 167;
                    section.data(119).dtTransOffset = 132;

                    ;% VIRTUAL_data_collection_P.Integrator1_UpperSat_d
                    section.data(120).logicalSrcIdx = 168;
                    section.data(120).dtTransOffset = 133;

                    ;% VIRTUAL_data_collection_P.Integrator1_LowerSat_m
                    section.data(121).logicalSrcIdx = 169;
                    section.data(121).dtTransOffset = 134;

                    ;% VIRTUAL_data_collection_P.Saturation1_UpperSat
                    section.data(122).logicalSrcIdx = 170;
                    section.data(122).dtTransOffset = 135;

                    ;% VIRTUAL_data_collection_P.Saturation1_LowerSat
                    section.data(123).logicalSrcIdx = 171;
                    section.data(123).dtTransOffset = 136;

                    ;% VIRTUAL_data_collection_P.Constant1_Value_b
                    section.data(124).logicalSrcIdx = 172;
                    section.data(124).dtTransOffset = 137;

                    ;% VIRTUAL_data_collection_P.Constant3_Value
                    section.data(125).logicalSrcIdx = 173;
                    section.data(125).dtTransOffset = 138;

                    ;% VIRTUAL_data_collection_P.Constant1_Value_k
                    section.data(126).logicalSrcIdx = 174;
                    section.data(126).dtTransOffset = 139;

                    ;% VIRTUAL_data_collection_P.Gain6_Gain
                    section.data(127).logicalSrcIdx = 175;
                    section.data(127).dtTransOffset = 140;

                    ;% VIRTUAL_data_collection_P.Constant_Value_p
                    section.data(128).logicalSrcIdx = 176;
                    section.data(128).dtTransOffset = 141;

                    ;% VIRTUAL_data_collection_P.Integrator2_IC
                    section.data(129).logicalSrcIdx = 177;
                    section.data(129).dtTransOffset = 142;

                    ;% VIRTUAL_data_collection_P.Constant_Value_h
                    section.data(130).logicalSrcIdx = 178;
                    section.data(130).dtTransOffset = 143;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Brightnes
                    section.data(131).logicalSrcIdx = 179;
                    section.data(131).dtTransOffset = 144;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Contrast
                    section.data(132).logicalSrcIdx = 180;
                    section.data(132).dtTransOffset = 145;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Hue
                    section.data(133).logicalSrcIdx = 181;
                    section.data(133).dtTransOffset = 146;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Saturatio
                    section.data(134).logicalSrcIdx = 182;
                    section.data(134).dtTransOffset = 147;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Sharpness
                    section.data(135).logicalSrcIdx = 183;
                    section.data(135).dtTransOffset = 148;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Gamma
                    section.data(136).logicalSrcIdx = 184;
                    section.data(136).dtTransOffset = 149;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_WhiteBala
                    section.data(137).logicalSrcIdx = 185;
                    section.data(137).dtTransOffset = 150;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Backlight
                    section.data(138).logicalSrcIdx = 186;
                    section.data(138).dtTransOffset = 151;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Gain
                    section.data(139).logicalSrcIdx = 187;
                    section.data(139).dtTransOffset = 152;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Exposure
                    section.data(140).logicalSrcIdx = 188;
                    section.data(140).dtTransOffset = 153;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Emitter
                    section.data(141).logicalSrcIdx = 189;
                    section.data(141).dtTransOffset = 154;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Brightness
                    section.data(142).logicalSrcIdx = 190;
                    section.data(142).dtTransOffset = 155;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Contrast
                    section.data(143).logicalSrcIdx = 191;
                    section.data(143).dtTransOffset = 156;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Hue
                    section.data(144).logicalSrcIdx = 192;
                    section.data(144).dtTransOffset = 157;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Saturation
                    section.data(145).logicalSrcIdx = 193;
                    section.data(145).dtTransOffset = 158;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Sharpness
                    section.data(146).logicalSrcIdx = 194;
                    section.data(146).dtTransOffset = 159;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Gamma
                    section.data(147).logicalSrcIdx = 195;
                    section.data(147).dtTransOffset = 160;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_ColorEnable
                    section.data(148).logicalSrcIdx = 196;
                    section.data(148).dtTransOffset = 161;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_WhiteBalance
                    section.data(149).logicalSrcIdx = 197;
                    section.data(149).dtTransOffset = 162;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_BacklightCompens
                    section.data(150).logicalSrcIdx = 198;
                    section.data(150).dtTransOffset = 163;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Gain
                    section.data(151).logicalSrcIdx = 199;
                    section.data(151).dtTransOffset = 164;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Pan
                    section.data(152).logicalSrcIdx = 200;
                    section.data(152).dtTransOffset = 165;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Tilt
                    section.data(153).logicalSrcIdx = 201;
                    section.data(153).dtTransOffset = 166;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Roll
                    section.data(154).logicalSrcIdx = 202;
                    section.data(154).dtTransOffset = 167;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Zoom
                    section.data(155).logicalSrcIdx = 203;
                    section.data(155).dtTransOffset = 168;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Exposure
                    section.data(156).logicalSrcIdx = 204;
                    section.data(156).dtTransOffset = 169;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Iris
                    section.data(157).logicalSrcIdx = 205;
                    section.data(157).dtTransOffset = 170;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Focus
                    section.data(158).logicalSrcIdx = 206;
                    section.data(158).dtTransOffset = 171;

                    ;% VIRTUAL_data_collection_P.rightCSICamera_Mirror
                    section.data(159).logicalSrcIdx = 207;
                    section.data(159).dtTransOffset = 172;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Brightness
                    section.data(160).logicalSrcIdx = 208;
                    section.data(160).dtTransOffset = 173;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Contrast
                    section.data(161).logicalSrcIdx = 209;
                    section.data(161).dtTransOffset = 174;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Hue
                    section.data(162).logicalSrcIdx = 210;
                    section.data(162).dtTransOffset = 175;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Saturation
                    section.data(163).logicalSrcIdx = 211;
                    section.data(163).dtTransOffset = 176;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Sharpness
                    section.data(164).logicalSrcIdx = 212;
                    section.data(164).dtTransOffset = 177;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Gamma
                    section.data(165).logicalSrcIdx = 213;
                    section.data(165).dtTransOffset = 178;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_ColorEnable
                    section.data(166).logicalSrcIdx = 214;
                    section.data(166).dtTransOffset = 179;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_WhiteBalance
                    section.data(167).logicalSrcIdx = 215;
                    section.data(167).dtTransOffset = 180;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_BacklightCompensa
                    section.data(168).logicalSrcIdx = 216;
                    section.data(168).dtTransOffset = 181;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Gain
                    section.data(169).logicalSrcIdx = 217;
                    section.data(169).dtTransOffset = 182;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Pan
                    section.data(170).logicalSrcIdx = 218;
                    section.data(170).dtTransOffset = 183;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Tilt
                    section.data(171).logicalSrcIdx = 219;
                    section.data(171).dtTransOffset = 184;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Roll
                    section.data(172).logicalSrcIdx = 220;
                    section.data(172).dtTransOffset = 185;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Zoom
                    section.data(173).logicalSrcIdx = 221;
                    section.data(173).dtTransOffset = 186;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Exposure
                    section.data(174).logicalSrcIdx = 222;
                    section.data(174).dtTransOffset = 187;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Iris
                    section.data(175).logicalSrcIdx = 223;
                    section.data(175).dtTransOffset = 188;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Focus
                    section.data(176).logicalSrcIdx = 224;
                    section.data(176).dtTransOffset = 189;

                    ;% VIRTUAL_data_collection_P.rearCSICamera_Mirror
                    section.data(177).logicalSrcIdx = 225;
                    section.data(177).dtTransOffset = 190;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Brightness
                    section.data(178).logicalSrcIdx = 226;
                    section.data(178).dtTransOffset = 191;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Contrast
                    section.data(179).logicalSrcIdx = 227;
                    section.data(179).dtTransOffset = 192;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Hue
                    section.data(180).logicalSrcIdx = 228;
                    section.data(180).dtTransOffset = 193;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Saturation
                    section.data(181).logicalSrcIdx = 229;
                    section.data(181).dtTransOffset = 194;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Sharpness
                    section.data(182).logicalSrcIdx = 230;
                    section.data(182).dtTransOffset = 195;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Gamma
                    section.data(183).logicalSrcIdx = 231;
                    section.data(183).dtTransOffset = 196;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_ColorEnable
                    section.data(184).logicalSrcIdx = 232;
                    section.data(184).dtTransOffset = 197;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_WhiteBalance
                    section.data(185).logicalSrcIdx = 233;
                    section.data(185).dtTransOffset = 198;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_BacklightCompensa
                    section.data(186).logicalSrcIdx = 234;
                    section.data(186).dtTransOffset = 199;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Gain
                    section.data(187).logicalSrcIdx = 235;
                    section.data(187).dtTransOffset = 200;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Pan
                    section.data(188).logicalSrcIdx = 236;
                    section.data(188).dtTransOffset = 201;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Tilt
                    section.data(189).logicalSrcIdx = 237;
                    section.data(189).dtTransOffset = 202;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Roll
                    section.data(190).logicalSrcIdx = 238;
                    section.data(190).dtTransOffset = 203;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Zoom
                    section.data(191).logicalSrcIdx = 239;
                    section.data(191).dtTransOffset = 204;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Exposure
                    section.data(192).logicalSrcIdx = 240;
                    section.data(192).dtTransOffset = 205;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Iris
                    section.data(193).logicalSrcIdx = 241;
                    section.data(193).dtTransOffset = 206;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Focus
                    section.data(194).logicalSrcIdx = 242;
                    section.data(194).dtTransOffset = 207;

                    ;% VIRTUAL_data_collection_P.leftCSICamera_Mirror
                    section.data(195).logicalSrcIdx = 243;
                    section.data(195).dtTransOffset = 208;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Brightness
                    section.data(196).logicalSrcIdx = 244;
                    section.data(196).dtTransOffset = 209;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Contrast
                    section.data(197).logicalSrcIdx = 245;
                    section.data(197).dtTransOffset = 210;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Hue
                    section.data(198).logicalSrcIdx = 246;
                    section.data(198).dtTransOffset = 211;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Saturation
                    section.data(199).logicalSrcIdx = 247;
                    section.data(199).dtTransOffset = 212;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Sharpness
                    section.data(200).logicalSrcIdx = 248;
                    section.data(200).dtTransOffset = 213;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Gamma
                    section.data(201).logicalSrcIdx = 249;
                    section.data(201).dtTransOffset = 214;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_ColorEnable
                    section.data(202).logicalSrcIdx = 250;
                    section.data(202).dtTransOffset = 215;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_WhiteBalance
                    section.data(203).logicalSrcIdx = 251;
                    section.data(203).dtTransOffset = 216;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_BacklightCompens
                    section.data(204).logicalSrcIdx = 252;
                    section.data(204).dtTransOffset = 217;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Gain
                    section.data(205).logicalSrcIdx = 253;
                    section.data(205).dtTransOffset = 218;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Pan
                    section.data(206).logicalSrcIdx = 254;
                    section.data(206).dtTransOffset = 219;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Tilt
                    section.data(207).logicalSrcIdx = 255;
                    section.data(207).dtTransOffset = 220;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Roll
                    section.data(208).logicalSrcIdx = 256;
                    section.data(208).dtTransOffset = 221;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Zoom
                    section.data(209).logicalSrcIdx = 257;
                    section.data(209).dtTransOffset = 222;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Exposure
                    section.data(210).logicalSrcIdx = 258;
                    section.data(210).dtTransOffset = 223;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Iris
                    section.data(211).logicalSrcIdx = 259;
                    section.data(211).dtTransOffset = 224;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Focus
                    section.data(212).logicalSrcIdx = 260;
                    section.data(212).dtTransOffset = 225;

                    ;% VIRTUAL_data_collection_P.frontCSICamera_Mirror
                    section.data(213).logicalSrcIdx = 261;
                    section.data(213).dtTransOffset = 226;

                    ;% VIRTUAL_data_collection_P.RangingSensor_Budget
                    section.data(214).logicalSrcIdx = 262;
                    section.data(214).dtTransOffset = 227;

                    ;% VIRTUAL_data_collection_P.RangingSensor_Period
                    section.data(215).logicalSrcIdx = 263;
                    section.data(215).dtTransOffset = 228;

                    ;% VIRTUAL_data_collection_P.RangingSensor_MaxInterpolationD
                    section.data(216).logicalSrcIdx = 264;
                    section.data(216).dtTransOffset = 229;

                    ;% VIRTUAL_data_collection_P.RangingSensor_MaxInterpolationA
                    section.data(217).logicalSrcIdx = 265;
                    section.data(217).dtTransOffset = 230;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L1Width
                    section.data(218).logicalSrcIdx = 266;
                    section.data(218).dtTransOffset = 231;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L1Color
                    section.data(219).logicalSrcIdx = 267;
                    section.data(219).dtTransOffset = 232;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L1MSize
                    section.data(220).logicalSrcIdx = 268;
                    section.data(220).dtTransOffset = 235;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L1MEdgeColor
                    section.data(221).logicalSrcIdx = 269;
                    section.data(221).dtTransOffset = 236;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L1MFaceColor
                    section.data(222).logicalSrcIdx = 270;
                    section.data(222).dtTransOffset = 239;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L2Width
                    section.data(223).logicalSrcIdx = 271;
                    section.data(223).dtTransOffset = 242;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L2Color
                    section.data(224).logicalSrcIdx = 272;
                    section.data(224).dtTransOffset = 243;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L2MSize
                    section.data(225).logicalSrcIdx = 273;
                    section.data(225).dtTransOffset = 246;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L2MEdgeColor
                    section.data(226).logicalSrcIdx = 274;
                    section.data(226).dtTransOffset = 247;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L2MFaceColor
                    section.data(227).logicalSrcIdx = 275;
                    section.data(227).dtTransOffset = 250;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L3Width
                    section.data(228).logicalSrcIdx = 276;
                    section.data(228).dtTransOffset = 253;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L3Color
                    section.data(229).logicalSrcIdx = 277;
                    section.data(229).dtTransOffset = 254;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L3MSize
                    section.data(230).logicalSrcIdx = 278;
                    section.data(230).dtTransOffset = 257;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L3MEdgeColor
                    section.data(231).logicalSrcIdx = 279;
                    section.data(231).dtTransOffset = 258;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L3MFaceColor
                    section.data(232).logicalSrcIdx = 280;
                    section.data(232).dtTransOffset = 261;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L4Width
                    section.data(233).logicalSrcIdx = 281;
                    section.data(233).dtTransOffset = 264;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L4Color
                    section.data(234).logicalSrcIdx = 282;
                    section.data(234).dtTransOffset = 265;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L4MSize
                    section.data(235).logicalSrcIdx = 283;
                    section.data(235).dtTransOffset = 268;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L4MEdgeColor
                    section.data(236).logicalSrcIdx = 284;
                    section.data(236).dtTransOffset = 269;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L4MFaceColor
                    section.data(237).logicalSrcIdx = 285;
                    section.data(237).dtTransOffset = 272;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L5Width
                    section.data(238).logicalSrcIdx = 286;
                    section.data(238).dtTransOffset = 275;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L5Color
                    section.data(239).logicalSrcIdx = 287;
                    section.data(239).dtTransOffset = 276;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L5MSize
                    section.data(240).logicalSrcIdx = 288;
                    section.data(240).dtTransOffset = 279;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L5MEdgeColor
                    section.data(241).logicalSrcIdx = 289;
                    section.data(241).dtTransOffset = 280;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L5MFaceColor
                    section.data(242).logicalSrcIdx = 290;
                    section.data(242).dtTransOffset = 283;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L1Width
                    section.data(243).logicalSrcIdx = 291;
                    section.data(243).dtTransOffset = 286;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L1Color
                    section.data(244).logicalSrcIdx = 292;
                    section.data(244).dtTransOffset = 287;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L1MSize
                    section.data(245).logicalSrcIdx = 293;
                    section.data(245).dtTransOffset = 290;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L1MEdgeColor
                    section.data(246).logicalSrcIdx = 294;
                    section.data(246).dtTransOffset = 291;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L1MFaceColor
                    section.data(247).logicalSrcIdx = 295;
                    section.data(247).dtTransOffset = 294;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L2Width
                    section.data(248).logicalSrcIdx = 296;
                    section.data(248).dtTransOffset = 297;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L2Color
                    section.data(249).logicalSrcIdx = 297;
                    section.data(249).dtTransOffset = 298;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L2MSize
                    section.data(250).logicalSrcIdx = 298;
                    section.data(250).dtTransOffset = 301;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L2MEdgeColor
                    section.data(251).logicalSrcIdx = 299;
                    section.data(251).dtTransOffset = 302;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L2MFaceColor
                    section.data(252).logicalSrcIdx = 300;
                    section.data(252).dtTransOffset = 305;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L3Width
                    section.data(253).logicalSrcIdx = 301;
                    section.data(253).dtTransOffset = 308;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L3Color
                    section.data(254).logicalSrcIdx = 302;
                    section.data(254).dtTransOffset = 309;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L3MSize
                    section.data(255).logicalSrcIdx = 303;
                    section.data(255).dtTransOffset = 312;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L3MEdgeColor
                    section.data(256).logicalSrcIdx = 304;
                    section.data(256).dtTransOffset = 313;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L3MFaceColor
                    section.data(257).logicalSrcIdx = 305;
                    section.data(257).dtTransOffset = 316;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L4Width
                    section.data(258).logicalSrcIdx = 306;
                    section.data(258).dtTransOffset = 319;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L4Color
                    section.data(259).logicalSrcIdx = 307;
                    section.data(259).dtTransOffset = 320;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L4MSize
                    section.data(260).logicalSrcIdx = 308;
                    section.data(260).dtTransOffset = 323;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L4MEdgeColor
                    section.data(261).logicalSrcIdx = 309;
                    section.data(261).dtTransOffset = 324;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L4MFaceColor
                    section.data(262).logicalSrcIdx = 310;
                    section.data(262).dtTransOffset = 327;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L5Width
                    section.data(263).logicalSrcIdx = 311;
                    section.data(263).dtTransOffset = 330;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L5Color
                    section.data(264).logicalSrcIdx = 312;
                    section.data(264).dtTransOffset = 331;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L5MSize
                    section.data(265).logicalSrcIdx = 313;
                    section.data(265).dtTransOffset = 334;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L5MEdgeColor
                    section.data(266).logicalSrcIdx = 314;
                    section.data(266).dtTransOffset = 335;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L5MFaceColor
                    section.data(267).logicalSrcIdx = 315;
                    section.data(267).dtTransOffset = 338;

                    ;% VIRTUAL_data_collection_P.Constant3_Value_h
                    section.data(268).logicalSrcIdx = 316;
                    section.data(268).dtTransOffset = 341;

                    ;% VIRTUAL_data_collection_P.InverseModulus1_Modulus
                    section.data(269).logicalSrcIdx = 317;
                    section.data(269).dtTransOffset = 342;

                    ;% VIRTUAL_data_collection_P.Switch_Threshold
                    section.data(270).logicalSrcIdx = 318;
                    section.data(270).dtTransOffset = 343;

                    ;% VIRTUAL_data_collection_P.Constant_Value_lc
                    section.data(271).logicalSrcIdx = 319;
                    section.data(271).dtTransOffset = 344;

            nTotData = nTotData + section.nData;
            paramMap.sections(5) = section;
            clear section

            section.nData     = 31;
            section.data(31)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.HostInitialize_SendBufferSize
                    section.data(1).logicalSrcIdx = 320;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.HostInitialize_ReceiveBufferSiz
                    section.data(2).logicalSrcIdx = 321;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_P.HostInitialize_ThreadPriority
                    section.data(3).logicalSrcIdx = 322;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOWatchdog
                    section.data(4).logicalSrcIdx = 323;
                    section.data(4).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIInitial
                    section.data(5).logicalSrcIdx = 324;
                    section.data(5).dtTransOffset = 4;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POModes
                    section.data(6).logicalSrcIdx = 325;
                    section.data(6).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POConfiguration
                    section.data(7).logicalSrcIdx = 326;
                    section.data(7).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POAlignment
                    section.data(8).logicalSrcIdx = 327;
                    section.data(8).dtTransOffset = 7;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POPolarity
                    section.data(9).logicalSrcIdx = 328;
                    section.data(9).dtTransOffset = 8;

                    ;% VIRTUAL_data_collection_P.HILReadTimebase_Clock
                    section.data(10).logicalSrcIdx = 329;
                    section.data(10).dtTransOffset = 9;

                    ;% VIRTUAL_data_collection_P.HostGameController_BufferSize
                    section.data(11).logicalSrcIdx = 330;
                    section.data(11).dtTransOffset = 10;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L1Style
                    section.data(12).logicalSrcIdx = 331;
                    section.data(12).dtTransOffset = 11;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L1Marker
                    section.data(13).logicalSrcIdx = 332;
                    section.data(13).dtTransOffset = 12;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L2Style
                    section.data(14).logicalSrcIdx = 333;
                    section.data(14).dtTransOffset = 13;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L2Marker
                    section.data(15).logicalSrcIdx = 334;
                    section.data(15).dtTransOffset = 14;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L3Style
                    section.data(16).logicalSrcIdx = 335;
                    section.data(16).dtTransOffset = 15;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L3Marker
                    section.data(17).logicalSrcIdx = 336;
                    section.data(17).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L4Style
                    section.data(18).logicalSrcIdx = 337;
                    section.data(18).dtTransOffset = 17;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L4Marker
                    section.data(19).logicalSrcIdx = 338;
                    section.data(19).dtTransOffset = 18;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L5Style
                    section.data(20).logicalSrcIdx = 339;
                    section.data(20).dtTransOffset = 19;

                    ;% VIRTUAL_data_collection_P.BodyFrame_L5Marker
                    section.data(21).logicalSrcIdx = 340;
                    section.data(21).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L1Style
                    section.data(22).logicalSrcIdx = 341;
                    section.data(22).dtTransOffset = 21;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L1Marker
                    section.data(23).logicalSrcIdx = 342;
                    section.data(23).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L2Style
                    section.data(24).logicalSrcIdx = 343;
                    section.data(24).dtTransOffset = 23;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L2Marker
                    section.data(25).logicalSrcIdx = 344;
                    section.data(25).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L3Style
                    section.data(26).logicalSrcIdx = 345;
                    section.data(26).dtTransOffset = 25;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L3Marker
                    section.data(27).logicalSrcIdx = 346;
                    section.data(27).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L4Style
                    section.data(28).logicalSrcIdx = 347;
                    section.data(28).dtTransOffset = 27;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L4Marker
                    section.data(29).logicalSrcIdx = 348;
                    section.data(29).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L5Style
                    section.data(30).logicalSrcIdx = 349;
                    section.data(30).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_P.FixedFrame_L5Marker
                    section.data(31).logicalSrcIdx = 350;
                    section.data(31).dtTransOffset = 30;

            nTotData = nTotData + section.nData;
            paramMap.sections(6) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.Gain1_Gain_n
                    section.data(1).logicalSrcIdx = 351;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.Memory_InitialCondition_h
                    section.data(2).logicalSrcIdx = 352;
                    section.data(2).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_P.Gain_Gain_l
                    section.data(3).logicalSrcIdx = 353;
                    section.data(3).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            paramMap.sections(7) = section;
            clear section

            section.nData     = 13;
            section.data(13)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.HILInitialize_AIChannels
                    section.data(1).logicalSrcIdx = 354;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DIChannels
                    section.data(2).logicalSrcIdx = 355;
                    section.data(2).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOChannels
                    section.data(3).logicalSrcIdx = 356;
                    section.data(3).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIChannels
                    section.data(4).logicalSrcIdx = 357;
                    section.data(4).dtTransOffset = 36;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIQuadrature
                    section.data(5).logicalSrcIdx = 358;
                    section.data(5).dtTransOffset = 39;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POChannels
                    section.data(6).logicalSrcIdx = 359;
                    section.data(6).dtTransOffset = 40;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOChannels
                    section.data(7).logicalSrcIdx = 360;
                    section.data(7).dtTransOffset = 42;

                    ;% VIRTUAL_data_collection_P.HILReadTimebase_SamplesInBuffer
                    section.data(8).logicalSrcIdx = 361;
                    section.data(8).dtTransOffset = 44;

                    ;% VIRTUAL_data_collection_P.HILReadTimebase_AnalogChannels
                    section.data(9).logicalSrcIdx = 362;
                    section.data(9).dtTransOffset = 45;

                    ;% VIRTUAL_data_collection_P.HILReadTimebase_EncoderChannels
                    section.data(10).logicalSrcIdx = 363;
                    section.data(10).dtTransOffset = 47;

                    ;% VIRTUAL_data_collection_P.HILReadTimebase_OtherChannels
                    section.data(11).logicalSrcIdx = 364;
                    section.data(11).dtTransOffset = 48;

                    ;% VIRTUAL_data_collection_P.realsenseDepthCapture_Preset
                    section.data(12).logicalSrcIdx = 365;
                    section.data(12).dtTransOffset = 55;

                    ;% VIRTUAL_data_collection_P.RangingSensor_Range
                    section.data(13).logicalSrcIdx = 366;
                    section.data(13).dtTransOffset = 56;

            nTotData = nTotData + section.nData;
            paramMap.sections(8) = section;
            clear section

            section.nData     = 48;
            section.data(48)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.HostInitialize_RunClient
                    section.data(1).logicalSrcIdx = 367;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.HostInitialize_UseWindow
                    section.data(2).logicalSrcIdx = 368;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_P.HostInitialize_Active
                    section.data(3).logicalSrcIdx = 369;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_P.HILInitialize_Active
                    section.data(4).logicalSrcIdx = 370;
                    section.data(4).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AOTerminate
                    section.data(5).logicalSrcIdx = 371;
                    section.data(5).dtTransOffset = 4;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AOExit
                    section.data(6).logicalSrcIdx = 372;
                    section.data(6).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOTerminate
                    section.data(7).logicalSrcIdx = 373;
                    section.data(7).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOExit
                    section.data(8).logicalSrcIdx = 374;
                    section.data(8).dtTransOffset = 7;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POTerminate
                    section.data(9).logicalSrcIdx = 375;
                    section.data(9).dtTransOffset = 8;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POExit
                    section.data(10).logicalSrcIdx = 376;
                    section.data(10).dtTransOffset = 9;

                    ;% VIRTUAL_data_collection_P.HILInitialize_CKPStart
                    section.data(11).logicalSrcIdx = 377;
                    section.data(11).dtTransOffset = 10;

                    ;% VIRTUAL_data_collection_P.HILInitialize_CKPEnter
                    section.data(12).logicalSrcIdx = 378;
                    section.data(12).dtTransOffset = 11;

                    ;% VIRTUAL_data_collection_P.HILInitialize_CKStart
                    section.data(13).logicalSrcIdx = 379;
                    section.data(13).dtTransOffset = 12;

                    ;% VIRTUAL_data_collection_P.HILInitialize_CKEnter
                    section.data(14).logicalSrcIdx = 380;
                    section.data(14).dtTransOffset = 13;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AIPStart
                    section.data(15).logicalSrcIdx = 381;
                    section.data(15).dtTransOffset = 14;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AIPEnter
                    section.data(16).logicalSrcIdx = 382;
                    section.data(16).dtTransOffset = 15;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AOPStart
                    section.data(17).logicalSrcIdx = 383;
                    section.data(17).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AOPEnter
                    section.data(18).logicalSrcIdx = 384;
                    section.data(18).dtTransOffset = 17;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AOStart
                    section.data(19).logicalSrcIdx = 385;
                    section.data(19).dtTransOffset = 18;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AOEnter
                    section.data(20).logicalSrcIdx = 386;
                    section.data(20).dtTransOffset = 19;

                    ;% VIRTUAL_data_collection_P.HILInitialize_AOReset
                    section.data(21).logicalSrcIdx = 387;
                    section.data(21).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOPStart
                    section.data(22).logicalSrcIdx = 388;
                    section.data(22).dtTransOffset = 21;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOPEnter
                    section.data(23).logicalSrcIdx = 389;
                    section.data(23).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOStart
                    section.data(24).logicalSrcIdx = 390;
                    section.data(24).dtTransOffset = 23;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOEnter
                    section.data(25).logicalSrcIdx = 391;
                    section.data(25).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOReset
                    section.data(26).logicalSrcIdx = 392;
                    section.data(26).dtTransOffset = 25;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIPStart
                    section.data(27).logicalSrcIdx = 393;
                    section.data(27).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIPEnter
                    section.data(28).logicalSrcIdx = 394;
                    section.data(28).dtTransOffset = 27;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIStart
                    section.data(29).logicalSrcIdx = 395;
                    section.data(29).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_P.HILInitialize_EIEnter
                    section.data(30).logicalSrcIdx = 396;
                    section.data(30).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POPStart
                    section.data(31).logicalSrcIdx = 397;
                    section.data(31).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POPEnter
                    section.data(32).logicalSrcIdx = 398;
                    section.data(32).dtTransOffset = 31;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POStart
                    section.data(33).logicalSrcIdx = 399;
                    section.data(33).dtTransOffset = 32;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POEnter
                    section.data(34).logicalSrcIdx = 400;
                    section.data(34).dtTransOffset = 33;

                    ;% VIRTUAL_data_collection_P.HILInitialize_POReset
                    section.data(35).logicalSrcIdx = 401;
                    section.data(35).dtTransOffset = 34;

                    ;% VIRTUAL_data_collection_P.HILInitialize_OOReset
                    section.data(36).logicalSrcIdx = 402;
                    section.data(36).dtTransOffset = 35;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOFinal
                    section.data(37).logicalSrcIdx = 403;
                    section.data(37).dtTransOffset = 36;

                    ;% VIRTUAL_data_collection_P.HILInitialize_DOInitial
                    section.data(38).logicalSrcIdx = 404;
                    section.data(38).dtTransOffset = 37;

                    ;% VIRTUAL_data_collection_P.HILReadTimebase_Active
                    section.data(39).logicalSrcIdx = 405;
                    section.data(39).dtTransOffset = 38;

                    ;% VIRTUAL_data_collection_P.TmpRTBAtHeadingKalmanFilterInpo
                    section.data(40).logicalSrcIdx = 406;
                    section.data(40).dtTransOffset = 39;

                    ;% VIRTUAL_data_collection_P.TmpRTBAtQCarEKFInport6_InitialC
                    section.data(41).logicalSrcIdx = 407;
                    section.data(41).dtTransOffset = 40;

                    ;% VIRTUAL_data_collection_P.lane_detected_InitialCondition
                    section.data(42).logicalSrcIdx = 408;
                    section.data(42).dtTransOffset = 41;

                    ;% VIRTUAL_data_collection_P.HostGameController_AutoCenter
                    section.data(43).logicalSrcIdx = 409;
                    section.data(43).dtTransOffset = 42;

                    ;% VIRTUAL_data_collection_P.HostGameController_Enabled
                    section.data(44).logicalSrcIdx = 410;
                    section.data(44).dtTransOffset = 43;

                    ;% VIRTUAL_data_collection_P.HostGameController_DebugMode
                    section.data(45).logicalSrcIdx = 411;
                    section.data(45).dtTransOffset = 44;

                    ;% VIRTUAL_data_collection_P.HILWrite_Active
                    section.data(46).logicalSrcIdx = 412;
                    section.data(46).dtTransOffset = 45;

                    ;% VIRTUAL_data_collection_P.RangingSensor_Active
                    section.data(47).logicalSrcIdx = 413;
                    section.data(47).dtTransOffset = 46;

                    ;% VIRTUAL_data_collection_P.Memory_InitialCondition_p
                    section.data(48).logicalSrcIdx = 414;
                    section.data(48).dtTransOffset = 47;

            nTotData = nTotData + section.nData;
            paramMap.sections(9) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.HostGameController_Controller
                    section.data(1).logicalSrcIdx = 415;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(10) = section;
            clear section

            section.nData     = 13;
            section.data(13)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.HostInitialize_URI
                    section.data(1).logicalSrcIdx = 416;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_P.HILReadTimebase_OverflowMode
                    section.data(2).logicalSrcIdx = 417;
                    section.data(2).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_P.ManualSwitch2_CurrentSetting
                    section.data(3).logicalSrcIdx = 418;
                    section.data(3).dtTransOffset = 25;

                    ;% VIRTUAL_data_collection_P.ManualSwitch1_CurrentSetting
                    section.data(4).logicalSrcIdx = 419;
                    section.data(4).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_P.ManualSwitch_CurrentSetting
                    section.data(5).logicalSrcIdx = 420;
                    section.data(5).dtTransOffset = 27;

                    ;% VIRTUAL_data_collection_P.ManualSwitch_CurrentSetting_n
                    section.data(6).logicalSrcIdx = 421;
                    section.data(6).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_P.ManualSwitch_CurrentSetting_nu
                    section.data(7).logicalSrcIdx = 422;
                    section.data(7).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_P.TmpRTBAtMATLABFunction1Inport1_
                    section.data(8).logicalSrcIdx = 423;
                    section.data(8).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_P.TmpRTBAtToWorkspaceInport1_Init
                    section.data(9).logicalSrcIdx = 424;
                    section.data(9).dtTransOffset = 31;

                    ;% VIRTUAL_data_collection_P.BodyFrame_Mode
                    section.data(10).logicalSrcIdx = 425;
                    section.data(10).dtTransOffset = 32;

                    ;% VIRTUAL_data_collection_P.FixedFrame_Mode
                    section.data(11).logicalSrcIdx = 426;
                    section.data(11).dtTransOffset = 33;

                    ;% VIRTUAL_data_collection_P.XYPlot_Mode
                    section.data(12).logicalSrcIdx = 427;
                    section.data(12).dtTransOffset = 34;

                    ;% VIRTUAL_data_collection_P.XYPlot_Mode_g
                    section.data(13).logicalSrcIdx = 428;
                    section.data(13).dtTransOffset = 35;

            nTotData = nTotData + section.nData;
            paramMap.sections(11) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.IfActionSubsystem2.Bias_Bias
                    section.data(1).logicalSrcIdx = 429;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(12) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.IfActionSubsystem1.Bias_Bias
                    section.data(1).logicalSrcIdx = 430;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(13) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_P.IfActionSubsystem.Bias_Bias
                    section.data(1).logicalSrcIdx = 431;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(14) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 8;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (VIRTUAL_data_collection_B)
        ;%
            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.realsenseDepthCapture_o2
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section

            section.nData     = 70;
            section.data(70)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.encodercounts
                    section.data(1).logicalSrcIdx = 1;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_B.z
                    section.data(2).logicalSrcIdx = 2;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_B.wheelspeedms
                    section.data(3).logicalSrcIdx = 3;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_B.RateTransition
                    section.data(4).logicalSrcIdx = 4;
                    section.data(4).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_B.CalibrationBias
                    section.data(5).logicalSrcIdx = 5;
                    section.data(5).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_B.Bias1
                    section.data(6).logicalSrcIdx = 6;
                    section.data(6).dtTransOffset = 9;

                    ;% VIRTUAL_data_collection_B.Sum1
                    section.data(7).logicalSrcIdx = 7;
                    section.data(7).dtTransOffset = 10;

                    ;% VIRTUAL_data_collection_B.ManualSwitch1
                    section.data(8).logicalSrcIdx = 8;
                    section.data(8).dtTransOffset = 12;

                    ;% VIRTUAL_data_collection_B.Clock
                    section.data(9).logicalSrcIdx = 9;
                    section.data(9).dtTransOffset = 13;

                    ;% VIRTUAL_data_collection_B.light_color
                    section.data(10).logicalSrcIdx = 10;
                    section.data(10).dtTransOffset = 14;

                    ;% VIRTUAL_data_collection_B.sign_type
                    section.data(11).logicalSrcIdx = 11;
                    section.data(11).dtTransOffset = 15;

                    ;% VIRTUAL_data_collection_B.lane_offset
                    section.data(12).logicalSrcIdx = 12;
                    section.data(12).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_B.sign_size
                    section.data(13).logicalSrcIdx = 13;
                    section.data(13).dtTransOffset = 17;

                    ;% VIRTUAL_data_collection_B.HostGameController_o3
                    section.data(14).logicalSrcIdx = 14;
                    section.data(14).dtTransOffset = 18;

                    ;% VIRTUAL_data_collection_B.HostGameController_o4
                    section.data(15).logicalSrcIdx = 15;
                    section.data(15).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_B.Gain2
                    section.data(16).logicalSrcIdx = 16;
                    section.data(16).dtTransOffset = 21;

                    ;% VIRTUAL_data_collection_B.motorSat
                    section.data(17).logicalSrcIdx = 17;
                    section.data(17).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_B.Product
                    section.data(18).logicalSrcIdx = 18;
                    section.data(18).dtTransOffset = 23;

                    ;% VIRTUAL_data_collection_B.DifferenceInputs2
                    section.data(19).logicalSrcIdx = 19;
                    section.data(19).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_B.TmpRTBAtProductInport1
                    section.data(20).logicalSrcIdx = 20;
                    section.data(20).dtTransOffset = 25;

                    ;% VIRTUAL_data_collection_B.Product_o
                    section.data(21).logicalSrcIdx = 21;
                    section.data(21).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_B.desired
                    section.data(22).logicalSrcIdx = 22;
                    section.data(22).dtTransOffset = 27;

                    ;% VIRTUAL_data_collection_B.Kffms
                    section.data(23).logicalSrcIdx = 23;
                    section.data(23).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_B.measured
                    section.data(24).logicalSrcIdx = 24;
                    section.data(24).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_B.Kpms
                    section.data(25).logicalSrcIdx = 25;
                    section.data(25).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_B.motorsat
                    section.data(26).logicalSrcIdx = 26;
                    section.data(26).dtTransOffset = 31;

                    ;% VIRTUAL_data_collection_B.Floor
                    section.data(27).logicalSrcIdx = 27;
                    section.data(27).dtTransOffset = 32;

                    ;% VIRTUAL_data_collection_B.ManualSwitch
                    section.data(28).logicalSrcIdx = 28;
                    section.data(28).dtTransOffset = 33;

                    ;% VIRTUAL_data_collection_B.Memory
                    section.data(29).logicalSrcIdx = 29;
                    section.data(29).dtTransOffset = 34;

                    ;% VIRTUAL_data_collection_B.Selector1
                    section.data(30).logicalSrcIdx = 30;
                    section.data(30).dtTransOffset = 35;

                    ;% VIRTUAL_data_collection_B.Selector2
                    section.data(31).logicalSrcIdx = 31;
                    section.data(31).dtTransOffset = 36;

                    ;% VIRTUAL_data_collection_B.Kim
                    section.data(32).logicalSrcIdx = 32;
                    section.data(32).dtTransOffset = 37;

                    ;% VIRTUAL_data_collection_B.Bias1_e
                    section.data(33).logicalSrcIdx = 33;
                    section.data(33).dtTransOffset = 38;

                    ;% VIRTUAL_data_collection_B.m_to_mm
                    section.data(34).logicalSrcIdx = 34;
                    section.data(34).dtTransOffset = 39;

                    ;% VIRTUAL_data_collection_B.Gain
                    section.data(35).logicalSrcIdx = 35;
                    section.data(35).dtTransOffset = 41;

                    ;% VIRTUAL_data_collection_B.RT_a
                    section.data(36).logicalSrcIdx = 36;
                    section.data(36).dtTransOffset = 42;

                    ;% VIRTUAL_data_collection_B.LiDAR
                    section.data(37).logicalSrcIdx = 37;
                    section.data(37).dtTransOffset = 45;

                    ;% VIRTUAL_data_collection_B.m_to_mm2
                    section.data(38).logicalSrcIdx = 38;
                    section.data(38).dtTransOffset = 46;

                    ;% VIRTUAL_data_collection_B.Gain_l
                    section.data(39).logicalSrcIdx = 39;
                    section.data(39).dtTransOffset = 48;

                    ;% VIRTUAL_data_collection_B.Bias1_ej
                    section.data(40).logicalSrcIdx = 40;
                    section.data(40).dtTransOffset = 49;

                    ;% VIRTUAL_data_collection_B.TransferFcn
                    section.data(41).logicalSrcIdx = 41;
                    section.data(41).dtTransOffset = 52;

                    ;% VIRTUAL_data_collection_B.TmpSignalConversionAtIntegrator
                    section.data(42).logicalSrcIdx = 42;
                    section.data(42).dtTransOffset = 53;

                    ;% VIRTUAL_data_collection_B.ManualSwitch_f
                    section.data(43).logicalSrcIdx = 43;
                    section.data(43).dtTransOffset = 56;

                    ;% VIRTUAL_data_collection_B.Subtract1
                    section.data(44).logicalSrcIdx = 44;
                    section.data(44).dtTransOffset = 57;

                    ;% VIRTUAL_data_collection_B.ki
                    section.data(45).logicalSrcIdx = 45;
                    section.data(45).dtTransOffset = 60;

                    ;% VIRTUAL_data_collection_B.Integrator
                    section.data(46).logicalSrcIdx = 46;
                    section.data(46).dtTransOffset = 63;

                    ;% VIRTUAL_data_collection_B.Cos
                    section.data(47).logicalSrcIdx = 47;
                    section.data(47).dtTransOffset = 64;

                    ;% VIRTUAL_data_collection_B.Cos1
                    section.data(48).logicalSrcIdx = 48;
                    section.data(48).dtTransOffset = 65;

                    ;% VIRTUAL_data_collection_B.Saturation1
                    section.data(49).logicalSrcIdx = 49;
                    section.data(49).dtTransOffset = 66;

                    ;% VIRTUAL_data_collection_B.Sum2
                    section.data(50).logicalSrcIdx = 50;
                    section.data(50).dtTransOffset = 67;

                    ;% VIRTUAL_data_collection_B.final
                    section.data(51).logicalSrcIdx = 51;
                    section.data(51).dtTransOffset = 68;

                    ;% VIRTUAL_data_collection_B.Integrator1
                    section.data(52).logicalSrcIdx = 52;
                    section.data(52).dtTransOffset = 69;

                    ;% VIRTUAL_data_collection_B.Gain6
                    section.data(53).logicalSrcIdx = 53;
                    section.data(53).dtTransOffset = 70;

                    ;% VIRTUAL_data_collection_B.Product_c
                    section.data(54).logicalSrcIdx = 54;
                    section.data(54).dtTransOffset = 71;

                    ;% VIRTUAL_data_collection_B.Product1
                    section.data(55).logicalSrcIdx = 55;
                    section.data(55).dtTransOffset = 72;

                    ;% VIRTUAL_data_collection_B.SampleTime
                    section.data(56).logicalSrcIdx = 56;
                    section.data(56).dtTransOffset = 73;

                    ;% VIRTUAL_data_collection_B.Constant
                    section.data(57).logicalSrcIdx = 57;
                    section.data(57).dtTransOffset = 74;

                    ;% VIRTUAL_data_collection_B.ComputationTime
                    section.data(58).logicalSrcIdx = 58;
                    section.data(58).dtTransOffset = 75;

                    ;% VIRTUAL_data_collection_B.realsenseDepthCapture_o3
                    section.data(59).logicalSrcIdx = 59;
                    section.data(59).dtTransOffset = 76;

                    ;% VIRTUAL_data_collection_B.SampleTime_f
                    section.data(60).logicalSrcIdx = 60;
                    section.data(60).dtTransOffset = 77;

                    ;% VIRTUAL_data_collection_B.Constant_i
                    section.data(61).logicalSrcIdx = 61;
                    section.data(61).dtTransOffset = 78;

                    ;% VIRTUAL_data_collection_B.ComputationTime_h
                    section.data(62).logicalSrcIdx = 62;
                    section.data(62).dtTransOffset = 79;

                    ;% VIRTUAL_data_collection_B.SampleTime_fc
                    section.data(63).logicalSrcIdx = 63;
                    section.data(63).dtTransOffset = 80;

                    ;% VIRTUAL_data_collection_B.Constant_f
                    section.data(64).logicalSrcIdx = 64;
                    section.data(64).dtTransOffset = 81;

                    ;% VIRTUAL_data_collection_B.ComputationTime_b
                    section.data(65).logicalSrcIdx = 65;
                    section.data(65).dtTransOffset = 82;

                    ;% VIRTUAL_data_collection_B.RangingSensor_o1
                    section.data(66).logicalSrcIdx = 66;
                    section.data(66).dtTransOffset = 83;

                    ;% VIRTUAL_data_collection_B.RangingSensor_o2
                    section.data(67).logicalSrcIdx = 67;
                    section.data(67).dtTransOffset = 1083;

                    ;% VIRTUAL_data_collection_B.RangingSensor_o3
                    section.data(68).logicalSrcIdx = 68;
                    section.data(68).dtTransOffset = 2083;

                    ;% VIRTUAL_data_collection_B.RangingSensor_o4
                    section.data(69).logicalSrcIdx = 69;
                    section.data(69).dtTransOffset = 3083;

                    ;% VIRTUAL_data_collection_B.Bias
                    section.data(70).logicalSrcIdx = 70;
                    section.data(70).dtTransOffset = 4083;

            nTotData = nTotData + section.nData;
            sigMap.sections(2) = section;
            clear section

            section.nData     = 29;
            section.data(29)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.Constant1
                    section.data(1).logicalSrcIdx = 71;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_B.Bias2
                    section.data(2).logicalSrcIdx = 72;
                    section.data(2).dtTransOffset = 384;

                    ;% VIRTUAL_data_collection_B.SampleTime_l
                    section.data(3).logicalSrcIdx = 73;
                    section.data(3).dtTransOffset = 768;

                    ;% VIRTUAL_data_collection_B.Constant_ip
                    section.data(4).logicalSrcIdx = 74;
                    section.data(4).dtTransOffset = 769;

                    ;% VIRTUAL_data_collection_B.ComputationTime_i
                    section.data(5).logicalSrcIdx = 75;
                    section.data(5).dtTransOffset = 770;

                    ;% VIRTUAL_data_collection_B.RateTransition1
                    section.data(6).logicalSrcIdx = 76;
                    section.data(6).dtTransOffset = 771;

                    ;% VIRTUAL_data_collection_B.RateTransition2
                    section.data(7).logicalSrcIdx = 77;
                    section.data(7).dtTransOffset = 773;

                    ;% VIRTUAL_data_collection_B.RateTransition1_l
                    section.data(8).logicalSrcIdx = 78;
                    section.data(8).dtTransOffset = 775;

                    ;% VIRTUAL_data_collection_B.RateTransition2_j
                    section.data(9).logicalSrcIdx = 79;
                    section.data(9).dtTransOffset = 777;

                    ;% VIRTUAL_data_collection_B.SampleTime_i
                    section.data(10).logicalSrcIdx = 80;
                    section.data(10).dtTransOffset = 779;

                    ;% VIRTUAL_data_collection_B.Constant_m
                    section.data(11).logicalSrcIdx = 81;
                    section.data(11).dtTransOffset = 780;

                    ;% VIRTUAL_data_collection_B.ComputationTime_it
                    section.data(12).logicalSrcIdx = 82;
                    section.data(12).dtTransOffset = 781;

                    ;% VIRTUAL_data_collection_B.SampleTime_ij
                    section.data(13).logicalSrcIdx = 83;
                    section.data(13).dtTransOffset = 782;

                    ;% VIRTUAL_data_collection_B.Constant_a
                    section.data(14).logicalSrcIdx = 84;
                    section.data(14).dtTransOffset = 783;

                    ;% VIRTUAL_data_collection_B.ComputationTime_g
                    section.data(15).logicalSrcIdx = 85;
                    section.data(15).dtTransOffset = 784;

                    ;% VIRTUAL_data_collection_B.Sum1_b
                    section.data(16).logicalSrcIdx = 86;
                    section.data(16).dtTransOffset = 785;

                    ;% VIRTUAL_data_collection_B.correction_weight
                    section.data(17).logicalSrcIdx = 87;
                    section.data(17).dtTransOffset = 786;

                    ;% VIRTUAL_data_collection_B.Xhat
                    section.data(18).logicalSrcIdx = 88;
                    section.data(18).dtTransOffset = 787;

                    ;% VIRTUAL_data_collection_B.location
                    section.data(19).logicalSrcIdx = 89;
                    section.data(19).dtTransOffset = 790;

                    ;% VIRTUAL_data_collection_B.distance
                    section.data(20).logicalSrcIdx = 90;
                    section.data(20).dtTransOffset = 791;

                    ;% VIRTUAL_data_collection_B.Input
                    section.data(21).logicalSrcIdx = 91;
                    section.data(21).dtTransOffset = 792;

                    ;% VIRTUAL_data_collection_B.OutportBufferForExecuted
                    section.data(22).logicalSrcIdx = 92;
                    section.data(22).dtTransOffset = 793;

                    ;% VIRTUAL_data_collection_B.Switch
                    section.data(23).logicalSrcIdx = 93;
                    section.data(23).dtTransOffset = 794;

                    ;% VIRTUAL_data_collection_B.DataTypeConversion
                    section.data(24).logicalSrcIdx = 94;
                    section.data(24).dtTransOffset = 797;

                    ;% VIRTUAL_data_collection_B.steer_correction
                    section.data(25).logicalSrcIdx = 95;
                    section.data(25).dtTransOffset = 800;

                    ;% VIRTUAL_data_collection_B.light_color_e
                    section.data(26).logicalSrcIdx = 96;
                    section.data(26).dtTransOffset = 801;

                    ;% VIRTUAL_data_collection_B.sign_type_h
                    section.data(27).logicalSrcIdx = 97;
                    section.data(27).dtTransOffset = 802;

                    ;% VIRTUAL_data_collection_B.speed_scale
                    section.data(28).logicalSrcIdx = 98;
                    section.data(28).dtTransOffset = 803;

                    ;% VIRTUAL_data_collection_B.Constant_l
                    section.data(29).logicalSrcIdx = 99;
                    section.data(29).dtTransOffset = 804;

            nTotData = nTotData + section.nData;
            sigMap.sections(3) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.realsenseDepthCapture_o1
                    section.data(1).logicalSrcIdx = 100;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_B.pose
                    section.data(2).logicalSrcIdx = 101;
                    section.data(2).dtTransOffset = 307200;

                    ;% VIRTUAL_data_collection_B.LIDARScanMatch_o2
                    section.data(3).logicalSrcIdx = 102;
                    section.data(3).dtTransOffset = 307203;

                    ;% VIRTUAL_data_collection_B.Subtract
                    section.data(4).logicalSrcIdx = 103;
                    section.data(4).dtTransOffset = 307204;

            nTotData = nTotData + section.nData;
            sigMap.sections(4) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.HostInitialize_o2
                    section.data(1).logicalSrcIdx = 104;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(5) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.RangingSensor_o6
                    section.data(1).logicalSrcIdx = 105;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_B.RangingSensor_o7
                    section.data(2).logicalSrcIdx = 106;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_B.RangingSensor_o8
                    section.data(3).logicalSrcIdx = 107;
                    section.data(3).dtTransOffset = 5;

            nTotData = nTotData + section.nData;
            sigMap.sections(6) = section;
            clear section

            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.HostInitialize_o1
                    section.data(1).logicalSrcIdx = 108;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_B.rightCSICamera_o1
                    section.data(2).logicalSrcIdx = 109;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_B.rearCSICamera_o1
                    section.data(3).logicalSrcIdx = 110;
                    section.data(3).dtTransOffset = 921601;

                    ;% VIRTUAL_data_collection_B.leftCSICamera_o1
                    section.data(4).logicalSrcIdx = 111;
                    section.data(4).dtTransOffset = 1843201;

                    ;% VIRTUAL_data_collection_B.frontCSICamera_o1
                    section.data(5).logicalSrcIdx = 112;
                    section.data(5).dtTransOffset = 2764801;

                    ;% VIRTUAL_data_collection_B.TmpRTBAtToWorkspaceInport1
                    section.data(6).logicalSrcIdx = 113;
                    section.data(6).dtTransOffset = 3686401;

            nTotData = nTotData + section.nData;
            sigMap.sections(7) = section;
            clear section

            section.nData     = 8;
            section.data(8)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_B.RelationalOperator1
                    section.data(1).logicalSrcIdx = 114;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_B.TmpRTBAtHeadingKalmanFilterInpo
                    section.data(2).logicalSrcIdx = 115;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_B.TmpRTBAtQCarEKFInport6
                    section.data(3).logicalSrcIdx = 116;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_B.lane_detected
                    section.data(4).logicalSrcIdx = 117;
                    section.data(4).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_B.Compare
                    section.data(5).logicalSrcIdx = 118;
                    section.data(5).dtTransOffset = 4;

                    ;% VIRTUAL_data_collection_B.Compare_e
                    section.data(6).logicalSrcIdx = 119;
                    section.data(6).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_B.OR
                    section.data(7).logicalSrcIdx = 120;
                    section.data(7).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_B.RangingSensor_o5
                    section.data(8).logicalSrcIdx = 121;
                    section.data(8).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            sigMap.sections(8) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 24;
        sectIdxOffset = 8;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (VIRTUAL_data_collection_DW)
        ;%
            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HostGameController_ControllerSt
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HostGameController_Lock
                    section.data(1).logicalSrcIdx = 1;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.RangingSensor_Measurements
                    section.data(1).logicalSrcIdx = 2;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section

            section.nData     = 23;
            section.data(23)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.Time1_Timeout
                    section.data(1).logicalSrcIdx = 3;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.Time_Timeout
                    section.data(2).logicalSrcIdx = 4;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_DW.Time_Timeout_c
                    section.data(3).logicalSrcIdx = 5;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_DW.Time1_Timeout_p
                    section.data(4).logicalSrcIdx = 6;
                    section.data(4).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_DW.SampleTime_PreviousTime
                    section.data(5).logicalSrcIdx = 7;
                    section.data(5).dtTransOffset = 4;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_BeginTime
                    section.data(6).logicalSrcIdx = 8;
                    section.data(6).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_ComputationTime
                    section.data(7).logicalSrcIdx = 9;
                    section.data(7).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_DW.SampleTime_PreviousTime_c
                    section.data(8).logicalSrcIdx = 10;
                    section.data(8).dtTransOffset = 7;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_BeginTime_d
                    section.data(9).logicalSrcIdx = 11;
                    section.data(9).dtTransOffset = 8;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_ComputationTi_n
                    section.data(10).logicalSrcIdx = 12;
                    section.data(10).dtTransOffset = 9;

                    ;% VIRTUAL_data_collection_DW.SampleTime_PreviousTime_d
                    section.data(11).logicalSrcIdx = 13;
                    section.data(11).dtTransOffset = 10;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_BeginTime_c
                    section.data(12).logicalSrcIdx = 14;
                    section.data(12).dtTransOffset = 11;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_ComputationTi_e
                    section.data(13).logicalSrcIdx = 15;
                    section.data(13).dtTransOffset = 12;

                    ;% VIRTUAL_data_collection_DW.Time_Timeout_i
                    section.data(14).logicalSrcIdx = 16;
                    section.data(14).dtTransOffset = 13;

                    ;% VIRTUAL_data_collection_DW.SampleTime_PreviousTime_i
                    section.data(15).logicalSrcIdx = 17;
                    section.data(15).dtTransOffset = 14;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_BeginTime_f
                    section.data(16).logicalSrcIdx = 18;
                    section.data(16).dtTransOffset = 15;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_ComputationTi_g
                    section.data(17).logicalSrcIdx = 19;
                    section.data(17).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_DW.SampleTime_PreviousTime_n
                    section.data(18).logicalSrcIdx = 20;
                    section.data(18).dtTransOffset = 17;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_BeginTime_o
                    section.data(19).logicalSrcIdx = 21;
                    section.data(19).dtTransOffset = 18;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_ComputationTi_c
                    section.data(20).logicalSrcIdx = 22;
                    section.data(20).dtTransOffset = 19;

                    ;% VIRTUAL_data_collection_DW.SampleTime_PreviousTime_k
                    section.data(21).logicalSrcIdx = 23;
                    section.data(21).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_BeginTime_f4
                    section.data(22).logicalSrcIdx = 24;
                    section.data(22).dtTransOffset = 21;

                    ;% VIRTUAL_data_collection_DW.ComputationTime_ComputationTi_d
                    section.data(23).logicalSrcIdx = 25;
                    section.data(23).dtTransOffset = 22;

            nTotData = nTotData + section.nData;
            dworkMap.sections(4) = section;
            clear section

            section.nData     = 54;
            section.data(54)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.Delay_DSTATE
                    section.data(1).logicalSrcIdx = 26;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_AIMinimums
                    section.data(2).logicalSrcIdx = 27;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_AIMaximums
                    section.data(3).logicalSrcIdx = 28;
                    section.data(3).dtTransOffset = 6;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_FilterFrequency
                    section.data(4).logicalSrcIdx = 29;
                    section.data(4).dtTransOffset = 11;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_POSortedFreqs
                    section.data(5).logicalSrcIdx = 30;
                    section.data(5).dtTransOffset = 14;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_POValues
                    section.data(6).logicalSrcIdx = 31;
                    section.data(6).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_OOValues
                    section.data(7).logicalSrcIdx = 32;
                    section.data(7).dtTransOffset = 18;

                    ;% VIRTUAL_data_collection_DW.HILReadTimebase_AnalogBuffer
                    section.data(8).logicalSrcIdx = 33;
                    section.data(8).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_DW.HILReadTimebase_OtherBuffer
                    section.data(9).logicalSrcIdx = 34;
                    section.data(9).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_DW.Unwrap224_PreviousInput
                    section.data(10).logicalSrcIdx = 35;
                    section.data(10).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_DW.Unwrap224_Revolutions
                    section.data(11).logicalSrcIdx = 36;
                    section.data(11).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_DW.Memory2_PreviousInput
                    section.data(12).logicalSrcIdx = 37;
                    section.data(12).dtTransOffset = 31;

                    ;% VIRTUAL_data_collection_DW.RateTransition_Buffer0
                    section.data(13).logicalSrcIdx = 38;
                    section.data(13).dtTransOffset = 32;

                    ;% VIRTUAL_data_collection_DW.Memory1_PreviousInput
                    section.data(14).logicalSrcIdx = 39;
                    section.data(14).dtTransOffset = 35;

                    ;% VIRTUAL_data_collection_DW.light_color_Buffer0
                    section.data(15).logicalSrcIdx = 40;
                    section.data(15).dtTransOffset = 36;

                    ;% VIRTUAL_data_collection_DW.sign_type_Buffer0
                    section.data(16).logicalSrcIdx = 41;
                    section.data(16).dtTransOffset = 37;

                    ;% VIRTUAL_data_collection_DW.lane_offset_Buffer0
                    section.data(17).logicalSrcIdx = 42;
                    section.data(17).dtTransOffset = 38;

                    ;% VIRTUAL_data_collection_DW.sign_size_Buffer0
                    section.data(18).logicalSrcIdx = 43;
                    section.data(18).dtTransOffset = 39;

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtProductInport1_Buffer0
                    section.data(19).logicalSrcIdx = 44;
                    section.data(19).dtTransOffset = 40;

                    ;% VIRTUAL_data_collection_DW.Memory_PreviousInput
                    section.data(20).logicalSrcIdx = 45;
                    section.data(20).dtTransOffset = 41;

                    ;% VIRTUAL_data_collection_DW.RateTransition1_Buffer
                    section.data(21).logicalSrcIdx = 46;
                    section.data(21).dtTransOffset = 44;

                    ;% VIRTUAL_data_collection_DW.Memory_PreviousInput_f
                    section.data(22).logicalSrcIdx = 47;
                    section.data(22).dtTransOffset = 47;

                    ;% VIRTUAL_data_collection_DW.Memory_PreviousInput_f2
                    section.data(23).logicalSrcIdx = 48;
                    section.data(23).dtTransOffset = 48;

                    ;% VIRTUAL_data_collection_DW.RateTransition1_Buffer_m
                    section.data(24).logicalSrcIdx = 49;
                    section.data(24).dtTransOffset = 49;

                    ;% VIRTUAL_data_collection_DW.RateTransition2_Buffer
                    section.data(25).logicalSrcIdx = 50;
                    section.data(25).dtTransOffset = 51;

                    ;% VIRTUAL_data_collection_DW.RateTransition1_Buffer_n
                    section.data(26).logicalSrcIdx = 51;
                    section.data(26).dtTransOffset = 53;

                    ;% VIRTUAL_data_collection_DW.RateTransition2_Buffer_f
                    section.data(27).logicalSrcIdx = 52;
                    section.data(27).dtTransOffset = 55;

                    ;% VIRTUAL_data_collection_DW.Memory1_PreviousInput_k
                    section.data(28).logicalSrcIdx = 53;
                    section.data(28).dtTransOffset = 57;

                    ;% VIRTUAL_data_collection_DW.BodyFrame_XBuffer
                    section.data(29).logicalSrcIdx = 54;
                    section.data(29).dtTransOffset = 58;

                    ;% VIRTUAL_data_collection_DW.BodyFrame_YBuffer
                    section.data(30).logicalSrcIdx = 55;
                    section.data(30).dtTransOffset = 1058;

                    ;% VIRTUAL_data_collection_DW.FixedFrame_XBuffer
                    section.data(31).logicalSrcIdx = 56;
                    section.data(31).dtTransOffset = 2058;

                    ;% VIRTUAL_data_collection_DW.FixedFrame_YBuffer
                    section.data(32).logicalSrcIdx = 57;
                    section.data(32).dtTransOffset = 2442;

                    ;% VIRTUAL_data_collection_DW.InverseModulus1_PreviousInput
                    section.data(33).logicalSrcIdx = 58;
                    section.data(33).dtTransOffset = 2826;

                    ;% VIRTUAL_data_collection_DW.InverseModulus1_Revolutions
                    section.data(34).logicalSrcIdx = 59;
                    section.data(34).dtTransOffset = 2827;

                    ;% VIRTUAL_data_collection_DW.XYPlot_XBuffer
                    section.data(35).logicalSrcIdx = 60;
                    section.data(35).dtTransOffset = 2828;

                    ;% VIRTUAL_data_collection_DW.XYPlot_YBuffer
                    section.data(36).logicalSrcIdx = 61;
                    section.data(36).dtTransOffset = 3028;

                    ;% VIRTUAL_data_collection_DW.XYPlot_XBuffer_b
                    section.data(37).logicalSrcIdx = 62;
                    section.data(37).dtTransOffset = 3228;

                    ;% VIRTUAL_data_collection_DW.XYPlot_YBuffer_h
                    section.data(38).logicalSrcIdx = 63;
                    section.data(38).dtTransOffset = 3428;

                    ;% VIRTUAL_data_collection_DW.X_hat
                    section.data(39).logicalSrcIdx = 64;
                    section.data(39).dtTransOffset = 3628;

                    ;% VIRTUAL_data_collection_DW.P
                    section.data(40).logicalSrcIdx = 65;
                    section.data(40).dtTransOffset = 3631;

                    ;% VIRTUAL_data_collection_DW.I
                    section.data(41).logicalSrcIdx = 66;
                    section.data(41).dtTransOffset = 3640;

                    ;% VIRTUAL_data_collection_DW.C_heading
                    section.data(42).logicalSrcIdx = 67;
                    section.data(42).dtTransOffset = 3649;

                    ;% VIRTUAL_data_collection_DW.C_combined
                    section.data(43).logicalSrcIdx = 68;
                    section.data(43).dtTransOffset = 3652;

                    ;% VIRTUAL_data_collection_DW.X_hat_b
                    section.data(44).logicalSrcIdx = 69;
                    section.data(44).dtTransOffset = 3661;

                    ;% VIRTUAL_data_collection_DW.P_m
                    section.data(45).logicalSrcIdx = 70;
                    section.data(45).dtTransOffset = 3663;

                    ;% VIRTUAL_data_collection_DW.I_i
                    section.data(46).logicalSrcIdx = 71;
                    section.data(46).dtTransOffset = 3667;

                    ;% VIRTUAL_data_collection_DW.A
                    section.data(47).logicalSrcIdx = 72;
                    section.data(47).dtTransOffset = 3671;

                    ;% VIRTUAL_data_collection_DW.B
                    section.data(48).logicalSrcIdx = 73;
                    section.data(48).dtTransOffset = 3675;

                    ;% VIRTUAL_data_collection_DW.C
                    section.data(49).logicalSrcIdx = 74;
                    section.data(49).dtTransOffset = 3677;

                    ;% VIRTUAL_data_collection_DW.state
                    section.data(50).logicalSrcIdx = 75;
                    section.data(50).dtTransOffset = 3679;

                    ;% VIRTUAL_data_collection_DW.stop_timer
                    section.data(51).logicalSrcIdx = 76;
                    section.data(51).dtTransOffset = 3680;

                    ;% VIRTUAL_data_collection_DW.sign_stop_timer
                    section.data(52).logicalSrcIdx = 77;
                    section.data(52).dtTransOffset = 3681;

                    ;% VIRTUAL_data_collection_DW.red_light_frames
                    section.data(53).logicalSrcIdx = 78;
                    section.data(53).dtTransOffset = 3682;

                    ;% VIRTUAL_data_collection_DW.sign_frames
                    section.data(54).logicalSrcIdx = 79;
                    section.data(54).dtTransOffset = 3683;

            nTotData = nTotData + section.nData;
            dworkMap.sections(5) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.rightCSICamera_VideoCapture
                    section.data(1).logicalSrcIdx = 80;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.rearCSICamera_VideoCapture
                    section.data(2).logicalSrcIdx = 81;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_DW.leftCSICamera_VideoCapture
                    section.data(3).logicalSrcIdx = 82;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_DW.frontCSICamera_VideoCapture
                    section.data(4).logicalSrcIdx = 83;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            dworkMap.sections(6) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HostInitialize_ConnectedHandle
                    section.data(1).logicalSrcIdx = 84;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(7) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.RangingSensor_Sensor
                    section.data(1).logicalSrcIdx = 85;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(8) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.Video3DInitialize_Video3D
                    section.data(1).logicalSrcIdx = 86;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.realsenseDepthCapture_Video3D
                    section.data(2).logicalSrcIdx = 87;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            dworkMap.sections(9) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.realsenseDepthCapture_Stream
                    section.data(1).logicalSrcIdx = 88;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(10) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.LIDARScanMatch_Matcher
                    section.data(1).logicalSrcIdx = 89;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(11) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HILInitialize_Card
                    section.data(1).logicalSrcIdx = 90;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(12) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HILReadTimebase_Task
                    section.data(1).logicalSrcIdx = 91;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(13) = section;
            clear section

            section.nData     = 20;
            section.data(20)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HostInitialize_PWORK
                    section.data(1).logicalSrcIdx = 92;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.HILWrite_PWORK
                    section.data(2).logicalSrcIdx = 93;
                    section.data(2).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_DW.Speed_Tracking_PWORK.LoggedData
                    section.data(3).logicalSrcIdx = 94;
                    section.data(3).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_DW.SpeedComparison_PWORK.LoggedData
                    section.data(4).logicalSrcIdx = 95;
                    section.data(4).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_DW.HeadingComparison_PWORK.LoggedData
                    section.data(5).logicalSrcIdx = 96;
                    section.data(5).dtTransOffset = 7;

                    ;% VIRTUAL_data_collection_DW.Heading_PWORK.LoggedData
                    section.data(6).logicalSrcIdx = 97;
                    section.data(6).dtTransOffset = 10;

                    ;% VIRTUAL_data_collection_DW.Scope_PWORK.LoggedData
                    section.data(7).logicalSrcIdx = 98;
                    section.data(7).dtTransOffset = 11;

                    ;% VIRTUAL_data_collection_DW.Correction_Weight_PWORK.LoggedData
                    section.data(8).logicalSrcIdx = 99;
                    section.data(8).dtTransOffset = 14;

                    ;% VIRTUAL_data_collection_DW.steeringservodynamics_PWORK.LoggedData
                    section.data(9).logicalSrcIdx = 100;
                    section.data(9).dtTransOffset = 15;

                    ;% VIRTUAL_data_collection_DW.steering_PWORK.LoggedData
                    section.data(10).logicalSrcIdx = 101;
                    section.data(10).dtTransOffset = 17;

                    ;% VIRTUAL_data_collection_DW.distanceToPath_PWORK.LoggedData
                    section.data(11).logicalSrcIdx = 102;
                    section.data(11).dtTransOffset = 21;

                    ;% VIRTUAL_data_collection_DW.Control_PWORK.LoggedData
                    section.data(12).logicalSrcIdx = 103;
                    section.data(12).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_DW.CSI_PWORK.LoggedData
                    section.data(13).logicalSrcIdx = 104;
                    section.data(13).dtTransOffset = 23;

                    ;% VIRTUAL_data_collection_DW.RealSense_PWORK.LoggedData
                    section.data(14).logicalSrcIdx = 105;
                    section.data(14).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_DW.Scope_PWORK_f.LoggedData
                    section.data(15).logicalSrcIdx = 106;
                    section.data(15).dtTransOffset = 25;

                    ;% VIRTUAL_data_collection_DW.newLidar_PWORK.LoggedData
                    section.data(16).logicalSrcIdx = 107;
                    section.data(16).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_DW.LiDAR_PWORK.LoggedData
                    section.data(17).logicalSrcIdx = 108;
                    section.data(17).dtTransOffset = 27;

                    ;% VIRTUAL_data_collection_DW.ImageDisplays_PWORK.LoggedData
                    section.data(18).logicalSrcIdx = 109;
                    section.data(18).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_DW.LCD_PWORK.LoggedData
                    section.data(19).logicalSrcIdx = 110;
                    section.data(19).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_DW.PoseDeltas_PWORK.LoggedData
                    section.data(20).logicalSrcIdx = 111;
                    section.data(20).dtTransOffset = 30;

            nTotData = nTotData + section.nData;
            dworkMap.sections(14) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.LIDARScanMatch_Scan
                    section.data(1).logicalSrcIdx = 112;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.Memory_PreviousInput_e
                    section.data(2).logicalSrcIdx = 113;
                    section.data(2).dtTransOffset = 2770;

            nTotData = nTotData + section.nData;
            dworkMap.sections(15) = section;
            clear section

            section.nData     = 23;
            section.data(23)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HILInitialize_DOStates
                    section.data(1).logicalSrcIdx = 114;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_QuadratureModes
                    section.data(2).logicalSrcIdx = 115;
                    section.data(2).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_InitialEICounts
                    section.data(3).logicalSrcIdx = 116;
                    section.data(3).dtTransOffset = 19;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_POModeValues
                    section.data(4).logicalSrcIdx = 117;
                    section.data(4).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_POAlignValues
                    section.data(5).logicalSrcIdx = 118;
                    section.data(5).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_DW.HILInitialize_POPolarityVals
                    section.data(6).logicalSrcIdx = 119;
                    section.data(6).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_DW.HILReadTimebase_EncoderBuffer
                    section.data(7).logicalSrcIdx = 120;
                    section.data(7).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_DW.RangingSensor_DIMS1
                    section.data(8).logicalSrcIdx = 121;
                    section.data(8).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_DW.RangingSensor_DIMS2
                    section.data(9).logicalSrcIdx = 122;
                    section.data(9).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_DW.RangingSensor_DIMS3
                    section.data(10).logicalSrcIdx = 123;
                    section.data(10).dtTransOffset = 31;

                    ;% VIRTUAL_data_collection_DW.RangingSensor_DIMS4
                    section.data(11).logicalSrcIdx = 124;
                    section.data(11).dtTransOffset = 32;

                    ;% VIRTUAL_data_collection_DW.Bias_DIMS1
                    section.data(12).logicalSrcIdx = 125;
                    section.data(12).dtTransOffset = 33;

                    ;% VIRTUAL_data_collection_DW.sfEvent
                    section.data(13).logicalSrcIdx = 126;
                    section.data(13).dtTransOffset = 34;

                    ;% VIRTUAL_data_collection_DW.sfEvent_n
                    section.data(14).logicalSrcIdx = 127;
                    section.data(14).dtTransOffset = 35;

                    ;% VIRTUAL_data_collection_DW.sfEvent_j
                    section.data(15).logicalSrcIdx = 128;
                    section.data(15).dtTransOffset = 36;

                    ;% VIRTUAL_data_collection_DW.sfEvent_b
                    section.data(16).logicalSrcIdx = 129;
                    section.data(16).dtTransOffset = 37;

                    ;% VIRTUAL_data_collection_DW.sfEvent_bh
                    section.data(17).logicalSrcIdx = 130;
                    section.data(17).dtTransOffset = 38;

                    ;% VIRTUAL_data_collection_DW.sfEvent_m
                    section.data(18).logicalSrcIdx = 131;
                    section.data(18).dtTransOffset = 39;

                    ;% VIRTUAL_data_collection_DW.SFunction_DIMS2
                    section.data(19).logicalSrcIdx = 132;
                    section.data(19).dtTransOffset = 40;

                    ;% VIRTUAL_data_collection_DW.SFunction_DIMS3
                    section.data(20).logicalSrcIdx = 133;
                    section.data(20).dtTransOffset = 41;

                    ;% VIRTUAL_data_collection_DW.sfEvent_h
                    section.data(21).logicalSrcIdx = 134;
                    section.data(21).dtTransOffset = 42;

                    ;% VIRTUAL_data_collection_DW.sfEvent_g
                    section.data(22).logicalSrcIdx = 135;
                    section.data(22).dtTransOffset = 43;

                    ;% VIRTUAL_data_collection_DW.sfEvent_mq
                    section.data(23).logicalSrcIdx = 136;
                    section.data(23).dtTransOffset = 44;

            nTotData = nTotData + section.nData;
            dworkMap.sections(16) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HILInitialize_POSortedChans
                    section.data(1).logicalSrcIdx = 137;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(17) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.BodyFrame_IWORK
                    section.data(1).logicalSrcIdx = 138;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.FixedFrame_IWORK
                    section.data(2).logicalSrcIdx = 139;
                    section.data(2).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_DW.XYPlot_IWORK
                    section.data(3).logicalSrcIdx = 140;
                    section.data(3).dtTransOffset = 4;

                    ;% VIRTUAL_data_collection_DW.XYPlot_IWORK_o
                    section.data(4).logicalSrcIdx = 141;
                    section.data(4).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            dworkMap.sections(18) = section;
            clear section

            section.nData     = 7;
            section.data(7)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtMATLABFunction1Inport1_
                    section.data(1).logicalSrcIdx = 142;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtToWorkspaceInport1_Acti
                    section.data(2).logicalSrcIdx = 143;
                    section.data(2).dtTransOffset = 1;

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtToWorkspaceInport1_sema
                    section.data(3).logicalSrcIdx = 144;
                    section.data(3).dtTransOffset = 2;

                    ;% VIRTUAL_data_collection_DW.SteeringBasedonLiDAR_SubsysRanB
                    section.data(4).logicalSrcIdx = 145;
                    section.data(4).dtTransOffset = 3;

                    ;% VIRTUAL_data_collection_DW.If_ActiveSubsystem
                    section.data(5).logicalSrcIdx = 146;
                    section.data(5).dtTransOffset = 4;

                    ;% VIRTUAL_data_collection_DW.LatchInput_SubsysRanBC
                    section.data(6).logicalSrcIdx = 147;
                    section.data(6).dtTransOffset = 5;

                    ;% VIRTUAL_data_collection_DW.MatchScans_SubsysRanBC
                    section.data(7).logicalSrcIdx = 148;
                    section.data(7).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            dworkMap.sections(19) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtMATLABFunction1Inport_f
                    section.data(1).logicalSrcIdx = 149;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtToWorkspaceInport1_Buff
                    section.data(2).logicalSrcIdx = 150;
                    section.data(2).dtTransOffset = 1843200;

            nTotData = nTotData + section.nData;
            dworkMap.sections(20) = section;
            clear section

            section.nData     = 49;
            section.data(49)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.HILInitialize_DOBits
                    section.data(1).logicalSrcIdx = 151;
                    section.data(1).dtTransOffset = 0;

                    ;% VIRTUAL_data_collection_DW.Unwrap224_FirstSample
                    section.data(2).logicalSrcIdx = 152;
                    section.data(2).dtTransOffset = 16;

                    ;% VIRTUAL_data_collection_DW.Integrator_DWORK1
                    section.data(3).logicalSrcIdx = 153;
                    section.data(3).dtTransOffset = 17;

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtHeadingKalmanFilterInpo
                    section.data(4).logicalSrcIdx = 154;
                    section.data(4).dtTransOffset = 18;

                    ;% VIRTUAL_data_collection_DW.TmpRTBAtQCarEKFInport6_Buffer0
                    section.data(5).logicalSrcIdx = 155;
                    section.data(5).dtTransOffset = 19;

                    ;% VIRTUAL_data_collection_DW.lane_detected_Buffer0
                    section.data(6).logicalSrcIdx = 156;
                    section.data(6).dtTransOffset = 20;

                    ;% VIRTUAL_data_collection_DW.HostGameController_NewData
                    section.data(7).logicalSrcIdx = 157;
                    section.data(7).dtTransOffset = 21;

                    ;% VIRTUAL_data_collection_DW.icLoad
                    section.data(8).logicalSrcIdx = 158;
                    section.data(8).dtTransOffset = 22;

                    ;% VIRTUAL_data_collection_DW.Time1_Owner
                    section.data(9).logicalSrcIdx = 159;
                    section.data(9).dtTransOffset = 23;

                    ;% VIRTUAL_data_collection_DW.Time_Owner
                    section.data(10).logicalSrcIdx = 160;
                    section.data(10).dtTransOffset = 24;

                    ;% VIRTUAL_data_collection_DW.Time_Owner_l
                    section.data(11).logicalSrcIdx = 161;
                    section.data(11).dtTransOffset = 25;

                    ;% VIRTUAL_data_collection_DW.Time1_Owner_i
                    section.data(12).logicalSrcIdx = 162;
                    section.data(12).dtTransOffset = 26;

                    ;% VIRTUAL_data_collection_DW.Integrator1_DWORK1
                    section.data(13).logicalSrcIdx = 163;
                    section.data(13).dtTransOffset = 27;

                    ;% VIRTUAL_data_collection_DW.BodyFrame_IsFull
                    section.data(14).logicalSrcIdx = 164;
                    section.data(14).dtTransOffset = 28;

                    ;% VIRTUAL_data_collection_DW.FixedFrame_IsFull
                    section.data(15).logicalSrcIdx = 165;
                    section.data(15).dtTransOffset = 29;

                    ;% VIRTUAL_data_collection_DW.Time_Owner_le
                    section.data(16).logicalSrcIdx = 166;
                    section.data(16).dtTransOffset = 30;

                    ;% VIRTUAL_data_collection_DW.InverseModulus1_FirstSample
                    section.data(17).logicalSrcIdx = 167;
                    section.data(17).dtTransOffset = 31;

                    ;% VIRTUAL_data_collection_DW.Memory_PreviousInput_g
                    section.data(18).logicalSrcIdx = 168;
                    section.data(18).dtTransOffset = 32;

                    ;% VIRTUAL_data_collection_DW.XYPlot_IsFull
                    section.data(19).logicalSrcIdx = 169;
                    section.data(19).dtTransOffset = 33;

                    ;% VIRTUAL_data_collection_DW.XYPlot_IsFull_h
                    section.data(20).logicalSrcIdx = 170;
                    section.data(20).dtTransOffset = 34;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit
                    section.data(21).logicalSrcIdx = 171;
                    section.data(21).dtTransOffset = 35;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_f
                    section.data(22).logicalSrcIdx = 172;
                    section.data(22).dtTransOffset = 36;

                    ;% VIRTUAL_data_collection_DW.X_hat_not_empty
                    section.data(23).logicalSrcIdx = 173;
                    section.data(23).dtTransOffset = 37;

                    ;% VIRTUAL_data_collection_DW.P_not_empty
                    section.data(24).logicalSrcIdx = 174;
                    section.data(24).dtTransOffset = 38;

                    ;% VIRTUAL_data_collection_DW.I_not_empty
                    section.data(25).logicalSrcIdx = 175;
                    section.data(25).dtTransOffset = 39;

                    ;% VIRTUAL_data_collection_DW.C_heading_not_empty
                    section.data(26).logicalSrcIdx = 176;
                    section.data(26).dtTransOffset = 40;

                    ;% VIRTUAL_data_collection_DW.C_combined_not_empty
                    section.data(27).logicalSrcIdx = 177;
                    section.data(27).dtTransOffset = 41;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_j
                    section.data(28).logicalSrcIdx = 178;
                    section.data(28).dtTransOffset = 42;

                    ;% VIRTUAL_data_collection_DW.X_hat_not_empty_m
                    section.data(29).logicalSrcIdx = 179;
                    section.data(29).dtTransOffset = 43;

                    ;% VIRTUAL_data_collection_DW.P_not_empty_k
                    section.data(30).logicalSrcIdx = 180;
                    section.data(30).dtTransOffset = 44;

                    ;% VIRTUAL_data_collection_DW.I_not_empty_n
                    section.data(31).logicalSrcIdx = 181;
                    section.data(31).dtTransOffset = 45;

                    ;% VIRTUAL_data_collection_DW.A_not_empty
                    section.data(32).logicalSrcIdx = 182;
                    section.data(32).dtTransOffset = 46;

                    ;% VIRTUAL_data_collection_DW.B_not_empty
                    section.data(33).logicalSrcIdx = 183;
                    section.data(33).dtTransOffset = 47;

                    ;% VIRTUAL_data_collection_DW.C_not_empty
                    section.data(34).logicalSrcIdx = 184;
                    section.data(34).dtTransOffset = 48;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_d
                    section.data(35).logicalSrcIdx = 185;
                    section.data(35).dtTransOffset = 49;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_e
                    section.data(36).logicalSrcIdx = 186;
                    section.data(36).dtTransOffset = 50;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_jt
                    section.data(37).logicalSrcIdx = 187;
                    section.data(37).dtTransOffset = 51;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_c
                    section.data(38).logicalSrcIdx = 188;
                    section.data(38).dtTransOffset = 52;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_c3
                    section.data(39).logicalSrcIdx = 189;
                    section.data(39).dtTransOffset = 53;

                    ;% VIRTUAL_data_collection_DW.doneDoubleBufferReInit_m
                    section.data(40).logicalSrcIdx = 190;
                    section.data(40).dtTransOffset = 54;

                    ;% VIRTUAL_data_collection_DW.state_not_empty
                    section.data(41).logicalSrcIdx = 191;
                    section.data(41).dtTransOffset = 55;

                    ;% VIRTUAL_data_collection_DW.stop_timer_not_empty
                    section.data(42).logicalSrcIdx = 192;
                    section.data(42).dtTransOffset = 56;

                    ;% VIRTUAL_data_collection_DW.sign_stop_timer_not_empty
                    section.data(43).logicalSrcIdx = 193;
                    section.data(43).dtTransOffset = 57;

                    ;% VIRTUAL_data_collection_DW.sign_stopped
                    section.data(44).logicalSrcIdx = 194;
                    section.data(44).dtTransOffset = 58;

                    ;% VIRTUAL_data_collection_DW.sign_stopped_not_empty
                    section.data(45).logicalSrcIdx = 195;
                    section.data(45).dtTransOffset = 59;

                    ;% VIRTUAL_data_collection_DW.red_light_frames_not_empty
                    section.data(46).logicalSrcIdx = 196;
                    section.data(46).dtTransOffset = 60;

                    ;% VIRTUAL_data_collection_DW.sign_frames_not_empty
                    section.data(47).logicalSrcIdx = 197;
                    section.data(47).dtTransOffset = 61;

                    ;% VIRTUAL_data_collection_DW.SteeringBasedonLiDAR_MODE
                    section.data(48).logicalSrcIdx = 198;
                    section.data(48).dtTransOffset = 62;

                    ;% VIRTUAL_data_collection_DW.MatchScans_MODE
                    section.data(49).logicalSrcIdx = 199;
                    section.data(49).dtTransOffset = 63;

            nTotData = nTotData + section.nData;
            dworkMap.sections(21) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.IfActionSubsystem2.IfActionSubsystem_SubsysRanBC
                    section.data(1).logicalSrcIdx = 200;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(22) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.IfActionSubsystem1.IfActionSubsystem_SubsysRanBC
                    section.data(1).logicalSrcIdx = 201;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(23) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% VIRTUAL_data_collection_DW.IfActionSubsystem.IfActionSubsystem_SubsysRanBC
                    section.data(1).logicalSrcIdx = 202;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(24) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 1695081424;
    targMap.checksum1 = 1413908706;
    targMap.checksum2 = 1036152699;
    targMap.checksum3 = 890169148;

