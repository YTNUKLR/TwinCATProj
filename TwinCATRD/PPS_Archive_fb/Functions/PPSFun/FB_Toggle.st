(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_Toggle.st
 * Author: Paul Zurlinden
 * Created: November 04, 2010
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Monitors momentary input and toggles the output *)
FUNCTION_BLOCK FB_Toggle

counter(
	CU := i_xMomentary,
	RESET := i_xEmergency);
	
q_xCMD := counter.Q;


END_FUNCTION_BLOCK
