/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPerHour]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAverageAlarmsPerHour]
													  @StartDate datetime=null  ,
													  @EndDate datetime=null	,
													  @SPVALUE int output
													  
AS
BEGIN
SET NOCOUNT ON;
SET FMTONLY OFF; 
--declare @TotalAlarms decimal(38)

exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@StartDate,@EndDate,@SPVALUE output



select @SPVALUE/24 as 'AverageAlarmsPerHour'

		
SET NOCOUNT OFF;
END