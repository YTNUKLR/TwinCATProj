(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: PPS_Cyl.fun
 * Author: PaulZ
 * Created: April 16, 2012
 ********************************************************************
 * Functions and function blocks of library PPS_Cyl
 ********************************************************************)

FUNCTION_BLOCK FB_CylCntrl2 (*Controls a pneumatic cylinder with or without end of travel sensors*)
	VAR_IN_OUT
		iq_CylCntrlInterface : dtCylCntrlInterface2;
	END_VAR
	VAR
		RT : R_TRIG;
		RT_B : R_TRIG;
		xManCmdB : BOOL;
		RT_Brake : R_TRIG;
		xManBrake : BOOL;
		xManCmd : BOOL;
		Timer : TON;
		RT_Air : R_TRIG;
		FT_Air : F_TRIG;
		xFaultSum : BOOL;
		aFB_SensExt : ARRAY[0..1] OF FB_Debounce;
		RT_SensExt : R_TRIG;
		RT_SensRet : R_TRIG;
		xMonitor : BOOL;
		iCheckAir : INT;
		x2xSV : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION FC_CylFM_1xSV_Basic : BOOL (*Monitors Cylinder Fault for Single SV Cylinder*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_1xSV_Basic3 : BOOL (*Monitors Cylinder Fault for Single SV Cylinder*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_1xSV_Sensored : BOOL (*Monitors Cylinder Fault for Single SV Cylinder with Sensors*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
	VAR
		xFaultSum : BOOL;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_1xSV_Sensored3 : BOOL (*Monitors Cylinder Fault for Single SV Cylinder with Sensors*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
	VAR
		xFaultSum : BOOL;
		sNoExtTxt : STRING[80] := ' did not extend';
		sNoRetTxt : STRING[80] := ' did not retract';
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Basic_NoBrake : BOOL (*Monitors Cylinder Fault for Double SV Cylinder*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Basic_NoBrake3 : BOOL (*Monitors Cylinder Fault for Double SV Cylinder*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Sensored_NoBrake : BOOL (*Monitors Cylinder Fault for Double SV Cylinder with Sensor and no Brake*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
	VAR
		xFaultSum : BOOL;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Sensored_NoBrake3 : BOOL (*Monitors Cylinder Fault for Double SV Cylinder with Sensor and no Brake*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
	VAR
		xFaultSum : BOOL;
		sNoExtTxt : STRING[80] := ' did not extend';
		sNoRetTxt : STRING[80] := ' did not retract';
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Sensored_wBrake : BOOL (*Monitors Cylinder Fault for Double SV Cylinder with Sensors and Brake*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
	VAR
		xFaultSum : BOOL;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Sensored_wBrake3 : BOOL (*Monitors Cylinder Fault for Double SV Cylinder with Sensors and Brake*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
	VAR
		xFaultSum : BOOL;
		sNoExtTxt : STRING[80] := ' did not extend';
		sNoRetTxt : STRING[80] := ' did not retract';
	END_VAR
END_FUNCTION

FUNCTION FC_CylQ_1xSV : BOOL (*Controls the outputs for a Single SV Cylinder*)
	VAR_INPUT
		xManCmd : BOOL;
	END_VAR
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylQ_1xSV3 : BOOL (*Controls the outputs for a Single SV Cylinder*)
	VAR_INPUT
		xManCmd : BOOL;
	END_VAR
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylQ_2xSV_NoBrake : BOOL (*Controls the outputs for a Doube SV Cylinder, no Brake*)
	VAR_INPUT
		xManCmd : BOOL;
		xManCmdB : BOOL;
	END_VAR
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylQ_2xSV_NoBrake3 : BOOL (*Controls the outputs for a Doube SV Cylinder, no Brake*)
	VAR_INPUT
		xManCmd : BOOL;
		xManCmdB : BOOL;
	END_VAR
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylQ_2xSV_wBrake : BOOL (*Controls the outputs for a Doube SV Cylinder, with Brake*)
	VAR_INPUT
		xManCmd : BOOL;
		xManCmdB : BOOL;
		xManBrake : BOOL;
	END_VAR
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylQ_2xSV_wBrake3 : BOOL (*Controls the outputs for a Doube SV Cylinder, with Brake*)
	VAR_INPUT
		xManCmd : BOOL;
		xManCmdB : BOOL;
		xManBrake : BOOL;
	END_VAR
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Basic_wBrake : BOOL (*Monitors faults for a 2x SV, no Sensors, with Brake*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface2;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION FC_CylFM_2xSV_Basic_wBrake3 : BOOL (*Monitors faults for a 2x SV, no Sensors, with Brake*)
	VAR_IN_OUT
		iq_Cyl : dtCylCntrlInterface3;
		iq_Timer : TON;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK FB_CylCntrl3 (*Controls a pneumatic cylinder*)
	VAR_IN_OUT
		iq_CylCntrlInterface : dtCylCntrlInterface3;
	END_VAR
	VAR
		RT : R_TRIG;
		RT_B : R_TRIG;
		xManCmdB : BOOL;
		RT_Brake : R_TRIG;
		xManBrake : BOOL;
		xManCmd : BOOL;
		Timer : TON;
		RT_Air : R_TRIG;
		FT_Air : F_TRIG;
		xFaultSum : BOOL;
		aFB_SensExt : ARRAY[0..1] OF FB_Debounce;
		RT_SensExt : R_TRIG;
		RT_SensRet : R_TRIG;
		xMonitor : BOOL;
		iCheckAir : INT;
		x2xSV : BOOL;
	END_VAR
END_FUNCTION_BLOCK
