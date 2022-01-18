/****** Object:  Function [dbo].[UDF_#ChildByParent]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[UDF_#ChildByParent]
(
    @LocationID int 
)
RETURNS  int

AS
BEGIN
return(select count(*) from dbo.T_Location where ParentLocationID=@LocationID and StateID=1);

END