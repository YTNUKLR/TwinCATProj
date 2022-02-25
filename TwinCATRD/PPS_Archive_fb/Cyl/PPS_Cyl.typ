(********************************************************************
 * COPYRIGHT -- Pro Pack Systems, Inc.
 ********************************************************************
 * Library: PPS_Cyl
 * File: PPS_Cyl.typ
 * Author: PaulZ
 * Created: April 16, 2012
 ********************************************************************
 * Data types of library PPS_Cyl
 ********************************************************************)

TYPE
	dtCylCntrlInterface2 : 	STRUCT 
		I : dtCylCntrl_Inputs2;
		IQ : dtCylCntrl_InOut2;
		Q : dtCylCntrl_Outputs2;
		stSensorExt : dtDebounceInterface;
		stSensorRet : dtDebounceInterface;
	END_STRUCT;
	dtCylCntrlInterface3 : 	STRUCT 
		I : dtCylCntrl_Inputs3;
		IQ : dtCylCntrl_InOut3;
		Q : dtCylCntrl_Outputs3;
		stSensorExt : dtDebounceInterface;
		stSensorRet : dtDebounceInterface;
		stErrData : dtCylCntrl_ErrorData;
	END_STRUCT;
	dtCylCntrl_Inputs2 : 	STRUCT 
		xEnableFB : BOOL;
		diType : Enum_CylinderType;
		xValveOffRetract : BOOL;
		xAirOk : BOOL;
		xEnManCntrl : BOOL;
		xManCmdA : BOOL;
		xManCmdB : BOOL;
		xManBrake : BOOL;
		xEmergency : BOOL;
		tTravelDel : TIME;
		xFaultReset : BOOL;
	END_STRUCT;
	dtCylCntrl_Inputs3 : 	STRUCT 
		xEnableFB : BOOL;
		diType : Enum_CylinderType;
		xValveOffRetract : BOOL;
		xAirOk : BOOL;
		xEnManCntrl : BOOL;
		xManCmdA : BOOL;
		xManCmdB : BOOL;
		xManBrake : BOOL;
		xEmergency : BOOL;
		tTravelDel : TIME;
		sCylName : STRING[80];
	END_STRUCT;
	dtCylCntrl_InOut2 : 	STRUCT 
		xExtCmd : BOOL;
		xRetCmd : BOOL;
		xBrakeEn : BOOL;
		xBrakeDis : BOOL;
	END_STRUCT;
	dtCylCntrl_InOut3 : 	STRUCT 
		xExtCmd : BOOL;
		xRetCmd : BOOL;
		xBrakeEn : BOOL;
		xBrakeDis : BOOL;
		xFaultReset : BOOL;
	END_STRUCT;
	dtCylCntrl_Outputs2 : 	STRUCT 
		xFBActive : BOOL;
		xSVACmd : BOOL;
		xSVBCmd : BOOL;
		xSVBrakeCmd : BOOL;
		xExtended : BOOL;
		xRetracted : BOOL;
		xFaultNoExt : BOOL;
		xFaultNoRet : BOOL;
		tTimeToExtend : TIME;
		tTimeToRetract : TIME;
	END_STRUCT;
	dtCylCntrl_Outputs3 : 	STRUCT 
		xFBActive : BOOL;
		xSVACmd : BOOL;
		xSVBCmd : BOOL;
		xSVBrakeCmd : BOOL;
		xExtended : BOOL;
		xRetracted : BOOL;
		xFault : BOOL;
		sFaultText : STRING[80];
		tTimeToExtend : TIME;
		tTimeToRetract : TIME;
	END_STRUCT;
	dtCylCntrl_ErrorData : 	STRUCT 
		uiErrorID : UINT;
	END_STRUCT;
	Enum_CylinderType : 
		(
		EN_Cyl_1xSV_Basic := 0,
		EN_Cyl_1xSV_Sensored,
		EN_Cyl_2xSV_Basic_NoBrake,
		EN_Cyl_2xSV_Basic_WBrake,
		EN_Cyl_2xSV_Sensored_NoBrake,
		EN_Cyl_2xSV_Sensored_WBrake
		);
END_TYPE
