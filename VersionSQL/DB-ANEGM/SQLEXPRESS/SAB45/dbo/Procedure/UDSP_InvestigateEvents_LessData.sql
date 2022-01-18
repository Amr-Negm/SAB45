/****** Object:  Procedure [dbo].[UDSP_InvestigateEvents_LessData]    Committed by VersionSQL https://www.versionsql.com ******/

/****** Object:  StoredProcedure [dbo].[UDSP_InvestigateEvents_LessData]    Script Date: 12/12/2021 11:38:14 AM ******/

CREATE  PROC [dbo].[UDSP_InvestigateEvents_LessData]
		  @InvestigatEventsTableType InvestigatEventsTableType READONLY
		, @EventCategoryIDs			NVARCHAR(MAX) = NULL
		, @LocationIDs				NVARCHAR(MAX) = NULL
		, @LocationTypeIDs			NVARCHAR(MAX) = NULL
		, @EventDefinitionIDs		NVARCHAR(MAX) = NULL
		, @TPIDs					NVARCHAR(MAX) = NULL
		, @TPTypeIDs				NVARCHAR(MAX) = NULL
		, @PageNo					INT           = 1
		, @PageSize					INT           = 500000
		, @SortBy					NVARCHAR(MAX) = NULL
		, @SortType					NVARCHAR(MAX) = NULL
		, @x						NVARCHAR(MAX) = NULL
		, @Date_from				NVARCHAR(MAX) = '1900-08-01 00:00:00'
		, @Date_to					NVARCHAR(MAX) = '3021-08-01 23:59:59'

		AS
				
DECLARE @w nvarchar(50)
SELECT @w = CONCAT(YEAR(GETDATE()),'-',MONTH(GETDATE()),'-',DAY(GETDATE()))

DECLARE @TimeStamp bigint
SET @TimeStamp = DATEDIFF(MILLISECOND, @w, GETDATE())

INSERT [dbo].InvestigatEventsTableType_Temp2  (
[AlgorithmCategoryID] ,
	[EventParmKey] ,
	[StringValue] ,
	[TimeStamp]
	)
SELECT 
[AlgorithmCategoryID] ,
	[EventParmKey] ,
	[StringValue] ,
	@TimeStamp
	FROM @InvestigatEventsTableType

DECLARE @CCount bigint

SELECT @CCount = COUNT(*) FROM InvestigatEventsTableType_Temp2 WHERE [TimeStamp] = @TimeStamp

set @PageNo  = @PageNo -1;

if (@EventCategoryIDs is null or @EventCategoryIDs = '')
set @EventCategoryIDs = ' = A.AlgorithmCategoryID '
else  set @EventCategoryIDs = ' in ' + @EventCategoryIDs;

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

IF (@SortBy is null or @SortBy = '')  SET @SortBy = 'Occurance_Date'

IF (@SortType is null or @SortType = '')  SET @SortType = 'ASC'

IF (@CCount > 0)

BEGIN

execute (
'
select DISTINCT
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
LEFT join   T_EventParms			EP	ON E.EventID = EP.EventID
LEFT JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT JOIN	LT_AlgorithmCategories	ACat	ON ACat.AlgorithmCategoryID = A.AlgorithmCategoryID
LEFT join   T_EventParms			EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId'' AND ED.TouchPointIDSource IS NULL
LEFT join   T_EventParms			EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' AND ED.TouchPointIDSource IS NULL
LEFT JOIN	T_TouchPoints			TP	ON ISNULL(ED.TouchPointIDSource,EPT.STRINGVALUE) = TP.TouchPointID
LEFT JOIN	LT_TouchPointTypes		TPT	ON TP.TouchPointTypeID = TPT.TouchPointTypeID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
LEFT JOIN	T_Location				L1	ON ISNULL(TL.LocationID,EPL.STRINGVALUE) = L1.LocationID
LEFT JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID
JOIN	InvestigatEventsTableType_Temp2	TVIE	ON EP.EventParmKey LIKE CONCAT(''%'', TVIE.EventParmKey, ''%'') AND EP.StringValue LIKE CONCAT(''%'', TVIE.StringValue, ''%'') AND A.AlgorithmCategoryID LIKE CONCAT(''%'', TVIE.AlgorithmCategoryID, ''%'') AND TVIE.TimeStamp = '+@TimeStamp+'

where 
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' AND
ISNULL(TP.StateID,1) = 1 and
ISNULL(TL.StateID,1) = 1 and
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
A.AlgorithmCategoryID		'+@EventCategoryIDs+' AND 
ISNULL(E.EventDefinitionID,0)		'+@EventDefinitionIDs+'	AND
ISNULL(L1.LocationTypeID,0)		'+@LocationTypeIDs+'	AND
ISNULL(L1.LocationID,0)		'+@LocationIDs+'	AND
ISNULL(TP.TouchPointID,0)			'+@TPIDs+'	AND
ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'

order by '+@SortBy+' '+@SortType+' OFFSET '+@PageNo+'*'+@PageSize+' ROWS 
FETCH NEXT '+@PageSize+' ROWS ONLY
'
)

END

ELSE

BEGIN

execute (
'
select DISTINCT
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
LEFT join   T_EventParms			EP	ON E.EventID = EP.EventID
LEFT JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN   T_Algorithms			A	ON A.AlgorithmID=ED.AlgorithmID
LEFT JOIN	LT_AlgorithmCategories	ACat	ON ACat.AlgorithmCategoryID = A.AlgorithmCategoryID
LEFT join   T_EventParms			EPT	ON E.EventID = EPT.EventID  AND EPT.EVENTPARMKEY = ''TouchpointId'' AND ED.TouchPointIDSource IS NULL
LEFT join   T_EventParms			EPL	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' AND ED.TouchPointIDSource IS NULL
LEFT JOIN	T_TouchPoints			TP	ON ISNULL(ED.TouchPointIDSource,EPT.STRINGVALUE) = TP.TouchPointID
LEFT JOIN	LT_TouchPointTypes		TPT	ON TP.TouchPointTypeID = TPT.TouchPointTypeID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID
LEFT JOIN	T_Location				L1	ON ISNULL(TL.LocationID,EPL.STRINGVALUE) = L1.LocationID
LEFT JOIN	T_Location				L2	ON L1.ParentLocationID = L2.LocationID

where
E.Occurance_Date >=		'''+@Date_from +''' AND
E.Occurance_Date <=		'''+@Date_to+''' AND
ISNULL(TP.StateID,1) = 1 and
ISNULL(TL.StateID,1) = 1 and
(EP.EventParmKey is null or EP.EventParmKey not like ''%imag%'' ) and
A.AlgorithmCategoryID		'+@EventCategoryIDs+' AND
ISNULL(E.EventDefinitionID,0)		'+@EventDefinitionIDs+'	AND
ISNULL(L1.LocationTypeID,0)		'+@LocationTypeIDs+'	AND
ISNULL(L1.LocationID,0)			'+@LocationIDs+'	AND
ISNULL(TP.TouchPointID,0)			'+@TPIDs+'	AND
ISNULL(TP.TouchPointTypeID,0)		'+@TPTypeIDs+'

order by '+@SortBy+' '+@SortType+' OFFSET '+@PageNo+'*'+@PageSize+' ROWS 
FETCH NEXT '+@PageSize+' ROWS ONLY

'
)

END