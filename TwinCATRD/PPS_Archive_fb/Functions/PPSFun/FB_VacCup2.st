(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_VacCup2.st
 * Author: PaulZ
 * Created: March 19, 2013
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Controls seperate valves for vacuum and purge, impliments a monitoring input. *)
FUNCTION_BLOCK FB_VacCup2
	
	RT(CLK := iq_VacCupInterface.I.xManCmd);
	FT(CLK := iq_VacCupInterface.Q.xSVVac);
	Timer(PT := iq_VacCupInterface.I.tPurgeTime);
	tmrMon(PT := iq_VacCupInterface.I.tMonitorDelay);
	ifbMonitor(iq_DebounceInterface := iq_VacCupInterface.Monitor);
	
	IF iq_VacCupInterface.Q.xFault THEN
		iq_VacCupInterface.Q.xSVVac	:= FALSE;
		iq_VacCupInterface.IQ.xAutoOff	:= FALSE;
		iq_VacCupInterface.IQ.xAutoOn	:= FALSE;
	END_IF
	
	IF (tmrMon.Q) AND (NOT xHadVac) THEN
		tmrMon.IN								:= FALSE;
		iq_VacCupInterface.Q.xFault	:= TRUE;
  		iq_VacCupInterface.Q.sFaultTxt	:= CONCAT(iq_VacCupInterface.I.sName, ' could not vacuum');
	END_IF
	
	IF iq_VacCupInterface.Q.xFault AND iq_VacCupInterface.IQ.xClearFault THEN
 		iq_VacCupInterface.Q.xFault			:= FALSE;
		iq_VacCupInterface.Q.sFaultTxt		:= '';
		xHadVac								:= FALSE;
		iq_VacCupInterface.IQ.xClearFault	:= FALSE;
	END_IF

	IF iq_VacCupInterface.I.xEnable AND NOT iq_VacCupInterface.I.xEmergency THEN
		
		iq_VacCupInterface.Q.xFBActive	:= TRUE;
	
		(* Control the vacuum valve *)
		IF iq_VacCupInterface.I.xEnManCntrl THEN
			iq_VacCupInterface.IQ.xAutoOff	:= FALSE;
			iq_VacCupInterface.IQ.xAutoOn	:= FALSE;
			IF RT.Q THEN
		 		IF iq_VacCupInterface.Q.xSVVac THEN	
	  				iq_VacCupInterface.Q.xSVVac := FALSE;
	  	 		ELSE
				 	iq_VacCupInterface.Q.xSVVac := TRUE;
		   		END_IF
			END_IF
		ELSE
		
		 	IF iq_VacCupInterface.IQ.xAutoOff THEN
		  		iq_VacCupInterface.Q.xSVVac	:= FALSE;
				iq_VacCupInterface.IQ.xAutoOff	:= FALSE;
				IF iq_VacCupInterface.I.xMonitored THEN
					tmrMon.IN									:= FALSE;
				END_IF
				xHadVac										:= FALSE;
		  	END_IF
			 
			IF iq_VacCupInterface.IQ.xAutoOn THEN
		  		iq_VacCupInterface.Q.xSVVac	:= TRUE;
				iq_VacCupInterface.IQ.xAutoOn	:= FALSE;
				IF iq_VacCupInterface.I.xMonitored THEN
					tmrMon.IN									:= TRUE;
				END_IF
		  	END_IF
			
		END_IF
		
		(* Monitor for Vacuum *)
		IF	(iq_VacCupInterface.I.xMonitored)
			AND (iq_VacCupInterface.Q.xSVVac)
			AND (NOT tmrMon.Q)
			AND iq_VacCupInterface.Monitor.Q.xCmd THEN
				xHadVac		:= TRUE;
  				tmrMon.IN	:= FALSE;
  		END_IF					
		
		IF (iq_VacCupInterface.I.xMonitored)
			AND (NOT iq_VacCupInterface.I.xEnManCntrl)
   			AND (iq_VacCupInterface.Q.xSVVac)
   			AND (xHadVac)
			AND (NOT iq_VacCupInterface.Monitor.Q.xCmd) THEN
   				iq_VacCupInterface.Q.xFault	:= TRUE;
				iq_VacCupInterface.Q.sFaultTxt := CONCAT(iq_VacCupInterface.I.sName, ' lost vacuum');
		END_IF
	
		(* Control the purge valve *)
		IF (FT.Q) AND (NOT iq_VacCupInterface.Q.xFault) THEN
	 		Timer.IN 		:= TRUE;
	  	END_IF
	
		IF Timer.Q THEN
	 		Timer.IN		:= FALSE;
	  	END_IF
	
		iq_VacCupInterface.Q.xSVPurge		:= Timer.IN;
	
	ELSIF iq_VacCupInterface.I.xEmergency THEN
		Timer.IN										:= FALSE;
	 	iq_VacCupInterface.Q.xSVVac		:= FALSE;
	 	iq_VacCupInterface.Q.xSVPurge		:= FALSE;	
	ELSIF NOT iq_VacCupInterface.I.xEnable THEN
		Timer.IN										:= FALSE;
	 	iq_VacCupInterface.Q.xSVVac		:= FALSE;
	 	iq_VacCupInterface.Q.xSVPurge		:= FALSE;	
		iq_VacCupInterface.Q.xFBActive		:= FALSE;
		iq_VacCupInterface.Q.xFault			:= FALSE;
  		iq_VacCupInterface.Q.sFaultTxt		:= '';		
	END_IF	

END_FUNCTION_BLOCK
