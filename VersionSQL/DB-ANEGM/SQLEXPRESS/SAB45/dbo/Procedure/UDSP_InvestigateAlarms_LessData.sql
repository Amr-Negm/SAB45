/****** Object:  Procedure [dbo].[UDSP_InvestigateAlarms_LessData]    Committed by VersionSQL https://www.versionsql.com ******/

/****** Object:  StoredProcedure [dbo].[UDSP_InvestigateAlarms_LessData]    Script Date: 12/12/2021 11:30:32 AM ******/

CREATE procedure  [dbo].[UDSP_InvestigateAlarms_LessData]  
		  @InvestigatAlarmsTableType InvestigatAlarmsTableType2 READONLY
		, @AlarmCategoryIDs			NVARCHAR(MAX) = NULL
		, @AlarmClassificationIDs 	NVARCHAR(MAX) = NULL
		, @AlarmDefinitionIDs		NVARCHAR(MAX) = NULL
		, @AlarmStatus				NVARCHAR(MAX) = NULL
		, @LocationIDs				NVARCHAR(MAX) = NULL
		, @LocationTypeIDs			NVARCHAR(MAX) = NULL
		, @EventDefinitionIDs		NVARCHAR(MAX) = NULL
		, @TPIDs					NVARCHAR(MAX) = NULL
		, @TPTypeIDs				NVARCHAR(MAX) = NULL
		, @AlarmCode				NVARCHAR(MAX) = NULL
		, @PageNo					INT			  = 1
		, @PageSize					INT			  = 500000
		, @SortBy					NVARCHAR(MAX) = NULL
		, @SortType					NVARCHAR(MAX) = NULL
		, @Date_from				NVARCHAR(MAX) = '1900-08-01 00:00:00'
		, @Date_to					NVARCHAR(MAX) = '3021-08-01 23:59:59'
		, @TransitionStatus			NVARCHAR(MAX) = NULL
		, @CADStatus				NVARCHAR(MAX) = NULL
		, @x						NVARCHAR(MAX) = NULL
	
		AS
			
DECLARE @w nvarchar(50)
SELECT @w = CONCAT(YEAR(GETDATE()),'-',MONTH(GETDATE()),'-',DAY(GETDATE()))

DECLARE @TimeStamp bigint
SET @TimeStamp = DATEDIFF(MILLISECOND, @w, GETDATE())

INSERT [dbo].InvestigatAlarmsTableType_Temp2  (
[AlarmCategoryID] ,
	[EventParmKey] ,
	[StringValue] ,
	[TimeStamp]
	)
SELECT 
[AlarmCategoryID] ,
	[EventParmKey] ,
	[StringValue] ,
	@TimeStamp
	FROM @InvestigatAlarmsTableType

DECLARE @CCount bigint

SELECT @CCount = COUNT(*) FROM InvestigatAlarmsTableType_Temp2 WHERE [TimeStamp] = @TimeStamp

set @PageNo  = @PageNo -1;

if (@AlarmCategoryIDs is null or @AlarmCategoryIDs = '')
set @AlarmCategoryIDs = ' = AD.AlarmCategoryID '
else  set @AlarmCategoryIDs = ' in ' + @AlarmCategoryIDs;

if (@AlarmClassificationIDs is null or @AlarmClassificationIDs = '')
set @AlarmClassificationIDs = ' = A.AlarmClassificationID '
else set @AlarmClassificationIDs = ' in ' + @AlarmClassificationIDs;

if (@AlarmDefinitionIDs is null or @AlarmDefinitionIDs = '') 
set @AlarmDefinitionIDs = ' = A.AlarmsDefinitionID '
else set @AlarmDefinitionIDs = ' in ' + @AlarmDefinitionIDs;

if (@AlarmStatus is null or @AlarmStatus = '')
set @AlarmStatus = ' = A.AlarmStatusID '
else set @AlarmStatus = ' in ' + @AlarmStatus;

if (@LocationIDs is null or @LocationIDs = '')
set @x = ' = ISNULL(EPL.STRINGVALUE,0) ' 
else  set @x = ' in ' + @LocationIDs

if (@LocationIDs is null or @LocationIDs = '')  
set @LocationIDs = ' = ISNULL(L1.LocationID,0) ' 
else  set @LocationIDs = ' in ' + @LocationIDs

if (@LocationTypeIDs is null or @LocationTypeIDs = '')
set @LocationTypeIDs = ' = ISNULL(L1.LocationTypeID,0) ' 
else  set @LocationTypeIDs = ' in ' + @LocationTypeIDs

if (@EventDefinitionIDs is null or @EventDefinitionIDs = '')  
set @EventDefinitionIDs = ' = ISNULL(E.EventDefinitionID,0) ' 
else  set @EventDefinitionIDs = ' in ' + @EventDefinitionIDs

if (@TPIDs is null or @TPIDs = '')
set @TPIDs = ' = ISNULL(TP.TouchPointID,0) '
else  set @TPIDs = ' in ' + @TPIDs;

if (@TPTypeIDs is null or @TPTypeIDs = '')  
set @TPTypeIDs = ' = ISNULL(TP.TouchPointTypeID,0) ' 
else  set @TPTypeIDs = ' in ' + @TPTypeIDs;

if (@TPIDs is not null or @TPIDs <> '')  set @TPTypeIDs = ' = ISNULL(TP.TouchPointTypeID,0) ';

if (@AlarmCode is null or @AlarmCode = '')
set @AlarmCode = ' = A.AlarmCode '
else  set @AlarmCode = ' in ' + @AlarmCode;

if (@TransitionStatus is null or @TransitionStatus = '')
set @TransitionStatus = ' = ISNULL(A.TransitionStatusID,0) '
else  set @TransitionStatus = ' in ' + @TransitionStatus;

if (@CADStatus is null or @CADStatus = '')
set @CADStatus = ' = ISNULL(A.LatestCADStatusID,0) '
else  set @CADStatus = ' in ' + @CADStatus;

IF (@SortBy is null or @SortBy = '')  SET @SortBy = 'Occurance_Date'

IF (@SortType is null or @SortType = '')  SET @SortType = 'ASC'

IF (@CCount > 0)

BEGIN

EXECUTE (
'
select DISTINCT
A.AlarmID ,
E.eventid,
A.AlarmStatusID ,
AStatus.AlarmStatusTitle1,
AD.AlarmCategoryID,
ACat.AlarmCategoryTitle1,
A.AlarmClassificationID,
AClass.AlarmClassificationTitle1, 
A.AlarmCode,  
AD.AlarmDefinitionID ,
AD.AlarmDefinitionTitle1 ,
A.Occurance_Date ,
a.[Response_User],
a.[Response_Date],
TP.TouchPointTitle1 AS TouchpointName, 
TP.TouchPointTypeID,
L1.LocationID AS TouchpointLocationId, 
L1.Name AS TouchpointLocationName,
L2.LocationID AS ParentLocationId, 
L2.Name AS ParentLocationName,
ED.EventDefinitionTitle1 AS EventName,
S.[ScenarioTitle1]

FROM		T_Alarms				A
LEFT JOIN	LT_AlarmStatuses		AStatus	ON A.AlarmStatusID = AStatus.AlarmStatusID
LEFT JOIN	LT_AlarmClassifications	AClass	ON A.AlarmClassificationID = AClass.AlarmClassificationID
LEFT JOIN	T_AlarmDefinitions		AD		ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	LT_AlarmCategories		ACat	ON AD.AlarmCategoryID = ACat.AlarmCategoryID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
LEFT join   T_EventParms			EP	ON E.EventID = EP.EventID
LEFT JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT join   T_EventParms			EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId'' AND ED.TouchPointIDSource IS NULL
LEFT join   T_EventParms			EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' AND ED.TouchPointIDSource IS NULL
LEFT JOIN	T_TouchPoints			TP	ON ISNULL(ED.TouchPointIDSource,EPT.STRINGVALUE) = TP.TouchPointID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
LEFT JOIN	T_Location				L1	ON ISNULL(TL.LocationID,EPL.STRINGVALUE) = L1.LocationID
LEFT JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
LEFT JOIN   T_AlarmScenarios		ALS ON ALS.[AlarmID] = A.[AlarmID]
LEFT JOIN   [T_Scenarios]			S	ON S.[ScenarioID] = ALS.[ScenarioID]
LEFT JOIN   LT_CADStatus            CS  ON CS.CADStatusID = A.LatestCADStatusID
LEFT JOIN   LT_TransitionStatus     TS  ON TS.TransitionStatusID = A.TransitionStatusID
JOIN	InvestigatAlarmsTableType_Temp2	TVIA	ON EP.EventParmKey LIKE CONCAT(''%'', TVIA.EventParmKey, ''%'') AND EP.StringValue LIKE CONCAT(''%'', TVIA.StringValue, ''%'') AND AD.AlarmCategoryID LIKE CONCAT(''%'', TVIA.AlarmCategoryID, ''%'') AND TVIA.TimeStamp = '+@TimeStamp+'

WHERE 
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+'''  AND
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) AND
ISNULL(TL.StateID,1) = 1 AND
AD.AlarmCategoryID      '+@AlarmCategoryIDs+'    AND
A.AlarmClassificationID '+@AlarmClassificationIDs+'   AND
A.AlarmsDefinitionID    '+@AlarmDefinitionIDs+'	 AND 
A.AlarmStatusID	        '+@AlarmStatus+'	AND 
ISNULL(E.EventDefinitionID,0)		'+@EventDefinitionIDs+'	AND
ISNULL(L1.LocationTypeID,0)		'+@LocationTypeIDs+'	AND
ISNULL(EPL.STRINGVALUE,0) '+@x+' AND
A.AlarmCode             '+@AlarmCode+' AND
ISNULL(A.LatestCADStatusID,0)             '+@CADStatus+'   AND
ISNULL(A.TransitionStatusID,0)             '+@TransitionStatus+' 
ORDER BY '+@SortBy+' '+@SortType+'
OFFSET '+@PageNo+'*'+@PageSize+' ROWS 
FETCH NEXT '+@PageSize+' ROWS ONLY'
)

END

ELSE

BEGIN

EXECUTE (
'
select DISTINCT
A.AlarmID ,
E.eventid,
A.AlarmStatusID ,
AStatus.AlarmStatusTitle1,
AD.AlarmCategoryID,
ACat.AlarmCategoryTitle1,
A.AlarmClassificationID,
AClass.AlarmClassificationTitle1, 
A.AlarmCode,  
AD.AlarmDefinitionID ,
AD.AlarmDefinitionTitle1 ,
A.Occurance_Date ,
a.[Response_User],
a.[Response_Date],
TP.TouchPointTitle1 AS TouchpointName, 
TP.TouchPointTypeID,
L1.LocationID AS TouchpointLocationId, 
L1.Name AS TouchpointLocationName,
L2.LocationID AS ParentLocationId, 
L2.Name AS ParentLocationName,
ED.EventDefinitionTitle1 AS EventName,
S.[ScenarioTitle1]

FROM	T_Alarms A
LEFT JOIN	LT_AlarmStatuses		AStatus	ON A.AlarmStatusID = AStatus.AlarmStatusID 
LEFT JOIN	LT_AlarmClassifications	AClass	ON A.AlarmClassificationID = AClass.AlarmClassificationID
LEFT JOIN	T_AlarmDefinitions		AD		ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	LT_AlarmCategories		ACat	ON AD.AlarmCategoryID = ACat.AlarmCategoryID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
LEFT join   T_EventParms			EP	ON E.EventID = EP.EventID
LEFT JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT join   T_EventParms			EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId'' AND ED.TouchPointIDSource IS NULL
LEFT join   T_EventParms			EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' AND ED.TouchPointIDSource IS NULL
LEFT JOIN	T_TouchPoints			TP	ON ISNULL(ED.TouchPointIDSource,EPT.STRINGVALUE) = TP.TouchPointID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
LEFT JOIN	T_Location				L1	ON ISNULL(TL.LocationID,EPL.STRINGVALUE) = L1.LocationID
LEFT JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
LEFT JOIN   T_AlarmScenarios		ALS ON ALS.[AlarmID] = A.[AlarmID]
LEFT JOIN   [T_Scenarios]			S	ON S.[ScenarioID] = ALS.[ScenarioID]
LEFT JOIN   LT_CADStatus            CS  ON CS.CADStatusID = A.LatestCADStatusID
LEFT JOIN   LT_TransitionStatus     TS  ON TS.TransitionStatusID = A.TransitionStatusID

WHERE 
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+'''  AND
A.AlarmClassificationID '+@AlarmClassificationIDs+'   AND
A.AlarmsDefinitionID    '+@AlarmDefinitionIDs+'	 AND 
A.AlarmStatusID	        '+@AlarmStatus+'	AND 
A.AlarmCode             '+@AlarmCode+' AND
ISNULL(A.LatestCADStatusID,0)             '+@CADStatus+'   AND
ISNULL(A.TransitionStatusID,0)             '+@TransitionStatus+' AND
ISNULL(L1.LocationID,0)		'+@LocationIDs+'	AND
ISNULL(E.EventDefinitionID,0)		'+@EventDefinitionIDs+'	AND
ISNULL(L1.LocationTypeID,0)		'+@LocationTypeIDs+'	AND
ISNULL(TP.TouchPointID,0)			'+@TPIDs+'	AND
ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'	AND
ISNULL(TL.StateID,1) = 1 AND
ISNULL(A.LatestCADStatusID,0)             '+@CADStatus+'   AND
ISNULL(A.TransitionStatusID,0)             '+@TransitionStatus+' AND
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) AND
AD.AlarmCategoryID      '+@AlarmCategoryIDs+'    
ORDER BY '+@SortBy+' '+@SortType+'
OFFSET '+@PageNo+'*'+@PageSize+' ROWS 
FETCH NEXT '+@PageSize+' ROWS ONLY'

)

END

DELETE InvestigatAlarmsTableType_Temp2 WHERE TimeStamp = @TimeStamp