(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_DigCntrl.st
 * Author: Paul Zurlinden
 * Created: May 26, 2011
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Controls a digital output in the following ways;
		
		**** Must use dtDigCntrlInterface with this FB ****
		
		Allows a manual mode for only a momentary manual cmd to toggle the output
		If not in manual mode, allows for xAutoOn to be high to toggle output On,
			Conversly, allows xAutoOff to be high to toggle output Off.  xAutoOn and xAutoOff
			are set low by FB when scanned.
		Also if xEnMonitor is true monitors output with an input xMonitor in conjuction with a
			delay timer tMonitorDelay such that if the output is on, the monitor input must be high
			within the time specified by the delay else a fault is triggered which disables the output
			or any command to toggle it.*)
			
FUNCTION_BLOCK FB_DigCntrl

RT(CLK := iq_DigCntrlInterface.I.xManCmd);

IF iq_DigCntrlInterface.I.xEnMonitor THEN
	FB_MonitorDebounce(iq_DebounceInterface := iq_DigCntrlInterface.stMonitor);
END_IF

IF iq_DigCntrlInterface.I.xEmergency THEN
	iq_DigCntrlInterface.Q.xCmd := FALSE;
END_IF	

IF NOT iq_DigCntrlInterface.Q.xFault AND NOT iq_DigCntrlInterface.I.xEmergency THEN
	IF iq_DigCntrlInterface.I.xEnManCntrl THEN
		IF RT.Q THEN
	 		IF iq_DigCntrlInterface.Q.xCmd THEN
  				iq_DigCntrlInterface.Q.xCmd := FALSE;
  	 		ELSE
			 	iq_DigCntrlInterface.Q.xCmd := TRUE;
	   		END_IF
		END_IF
	ELSE
//		IF iq_DigCntrlInterface.Q.xCmd THEN
	 		IF iq_DigCntrlInterface.IQ.xAutoOff THEN
	  			iq_DigCntrlInterface.Q.xCmd		:= FALSE;
				iq_DigCntrlInterface.IQ.xAutoOff	:= FALSE;
	   		END_IF
//		ELSE
			IF iq_DigCntrlInterface.IQ.xAutoOn THEN
	  			iq_DigCntrlInterface.Q.xCmd		:= TRUE;
				iq_DigCntrlInterface.IQ.xAutoOn	:= FALSE;
	   		END_IF
//		END_IF
	END_IF
END_IF

IF iq_DigCntrlInterface.I.xEnMonitor (*AND iq_DigCntrlInterface.I.usiHWFamily <> 4*) THEN
	Timer(IN := iq_DigCntrlInterface.Q.xCmd, PT := iq_DigCntrlInterface.I.tMonitorDelay);

	IF Timer.Q AND NOT iq_DigCntrlInterface.stMonitor.Q.xCmd THEN
		iq_DigCntrlInterface.Q.xFault	:= TRUE;
		iq_DigCntrlInterface.Q.xCmd	:= FALSE;
	END_IF	

	IF iq_DigCntrlInterface.IQ.xFaultReset THEN
		iq_DigCntrlInterface.Q.xFault 		:= FALSE;
		iq_DigCntrlInterface.IQ.xFaultReset	:= FALSE;
	END_IF	
END_IF

END_FUNCTION_BLOCK
