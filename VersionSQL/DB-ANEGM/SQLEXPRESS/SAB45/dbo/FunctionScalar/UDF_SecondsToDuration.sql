/****** Object:  Function [dbo].[UDF_SecondsToDuration]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[UDF_SecondsToDuration]
(
    @Seconds int 
)
RETURNS nvarchar(50)

AS
BEGIN

DECLARE @Duration nvarchar(50),@Days nvarchar(50)
select @Days=CONVERT(VARCHAR(12), @Seconds / 60 / 60 / 24);

SELECT @Duration=
         CONVERT(VARCHAR(12), @Seconds / 60 / 60 % 24) 
+ ':' + CONVERT(VARCHAR(2), @Seconds / 60 % 60) 
+ ':' + CONVERT(VARCHAR(2), @Seconds % 60);

SELECT @Duration= cast( @Duration AS time(0));

if (@Days)<1
return @Duration;
else
select @Duration=concat(@Days,'Day(s), ',@Duration);
return @Duration;

END