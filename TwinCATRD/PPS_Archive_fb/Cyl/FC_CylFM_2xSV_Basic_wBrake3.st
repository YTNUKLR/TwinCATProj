(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: FC_CylFM_2xSV_Basic_wBrake.st
 * Author: PaulZ
 * Created: April 23, 2012
 ********************************************************************
 * Implementation of library PPS_Cyl
 ********************************************************************) 

(* Monitors Cylinder Faults for Double SV Cylinder, no Sensors, with Brake *)
FUNCTION FC_CylFM_2xSV_Basic_wBrake3

IF iq_Cyl.I.diType = EN_Cyl_2xSV_Basic_WBrake THEN
	
	IF iq_Cyl.Q.xSVACmd THEN
		IF iq_Timer.Q THEN
			IF iq_Cyl.I.xValveOffRetract THEN
				iq_Cyl.Q.xExtended		:= TRUE;
				iq_Cyl.Q.tTimeToExtend	:= iq_Timer.ET;
			ELSE
				iq_Cyl.Q.xRetracted		:= TRUE;
				iq_Cyl.Q.tTimeToRetract	:= iq_Timer.ET;
			END_IF
			iq_Timer.IN						:= FALSE;
		END_IF
	ELSIF iq_Cyl.Q.xSVBCmd THEN
		IF iq_Timer.Q THEN
			IF iq_Cyl.I.xValveOffRetract THEN
				iq_Cyl.Q.xRetracted		:= TRUE;
				iq_Cyl.Q.tTimeToRetract	:= iq_Timer.ET;
			ELSE
				iq_Cyl.Q.xExtended		:= TRUE;
				iq_Cyl.Q.tTimeToExtend	:= iq_Timer.ET;
 			END_IF
			iq_Timer.IN						:= FALSE;
		END_IF
	END_IF
	
END_IF

END_FUNCTION
