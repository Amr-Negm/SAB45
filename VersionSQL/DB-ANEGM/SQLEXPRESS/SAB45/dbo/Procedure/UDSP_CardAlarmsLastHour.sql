/****** Object:  Procedure [dbo].[UDSP_CardAlarmsLastHour]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAlarmsLastHour]  
													  @StartDate datetime=null  ,
													  @EndDate datetime=null	,
													   @SPValue int output													  
													  

AS
BEGIN
SET NOCOUNT ON;		

--declare @LastHourAlarms int
			  select @SPValue=count(*) from [dbo].[UDV_AllAlarmsNew]
									where
										[Occurance_Date]>=DateAdd(HH,-1,GetDate())				

						select @SPValue as 'LastHourAlarms'							 
													
--select cast(@LastHourAlarms as varchar(max))
SET NOCOUNT OFF;		
END