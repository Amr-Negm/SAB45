/****** Object:  Procedure [dbo].[UDSP_CardHBB]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardHBB]  
													  @StartDate datetime=null  ,
													  @EndDate datetime=null
													  

AS
BEGIN
SET NOCOUNT ON;		
SET FMTONLY OFF; 

				declare @HandledAlarms int
				declare @TotalAlarms  int
				declare @UnHandledAlarms int
				declare @LastHourAlarms int
				declare @AverageAlarmsPerHour int
				declare @AverageAlarmsPerDay int
				declare @AverageAlarmsPerWeek int
				declare @AverageAlarmsPerMonth int
				declare @ResponseTime int

				

--------------------------------------------------- Get Total Alarms ------------------------------------------------------

	 select @TotalAlarms=count(AlarmID)  from [dbo].[T_Alarms]
													where 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])			AND 
													[Occurance_Date]<=isnull(@EndDate,[Occurance_Date])	

				--ggggg
--------------------------------------------------- Get Handled Alarms ------------------------------------------------------
			  --select @HandledAlarms=count(AlarmID) from [dbo].[T_Alarms]
					--				where
					--							[Response_Date] is not null and 
					--								[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
					--								[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 

											 
													





--------------------------------------------------- Get UnHandled Alarms ------------------------------------------------------
													
			  --select @UnHandledAlarms=count(AlarmID) from [dbo].[T_Alarms]
					--				where
					--							[Response_Date] is  null and 
					--								[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
					--								[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 

													 
		


--------------------------------------------------- Get LastHour Alarms ------------------------------------------------------
		if(DATEDIFF(hour,@StartDate,@EndDate)=1)
		begin
					select @LastHourAlarms=count(*) from [dbo].[T_Alarms]
									where
										[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 		
		end
		else
		begin
					select @LastHourAlarms=count(*) from [dbo].[T_Alarms]
									where
										[Occurance_Date]>=DateAdd(HH,-1,GetDate())			
		end


--------------------------------------------------- Get AverageAlarmsPerHour ------------------------------------------------------							
				--select @AverageAlarmsPerHour= @TotalAlarms/24 

				 set @AverageAlarmsPerHour= @TotalAlarms/(select case when count(a.cx)=0 then @TotalAlarms+1 else  isnull(count(a.cx),1) end from ( 
													select count(*) as 'cx',DATEPART(hour,Occurance_Date) as 'hour'
													from [dbo].[T_Alarms] 
													where 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 
													 group by DATEPART(hour,Occurance_Date)) a) 


				--select DATEPART(hour,Occurance_Date),count(*) from T_Alarms group by DATEPART(hour,Occurance_Date)






















 set @AverageAlarmsPerDay= @TotalAlarms/(select case when count(a.cx)=0 then @TotalAlarms+1 else  isnull(count(a.cx),1) end from ( 
													select count(*) as 'cx',day(Occurance_Date) as 'day'
													from [dbo].[T_Alarms] 
													where 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 
													 group by day(Occurance_Date)) a) 
													






			 set @AverageAlarmsPerWeek= @TotalAlarms/(select  case when count(a.cx)=0 then @TotalAlarms+1 else COUNT(a.cx) end from ( 
													select count(*) as 'cx',
													'Week ' + cast(datepart(wk, Occurance_Date) as varchar(2)) as 'Week'
													from [dbo].[T_Alarms] 
													where 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 

													 group by 'Week ' + cast(datepart(wk, Occurance_Date) as varchar(2)) ) a) 
													





			 set @AverageAlarmsPerMonth= @TotalAlarms/(select    case when count(a.cx)=0 then @TotalAlarms+1 else COUNT(a.cx) end  from ( 
													select count(*) as 'cx',month(Occurance_Date) as 'month'
													from [dbo].[T_Alarms] 
													where 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 
	
													 group by month(Occurance_Date)) a) 

		select @ResponseTime=avg(ResponseTimeDifference)  from [dbo].[T_Alarms] 
			where
					 ResponseTimeDifference is not null and 
					
					[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
					[Occurance_Date]<=isnull(@EndDate,[Occurance_Date]) 



						select @HandledAlarms as 'HandledAlarms',@TotalAlarms  as 'TotalAlarms' ,@UnHandledAlarms  as'UnHandledAlarms',@LastHourAlarms as 'LastHourAlarms',
								@AverageAlarmsPerHour as 'AverageAlarmsPerHour',@AverageAlarmsPerDay as 'AverageAlarmsPerDay',@AverageAlarmsPerWeek as 'AverageAlarmsPerWeek',
				                @AverageAlarmsPerMonth as 'AverageAlarmsPerMonth',@ResponseTime as 'ResponseTime'
				  
				  
				  
				  


	
SET FMTONLY OFF; 	
END