/****** Object:  Procedure [dbo].[UDSP_InvestigateAlarms_old]    Committed by VersionSQL https://www.versionsql.com ******/

--select * from LT_AlarmCategories
Create procedure  [dbo].[UDSP_InvestigateAlarms_old] --@AlarmCategoryIDs='(25,23)',@Date_from= '2020-05-18 12:08:15' , @Date_to	= '2021-05-18 12:31:02'
	      @AlarmCategoryIDs			nvarchar(max) =null
		, @AlarmClassificationIDs 	nvarchar(max) =null
		, @AlarmDefinitionIDs		nvarchar(max) =null
		, @AlarmStatus				nvarchar(max) =null
		, @LocationIDs				nvarchar(max) =null
		, @TPIDs					nvarchar(max) =null
		, @TPTypeIDs				nvarchar(max) =null
		, @AlarmCode				nvarchar(max) =null
		, @Date_from				datetime --= '2020-05-18 12:08:15'
		, @Date_to					datetime --= '2020-05-18 12:31:02'
		
as 

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

Declare @result table (
AlarmID INT,
EventID int ,
AlarmStatusID INT,
AlarmCategoryID INT,
AlarmClassificationID INT,  
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
[ScenarioTitle1] NVARCHAR(250),
EventParmKey nvarchar(250),
StringValue nvarchar(250)

)

--declare @sqlCmd nvarchar(4000) =
INSERT INTO @result
execute (
'
select 
A.AlarmID ,
E.eventid,
A.AlarmStatusID ,
AD.AlarmCategoryID,
A.AlarmClassificationID, 
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
S.[ScenarioTitle1],
EP.EventParmKey ,
EP.StringValue 

FROM		T_Alarms				A
INNER JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
INNER JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
INNER JOIN	T_Events				E	ON EA.EventID = E.EventID
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
INNER JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
INNER JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
INNER JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
LEFT JOIN   T_AlarmScenarios		ALS ON ALS.[AlarmID] = A.[AlarmID]
LEFT JOIN   [T_Scenarios]			S	ON S.[ScenarioID] = ALS.[ScenarioID]

WHERE 
TP.StateID = 1 and
TL.StateID = 1 and
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' )and
AD.AlarmCategoryID      '+@AlarmCategoryIDs+'   AND
A.AlarmClassificationID '+@AlarmClassificationIDs+'   AND
A.AlarmsDefinitionID    '+@AlarmDefinitionIDs+'	 AND 
A.AlarmStatusID	        '+@AlarmStatus+'	AND 
L1.LocationID			'+@LocationIDs+'	AND
TP.TouchPointID			'+@TPIDs+'	AND
TP.TouchPointTypeID		'+@TPTypeIDs+'	AND
A.AlarmCode             '+@AlarmCode+'  AND
A.Occurance_Date >=		'''+@Date_from +''' AND
A.Occurance_Date <=		'''+@Date_to+''' ' )

--Declare @EventParms table (
--AlarmID INT,
--EventID INT,
--EventParmKey nvarchar(250),
--StringValue nvarchar(250)
--)
--insert into @EventParms

--select distinct
--r.AlarmID ,
--r.EventID ,
--EP.EventParmKey,
--EP.StringValue

--FROM		T_EventParms ep
--inner join @result r on r.EventID = ep.EventID
--WHERE 
--EventParmKey not like '%imag%'

SELECT * FROM @result
--select * from @EventParms