(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_GlueApplicator.st
 * Author: Paul Zurlinden
 * Created: November 05, 2010
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Controls Glue Applicator for Auto and Manual Mode *)
FUNCTION_BLOCK FB_GlueApplicator

RT(CLK := i_xManPurgeCmd);

Timer(PT := i_tPurgeTime);
IF Timer.Q THEN
	Timer.IN := FALSE;
END_IF	

IF i_xEnable THEN
	
	IF i_xEnManual AND RT.Q THEN
 		Timer.IN := TRUE;
  	END_IF
	
	IF Timer.IN OR i_xApplyCmd THEN
 		q_xApplicatorEnable := TRUE;
  	ELSE
		q_xApplicatorEnable := FALSE;
  	END_IF		

ELSIF i_xEmergency OR NOT i_xEnable THEN
	
	q_xApplicatorEnable := FALSE;
 	Timer.IN := FALSE;

END_IF		

END_FUNCTION_BLOCK
