(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: FB_EZLight.st
 * Author: Paul Zurlinden
 * Created: November 05, 2010
 ********************************************************************
 * Implementation of library PPSFun
 ********************************************************************) 

(* Controls Banner Light K50LGRYB4PQ *)
FUNCTION_BLOCK FB_EZLight

IF iq_diCmd <> 0 THEN
	q_diResult := iq_diCmd;
	IF iq_diCmd = q_diResult THEN
		iq_diCmd :=0;
	END_IF
END_IF

IF q_xGnLight OR q_xRdLight OR q_xYwLight OR q_xBuLight THEN
	q_xLightActive := TRUE;
ELSE
	q_xLightActive := FALSE;
END_IF


CASE q_diResult OF

	EN_EZL_GNSteady:
		q_xGnLight := TRUE;
		q_xRdLight	:= FALSE;
  		q_xBuLight	:= FALSE;
  		q_xYwLight	:= FALSE;				
		q_sResultText := 'Green Steady';

	EN_EZL_GNFlash:
		q_xGnLight := TRUE;
		q_xYwLight := TRUE;
		q_xBuLight	:= FALSE;
  		q_xRdLight	:= FALSE;		
		q_sResultText := 'Green Flashing';

	EN_EZL_RDSteady:
		q_xRdLight := TRUE;
		q_xGnLight	:= FALSE;
  		q_xYwLight	:= FALSE;
  		q_xBuLight	:= FALSE;				
		q_sResultText := 'Red Steady';

	EN_EZL_RDFlash:
		q_xRdLight := TRUE;
		q_xGnLight := TRUE;
		q_xYwLight	:= FALSE;
  		q_xBuLight	:= FALSE;		
		q_sResultText := 'Red Flashing';

	EN_EZL_YWSteady:
		q_xYwLight := TRUE;
		q_xGnLight	:= FALSE;
  		q_xRdLight	:= FALSE;
  		q_xBuLight	:= FALSE;
		q_sResultText := 'Yellow Steady';

	EN_EZL_YWFlash:
		q_xYwLight :=TRUE;
		q_xRdLight := TRUE;
		q_xBuLight	:= FALSE;
  		q_xGnLight	:= FALSE;		
		q_sResultText := 'Yellow Flashing';

	EN_EZL_BUSteady:
		q_xBuLight := TRUE;
		q_xGnLight	:= FALSE;
  		q_xRdLight	:= FALSE;
  		q_xYwLight	:= FALSE;				
		q_sResultText := 'Blue Steady';

	EN_EZL_BUFlash:
		q_xBuLight := TRUE;
		q_xRdLight := TRUE;
		q_xYwLight	:= FALSE;
  		q_xGnLight	:= FALSE;		
		q_sResultText := 'Blue Flashing';

	EN_EZL_AltGnRd:
		q_xGnLight := TRUE;
		q_xBuLight := TRUE;
		q_xYwLight	:= FALSE;
  		q_xRdLight	:= FALSE;		
		q_sResultText := 'Alternating Green and Red';

	EN_EZL_AltRdBu:
		q_xYwLight := TRUE;
		q_xBuLight := TRUE;
		q_xGnLight	:= FALSE;
  		q_xRdLight	:= FALSE;		
		q_sResultText := 'Alternating Red and Blue';

	EN_EZL_AltGnYw:
		q_xGnLight := TRUE;
		q_xYwLight := TRUE;
		q_xBuLight := TRUE;
		q_xRdLight	:= FALSE;
		q_sResultText := 'Alternating Green and Yellow';

	EN_EZL_AltGnBu:
		q_xGnLight := TRUE;
		q_xRdLight := TRUE;
		q_xBuLight := TRUE;
		q_xYwLight	:= FALSE;
		q_sResultText := 'Alternating Green and Blue';

	EN_EZL_AltRdYw:
		q_xRdLight := TRUE;
		q_xYwLight := TRUE;
		q_xBuLight := TRUE;
		q_xGnLight	:= FALSE;
		q_sResultText := 'Alternating Red and Yellow';

	EN_EZL_AltYwBu:
		q_xGnLight := TRUE;
		q_xRdLight := TRUE;
		q_xYwLight := TRUE;
		q_xBuLight	:= FALSE;
		q_sResultText := 'Alternating Yellow and Blue';

	EN_EZL_AltGnRdYwBu:
		q_xGnLight := TRUE;
		q_xRdLight := TRUE;
		q_xYwLight := TRUE;
		q_xBuLight := TRUE;
		q_sResultText := 'Alternating Green, Red, Yellow and Blue';

	EN_EZL_AllOff:
		q_xGnLight := FALSE;
		q_xRdLight := FALSE;
		q_xYwLight := FALSE;
		q_xBuLight := FALSE;
		q_sResultText := 'All Off';

END_CASE

END_FUNCTION_BLOCK
