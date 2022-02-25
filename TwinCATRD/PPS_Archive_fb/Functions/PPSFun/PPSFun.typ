(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPSFun
 * File: PPSFun.typ
 * Author: Paul Zurlinden
 * Created: November 03, 2010
 ********************************************************************
 * Data types of library PPSFun
 ********************************************************************)

TYPE
	dtEasyLight_Outputs : 	STRUCT 
		xCmdActive : BOOL;
		diResult : DINT;
		sResultText : STRING[41];
	END_STRUCT;
	dtEasyLight_InputOutput : 	STRUCT 
		diCmd : DINT;
	END_STRUCT;
	dtEasyLightInterface : 	STRUCT 
		Q : dtEasyLight_Outputs;
		IQ : dtEasyLight_InputOutput;
	END_STRUCT;
	dtVacCupInputs : 	STRUCT 
		xEnable : BOOL;
		xEnManCntrl : BOOL;
		xManCmd : BOOL;
		tPurgeTime : TIME;
		xEmergency : BOOL;
	END_STRUCT;
	dtVacCupInputs2 : 	STRUCT 
		xEnable : BOOL;
		xEnManCntrl : BOOL;
		xManCmd : BOOL;
		tPurgeTime : TIME;
		xEmergency : BOOL;
		sName : STRING[40];
		xMonitored : BOOL;
		tMonitorDelay : TIME;
	END_STRUCT;
	dtVacCup_InOut2 : 	STRUCT 
		xAutoOn : BOOL;
		xAutoOff : BOOL;
		xClearFault : BOOL;
	END_STRUCT;
	dtVacCup_InOut : 	STRUCT 
		xAutoOn : BOOL;
		xAutoOff : BOOL;
	END_STRUCT;
	dtVacCupOuputs : 	STRUCT 
		xFBActive : BOOL;
		xSVPurge : BOOL;
		xSVVac : BOOL;
	END_STRUCT;
	dtVacCupOuputs2 : 	STRUCT 
		xFBActive : BOOL;
		xSVPurge : BOOL;
		xSVVac : BOOL;
		xFault : BOOL;
		sFaultTxt : STRING[82];
	END_STRUCT;
	dtVacuumCupInterface : 	STRUCT 
		I : dtVacCupInputs;
		IQ : dtVacCup_InOut;
		Q : dtVacCupOuputs;
	END_STRUCT;
	dtVacuumCupInterface2 : 	STRUCT 
		I : dtVacCupInputs2;
		IQ : dtVacCup_InOut2;
		Monitor : dtDebounceInterface;
		Q : dtVacCupOuputs2;
		stErrData : dtFB_ErrorData;
	END_STRUCT;
	EnumerationEasyLight : 
		(
		EN_EZL_GNSteady := 1,
		EN_EZL_RDSteady := 2,
		EN_EZL_YWSteady := 3,
		EN_EZL_BUSteady := 4,
		EN_EZL_GNFlash := 5,
		EN_EZL_RDFlash := 6,
		EN_EZL_YWFlash := 7,
		EN_EZL_BUFlash := 8,
		EN_EZL_AltGnRd := 9,
		EN_EZL_AltRdBu := 10,
		EN_EZL_AltGnYw := 11,
		EN_EZL_AltGnBu := 12,
		EN_EZL_AltRdYw := 13,
		EN_EZL_AltYwBu := 14,
		EN_EZL_AltGnRdYwBu := 15,
		EN_EZL_AllOff := 16
		);
	dtGlueApplictor : 	STRUCT 
		xEnable : BOOL;
		xApplyCmd : BOOL;
		xEnManual : BOOL;
		xManPurgeCmd : BOOL;
		tPurgeTime : TIME;
		xEmergency : BOOL;
	END_STRUCT;
	dtDigCntrlInterface : 	STRUCT 
		I : dtDigCntrl_Inputs;
		IQ : dtDigCntrl_InOut;
		Q : dtDigCntrl_Outputs;
		stMonitor : dtDebounceInterface;
		stErrData : dtFB_ErrorData;
	END_STRUCT;
	dtDigCntrl_Inputs : 	STRUCT 
		xEnManCntrl : BOOL;
		xManCmd : BOOL;
		xEmergency : BOOL;
		xEnMonitor : BOOL;
		tMonitorDelay : TIME;
	END_STRUCT;
	dtDigCntrl_InOut : 	STRUCT 
		xAutoOn : BOOL;
		xAutoOff : BOOL;
		xFaultReset : BOOL;
	END_STRUCT;
	dtDigCntrl_Outputs : 	STRUCT 
		xCmd : BOOL;
		xFault : BOOL;
	END_STRUCT;
	dtFB_ErrorData : 	STRUCT 
		uiErrorID : UINT;
		sErrorString : STRING[80];
		sSourceName : STRING[80];
	END_STRUCT;
	dtDebounceInterface : 	STRUCT 
		I : dtDebounce_Inputs;
		Q : dtDebounce_Outputs;
	END_STRUCT;
	dtDebounce_Inputs : 	STRUCT 
		xSignal : BOOL;
		tOnDelay : TIME;
		tOffDelay : TIME;
	END_STRUCT;
	dtDebounce_Outputs : 	STRUCT 
		xCmd : BOOL;
		tOnTimer : TIME;
		tOffTimer : TIME;
	END_STRUCT;
	dtCylCntrlInterface : 	STRUCT 
		I : dtCylCntrl_Inputs;
		IQ : dtCylCntrl_InOut;
		Q : dtCylCntrl_Outputs;
		stSensorExt : dtDebounceInterface;
		stSensorRet : dtDebounceInterface;
	END_STRUCT;
	dtCylCntrl_Inputs : 	STRUCT 
		xEnableFB : BOOL;
		xValveOffRetract : BOOL;
		xAirOk : BOOL;
		xEnManCntrl : BOOL;
		xManCmd : BOOL;
		xEmergency : BOOL;
		xEnMonitor : BOOL;
		usiHWFamily : USINT;
		tTravelDel : TIME;
		xFaultReset : BOOL;
	END_STRUCT;
	dtCylCntrl_InOut : 	STRUCT 
		xExtCmd : BOOL;
		xRetCmd : BOOL;
	END_STRUCT;
	dtCylCntrl_Outputs : 	STRUCT 
		xFBActive : BOOL;
		xSVCmd : BOOL;
		xExtended : BOOL;
		xRetracted : BOOL;
		xFaultNoExt : BOOL;
		xFaultNoRet : BOOL;
	END_STRUCT;
END_TYPE
