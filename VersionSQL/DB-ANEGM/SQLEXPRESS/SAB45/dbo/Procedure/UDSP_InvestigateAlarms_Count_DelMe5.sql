/****** Object:  Procedure [dbo].[UDSP_InvestigateAlarms_Count_DelMe5]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure  [dbo].[UDSP_InvestigateAlarms_Count_DelMe5] 
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
		, @Date_from				NVARCHAR(MAX) = '2021-08-01 23:44:00'
		, @Date_to					NVARCHAR(MAX) = '2021-08-01 23:59:59'
		, @x						NVARCHAR(MAX) = NULL
	
		AS
		
DECLARE @w nvarchar(50)
SELECT @w = CONCAT(YEAR(GETDATE()),'-',MONTH(GETDATE()),'-',DAY(GETDATE()))

DECLARE @TimeStamp bigint
SET @TimeStamp = DATEDIFF(MILLISECOND, @w, GETDATE())

INSERT [dbo].InvestigatAlarmsTableType_TempCount2  (
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

Declare @result table (
AlarmID INT
)

DECLARE @CCount bigint

SELECT @CCount = COUNT(*) FROM  InvestigatAlarmsTableType_TempCount2 WHERE [TimeStamp] = @TimeStamp

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
select DISTINCT A.AlarmID
FROM		T_Alarms				A
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID and TL.stateid=1
LEFT JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID
JOIN	InvestigatAlarmsTableType_TempCount2	TVIA	ON TVIA.EventParmKey = EParms.EventParmKey AND TVIA.StringValue = EParms.StringValue AND AD.AlarmCategoryID=TVIA.AlarmCategoryID AND TVIA.TimeStamp = '+@TimeStamp+'

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

select DISTINCT A.AlarmID

FROM		T_Alarms				A
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
LEFT join  T_EventParms				EP	ON E.EventID = EP.EventID  AND EP.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPl	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' 
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
JOIN	InvestigatAlarmsTableType_TempCount2	TVIA	ON TVIA.EventParmKey = EParms.EventParmKey AND TVIA.StringValue = EParms.StringValue AND AD.AlarmCategoryID=TVIA.AlarmCategoryID AND TVIA.TimeStamp = '+@TimeStamp+'

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
select DISTINCT A.AlarmID
FROM		T_Alarms				A
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
Left join   T_EventParms			EP	ON E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID
LEFT JOIN	T_TouchPoints			TP	ON ED.TouchPointIDSource = TP.TouchPointID
LEFT JOIN	T_TouchPointLocation	TL	ON TP.TouchPointID = TL.TouchPointID and TL.stateid=1
LEFT JOIN	T_Location				L1	ON TL.LocationID = L1.LocationID

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

select DISTINCT A.AlarmID

FROM		T_Alarms				A
LEFT JOIN	T_AlarmDefinitions		AD	ON A.AlarmsDefinitionID = AD.AlarmDefinitionID
LEFT JOIN	T_EventAlarms			EA	ON A.AlarmID = EA.AlarmID
LEFT JOIN	T_Events				E	ON EA.EventID = E.EventID
LEFT join  T_EventParms				EP	ON E.EventID = EP.EventID  AND EP.EVENTPARMKEY = ''TouchpointId''
LEFT join  T_EventParms				EPl	ON E.EventID = EPL.EventID  AND EPL.EVENTPARMKEY = ''LOCATIONId'' 
INNER JOIN	T_EventDefinitions		ED	ON ED.EventDefinitionID = E.EventDefinitionID

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

SELECT COUNT(DISTINCT AlarmID) AS TotalCount FROM @result

DELETE InvestigatAlarmsTableType_TempCount2 WHERE [TimeStamp] = @TimeStamp