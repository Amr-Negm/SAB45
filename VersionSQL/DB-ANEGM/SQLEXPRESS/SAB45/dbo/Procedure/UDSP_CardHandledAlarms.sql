/****** Object:  Procedure [dbo].[UDSP_CardHandledAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardHandledAlarms]  
													  @StartDate datetime=null  ,
													  @EndDate datetime=null ,
													  @SPValue int output
													  

AS
BEGIN
SET NOCOUNT ON;		

SET FMTONLY OFF; 
--declare @HandledAlarms int
			  select @SPValue=count(*) from [dbo].[UDV_AllAlarmsNew]
									where
												[Response_Date] is not null and 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) 

				select 	@SPValue ;--as 'HandledAlarms'								 
													
--select cast(@HandledAlarms as varchar(max))
SET NOCOUNT OFF;	
SET FMTONLY OFF; 	
END