(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: FC_CylQ_1xSV_Basic.st
 * Author: PaulZ
 * Created: April 19, 2012
 ********************************************************************
 * Implementation of library PPS_Cyl
 ********************************************************************) 

(* Controls the outputs for a Single SV Cylinder *)
FUNCTION FC_CylQ_1xSV
	
IF iq_Cyl.I.diType = EN_Cyl_1xSV_Basic OR
	iq_Cyl.I.diType = EN_Cyl_1xSV_Sensored THEN
	
	IF NOT iq_Cyl.I.xEnManCntrl THEN (* When not in Manual Mode, control output *)
			
		IF iq_Cyl.I.xValveOffRetract THEN
			IF iq_Cyl.IQ.xExtCmd THEN
				iq_Cyl.Q.xSVACmd		:= TRUE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.tTimeToExtend	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF iq_Cyl.Q.xSVACmd THEN
					iq_Cyl.IQ.xExtCmd		:= FALSE;
				END_IF
			END_IF

			IF iq_Cyl.IQ.xRetCmd THEN
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.tTimeToRetract	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF NOT iq_Cyl.Q.xSVACmd THEN
					iq_Cyl.IQ.xRetCmd		:= FALSE;
				END_IF
			END_IF
		ELSE
			IF iq_Cyl.IQ.xExtCmd THEN
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.tTimeToExtend	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF NOT iq_Cyl.Q.xSVACmd THEN
					iq_Cyl.IQ.xExtCmd		:= FALSE;
				END_IF
			END_IF

			IF iq_Cyl.IQ.xRetCmd THEN
				iq_Cyl.Q.xSVACmd		:= TRUE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.tTimeToRetract	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF iq_Cyl.Q.xSVACmd THEN
					iq_Cyl.IQ.xRetCmd		:= FALSE;
				END_IF
			END_IF
		END_IF
		
	ELSE (* When in Manual Mode, control output *)
		IF iq_Cyl.Q.xSVACmd THEN
			IF xManCmd THEN
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.tTimeToRetract	:= T#0ms;
				iq_Timer.IN					:= TRUE;
			END_IF
		ELSE
			IF xManCmd THEN
				iq_Cyl.Q.xSVACmd		:= TRUE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.tTimeToExtend	:= T#0ms;
				iq_Timer.IN					:= TRUE;
			END_IF
		END_IF
	END_IF
		
END_IF
	

END_FUNCTION
