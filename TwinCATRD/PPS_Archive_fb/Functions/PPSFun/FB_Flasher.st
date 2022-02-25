(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_Flasher.st
 * Author: PaulZ
 * Created: December 29, 2010
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Flasher *)
FUNCTION_BLOCK FB_Flasher
	
tmrOn(PT := i_tOn);
tmrOff(IN := tmrOn.Q, PT := i_tOff);

IF i_xSignal AND NOT tmrOff.Q THEN
	tmrOn.IN	:= TRUE;
ELSE
	tmrOn.IN	:= FALSE;
END_IF

q_xFlash	:= tmrOff.Q;

END_FUNCTION_BLOCK
