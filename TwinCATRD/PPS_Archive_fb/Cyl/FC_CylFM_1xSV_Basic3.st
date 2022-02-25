(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: FC_CylFM_1xSV_Basic.st
 * Author: PaulZ
 * Created: April 18, 2012
 ********************************************************************
 * Implementation of library PPS_Cyl
 ********************************************************************) 

(* Monitors Cylinder Fault for Single SV Cylinder *)
FUNCTION FC_CylFM_1xSV_Basic3

IF iq_Cyl.I.diType = EN_Cyl_1xSV_Basic THEN
	
	IF iq_Cyl.Q.xSVACmd THEN
		IF iq_Timer.Q THEN
			IF iq_Cyl.I.xValveOffRetract THEN
				iq_Cyl.Q.xExtended	:= TRUE;
			ELSE
				iq_Cyl.Q.xRetracted	:= TRUE;					
			END_IF
			iq_Timer.IN					:= FALSE;
		END_IF
	ELSE
		IF iq_Timer.Q THEN
			IF iq_Cyl.I.xValveOffRetract THEN
				iq_Cyl.Q.xRetracted	:= TRUE;
			ELSE
				iq_Cyl.Q.xExtended	:= TRUE;
				END_IF					
			iq_Timer.IN					:= FALSE;
		END_IF
	END_IF
	
END_IF

END_FUNCTION
