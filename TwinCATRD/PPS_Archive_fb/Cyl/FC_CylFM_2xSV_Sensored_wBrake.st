(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: FC_CylFM_2xSV_Sensored_wBrake.st
 * Author: PaulZ
 * Created: April 18, 2012
 ********************************************************************
 * Implementation of library PPS_Cyl
 ********************************************************************) 

(* Monitors Cylinder Fault for Double SV Cylinder with Sensors and Brake *)
FUNCTION FC_CylFM_2xSV_Sensored_wBrake

IF iq_Cyl.I.diType = EN_Cyl_2xSV_Sensored_WBrake THEN
	
	xFaultSum	:= iq_Cyl.Q.xFaultNoExt OR iq_Cyl.Q.xFaultNoRet;
 
 	IF iq_Cyl.Q.xSVBrakeCmd THEN
 		iq_Timer.IN		:= FALSE;
	END_IF
		
	IF NOT xFaultSum THEN
		IF iq_Cyl.I.xValveOffRetract THEN
			IF iq_Cyl.Q.xSVACmd THEN
				IF iq_Cyl.stSensorExt.Q.xCmd THEN
					iq_Cyl.Q.xExtended			:= TRUE;
					iq_Cyl.Q.xFaultNoExt			:= FALSE;
					iq_Timer.IN						:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xExtended		:= FALSE;
						iq_Cyl.Q.xFaultNoExt		:= TRUE;
						iq_Timer.IN					:= FALSE;
					END_IF
				END_IF
			ELSIF iq_Cyl.Q.xSVBCmd THEN
				IF iq_Cyl.stSensorRet.Q.xCmd THEN
					iq_Cyl.Q.xRetracted 			:= TRUE;
					iq_Cyl.Q.xFaultNoRet			:= FALSE;
					iq_Timer.IN						:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xRetracted		:= FALSE;
						iq_Cyl.Q.xFaultNoRet		:= TRUE;
						iq_Timer.IN					:= FALSE;
					END_IF
				END_IF
			END_IF
		ELSE
			IF iq_Cyl.Q.xSVBCmd THEN
				IF iq_Cyl.stSensorExt.Q.xCmd THEN
					iq_Cyl.Q.xExtended			:= TRUE;
					iq_Cyl.Q.xFaultNoExt			:= FALSE;
					iq_Timer.IN						:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xExtended		:= FALSE;
						iq_Cyl.Q.xFaultNoExt		:= TRUE;
						iq_Timer.IN					:= FALSE;
					END_IF
				END_IF
			ELSIF iq_Cyl.Q.xSVACmd THEN
				IF iq_Cyl.stSensorRet.Q.xCmd THEN
					iq_Cyl.Q.xRetracted			:= TRUE;
					iq_Cyl.Q.xFaultNoRet			:= FALSE;
					iq_Timer.IN						:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xRetracted		:= FALSE;
						iq_Cyl.Q.xFaultNoRet		:= TRUE;
						iq_Timer.IN					:= FALSE;
					END_IF
				END_IF
			END_IF
		END_IF
	END_IF	

END_IF

END_FUNCTION
