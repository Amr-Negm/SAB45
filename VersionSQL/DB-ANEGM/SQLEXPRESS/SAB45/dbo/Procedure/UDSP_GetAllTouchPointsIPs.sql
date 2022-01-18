/****** Object:  Procedure [dbo].[UDSP_GetAllTouchPointsIPs]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROC [dbo].[UDSP_GetAllTouchPointsIPs]
AS
select a.TouchPointID,a.TouchPointTypeID,c.TPParmID,c.TPParmSiteID,c.TouchPointSiteID,c.StringValue,c.StateID
from T_TouchPoints as a
join T_TouchPointLocation as b
on a.TouchPointID = b.TouchPointID and a.TouchPointTypeID = 1 and ISNULL(a.StateID,1) != 3 and ISNULL(b.StateID,1) != 3
join T_TouchPointParms as c
on a.TouchPointID = c.TouchPointID and ISNULL(c.StateID,1) != 3 and c.TPParmID = 1