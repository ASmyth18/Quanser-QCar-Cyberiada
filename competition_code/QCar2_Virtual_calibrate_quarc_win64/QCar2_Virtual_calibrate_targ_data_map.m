    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 7;
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
        ;% Auto data (QCar2_Virtual_calibrate_P)
        ;%
            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_maximum_rho
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_maximum_theta
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_minimum_rho
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_minimum_theta
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_direction
                    section.data(1).logicalSrcIdx = 4;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_update_rate
                    section.data(2).logicalSrcIdx = 5;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_zero_location
                    section.data(3).logicalSrcIdx = 6;
                    section.data(3).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 33;
            section.data(33)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_P.Constant_Value
                    section.data(1).logicalSrcIdx = 7;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_P.RangingSensor_Budget
                    section.data(2).logicalSrcIdx = 8;
                    section.data(2).dtTransOffset = 384;

                    ;% QCar2_Virtual_calibrate_P.RangingSensor_Period
                    section.data(3).logicalSrcIdx = 9;
                    section.data(3).dtTransOffset = 385;

                    ;% QCar2_Virtual_calibrate_P.RangingSensor_MaxInterpolationD
                    section.data(4).logicalSrcIdx = 10;
                    section.data(4).dtTransOffset = 386;

                    ;% QCar2_Virtual_calibrate_P.RangingSensor_MaxInterpolationA
                    section.data(5).logicalSrcIdx = 11;
                    section.data(5).dtTransOffset = 387;

                    ;% QCar2_Virtual_calibrate_P.QCar2LidartoMapFrameOffset_Bias
                    section.data(6).logicalSrcIdx = 12;
                    section.data(6).dtTransOffset = 388;

                    ;% QCar2_Virtual_calibrate_P.QCar2VirtualtoPhysicalLidaroffs
                    section.data(7).logicalSrcIdx = 13;
                    section.data(7).dtTransOffset = 389;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L1Width
                    section.data(8).logicalSrcIdx = 14;
                    section.data(8).dtTransOffset = 390;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L1Color
                    section.data(9).logicalSrcIdx = 15;
                    section.data(9).dtTransOffset = 391;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L1MSize
                    section.data(10).logicalSrcIdx = 16;
                    section.data(10).dtTransOffset = 394;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L1MEdgeColor
                    section.data(11).logicalSrcIdx = 17;
                    section.data(11).dtTransOffset = 395;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L1MFaceColor
                    section.data(12).logicalSrcIdx = 18;
                    section.data(12).dtTransOffset = 398;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L2Width
                    section.data(13).logicalSrcIdx = 19;
                    section.data(13).dtTransOffset = 401;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L2Color
                    section.data(14).logicalSrcIdx = 20;
                    section.data(14).dtTransOffset = 402;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L2MSize
                    section.data(15).logicalSrcIdx = 21;
                    section.data(15).dtTransOffset = 405;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L2MEdgeColor
                    section.data(16).logicalSrcIdx = 22;
                    section.data(16).dtTransOffset = 406;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L2MFaceColor
                    section.data(17).logicalSrcIdx = 23;
                    section.data(17).dtTransOffset = 409;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L3Width
                    section.data(18).logicalSrcIdx = 24;
                    section.data(18).dtTransOffset = 412;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L3Color
                    section.data(19).logicalSrcIdx = 25;
                    section.data(19).dtTransOffset = 413;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L3MSize
                    section.data(20).logicalSrcIdx = 26;
                    section.data(20).dtTransOffset = 416;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L3MEdgeColor
                    section.data(21).logicalSrcIdx = 27;
                    section.data(21).dtTransOffset = 417;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L3MFaceColor
                    section.data(22).logicalSrcIdx = 28;
                    section.data(22).dtTransOffset = 420;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L4Width
                    section.data(23).logicalSrcIdx = 29;
                    section.data(23).dtTransOffset = 423;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L4Color
                    section.data(24).logicalSrcIdx = 30;
                    section.data(24).dtTransOffset = 424;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L4MSize
                    section.data(25).logicalSrcIdx = 31;
                    section.data(25).dtTransOffset = 427;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L4MEdgeColor
                    section.data(26).logicalSrcIdx = 32;
                    section.data(26).dtTransOffset = 428;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L4MFaceColor
                    section.data(27).logicalSrcIdx = 33;
                    section.data(27).dtTransOffset = 431;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L5Width
                    section.data(28).logicalSrcIdx = 34;
                    section.data(28).dtTransOffset = 434;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L5Color
                    section.data(29).logicalSrcIdx = 35;
                    section.data(29).dtTransOffset = 435;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L5MSize
                    section.data(30).logicalSrcIdx = 36;
                    section.data(30).dtTransOffset = 438;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L5MEdgeColor
                    section.data(31).logicalSrcIdx = 37;
                    section.data(31).dtTransOffset = 439;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L5MFaceColor
                    section.data(32).logicalSrcIdx = 38;
                    section.data(32).dtTransOffset = 442;

                    ;% QCar2_Virtual_calibrate_P.Constant2_Value
                    section.data(33).logicalSrcIdx = 39;
                    section.data(33).dtTransOffset = 445;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 12;
            section.data(12)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_P.ToHostFile_Encoding
                    section.data(1).logicalSrcIdx = 40;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile1_Encoding
                    section.data(2).logicalSrcIdx = 41;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L1Style
                    section.data(3).logicalSrcIdx = 42;
                    section.data(3).dtTransOffset = 2;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L1Marker
                    section.data(4).logicalSrcIdx = 43;
                    section.data(4).dtTransOffset = 3;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L2Style
                    section.data(5).logicalSrcIdx = 44;
                    section.data(5).dtTransOffset = 4;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L2Marker
                    section.data(6).logicalSrcIdx = 45;
                    section.data(6).dtTransOffset = 5;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L3Style
                    section.data(7).logicalSrcIdx = 46;
                    section.data(7).dtTransOffset = 6;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L3Marker
                    section.data(8).logicalSrcIdx = 47;
                    section.data(8).dtTransOffset = 7;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L4Style
                    section.data(9).logicalSrcIdx = 48;
                    section.data(9).dtTransOffset = 8;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L4Marker
                    section.data(10).logicalSrcIdx = 49;
                    section.data(10).dtTransOffset = 9;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L5Style
                    section.data(11).logicalSrcIdx = 50;
                    section.data(11).dtTransOffset = 10;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_L5Marker
                    section.data(12).logicalSrcIdx = 51;
                    section.data(12).dtTransOffset = 11;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section

            section.nData     = 5;
            section.data(5)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_P.ToHostFile_Decimation
                    section.data(1).logicalSrcIdx = 52;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile_BitRate
                    section.data(2).logicalSrcIdx = 53;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile1_Decimation
                    section.data(3).logicalSrcIdx = 54;
                    section.data(3).dtTransOffset = 2;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile1_BitRate
                    section.data(4).logicalSrcIdx = 55;
                    section.data(4).dtTransOffset = 3;

                    ;% QCar2_Virtual_calibrate_P.RangingSensor_Range
                    section.data(5).logicalSrcIdx = 56;
                    section.data(5).dtTransOffset = 4;

            nTotData = nTotData + section.nData;
            paramMap.sections(5) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_P.SystemTimebase_StopOnOverrun
                    section.data(1).logicalSrcIdx = 57;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_P.RangingSensor_Active
                    section.data(2).logicalSrcIdx = 58;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            paramMap.sections(6) = section;
            clear section

            section.nData     = 8;
            section.data(8)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_P.ToHostFile_VarName
                    section.data(1).logicalSrcIdx = 59;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile_FileFormat
                    section.data(2).logicalSrcIdx = 60;
                    section.data(2).dtTransOffset = 19;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile_file_name
                    section.data(3).logicalSrcIdx = 61;
                    section.data(3).dtTransOffset = 20;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile1_VarName
                    section.data(4).logicalSrcIdx = 62;
                    section.data(4).dtTransOffset = 43;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile1_FileFormat
                    section.data(5).logicalSrcIdx = 63;
                    section.data(5).dtTransOffset = 60;

                    ;% QCar2_Virtual_calibrate_P.ToHostFile1_file_name
                    section.data(6).logicalSrcIdx = 64;
                    section.data(6).dtTransOffset = 61;

                    ;% QCar2_Virtual_calibrate_P.BodyFrame_Mode
                    section.data(7).logicalSrcIdx = 65;
                    section.data(7).dtTransOffset = 82;

                    ;% QCar2_Virtual_calibrate_P.Gain_Gain
                    section.data(8).logicalSrcIdx = 66;
                    section.data(8).dtTransOffset = 83;

            nTotData = nTotData + section.nData;
            paramMap.sections(7) = section;
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
        nTotSects     = 5;
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
        ;% Auto data (QCar2_Virtual_calibrate_B)
        ;%
            section.nData     = 10;
            section.data(10)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o1
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o2
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 384;

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o3
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 768;

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o4
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 1152;

                    ;% QCar2_Virtual_calibrate_B.QCar2VirtualtoPhysicalLidaroffs
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 1536;

                    ;% QCar2_Virtual_calibrate_B.Width
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 1920;

                    ;% QCar2_Virtual_calibrate_B.fixed_array
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 1921;

                    ;% QCar2_Virtual_calibrate_B.angle_range
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 2305;

                    ;% QCar2_Virtual_calibrate_B.fixed_array_p
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 2306;

                    ;% QCar2_Virtual_calibrate_B.angle_range_d
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 2690;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o6
                    section.data(1).logicalSrcIdx = 10;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(2) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o7
                    section.data(1).logicalSrcIdx = 11;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o8
                    section.data(2).logicalSrcIdx = 12;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o9
                    section.data(3).logicalSrcIdx = 13;
                    section.data(3).dtTransOffset = 5;

            nTotData = nTotData + section.nData;
            sigMap.sections(3) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_B.Gain
                    section.data(1).logicalSrcIdx = 14;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(4) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_B.RangingSensor_o5
                    section.data(1).logicalSrcIdx = 15;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(5) = section;
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
        nTotSects     = 11;
        sectIdxOffset = 5;

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
        ;% Auto data (QCar2_Virtual_calibrate_DW)
        ;%
            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.RangingSensor_Measurements
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.SystemTimebase_PreviousTime
                    section.data(1).logicalSrcIdx = 1;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.BodyFrame_XBuffer
                    section.data(1).logicalSrcIdx = 2;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_DW.BodyFrame_YBuffer
                    section.data(2).logicalSrcIdx = 3;
                    section.data(2).dtTransOffset = 384;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.RangingSensor_Sensor
                    section.data(1).logicalSrcIdx = 4;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(4) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile_PointsWritten
                    section.data(1).logicalSrcIdx = 5;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile1_PointsWritten
                    section.data(2).logicalSrcIdx = 6;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            dworkMap.sections(5) = section;
            clear section

            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.DataSize_PWORK.LoggedData
                    section.data(1).logicalSrcIdx = 7;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_DW.New_PWORK.LoggedData
                    section.data(2).logicalSrcIdx = 8;
                    section.data(2).dtTransOffset = 3;

                    ;% QCar2_Virtual_calibrate_DW.Scope_PWORK.LoggedData
                    section.data(3).logicalSrcIdx = 9;
                    section.data(3).dtTransOffset = 4;

                    ;% QCar2_Virtual_calibrate_DW.Scope_PWORK_o.LoggedData
                    section.data(4).logicalSrcIdx = 10;
                    section.data(4).dtTransOffset = 5;

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile_PWORK
                    section.data(5).logicalSrcIdx = 11;
                    section.data(5).dtTransOffset = 6;

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile1_PWORK
                    section.data(6).logicalSrcIdx = 12;
                    section.data(6).dtTransOffset = 8;

            nTotData = nTotData + section.nData;
            dworkMap.sections(6) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.sfEvent
                    section.data(1).logicalSrcIdx = 13;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_DW.sfEvent_h
                    section.data(2).logicalSrcIdx = 14;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_DW.sfEvent_o
                    section.data(3).logicalSrcIdx = 15;
                    section.data(3).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            dworkMap.sections(7) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile_SamplesCount
                    section.data(1).logicalSrcIdx = 16;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile_ArrayNameLength
                    section.data(2).logicalSrcIdx = 17;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile1_SamplesCount
                    section.data(3).logicalSrcIdx = 18;
                    section.data(3).dtTransOffset = 2;

                    ;% QCar2_Virtual_calibrate_DW.ToHostFile1_ArrayNameLength
                    section.data(4).logicalSrcIdx = 19;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            dworkMap.sections(8) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.BodyFrame_IWORK
                    section.data(1).logicalSrcIdx = 20;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(9) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.WriteMatfiles_SubsysRanBC
                    section.data(1).logicalSrcIdx = 21;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(10) = section;
            clear section

            section.nData     = 5;
            section.data(5)  = dumData; %prealloc

                    ;% QCar2_Virtual_calibrate_DW.BodyFrame_IsFull
                    section.data(1).logicalSrcIdx = 22;
                    section.data(1).dtTransOffset = 0;

                    ;% QCar2_Virtual_calibrate_DW.doneDoubleBufferReInit
                    section.data(2).logicalSrcIdx = 23;
                    section.data(2).dtTransOffset = 1;

                    ;% QCar2_Virtual_calibrate_DW.doneDoubleBufferReInit_b
                    section.data(3).logicalSrcIdx = 24;
                    section.data(3).dtTransOffset = 2;

                    ;% QCar2_Virtual_calibrate_DW.doneDoubleBufferReInit_j
                    section.data(4).logicalSrcIdx = 25;
                    section.data(4).dtTransOffset = 3;

                    ;% QCar2_Virtual_calibrate_DW.WriteMatfiles_MODE
                    section.data(5).logicalSrcIdx = 26;
                    section.data(5).dtTransOffset = 4;

            nTotData = nTotData + section.nData;
            dworkMap.sections(11) = section;
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


    targMap.checksum0 = 631371864;
    targMap.checksum1 = 1459574279;
    targMap.checksum2 = 1872521194;
    targMap.checksum3 = 3234462749;

