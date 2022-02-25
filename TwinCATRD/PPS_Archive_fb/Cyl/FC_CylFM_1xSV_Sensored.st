(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: FC_CylFM_1xSV_Sensored.st
 * Author: PaulZ
 * Created: April 18, 2012
 ********************************************************************
 * Implementation of library PPS_Cyl
 ********************************************************************) 

(* Monitors Cylinder Fault for Single SV Cylinder with Sensors *)
FUNCTION FC_CylFM_1xSV_Sensored

IF iq_Cyl.I.diType = EN_Cyl_1xSV_Sensored THEN
	
	xFaultSum	:= iq_Cyl.Q.xFaultNoExt OR iq_Cyl.Q.xFaultNoRet;

	IF NOT xFaultSum THEN
		IF iq_Cyl.I.xValveOffRetract THEN
			IF iq_Cyl.Q.xSVACmd THEN
				IF iq_Cyl.stSensorExt.Q.xCmd THEN
					iq_Cyl.Q.xExtended		:= TRUE;
					iq_Cyl.Q.xFaultNoExt		:= FALSE;
					iq_Timer.IN					:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xExtended	:= FALSE;
						iq_Cyl.Q.xFaultNoExt	:= TRUE;
						iq_Timer.IN				:= FALSE;
					END_IF
				END_IF
			ELSE
				IF iq_Cyl.stSensorRet.Q.xCmd THEN
					iq_Cyl.Q.xRetracted 		:= TRUE;
					iq_Cyl.Q.xFaultNoRet		:= FALSE;
					iq_Timer.IN					:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xRetracted	:= FALSE;
						iq_Cyl.Q.xFaultNoRet	:= TRUE;
						iq_Timer.IN				:= FALSE;
					END_IF
				END_IF
			END_IF
		ELSE
			IF NOT iq_Cyl.Q.xSVACmd THEN
				IF iq_Cyl.stSensorExt.Q.xCmd THEN
					iq_Cyl.Q.xExtended		:= TRUE;
					iq_Cyl.Q.xFaultNoExt		:= FALSE;
					iq_Timer.IN					:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xExtended	:= FALSE;
						iq_Cyl.Q.xFaultNoExt	:= TRUE;
						iq_Timer.IN				:= FALSE;
					END_IF
				END_IF
			ELSE
				IF iq_Cyl.stSensorRet.Q.xCmd THEN
					iq_Cyl.Q.xRetracted		:= TRUE;
					iq_Cyl.Q.xFaultNoRet		:= FALSE;
					iq_Timer.IN					:= FALSE;
				ELSE
					IF iq_Timer.Q THEN
						iq_Cyl.Q.xRetracted	:= FALSE;
						iq_Cyl.Q.xFaultNoRet	:= TRUE;
						iq_Timer.IN				:= FALSE;
					END_IF
				END_IF
			END_IF
		END_IF
	END_IF

END_IF

END_FUNCTION
