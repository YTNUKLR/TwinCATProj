(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: FB_CylCntrl2.st
 * Author: Paul Zurlinden
 * Created: April 16, 2012
 ********************************************************************
 * Implementation of library PPS_Cyl
 ********************************************************************) 

(* Controls a pneumatic cylinder of the following types:
		EN_Cyl_1xSV_Basic
		EN_Cyl_1xSV_Sensored
		EN_Cyl_2xSV_Basic_NoBrake
		EN_Cyl_2xSV_Basic_WBrake
		EN_Cyl_2xSV_Sensored_NoBrake
		EN_Cyl_2xSV_Sensored_WBrake *)
		
FUNCTION_BLOCK FB_CylCntrl2
	
xMonitor :=	iq_CylCntrlInterface.I.diType = EN_Cyl_1xSV_Sensored OR
					iq_CylCntrlInterface.I.diType = EN_Cyl_2xSV_Sensored_NoBrake OR
					iq_CylCntrlInterface.I.diType = EN_Cyl_2xSV_Sensored_WBrake;

x2xSV	:= iq_CylCntrlInterface.I.diType = EN_Cyl_2xSV_Basic_NoBrake OR
				iq_CylCntrlInterface.I.diType = EN_Cyl_2xSV_Basic_WBrake OR
				iq_CylCntrlInterface.I.diType = EN_Cyl_2xSV_Sensored_NoBrake OR
				iq_CylCntrlInterface.I.diType = EN_Cyl_2xSV_Sensored_WBrake;

Timer(PT := iq_CylCntrlInterface.I.tTravelDel);

RT(CLK := iq_CylCntrlInterface.I.xManCmdA);
xManCmd	:= RT.Q;

RT_B(CLK := iq_CylCntrlInterface.I.xManCmdB);
xManCmdB := RT_B.Q;

RT_Brake(CLK := iq_CylCntrlInterface.I.xManBrake);
xManBrake := RT_Brake.Q;

RT_Air(CLK := iq_CylCntrlInterface.I.xAirOk);
FT_Air(CLK := iq_CylCntrlInterface.I.xAirOk);

(* Debounce Cylinder Position Sensors *)
IF xMonitor THEN
	aFB_SensExt[0](iq_DebounceInterface := iq_CylCntrlInterface.stSensorExt);
	aFB_SensExt[1](iq_DebounceInterface := iq_CylCntrlInterface.stSensorRet);

	RT_SensExt(CLK := iq_CylCntrlInterface.stSensorExt.I.xSignal);
	IF RT_SensExt.Q THEN
 		iq_CylCntrlInterface.Q.tTimeToExtend	:= Timer.ET;
	END_IF
	
	RT_SensRet(CLK := iq_CylCntrlInterface.stSensorRet.I.xSignal);
	IF RT_SensRet.Q THEN
 		iq_CylCntrlInterface.Q.tTimeToRetract	:= Timer.ET;
	END_IF	
END_IF

xFaultSum	:= iq_CylCntrlInterface.Q.xFaultNoExt OR iq_CylCntrlInterface.Q.xFaultNoRet;

IF iq_CylCntrlInterface.I.xFaultReset THEN
	iq_CylCntrlInterface.Q.xFaultNoExt	:= FALSE;
	iq_CylCntrlInterface.Q.xFaultNoRet := FALSE;
END_IF

IF iq_CylCntrlInterface.I.xEnableFB THEN
	iq_CylCntrlInterface.Q.xFBActive	:= TRUE;
	
	(* Determine Cylinder Position when air is first turned on *)
	CASE iCheckAir OF
 		0:
			IF RT_Air.Q THEN
   				IF xMonitor OR x2xSV THEN
   					iCheckAir	:= 10;
				ELSE
					IF iq_CylCntrlInterface.I.xValveOffRetract THEN
   						IF iq_CylCntrlInterface.Q.xSVACmd THEN
							iq_CylCntrlInterface.Q.xExtended	:= TRUE;
							iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
	 					ELSE
						   	iq_CylCntrlInterface.Q.xRetracted	:= TRUE;
							iq_CylCntrlInterface.Q.xExtended	:= FALSE;
	 					END_IF
					ELSE
						IF iq_CylCntrlInterface.Q.xSVACmd THEN
							iq_CylCntrlInterface.Q.xRetracted	:= TRUE;
							iq_CylCntrlInterface.Q.xExtended	:= FALSE;
	 					ELSE
						   	iq_CylCntrlInterface.Q.xExtended	:= TRUE;
							iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
		 				END_IF
					END_IF
				END_IF
			END_IF
			
		10:
			IF xMonitor THEN
   				iCheckAir	:= 20;
			ELSE
				IF iq_CylCntrlInterface.I.xValveOffRetract THEN
   					IF iq_CylCntrlInterface.Q.xSVACmd THEN
						iq_CylCntrlInterface.Q.xExtended	:= TRUE;
						iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
						iCheckAir										:= 0;
	 				ELSIF iq_CylCntrlInterface.Q.xSVBCmd THEN
					   	iq_CylCntrlInterface.Q.xRetracted	:= TRUE;
						iq_CylCntrlInterface.Q.xExtended	:= FALSE;
						iCheckAir										:= 0;
	 				END_IF
				ELSE
					IF iq_CylCntrlInterface.Q.xSVACmd THEN
						iq_CylCntrlInterface.Q.xRetracted	:= TRUE;
						iq_CylCntrlInterface.Q.xExtended	:= FALSE;
						iCheckAir										:= 0;
	 				ELSIF iq_CylCntrlInterface.Q.xSVBCmd THEN
					   	iq_CylCntrlInterface.Q.xExtended	:= TRUE;
						iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
						iCheckAir										:= 0;
		 			END_IF
				END_IF
			END_IF
			
		20:
			IF iq_CylCntrlInterface.stSensorExt.Q.xCmd THEN
   				iq_CylCntrlInterface.Q.xExtended	:= TRUE;
				iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
				iCheckAir										:= 0;
			END_IF
			
			IF iq_CylCntrlInterface.stSensorRet.Q.xCmd THEN
   				iq_CylCntrlInterface.Q.xRetracted	:= TRUE;
				iq_CylCntrlInterface.Q.xExtended	:= FALSE;
				iCheckAir										:= 0;
			END_IF											
			

	END_CASE
	 			
	
	(* Fault Montiors *)
	FC_CylFM_1xSV_Basic(iq_CylCntrlInterface, Timer);
	FC_CylFM_1xSV_Sensored(iq_CylCntrlInterface, Timer);
	FC_CylFM_2xSV_Basic_NoBrake(iq_CylCntrlInterface, Timer);
	FC_CylFM_2xSV_Basic_wBrake(iq_CylCntrlInterface, Timer);
	FC_CylFM_2xSV_Sensored_NoBrake(iq_CylCntrlInterface, Timer);
	FC_CylFM_2xSV_Sensored_wBrake(iq_CylCntrlInterface, Timer);



	(* Control output *)
	IF iq_CylCntrlInterface.I.xEmergency OR xFaultSum OR FT_Air.Q THEN
		iq_CylCntrlInterface.Q.xSVACmd			:= FALSE;
		iq_CylCntrlInterface.Q.xSVBCmd			:= FALSE;
		iq_CylCntrlInterface.Q.xSVBrakeCmd	:= FALSE;
	ELSE
		FC_CylQ_1xSV(xManCmd, iq_CylCntrlInterface, Timer);
		FC_CylQ_2xSV_NoBrake(xManCmd, xManCmdB, iq_CylCntrlInterface, Timer);
		FC_CylQ_2xSV_wBrake(xManCmd, xManCmdB, xManBrake, iq_CylCntrlInterface, Timer);
	END_IF
	
	IF iq_CylCntrlInterface.I.xEmergency THEN
 		iq_CylCntrlInterface.Q.xExtended	:= FALSE;
  		iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
  	END_IF					

ELSE
	iq_CylCntrlInterface.Q.xFBActive			:= FALSE;
	iq_CylCntrlInterface.Q.xSVACmd			:= FALSE;
	iq_CylCntrlInterface.Q.xSVBCmd			:= FALSE;
 	iq_CylCntrlInterface.Q.xSVBrakeCmd	:= FALSE;	
	iq_CylCntrlInterface.Q.xExtended		:= FALSE;
	iq_CylCntrlInterface.Q.xRetracted		:= FALSE;
	Timer.IN											:= FALSE;
END_IF

END_FUNCTION_BLOCK
