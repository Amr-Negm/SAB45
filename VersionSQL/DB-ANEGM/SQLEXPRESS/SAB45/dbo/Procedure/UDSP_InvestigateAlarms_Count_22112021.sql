/****** Object:  Procedure [dbo].[UDSP_InvestigateAlarms_Count_22112021]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure  [dbo].[UDSP_InvestigateAlarms_Count] 
		  @InvestigatAlarmsTableType InvestigatAlarmsTableType2 READONLY
		, @AlarmCategoryIDs			nvarchar(max) =null
		, @AlarmClassificationIDs 	nvarchar(max) =null
		, @AlarmDefinitionIDs		nvarchar(max) =null
		, @AlarmStatus				nvarchar(max) =null
		, @LocationIDs				nvarchar(max) =null
		, @TPIDs					nvarchar(max) =null
		, @TPTypeIDs				nvarchar(max) =null
		, @AlarmCode				nvarchar(max) =null
		, @PageNo					int=1
		, @PageSize					int=500000
		, @Date_from				datetime --= '2020-05-18 12:08:15'
		, @Date_to					datetime --= '2020-05-18 12:31:02'
	
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
if (@AlarmCategoryIDs is null or @AlarmCategoryIDs = '')  set @AlarmCategoryIDs = ' = AD.AlarmCategoryID '
else  set @AlarmCategoryIDs = ' in ' + @AlarmCategoryIDs;
if (@AlarmClassificationIDs is null or @AlarmClassificationIDs = '') set @AlarmClassificationIDs = ' = A.AlarmClassificationID '
else set @AlarmClassificationIDs = ' in ' + @AlarmClassificationIDs;
if (@AlarmDefinitionIDs is null or @AlarmDefinitionIDs = '')  set @AlarmDefinitionIDs = ' = A.AlarmsDefinitionID '
else set @AlarmDefinitionIDs = ' in ' + @AlarmDefinitionIDs;
if (@AlarmStatus is null or @AlarmStatus = '')  set @AlarmStatus = ' = A.AlarmStatusID '
else set @AlarmStatus = ' in ' + @AlarmStatus;
if (@LocationIDs is null or @LocationIDs = '')  set @LocationIDs = ' = L1.LocationID '
else  set @LocationIDs = ' in ' + @LocationIDs;

if (@TPIDs is null or @TPIDs = '')  
set @TPIDs = ' = TP.TouchPointID '
else  set @TPIDs = ' in ' + @TPIDs;

if (@TPTypeIDs is null or @TPTypeIDs = '')  
set @TPTypeIDs = ' = TP.TouchPointTypeID ' 
else  set @TPTypeIDs = ' in ' + @TPTypeIDs;

if (@TPIDs is not null or @TPIDs <> '')  set @TPTypeIDs = ' = TP.TouchPointTypeID ';

--if (@AlarmCode is null or @AlarmCode = '')  set @AlarmCode = ' = A.AlarmCode '
if (@AlarmCode is null or @AlarmCode = '')  set @AlarmCode = ' = A.AlarmCode '
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
LEFT JOIN	LT_AlarmCategories		ACat	ON A.AlarmStatusID = ACat.AlarmCategoryID
LEFT JOIN	LT_AlarmClassifications	AClass	ON A.AlarmStatusID = AClass.AlarmClassificationID
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
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
L1.LocationID			'+@LocationIDs+'	AND
TP.TouchPointID			'+@TPIDs+'	AND
TP.TouchPointTypeID		'+@TPTypeIDs+'	AND
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
LEFT JOIN	LT_AlarmCategories		ACat	ON A.AlarmStatusID = ACat.AlarmCategoryID
LEFT JOIN	LT_AlarmClassifications	AClass	ON A.AlarmStatusID = AClass.AlarmClassificationID
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
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

--(EPL.STRINGVALUE '+@LocationIDs+'  OR EPT.STRINGVALUE '+@TPIDs+' ) AND

EPL.STRINGVALUE '+@LocationIDs+' AND
--EP.STRINGVALUE '+@TPIDs+' AND

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
LEFT JOIN	LT_AlarmCategories		ACat	ON A.AlarmStatusID = ACat.AlarmCategoryID
LEFT JOIN	LT_AlarmClassifications	AClass	ON A.AlarmStatusID = AClass.AlarmClassificationID
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
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
L1.LocationID			'+@LocationIDs+'	AND
TP.TouchPointID			'+@TPIDs+'	AND
TP.TouchPointTypeID		'+@TPTypeIDs+'	AND
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
LEFT JOIN	LT_AlarmCategories		ACat	ON A.AlarmStatusID = ACat.AlarmCategoryID
LEFT JOIN	LT_AlarmClassifications	AClass	ON A.AlarmStatusID = AClass.AlarmClassificationID
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
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

--(EPL.STRINGVALUE '+@LocationIDs+'  OR EPT.STRINGVALUE '+@TPIDs+' ) AND

EPL.STRINGVALUE '+@LocationIDs+' AND
--EP.STRINGVALUE '+@TPIDs+' AND

A.AlarmCode             '+@AlarmCode+'  AND
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+''' 

' 
)

END

SELECT COUNT(DISTINCT AlarmID) AS TotalCount FROM @result