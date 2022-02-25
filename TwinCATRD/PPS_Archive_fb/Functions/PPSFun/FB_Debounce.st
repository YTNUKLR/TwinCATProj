(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_Debounce.st
 * Author: Paul Zurlinden
 * Created: November 03, 2010
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Filter an input with On and Off delays *)
FUNCTION_BLOCK FB_Debounce

tmrOn(IN := iq_DebounceInterface.I.xSignal, PT := iq_DebounceInterface.I.tOnDelay);
tmrOff(IN := tmrOn.Q, PT := iq_DebounceInterface.I.tOffDelay);

iq_DebounceInterface.Q.xCmd			:= tmrOff.Q;
iq_DebounceInterface.Q.tOnTimer		:= tmrOn.ET;
iq_DebounceInterface.Q.tOffTimer		:= tmrOff.ET;

END_FUNCTION_BLOCK
