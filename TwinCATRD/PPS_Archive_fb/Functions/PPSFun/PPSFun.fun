(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: PPSFun.fun
 * Author: Paul Zurlinden
 * Created: November 03, 2010
 ********************************************************************
 * Functions and function blocks of library PPSFun
 ********************************************************************)

FUNCTION_BLOCK FB_Debounce (*Filter an input with On and Off delays*)
	VAR_IN_OUT
		iq_DebounceInterface : dtDebounceInterface;
	END_VAR
	VAR
		tmrOn : TON;
		tmrOff : TOF;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_Toggle (*Monitors momentary input and toggles the output*)
	VAR_INPUT
		i_xMomentary : BOOL;
		i_xEmergency : BOOL;
	END_VAR
	VAR_OUTPUT
		q_xCMD : BOOL;
	END_VAR
	VAR
		counter : CTU;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_DigCntrl
	VAR_IN_OUT
		iq_DigCntrlInterface : dtDigCntrlInterface;
	END_VAR
	VAR
		RT : R_TRIG;
		Timer : TON;
		FB_MonitorDebounce : FB_Debounce;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_CylCntrl (*Controls a pneumatic cylinder with or without end of travel sensors*)
	VAR_IN_OUT
		iq_CylCntrlInterface : dtCylCntrlInterface;
	END_VAR
	VAR
		RT : R_TRIG;
		Timer : TON;
		RT_Air : R_TRIG;
		xFaultSum : BOOL;
		aFB_SensExt : ARRAY[0..1] OF FB_Debounce;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_EZLight (*Controls Banner Light K50LGRYB4PQ*)
	VAR_OUTPUT
		q_xCmdActive : BOOL;
		q_diResult : DINT;
		q_sResultText : STRING[41];
		q_xLightActive : BOOL;
		q_xGnLight : BOOL;
		q_xRdLight : BOOL;
		q_xYwLight : BOOL;
		q_xBuLight : BOOL;
	END_VAR
	VAR_IN_OUT
		iq_diCmd : DINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_GlueApplicator (*Controls Glue Applicator for Auto and Manual Mode*)
	VAR_INPUT
		i_xEnable : BOOL;
		i_xApplyCmd : BOOL;
		i_xEnManual : BOOL;
		i_xManPurgeCmd : BOOL;
		i_tPurgeTime : TIME;
		i_xEmergency : BOOL;
	END_VAR
	VAR_OUTPUT
		q_xApplicatorEnable : BOOL;
	END_VAR
	VAR
		RT : R_TRIG;
		Timer : TON;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_VacCup (*Controls a vacuum cup with purge*)
	VAR_IN_OUT
		iq_VacCupInterface : dtVacuumCupInterface;
	END_VAR
	VAR
		Timer : TON;
		RT : R_TRIG;
		FT : F_TRIG;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_Flasher (*Flasher*)
	VAR_INPUT
		i_xSignal : BOOL;
		i_tOn : TIME;
		i_tOff : TIME;
	END_VAR
	VAR_OUTPUT
		q_xFlash : BOOL;
	END_VAR
	VAR
		tmrOn : TON;
		tmrOff : TOF;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_VacCup2 (*Controls seperate valves for vacuum and purge, impliments a monitoring input.*)
	VAR_IN_OUT
		iq_VacCupInterface : dtVacuumCupInterface2;
	END_VAR
	VAR
		Timer : TON;
		RT : R_TRIG;
		FT : F_TRIG;
		tmrMon : TON;
		ifbMonitor : FB_Debounce;
		xHadVac : BOOL;
	END_VAR
END_FUNCTION_BLOCK
