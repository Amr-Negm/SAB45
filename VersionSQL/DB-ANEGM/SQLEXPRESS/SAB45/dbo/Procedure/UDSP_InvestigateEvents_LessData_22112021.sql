/****** Object:  Procedure [dbo].[UDSP_InvestigateEvents_LessData_22112021]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE  PROC [dbo].[UDSP_InvestigateEvents_LessData]
		  @InvestigatEventsTableType InvestigatEventsTableType READONLY
		, @EventCategoryIDs			nvarchar(500) = NULL
		, @LocationIDs				nvarchar(500) = NULL
		, @TPIDs					nvarchar(500) = NULL
		, @TPTypeIDs				nvarchar(500) = NULL
		, @PageNo					int           = 1
		, @PageSize					int           = 500000
		--, @GroupBy					nvarchar(500) = NULL
		, @SortBy					nvarchar(500) = NULL
		, @SortType					nvarchar(500) = NULL
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
TouchPointTypeTitle1 NVARCHAR(250),
TouchpointLocationName NVARCHAR(250),
ParentLocationName NVARCHAR(250),
StatusID int,
[Algorithm] nvarchar(50),
AlgorithmCategoryID int ,
AlgorithmCategoryTitle1 NVARCHAR(250)
)

DECLARE @CCount bigint

SELECT @CCount = COUNT(*) FROM InvestigatEventsTableType_Temp

set @PageNo  = @PageNo -1;
if (@EventCategoryIDs is null or @EventCategoryIDs = '')  set @EventCategoryIDs = ' = A.AlgorithmCategoryID '
else  set @EventCategoryIDs = ' in ' + @EventCategoryIDs;

if (@LocationIDs is null or @LocationIDs = '')  set @LocationIDs = ' = L1.LocationID '
else  set @LocationIDs = ' in ' + @LocationIDs;

if (@TPIDs is null or @TPIDs = '')  set @TPIDs = ' = ISNULL(TP.TouchPointID,0) '
else  set @TPIDs = ' in ' + @TPIDs;

if (@TPTypeIDs is null or @TPTypeIDs = '')  
set @TPTypeIDs = ' = ISNULL(TP.TouchPointTypeID,0) ' 
else  set @TPTypeIDs = ' in ' + @TPTypeIDs;

if (@TPIDs is not null or @TPIDs <> '')  set @TPTypeIDs = ' = ISNULL(TP.TouchPointTypeID,0) ';

IF (@CCount > 0)

BEGIN

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
TPT.TouchPointTypeTitle1,
L1.Name AS TouchpointLocationName,
L2.Name AS ParentLocationName,
E.StatusID,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID,
ACat.AlgorithmCategoryTitle1

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT JOIN	LT_AlgorithmCategories	ACat	ON ACat.AlgorithmCategoryID = A.AlgorithmCategoryID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	LT_TouchPointTypes		TPT	ON TP.TouchPointTypeID = TPT.TouchPointTypeID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
LEFT JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
JOIN	InvestigatEventsTableType_Temp	TVIE	ON TVIE.EventParmKey = EP.EventParmKey AND TVIE.StringValue = EP.StringValue AND A.AlgorithmCategoryID=TVIE.AlgorithmCategoryID

where 
ISNULL(TP.StateID,1) = 1 and
ISNULL(TL.StateID,1) = 1 and
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and
L1.LocationID			'+@LocationIDs+'	AND
ISNULL(TP.TouchPointID,0)			'+@TPIDs+'	AND
ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'	AND
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
TPT.TouchPointTypeTitle1,
L1.Name AS TouchpointLocationName,
L2.Name AS ParentLocationName,
E.StatusID,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID,
ACat.AlgorithmCategoryTitle1

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT join  T_EventParms				EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId''
LEFT JOIN	LT_AlgorithmCategories	ACat	ON ACat.AlgorithmCategoryID = A.AlgorithmCategoryID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	LT_TouchPointTypes		TPT	ON TP.TouchPointTypeID = TPT.TouchPointTypeID
LEFT JOIN	T_Location				L1	ON EPL.STRINGVALUE = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
JOIN	InvestigatEventsTableType_Temp	TVIE	ON TVIE.EventParmKey = EP.EventParmKey AND TVIE.StringValue = EP.StringValue AND A.AlgorithmCategoryID=TVIE.AlgorithmCategoryID

where 
ISNULL(TP.StateID,1) = 1 and

(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) AND
ED.TouchPointIDSource IS NULL AND
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and

--(EPL.STRINGVALUE '+@LocationIDs+'  OR EPT.STRINGVALUE '+@TPIDs+' ) AND

EPL.STRINGVALUE '+@LocationIDs+' AND
--EPT.STRINGVALUE '+@TPIDs+' AND

ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'	AND
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' 

'
)

END

ELSE

BEGIN

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
TPT.TouchPointTypeTitle1,
L1.Name AS TouchpointLocationName,
L2.Name AS ParentLocationName,
E.StatusID,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID,
ACat.AlgorithmCategoryTitle1

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT JOIN	LT_AlgorithmCategories	ACat	ON ACat.AlgorithmCategoryID = A.AlgorithmCategoryID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	LT_TouchPointTypes		TPT	ON TP.TouchPointTypeID = TPT.TouchPointTypeID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
LEFT JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID

where 
ISNULL(TP.StateID,1) = 1 and
ISNULL(TL.StateID,1) = 1 and
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and
L1.LocationID			'+@LocationIDs+'	AND
ISNULL(TP.TouchPointID,0)			'+@TPIDs+'	AND
ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'	AND
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
TPT.TouchPointTypeTitle1,
L1.Name AS TouchpointLocationName,
L2.Name AS ParentLocationName,
E.StatusID,
A.AlgorithmTitle1 AS [Algorithm],
A.AlgorithmCategoryID,
ACat.AlgorithmCategoryTitle1

FROM		T_Events				E	
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT join  T_EventParms				EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId''
LEFT JOIN	LT_AlgorithmCategories	ACat	ON ACat.AlgorithmCategoryID = A.AlgorithmCategoryID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	LT_TouchPointTypes		TPT	ON TP.TouchPointTypeID = TPT.TouchPointTypeID
LEFT JOIN	T_Location				L1	ON EPL.STRINGVALUE = L1.LocationID
LEFT  JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID

where 
ISNULL(TP.StateID,1) = 1 and

(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) AND
ED.TouchPointIDSource IS NULL AND
A.AlgorithmCategoryID		'+@EventCategoryIDs+' and

--(EPL.STRINGVALUE '+@LocationIDs+'  OR EPT.STRINGVALUE '+@TPIDs+' ) AND

EPL.STRINGVALUE '+@LocationIDs+' AND
--EPT.STRINGVALUE '+@TPIDs+' AND

ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'	AND
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' 

'
)

END

--IF (@GroupBy is null or @GroupBy = '')  SET @GroupBy = ''
--ELSE SET @GroupBy = CONCAT(@GroupBy,',')

IF (@SortBy is null or @SortBy = '')  SET @SortBy = 'Occurance_Date'

IF (@SortType is null or @SortType = '')  SET @SortType = 'ASC'

BEGIN TRY  
    DROP TABLE InvestigatEventsTable_Temp
END TRY  
BEGIN CATCH  

END CATCH  

SELECT DISTINCT * INTO InvestigatEventsTable_Temp FROM @result 

DECLARE @Sql	nvarchar(MAX) =null

SELECT @Sql =
CONCAT(
'SELECT * FROM InvestigatEventsTable_Temp order by ',@SortBy,' ',@SortType,' OFFSET ',@PageNo,'*',@PageSize,' ROWS 
FETCH NEXT ',@PageSize,' ROWS ONLY'
)

--SELECT @Sql

EXECUTE (@Sql)

/*
'SELECT DISTINCT * FROM ',@result,' order by ',@GroupBy,@SortBy,' ',@SortType,' OFFSET ',@PageNo,'*',@PageSize,' ROWS 
FETCH NEXT ',@PageSize,' ROWS ONLY'

SELECT DISTINCT * FROM @result order by Occurance_Date OFFSET @PageNo*@PageSize ROWS 
FETCH NEXT @PageSize ROWS ONLY
*/