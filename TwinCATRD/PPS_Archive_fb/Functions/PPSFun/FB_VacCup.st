(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_VacCup.st
 * Author: Paul Zurlinden
 * Created: November 09, 2010
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Controls a vacuum cup with purge *)
FUNCTION_BLOCK FB_VacCup
RT(CLK := iq_VacCupInterface.I.xManCmd);
FT(CLK := iq_VacCupInterface.Q.xSVVac);
Timer(PT := iq_VacCupInterface.I.tPurgeTime);

IF iq_VacCupInterface.I.xEnable AND NOT iq_VacCupInterface.I.xEmergency THEN
	iq_VacCupInterface.Q.xFBActive	:= TRUE;
	(* Control the vacuum valve *)
	IF iq_VacCupInterface.I.xEnManCntrl THEN
		IF RT.Q THEN
	 		IF iq_VacCupInterface.Q.xSVVac THEN
  				iq_VacCupInterface.Q.xSVVac := FALSE;
  	 		ELSE
			 	iq_VacCupInterface.Q.xSVVac := TRUE;
	   		END_IF
		END_IF
	ELSE
//		IF iq_VacCupInterface.Q.xSVVac THEN
	 		IF iq_VacCupInterface.IQ.xAutoOff THEN
	  			iq_VacCupInterface.Q.xSVVac	:= FALSE;
				iq_VacCupInterface.IQ.xAutoOff	:= FALSE;
	   		END_IF
//		ELSE
			IF iq_VacCupInterface.IQ.xAutoOn THEN
	  			iq_VacCupInterface.Q.xSVVac	:= TRUE;
				iq_VacCupInterface.IQ.xAutoOn	:= FALSE;
	   		END_IF
		END_IF
//	END_IF
	
	(* Control the purge valve *)
	IF FT.Q THEN
 		Timer.IN 		:= TRUE;
  	END_IF
	
	IF Timer.Q THEN
 		Timer.IN		:= FALSE;
  	END_IF
	
	iq_VacCupInterface.Q.xSVPurge		:= Timer.IN;
	
ELSIF iq_VacCupInterface.I.xEmergency THEN
	Timer.IN		:= FALSE;
 	iq_VacCupInterface.Q.xSVVac		:= FALSE;
 	iq_VacCupInterface.Q.xSVPurge		:= FALSE;	
ELSIF NOT iq_VacCupInterface.I.xEnable THEN
	Timer.IN		:= FALSE;
 	iq_VacCupInterface.Q.xSVVac		:= FALSE;
 	iq_VacCupInterface.Q.xSVPurge		:= FALSE;	
	iq_VacCupInterface.Q.xFBActive	:= FALSE;
END_IF	

END_FUNCTION_BLOCK
