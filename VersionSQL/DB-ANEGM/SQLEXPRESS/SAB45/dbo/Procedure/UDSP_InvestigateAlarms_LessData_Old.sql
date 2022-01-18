/****** Object:  Procedure [dbo].[UDSP_InvestigateAlarms_LessData_Old]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure  [dbo].[UDSP_InvestigateAlarms_LessData_Old] 
		  @InvestigatAlarmsTableType InvestigatAlarmsTableType2 READONLY
		, @AlarmCategoryIDs			NVARCHAR(MAX) = NULL
		, @AlarmClassificationIDs 	NVARCHAR(MAX) = NULL
		, @AlarmDefinitionIDs		NVARCHAR(MAX) = NULL
		, @AlarmStatus				NVARCHAR(MAX) = NULL
		, @LocationIDs				NVARCHAR(MAX) = NULL
		, @TPIDs					NVARCHAR(MAX) = NULL
		, @TPTypeIDs				NVARCHAR(MAX) = NULL
		, @AlarmCode				NVARCHAR(MAX) = NULL
		, @PageNo					INT			  = 1
		, @PageSize					INT			  = 500000
		, @SortBy					NVARCHAR(MAX) = NULL
		, @SortType					NVARCHAR(MAX) = NULL
		, @Date_from				NVARCHAR(MAX) = '2021-08-01 23:44:00'
		, @Date_to					NVARCHAR(MAX) = '2021-08-01 23:59:59'
		, @x						NVARCHAR(MAX) = NULL
	
		AS
		
BEGIN TRY  
    DROP TABLE InvestigatAlarmsTableType_Temp
END TRY  
BEGIN CATCH  

END CATCH  

SELECT * INTO InvestigatAlarmsTableType_Temp FROM @InvestigatAlarmsTableType

Declare @result table (
AlarmID INT,
EventID int ,
AlarmStatusID INT,
AlarmStatusTitle1 NVARCHAR(250),
AlarmCategoryID INT,
AlarmCategoryTitle1 NVARCHAR(250),
AlarmClassificationID INT,
AlarmClassificationTitle1 NVARCHAR(250),  
AlarmCode NVARCHAR(250),  
AlarmDefinitionID INT,
AlarmDefinitionTitle1 NVARCHAR(250),
Occurance_Date DATETIME,
Response_User NVARCHAR(250),
Response_Date DATETIME,
TouchpointName NVARCHAR(250), 
TouchPointTypeID int ,
TouchpointLocationId INT, 
TouchpointLocationName NVARCHAR(250),
ParentLocationId INT, 
ParentLocationName NVARCHAR(250),
EventName NVARCHAR(250),
[ScenarioTitle1] NVARCHAR(250)

)

DECLARE @CCount bigint

SELECT @CCount = COUNT(*) FROM InvestigatAlarmsTableType_Temp

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

if (@TPIDs is null or @TPIDs = '')
set @TPIDs = ' = ISNULL(TP.TouchPointID,0) '
else  set @TPIDs = ' in ' + @TPIDs;

if (@TPTypeIDs is null or @TPTypeIDs = '')  
set @TPTypeIDs = ' = ISNULL(TP.TouchPointTypeID,0) ' 
else  set @TPTypeIDs = ' in ' + @TPTypeIDs;

if (@TPIDs is not null or @TPIDs <> '')  set @TPTypeIDs = ' = ISNULL(TP.TouchPointTypeID,0) ';

--if (@AlarmCode is null or @AlarmCode = '')  set @AlarmCode = ' = A.AlarmCode '
if (@AlarmCode is null or @AlarmCode = '')
set @AlarmCode = ' = A.AlarmCode '
else  set @AlarmCode = ' in ' + @AlarmCode;

IF (@CCount > 0)

BEGIN

--declare @sqlCmd nvarchar(4000) =
INSERT INTO @result
execute (
'
select 
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
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	LT_AlarmCategories		ACat	ON AD.AlarmCategoryID = ACat.AlarmCategoryID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
LEFT JOIN   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID and TL.stateid=1
LEFT JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
LEFT JOIN   T_AlarmScenarios		ALS ON ALS.[AlarmID] = A.[AlarmID]
LEFT JOIN   [T_Scenarios]			S	ON S.[ScenarioID] = ALS.[ScenarioID]
LEFT JOIN   T_Algorithms			Alg	ON Alg.AlgorithmID=ED.AlgorithmID
JOIN	InvestigatAlarmsTableType_Temp	TVIA	ON TVIA.EventParmKey = EP.EventParmKey AND TVIA.StringValue = EP.StringValue AND AD.AlarmCategoryID=TVIA.AlarmCategoryID

WHERE 
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
AD.AlarmCategoryID      '+@AlarmCategoryIDs+'    AND
A.AlarmClassificationID '+@AlarmClassificationIDs+'   AND
A.AlarmsDefinitionID    '+@AlarmDefinitionIDs+'	 AND 
A.AlarmStatusID	        '+@AlarmStatus+'	AND 
ISNULL(L1.LocationID,0)			'+@LocationIDs+'	AND
ISNULL(TP.TouchPointID,0)			'+@TPIDs+'	AND
ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'	AND
A.AlarmCode             '+@AlarmCode+'  AND
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+''' 

UNION all

select 
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
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	LT_AlarmCategories		ACat	ON AD.AlarmCategoryID = ACat.AlarmCategoryID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
LEFT join  T_EventParms				EParms	ON E.EventID = EParms.EventID  
LEFT join  T_EventParms				EP	ON E.EventID = EP.EventID  AND EP.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPl	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' 
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
left JOIN	T_TouchPoints			TP	ON EP.STRINGVALUE = TP.TouchPointID  
LEFT JOIN	T_Location				L1	ON EPL.STRINGVALUE = L1.LocationID 
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
LEFT JOIN   T_AlarmScenarios		ALS ON ALS.[AlarmID] = A.[AlarmID]
LEFT JOIN   [T_Scenarios]			S	ON S.[ScenarioID] = ALS.[ScenarioID]
LEFT JOIN   T_Algorithms			Alg	ON Alg.AlgorithmID=ED.AlgorithmID
JOIN	InvestigatAlarmsTableType_Temp	TVIA	ON TVIA.EventParmKey = EParms.EventParmKey AND TVIA.StringValue = EParms.StringValue AND AD.AlarmCategoryID=TVIA.AlarmCategoryID

WHERE 
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
ED.TouchPointIDSource IS NULL AND
AD.AlarmCategoryID      '+@AlarmCategoryIDs+'    AND
A.AlarmClassificationID '+@AlarmClassificationIDs+'   AND
A.AlarmsDefinitionID    '+@AlarmDefinitionIDs+'	 AND 
A.AlarmStatusID	        '+@AlarmStatus+'	AND 
ISNULL(EPL.STRINGVALUE,0) '+@x+' AND
A.AlarmCode             '+@AlarmCode+'  AND
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+''' 
' 
)

END

ELSE

BEGIN
--declare @sqlCmd nvarchar(4000) =
INSERT INTO @result
execute (
'
select 
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
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	LT_AlarmCategories		ACat	ON AD.AlarmCategoryID = ACat.AlarmCategoryID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID and TL.stateid=1
LEFT JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
LEFT JOIN   T_AlarmScenarios		ALS ON ALS.[AlarmID] = A.[AlarmID]
LEFT JOIN   [T_Scenarios]			S	ON S.[ScenarioID] = ALS.[ScenarioID]

WHERE 
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
AD.AlarmCategoryID      '+@AlarmCategoryIDs+'    AND
A.AlarmClassificationID '+@AlarmClassificationIDs+'   AND
A.AlarmsDefinitionID    '+@AlarmDefinitionIDs+'	 AND 
A.AlarmStatusID	        '+@AlarmStatus+'	AND 
ISNULL(L1.LocationID,0)		'+@LocationIDs+'	AND
ISNULL(TP.TouchPointID,0)			'+@TPIDs+'	AND
ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'	AND
A.AlarmCode             '+@AlarmCode+'  AND
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+''' 

UNION

select 
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
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	LT_AlarmCategories		ACat	ON AD.AlarmCategoryID = ACat.AlarmCategoryID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
LEFT join  T_EventParms				EParms	ON E.EventID = EParms.EventID  
LEFT join  T_EventParms				EP	ON E.EventID = EP.EventID  AND EP.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPl	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' 
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
left JOIN	T_TouchPoints			TP	ON EP.STRINGVALUE = TP.TouchPointID  
LEFT JOIN	T_Location				L1	ON EPL.STRINGVALUE = L1.LocationID 
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
LEFT JOIN   T_AlarmScenarios		ALS ON ALS.[AlarmID] = A.[AlarmID]
LEFT JOIN   [T_Scenarios]			S	ON S.[ScenarioID] = ALS.[ScenarioID]

WHERE 
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
ED.TouchPointIDSource IS NULL AND
AD.AlarmCategoryID      '+@AlarmCategoryIDs+'    AND
A.AlarmClassificationID '+@AlarmClassificationIDs+'   AND
A.AlarmsDefinitionID    '+@AlarmDefinitionIDs+'	 AND 
A.AlarmStatusID	        '+@AlarmStatus+'	AND 
ISNULL(EPL.STRINGVALUE,0) '+@x+' AND
A.AlarmCode             '+@AlarmCode+'  AND
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+''' 

' 
)

END

IF (@SortBy is null or @SortBy = '')  SET @SortBy = 'Occurance_Date'

IF (@SortType is null or @SortType = '')  SET @SortType = 'ASC'

BEGIN TRY  
    DROP TABLE InvestigatAlarmsTable_Temp
END TRY  
BEGIN CATCH  

END CATCH  

SELECT DISTINCT * INTO InvestigatAlarmsTable_Temp FROM @result 

DECLARE @Sql	nvarchar(MAX) =null

SELECT @Sql =
CONCAT(
'SELECT AlarmID ,
EventID  ,
AlarmStatusID ,
AlarmStatusTitle1 ,
AlarmCategoryID ,
AlarmCategoryTitle1 ,
AlarmClassificationID ,
AlarmClassificationTitle1 ,  
AlarmCode ,  
AlarmDefinitionID ,
AlarmDefinitionTitle1 ,
Occurance_Date ,
Response_User ,
Response_Date ,
MAX(TouchpointName) AS TouchpointName , 
MAX(TouchPointTypeID) AS TouchPointTypeID  ,
MAX(TouchPointTypeID) AS TouchPointTypeID , 
MAX(TouchpointLocationName) AS TouchpointLocationName ,
MAX(ParentLocationId) AS ParentLocationId , 
MAX(ParentLocationName) AS ParentLocationName ,
EventName ,
[ScenarioTitle1] 

FROM InvestigatAlarmsTable_Temp

GROUP BY 

AlarmID ,
EventID  ,
AlarmStatusID ,
AlarmStatusTitle1 ,
AlarmCategoryID ,
AlarmCategoryTitle1 ,
AlarmClassificationID ,
AlarmClassificationTitle1 ,  
AlarmCode ,  
AlarmDefinitionID ,
AlarmDefinitionTitle1 ,
Occurance_Date ,
Response_User ,
Response_Date ,
EventName ,
[ScenarioTitle1] 

ORDER BY ',@SortBy,' ',@SortType,' OFFSET ',@PageNo,'*',@PageSize,' ROWS 
FETCH NEXT ',@PageSize,' ROWS ONLY'
)

EXECUTE (@Sql)