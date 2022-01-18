/****** Object:  Procedure [dbo].[USDP_GetTPLocations]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[USDP_GetTPLocations] @TPIDs nvarchar(max)
as


Declare @result table (
TouchPointID int ,  
TouchpointName nvarchar(50),
TouchpointLocationId int, 
TouchpointLocationName nvarchar(50),

ParentLocationId int, 
ParentLocationName nvarchar(50),
ParentState int,

ParentOfParentLocationId int ,
ParenOfParenttLocationName nvarchar(50),
ParentOfParentState int
)

INSERT INTO @result
execute (
'
select 
TP.TouchPointID, 
TP.TouchPointTitle1 AS TouchpointName,
L.LocationID AS TouchpointLocationId, 
L.Name AS TouchpointLocationName,

L_Parent.LocationID AS ParentLocationId, 
L_Parent.Name AS ParentLocationName,
L_Parent.StateId AS ParentState,

L_ParentOfParent.LocationID AS ParentOfParentLocationId, 
L_ParentOfParent.Name AS ParenOfParenttLocationName,
L_ParentOfParent.StateId AS ParentOfParentState

FROM		
T_TouchPoints			TP	
INNER JOIN	T_TouchPointLocation	TL	ON (TP.TouchPointID = TL.TouchPointID)
INNER JOIN	T_Location				L	ON (TL.LocationID = L.LocationID)
LEFT  JOIN	T_Location				L_Parent	ON (L.ParentLocationID = L_Parent.LocationID)
LEFT  JOIN	T_Location				L_ParentOfParent	ON (L_Parent.ParentLocationID = L_ParentOfParent.LocationID)

WHERE 
TP.TouchPointID in '+@TPIDs+'  and
TP.StateID	= 1 AND
TL.StateID	= 1 AND 
L.StateID	= 1 '
)
select * from @result