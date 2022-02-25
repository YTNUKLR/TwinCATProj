(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_CylCntrl.st
 * Author: Paul Zurlinden
 * Created: November 04, 2010
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Controls a pneumatic cylinder with or without end of travel sensors *)
FUNCTION_BLOCK FB_CylCntrl

Timer(PT := iq_CylCntrlInterface.I.tTravelDel);
RT(CLK := iq_CylCntrlInterface.I.xManCmd);
RT_Air(CLK := iq_CylCntrlInterface.I.xAirOk);

(* Debounce Cylinder Position Sensors *)
IF iq_CylCntrlInterface.I.xEnMonitor THEN
	aFB_SensExt[0](iq_DebounceInterface := iq_CylCntrlInterface.stSensorExt);
	aFB_SensExt[1](iq_DebounceInterface := iq_CylCntrlInterface.stSensorRet);
END_IF

IF iq_CylCntrlInterface.Q.xFaultNoExt OR iq_CylCntrlInterface.Q.xFaultNoRet THEN
	xFaultSum := TRUE;
ELSE
	xFaultSum	:= FALSE;
END_IF

IF iq_CylCntrlInterface.I.xFaultReset THEN
	iq_CylCntrlInterface.Q.xFaultNoExt	:= FALSE;
	iq_CylCntrlInterface.Q.xFaultNoRet := FALSE;
END_IF

IF iq_CylCntrlInterface.I.xEnableFB THEN
	iq_CylCntrlInterface.Q.xFBActive	:= TRUE;

	(* Determine Cylinder Position when air is first turned on *)
	IF RT_Air.Q THEN
		IF iq_CylCntrlInterface.I.xEnMonitor THEN
	 		IF iq_CylCntrlInterface.stSensorExt.Q.xCmd THEN
  				iq_CylCntrlInterface.Q.xExtended		:= TRUE;
   			ELSIF iq_CylCntrlInterface.stSensorRet.Q.xCmd THEN
			 	iq_CylCntrlInterface.Q.xRetracted	:= TRUE;
   			END_IF
		ELSE
			IF iq_CylCntrlInterface.I.xValveOffRetract THEN
   				IF iq_CylCntrlInterface.Q.xSVCmd THEN
					iq_CylCntrlInterface.Q.xExtended := TRUE;
	 			ELSE
				   	iq_CylCntrlInterface.Q.xRetracted := TRUE;
	 			END_IF
			ELSE
				IF iq_CylCntrlInterface.Q.xSVCmd THEN
					iq_CylCntrlInterface.Q.xRetracted := TRUE;
	 			ELSE
				   	iq_CylCntrlInterface.Q.xExtended := TRUE;
	 			END_IF
			END_IF
		END_IF
	END_IF

	(* Fault monitor *)
	IF iq_CylCntrlInterface.I.xEnMonitor (*AND iq_CylCntrlInterface.I.usiHWFamily <> 4*) THEN (* Fault Monitor is enabled *)
		IF NOT xFaultSum THEN
			IF iq_CylCntrlInterface.I.xValveOffRetract THEN
				IF iq_CylCntrlInterface.Q.xSVCmd THEN
					IF iq_CylCntrlInterface.stSensorExt.Q.xCmd THEN
						iq_CylCntrlInterface.Q.xExtended			:= TRUE;
						iq_CylCntrlInterface.Q.xFaultNoExt		:= FALSE;
						Timer.IN												:= FALSE;
					ELSE
						IF Timer.Q THEN
							iq_CylCntrlInterface.Q.xExtended		:= FALSE;
							iq_CylCntrlInterface.Q.xFaultNoExt	:= TRUE;
							Timer.IN											:= FALSE;
						END_IF
					END_IF
				ELSE
					IF iq_CylCntrlInterface.stSensorRet.Q.xCmd THEN
						iq_CylCntrlInterface.Q.xRetracted 		:= TRUE;
						iq_CylCntrlInterface.Q.xFaultNoRet		:= FALSE;
						Timer.IN												:= FALSE;
					ELSE
						IF Timer.Q THEN
							iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
							iq_CylCntrlInterface.Q.xFaultNoRet	:= TRUE;
							Timer.IN											:= FALSE;
						END_IF
					END_IF
				END_IF
			ELSE
				IF NOT iq_CylCntrlInterface.Q.xSVCmd THEN
					IF iq_CylCntrlInterface.stSensorExt.Q.xCmd THEN
						iq_CylCntrlInterface.Q.xExtended			:= TRUE;
						iq_CylCntrlInterface.Q.xFaultNoExt		:= FALSE;
						Timer.IN												:= FALSE;
					ELSE
						IF Timer.Q THEN
							iq_CylCntrlInterface.Q.xExtended		:= FALSE;
							iq_CylCntrlInterface.Q.xFaultNoExt	:= TRUE;
							Timer.IN	:= FALSE;
						END_IF
					END_IF
				ELSE
					IF iq_CylCntrlInterface.stSensorRet.Q.xCmd THEN
						iq_CylCntrlInterface.Q.xRetracted		:= TRUE;
						iq_CylCntrlInterface.Q.xFaultNoRet		:= FALSE;
						Timer.IN	:= FALSE;
					ELSE
						IF Timer.Q THEN
							iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
							iq_CylCntrlInterface.Q.xFaultNoRet	:= TRUE;
							Timer.IN											:= FALSE;
						END_IF
					END_IF
				END_IF
			END_IF
		END_IF
	ELSE (* Fault Monitor is disabled *)
		IF iq_CylCntrlInterface.Q.xSVCmd THEN
			IF Timer.Q THEN
				IF iq_CylCntrlInterface.I.xValveOffRetract THEN
					iq_CylCntrlInterface.Q.xExtended		:= TRUE;
				ELSE
					iq_CylCntrlInterface.Q.xRetracted	:= TRUE;					
				END_IF
				Timer.IN												:= FALSE;
			END_IF
		ELSE
			IF Timer.Q THEN
				IF iq_CylCntrlInterface.I.xValveOffRetract THEN
					iq_CylCntrlInterface.Q.xRetracted	:= TRUE;
				ELSE
					iq_CylCntrlInterface.Q.xExtended		:= TRUE;
	 			END_IF					
				Timer.IN												:= FALSE;
			END_IF
		END_IF
	END_IF
	(* End Fault Monitor *)


	(* Control output *)
	IF iq_CylCntrlInterface.I.xEmergency OR xFaultSum THEN
		iq_CylCntrlInterface.Q.xSVCmd := FALSE;
	ELSE
		IF NOT iq_CylCntrlInterface.I.xEnManCntrl THEN (* When not in Manual Mode, control output *)
			
			IF iq_CylCntrlInterface.I.xValveOffRetract THEN
				IF iq_CylCntrlInterface.IQ.xExtCmd (*AND NOT iq_CylCntrlInterface.Q.xSVCmd*) THEN
					iq_CylCntrlInterface.Q.xSVCmd		:= TRUE;
					iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
					iq_CylCntrlInterface.Q.xExtended		:= FALSE;
					Timer.IN											:= TRUE;
					IF iq_CylCntrlInterface.Q.xSVCmd THEN
						iq_CylCntrlInterface.IQ.xExtCmd		:= FALSE;
					END_IF
				END_IF

				IF iq_CylCntrlInterface.IQ.xRetCmd (*AND iq_CylCntrlInterface.Q.xSVCmd*) THEN
					iq_CylCntrlInterface.Q.xSVCmd		:= FALSE;
					iq_CylCntrlInterface.Q.xExtended		:= FALSE;
					iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
					Timer.IN											:= TRUE;
					IF NOT iq_CylCntrlInterface.Q.xSVCmd THEN
						iq_CylCntrlInterface.IQ.xRetCmd		:= FALSE;
					END_IF
				END_IF
			ELSE
				IF iq_CylCntrlInterface.IQ.xExtCmd (*AND iq_CylCntrlInterface.Q.xSVCmd*) THEN
					iq_CylCntrlInterface.Q.xSVCmd		:= FALSE;
					iq_CylCntrlInterface.Q.xExtended		:= FALSE;
					iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
					Timer.IN											:= TRUE;
					IF NOT iq_CylCntrlInterface.Q.xSVCmd THEN
						iq_CylCntrlInterface.IQ.xExtCmd		:= FALSE;
					END_IF
				END_IF

				IF iq_CylCntrlInterface.IQ.xRetCmd (*AND NOT iq_CylCntrlInterface.Q.xSVCmd*) THEN
					iq_CylCntrlInterface.Q.xSVCmd		:= TRUE;
					iq_CylCntrlInterface.Q.xExtended		:= FALSE;
					iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
					Timer.IN											:= TRUE;
					IF iq_CylCntrlInterface.Q.xSVCmd THEN
						iq_CylCntrlInterface.IQ.xRetCmd		:= FALSE;
					END_IF
				END_IF
			END_IF
		
		ELSE (* When in Manual Mode, control output *)
			IF iq_CylCntrlInterface.Q.xSVCmd THEN
				IF RT.Q THEN
					iq_CylCntrlInterface.Q.xSVCmd		:= FALSE;
					iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
					iq_CylCntrlInterface.Q.xExtended		:= FALSE;
					Timer.IN											:= TRUE;
				END_IF
			ELSE
				IF RT.Q THEN
					iq_CylCntrlInterface.Q.xSVCmd		:= TRUE;
					iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
					iq_CylCntrlInterface.Q.xExtended		:= FALSE;
					Timer.IN											:= TRUE;
				END_IF
			END_IF
		END_IF
	END_IF

ELSE
	iq_CylCntrlInterface.Q.xFBActive		:= FALSE;
	iq_CylCntrlInterface.Q.xSVCmd		:= FALSE;
	iq_CylCntrlInterface.Q.xExtended		:= FALSE;
	iq_CylCntrlInterface.Q.xRetracted	:= FALSE;
	Timer.IN	:= FALSE;
END_IF

END_FUNCTION_BLOCK
