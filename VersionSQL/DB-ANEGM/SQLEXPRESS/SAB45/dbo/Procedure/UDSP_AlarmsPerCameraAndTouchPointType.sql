/****** Object:  Procedure [dbo].[UDSP_AlarmsPerCameraAndTouchPointType]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_AlarmsPerCameraAndTouchPointType](
													
													@StartDate datetime=null    ,
													@EndDate datetime=null
													)
AS
BEGIN
SET NOCOUNT ON;	
SET FMTONLY OFF;

			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr=' '
-------------------------------------------------Alarms Total Number--------------------------------------------------------
		set @wherecode=''
				

				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(20), @StartDate, 120)+':000'' AND'
				end 
				if(@StartDate ='' or @StartDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
				end

				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(20), @EndDate    , 120)+':000'' AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
				end

				if(@wherecode!='')
					set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )



-----------------------------------------------------------------------------------------------------------------------------

if(@wherecode='')
--set @sqlstr+=' select  TouchPointTitle1 as ''SourceName'',count(*) as ''No_OF_Alarm''  from [dbo].[UDV_AllAlarmsNew]  group by  TouchPointTitle1 order by 1 desc' -- 12262018
set @sqlstr+=' select  TouchPointCode as ''SourceName'',TouchPointTypeID,TouchPointTypeName,count(*) as ''No_OF_Alarm''  from [dbo].[UDV_AllAlarmsNew]  where (lStateID = 1) AND (TStateID = 1) AND (TLStateID = 1)  group by  TouchPointCode ,TouchPointTypeID,TouchPointTypeName order by 1 desc'
	
else
begin

--set @sqlstr+='select  TouchPointTitle1 as ''SourceName'',count(*) as ''No_OF_Alarm''  from [dbo].[UDV_AllAlarmsNew] where '+@wherecode+'  group by  TouchPointTitle1 order by 1 desc' -- 12262018
set @sqlstr+='select  TouchPointCode as ''SourceName'',TouchPointTypeID,TouchPointTypeName,count(*) as ''No_OF_Alarm''  from [dbo].[UDV_AllAlarmsNew] where (lStateID = 1) AND (TStateID = 1) AND  (TLStateID = 1) AND  '+@wherecode+'  group by  TouchPointCode,TouchPointTypeID,TouchPointTypeName order by 1 desc'
end


 print @sqlstr
	execute(@sqlstr)
SET NOCOUNT OFF;	
END