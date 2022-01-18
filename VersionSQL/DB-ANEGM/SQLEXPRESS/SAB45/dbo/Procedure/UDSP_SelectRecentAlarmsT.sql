/****** Object:  Procedure [dbo].[UDSP_SelectRecentAlarmsT]    Committed by VersionSQL https://www.versionsql.com ******/

--Requested by Kamal 6 Feb 2020
CREATE Procedure [dbo].[UDSP_SelectRecentAlarmsT] @LocationIDs nvarchar(500) , @AlarmCategoryIDs nvarchar(500)
as
--exec [dbo].[UDSP_SelectRecentAlarms] '(1,2,3)', '(1,2,3)'
Declare @result table (
Drnk int , AlarmID int, AlarmStatusID int,AlarmDefinitionID int ,AlarmTitle nvarchar(100),
TouchPointID int, TouchpointName nvarchar(100), EventID int, [Event] nvarchar(100),
TouchpointLocationId int, TouchpointLocationName nvarchar(100),
ParentLocationId int ,ParentLocationName nvarchar(100) ,ParentState int ,
AlarmClassificationID int, AlarmCode nvarchar(300),  Occurance_Date datetime,AlarmCategoryID int 
)
Declare @Top int =(SELECT [Value]
  FROM T_Configuration c
  inner join  [dbo].[T_ConfigurationValue] cv on c.ConfigurationID = cv.ConfigurationID
  where [KEY]=N'MaxAlarmsToLoad');

  insert into @result
execute 
('
select * from (
select Dense_RANK() OVER   (ORDER BY A.Occurance_Date desc,A.alarmid desc ) AS Drnk,
A.AlarmID ,A.AlarmStatusID ,AD.AlarmDefinitionID ,AD.AlarmDefinitionTitle1 AS AlarmTitle,
TP.TouchPointID, TP.TouchPointTitle1 AS TouchpointName, E.EventID, ED.EventDefinitionTitle1 AS Event,
L1.LocationID AS TouchpointLocationId, L1.Name AS TouchpointLocationName,
L2.LocationID AS ParentLocationId, L2.Name AS ParentLocationName,L2.StateId AS ParentState,
A.AlarmClassificationID, A.AlarmCode,  A.Occurance_Date ,AD.AlarmCategoryID

FROM		T_Alarms				A
INNER JOIN	T_AlarmDefinitions		AD	ON (A.AlarmsDefinitionID = AD.AlarmDefinitionID)
INNER JOIN	T_EventAlarms			EA	ON (A.AlarmID = EA.AlarmID)
INNER JOIN	T_Events				E	ON (EA.EventID = E.EventID)
INNER JOIN	T_EventDefinitions		ED	ON (ED.EventDefinitionID = E.EventDefinitionID)
INNER JOIN  T_EVENTPARMS EP ON EP.EVENTID = E.EVENTID AND EP.EVENTPARMKEY = ''locationid'' AND EP.STRINGVALUE IN '+@LocationIDs+'
LEFT JOIN	T_TouchPoints			TP	ON (ED.TouchPointIDSource = TP.TouchPointID)
LEFT JOIN	T_TouchPointLocation	TL	ON (TP.TouchPointID = TL.TouchPointID)
LEFT JOIN	T_Location				L1	ON (TL.LocationID = L1.LocationID)
LEFT  JOIN	T_Location				L2	ON (L1.ParentLocationID = L2.LocationID)

WHERE 
ED.touchpointidsource is null AND
A. StateID	= 1 AND A. StatusID	= 1 AND A.AlarmStatusID	= 1 AND AD.AlarmCategoryID in '+@AlarmCategoryIDs+' AND
AD.StateID	= 1	AND	AD.StatusID	= 1	AND	
E. StateID	= 1 AND E. StatusID	= 1 AND	
ED.StateID	= 1 AND ED.StatusID	= 1
) t where Drnk <='+@Top);



select * from @result

--SELECT touchpointidsource FROM T_eventDefinitions
--SELECT TOP 10 * FROM T_EVENTPARMS EP WHERE EVENTID=88708 AND EP.EVENTPARMKEY = 'locationid' AND EP.STRINGVALUE=