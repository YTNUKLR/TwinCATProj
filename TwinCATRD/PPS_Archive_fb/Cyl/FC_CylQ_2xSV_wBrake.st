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

(* Controls the outputs for a Double SV Cylinder, with Brake *)
FUNCTION FC_CylQ_2xSV_wBrake
	
IF iq_Cyl.I.diType = EN_Cyl_2xSV_Basic_WBrake OR
	iq_Cyl.I.diType = EN_Cyl_2xSV_Sensored_WBrake THEN
	
	IF NOT iq_Cyl.I.xEnManCntrl THEN (* When not in Manual Mode, control output *)
		
		IF iq_Cyl.IQ.xBrakeEn THEN
  			iq_Cyl.Q.xSVACmd		:= FALSE;
   			iq_Cyl.Q.xSVBCmd		:= FALSE;
   			iq_Cyl.Q.xSVBrakeCmd	:= TRUE;
			iq_Timer.IN					:= FALSE;
			iq_Cyl.IQ.xBrakeEn		:= FALSE;
   		END_IF

		IF iq_Cyl.IQ.xBrakeDis THEN
  			iq_Cyl.Q.xSVBrakeCmd	:= FALSE;
   			iq_Cyl.IQ.xBrakeDis		:= FALSE;
   		END_IF

		IF iq_Cyl.Q.xSVBrakeCmd THEN
  			iq_Cyl.IQ.xExtCmd		:= FALSE;
   			iq_Cyl.IQ.xRetCmd		:= FALSE;
   		END_IF

		IF iq_Cyl.I.xValveOffRetract THEN
			IF iq_Cyl.IQ.xExtCmd THEN
				iq_Cyl.Q.xSVACmd		:= TRUE;
				iq_Cyl.Q.xSVBCmd		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.tTimeToExtend	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF iq_Cyl.Q.xSVACmd AND NOT iq_Cyl.Q.xSVBCmd THEN
					iq_Cyl.IQ.xExtCmd		:= FALSE;
				END_IF
			END_IF

			IF iq_Cyl.IQ.xRetCmd THEN
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xSVBCmd		:= TRUE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.tTimeToRetract	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF NOT iq_Cyl.Q.xSVACmd AND iq_Cyl.Q.xSVBCmd THEN
					iq_Cyl.IQ.xRetCmd		:= FALSE;
				END_IF
			END_IF
		ELSE
			IF iq_Cyl.IQ.xExtCmd THEN
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xSVBCmd		:= TRUE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.tTimeToExtend	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF NOT iq_Cyl.Q.xSVACmd AND iq_Cyl.Q.xSVBCmd THEN
					iq_Cyl.IQ.xExtCmd		:= FALSE;
				END_IF
			END_IF

			IF iq_Cyl.IQ.xRetCmd THEN
				iq_Cyl.Q.xSVACmd		:= TRUE;
				iq_Cyl.Q.xSVBCmd		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.tTimeToRetract	:= T#0ms;
				iq_Timer.IN					:= TRUE;
				IF iq_Cyl.Q.xSVACmd AND NOT iq_Cyl.Q.xSVBCmd THEN
					iq_Cyl.IQ.xRetCmd		:= FALSE;
				END_IF
			END_IF
		END_IF
		
	ELSE (* When in Manual Mode, control output *)
		
		IF xManBrake THEN
  			IF iq_Cyl.Q.xSVBrakeCmd THEN
   				iq_Cyl.Q.xSVBrakeCmd	:= FALSE;
			ELSE
			  	iq_Cyl.Q.xSVBrakeCmd	:= TRUE;
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xSVBCmd		:= FALSE;	
			END_IF
		END_IF
		
		IF iq_Cyl.Q.xSVACmd THEN
			IF xManCmd THEN
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Timer.IN					:= TRUE;
			END_IF
		ELSE
			IF xManCmd THEN
				iq_Cyl.Q.xSVACmd		:= TRUE;
				iq_Cyl.Q.xSVBCmd		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				IF iq_Cyl.I.xValveOffRetract THEN
					iq_Cyl.Q.tTimeToExtend	:= T#0ms;
	 			ELSE
					iq_Cyl.Q.tTimeToRetract	:= T#0ms;
	 			END_IF					
				iq_Timer.IN					:= TRUE;
			END_IF
		END_IF
		
		IF iq_Cyl.Q.xSVBCmd THEN
			IF xManCmdB THEN
				iq_Cyl.Q.xSVBCmd		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				iq_Timer.IN					:= TRUE;
			END_IF
		ELSE
			IF xManCmdB THEN
				iq_Cyl.Q.xSVBCmd		:= TRUE;
				iq_Cyl.Q.xSVACmd		:= FALSE;
				iq_Cyl.Q.xRetracted		:= FALSE;
				iq_Cyl.Q.xExtended		:= FALSE;
				IF iq_Cyl.I.xValveOffRetract THEN
					iq_Cyl.Q.tTimeToRetract	:= T#0ms;
	 			ELSE
					iq_Cyl.Q.tTimeToExtend	:= T#0ms;
	 			END_IF	
				iq_Timer.IN					:= TRUE;
			END_IF
		END_IF
	END_IF
		
END_IF
	

END_FUNCTION
