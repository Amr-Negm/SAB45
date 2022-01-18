/****** Object:  Function [dbo].[UDF_SecondsToDurationOld]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[UDF_SecondsToDurationOld]
(
    @Seconds int 
)
RETURNS nvarchar(50)

AS
BEGIN

DECLARE @Duration nvarchar(50)
SELECT @Duration=
         CONVERT(VARCHAR(12), @Seconds / 60 / 60 / 24) 
+ ',' + CONVERT(VARCHAR(12), @Seconds / 60 / 60 % 24) 
+ ':' + CONVERT(VARCHAR(2), @Seconds / 60 % 60) 
+ ':' + CONVERT(VARCHAR(2), @Seconds % 60);
SELECT @Duration= cast(substring(@Duration,3,Len(@Duration)) AS time(0));

if (@Seconds/ 60 / 60 / 24)<1
return @Duration;
else
select @Duration=cast((concat(CONVERT(VARCHAR(12), @Seconds / 60 / 60 / 24) ,',',@Duration)) as nvarchar(50));
return @Duration;

END