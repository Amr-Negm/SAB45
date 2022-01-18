/****** Object:  Procedure [dbo].[UDSP_InvestigateEvents_Count_Orgnl_NOK]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE  PROC [dbo].[UDSP_InvestigateEvents_Count_Orgnl_NOK]
		  @InvestigatEventsTableType InvestigatEventsTableType READONLY
		, @EventCategoryIDs			nvarchar(500) =null
		, @LocationIDs				nvarchar(500) =null
		, @TPIDs					nvarchar(500) =null
		, @TPTypeIDs				nvarchar(500) =null
		, @PageNo					int=1
		, @PageSize					int=500000
		, @Date_from				nvarchar(500) = '2020-05-18 12:08:15'
		, @Date_to					nvarchar(500) = '2020-05-18 12:31:02'

		AS

BEGIN TRY  
    DROP TABLE InvestigatEventsTableType_Temp
END TRY  
BEGIN CATCH  

END CATCH  

SELECT * INTO InvestigatEventsTableType_Temp FROM @InvestigatEventsTableType

Declare @result table (
EventID int ,
EventCode NVARCHAR(250), 
EventName NVARCHAR(250), 
Occurance_Date DATETIME,
TouchPointID int,
TouchpointName NVARCHAR(250), 
TouchPointTypeID int ,
--TouchpointLocationId INT, 
TouchpointLocationName NVARCHAR(250),
--ParentLocationId INT, 
ParentLocationName NVARCHAR(250),
StatusID int,
--Response_Date datetime,
--ResponseTaker nvarchar(50),
[Algorithm] nvarchar(50),
AlgorithmCategoryID int 
)

DECLARE @CCount bigint

SELECT @CCount = COUNT(*) FROM InvestigatEventsTableType_Temp

IF (@CCount > 0)

BEGIN


set @PageNo  = @PageNo -1;
if (@EventCategoryIDs is null or @EventCategoryIDs = '')  set @EventCategoryIDs = ' = A.AlgorithmCategoryID '
else  set @EventCategoryIDs = ' in ' + @EventCategoryIDs;

if (@LocationIDs is null or @LocationIDs = '')  set @LocationIDs = ' = L1.LocationID '
else  set @LocationIDs = ' in ' + @LocationIDs;

if (@TPIDs is null or @TPIDs = '')  set @TPIDs = ' = TP.TouchPointID '
else  set @TPIDs = ' in ' + @TPIDs;

if (@TPTypeIDs is null or @TPTypeIDs = '')  
set @TPTypeIDs = ' = TP.TouchPointTypeID ' 
else  set @TPTypeIDs = ' in ' + @TPTypeIDs;

if (@TPIDs is not null or @TPIDs <> '')  set @TPTypeIDs = ' = TP.TouchPointTypeID ';


INSERT INTO @result
execute (
'
select 
E.eventid,
ED.EventDefinitionCode AS EventCode,
ED.EventDefinitionTitle1 AS EventName,
E.Occurance_Date,
TP.TouchPointID,
TP.TouchPointTitle1 AS TouchpointName, 
TP.TouchPointTypeID,
--L1.LocationID AS TouchpointLocationId, 
L1.Name AS TouchpointLocationName,
--L2.LocationID AS ParentLocationId, 
L2.Name AS ParentLocationName,
E.StatusID,
--E.Response_Date,
--E.Response_User as ResponseTaker,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
INNER JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
INNER JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
INNER JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
JOIN	InvestigatEventsTableType_Temp	TVIE	ON TVIE.EventParmKey = EP.EventParmKey AND TVIE.StringValue = EP.StringValue AND A.AlgorithmCategoryID=TVIE.AlgorithmCategoryID

where 
TP.StateID = 1 and
TL.StateID = 1 and
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and
L1.LocationID			'+@LocationIDs+'	AND
TP.TouchPointID			'+@TPIDs+'	AND
TP.TouchPointTypeID		'+@TPTypeIDs+'	AND
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' 

UNION ALL

select 
E.eventid,
ED.EventDefinitionCode AS EventCode,
ED.EventDefinitionTitle1 AS EventName,
E.Occurance_Date,
TP.TouchPointID,
TP.TouchPointTitle1 AS TouchpointName, 
TP.TouchPointTypeID,
--L1.LocationID AS TouchpointLocationId, 
L1.Name AS TouchpointLocationName,
--L2.LocationID AS ParentLocationId, 
L2.Name AS ParentLocationName,
E.StatusID,
--E.Response_Date,
--E.Response_User as ResponseTaker,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT join  T_EventParms				EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId''
LEFT JOIN	T_TouchPoints			TP	ON EPT.STRINGVALUE = TP.TouchPointID
LEFT JOIN	T_Location				L1	ON EPL.STRINGVALUE = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
JOIN	InvestigatEventsTableType_Temp	TVIE	ON TVIE.EventParmKey = EP.EventParmKey AND TVIE.StringValue = EP.StringValue AND A.AlgorithmCategoryID=TVIE.AlgorithmCategoryID

where 
TP.StateID = 1 and

(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) AND
ED.TouchPointIDSource IS NULL AND
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and

(EPL.STRINGVALUE '+@LocationIDs+'  OR EPT.STRINGVALUE '+@TPIDs+' ) AND

TP.TouchPointTypeID		'+@TPTypeIDs+'	AND
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' 


'
)

END

ELSE

BEGIN



set @PageNo  = @PageNo -1;
if (@EventCategoryIDs is null or @EventCategoryIDs = '')  set @EventCategoryIDs = ' = A.AlgorithmCategoryID '
else  set @EventCategoryIDs = ' in ' + @EventCategoryIDs;

if (@LocationIDs is null or @LocationIDs = '')  set @LocationIDs = ' = L1.LocationID '
else  set @LocationIDs = ' in ' + @LocationIDs;

if (@TPIDs is null or @TPIDs = '')  set @TPIDs = ' = TP.TouchPointID '
else  set @TPIDs = ' in ' + @TPIDs;

if (@TPTypeIDs is null or @TPTypeIDs = '')  
set @TPTypeIDs = ' = TP.TouchPointTypeID ' 
else  set @TPTypeIDs = ' in ' + @TPTypeIDs;

if (@TPIDs is not null or @TPIDs <> '')  set @TPTypeIDs = ' = TP.TouchPointTypeID ';


INSERT INTO @result
execute (
'
select 
E.eventid,
ED.EventDefinitionCode AS EventCode,
ED.EventDefinitionTitle1 AS EventName,
E.Occurance_Date,
TP.TouchPointID,
TP.TouchPointTitle1 AS TouchpointName, 
TP.TouchPointTypeID,
--L1.LocationID AS TouchpointLocationId, 
L1.Name AS TouchpointLocationName,
--L2.LocationID AS ParentLocationId, 
L2.Name AS ParentLocationName,
E.StatusID,
--E.Response_Date,
--E.Response_User as ResponseTaker,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
INNER JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
INNER JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
INNER JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID

where 
TP.StateID = 1 and
TL.StateID = 1 and
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and
L1.LocationID			'+@LocationIDs+'	AND
TP.TouchPointID			'+@TPIDs+'	AND
TP.TouchPointTypeID		'+@TPTypeIDs+'	AND
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' 

UNION ALL

select 
E.eventid,
ED.EventDefinitionCode AS EventCode,
ED.EventDefinitionTitle1 AS EventName,
E.Occurance_Date,
TP.TouchPointID,
TP.TouchPointTitle1 AS TouchpointName, 
TP.TouchPointTypeID,
--L1.LocationID AS TouchpointLocationId, 
L1.Name AS TouchpointLocationName,
--L2.LocationID AS ParentLocationId, 
L2.Name AS ParentLocationName,
E.StatusID,
--E.Response_Date,
--E.Response_User as ResponseTaker,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT join  T_EventParms				EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId''
LEFT JOIN	T_TouchPoints			TP	ON EPT.STRINGVALUE = TP.TouchPointID
LEFT JOIN	T_Location				L1	ON EPL.STRINGVALUE = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID

where 
TP.StateID = 1 and

(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) AND
ED.TouchPointIDSource IS NULL AND
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and

(EPL.STRINGVALUE '+@LocationIDs+'  OR EPT.STRINGVALUE '+@TPIDs+' ) AND

TP.TouchPointTypeID		'+@TPTypeIDs+'	AND
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' 


'
)

END

SELECT COUNT(DISTINCT EventID) AS TotalCount FROM @result
------------------------------------------------------