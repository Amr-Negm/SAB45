/****** Object:  Procedure [dbo].[UDSP_CardPeekTimeActive]    Committed by VersionSQL https://www.versionsql.com ******/

Create procedure [dbo].[UDSP_CardPeekTimeActive] @ActiveAlarm nvarchar(100) output
as
begin
WITH ActiveAlarms_CTE(TotalAlarm,MaximumHour)
 as
 (

 select count(*) as Value, CONVERT(varchar(3),Occurance_Date,108)+'00'  as Hour 
	from [dbo].[UDV_AllAlarms] 
	 where Response_Date IS NULL
	group by CONVERT(varchar(3),Occurance_Date,108)+'00'

)
select @ActiveAlarm=MaximumHour from ActiveAlarms_CTE
where 
TotalAlarm=(select Max(TotalAlarm) from ActiveAlarms_CTE)
end