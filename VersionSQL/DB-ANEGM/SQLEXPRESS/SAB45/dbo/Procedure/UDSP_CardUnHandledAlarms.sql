/****** Object:  Procedure [dbo].[UDSP_CardUnHandledAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardUnHandledAlarms]  
													  @StartDate datetime=null  ,
													  @EndDate datetime=null	,
													   @SPValue int output
												 

AS
BEGIN
SET NOCOUNT ON;		

--declare @UnHandledAlarms int
			  select @SPValue=count(*) from [dbo].[UDV_AllAlarmsNew]
									where
												[Response_Date] is  null and 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) 

													 
		select 	@SPValue as 'UnHandledAlarms'										
--select cast(@UnHandledAlarms as varchar(max))
SET NOCOUNT OFF;		
END