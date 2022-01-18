/****** Object:  Procedure [dbo].[UDSP_GetPerformanceAnalytics]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetPerformanceAnalytics]( @City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null)
AS
BEGIN
		
		
			declare @TotalAlarm decimal 
			declare @TotalTakenAlarm decimal	
			declare @AverageBerDay int	
			declare @AverageBerHour int 
			declare @AverageBerMinute int	 
			declare @PeekDate varchar(50)  
			declare @PeekTime varchar(5) 
			declare @PeekTimeAck varchar(5)	
			declare @ActiveAlarmAvgTime int  
			declare @PeekTimeActive varchar(5)   
			declare @AckAverageTime int 

			set @PeekTimeActive =0
			set @TotalAlarm=0
			set @TotalTakenAlarm=0
			




			SET FMTONLY OFF; 


			

			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr=''
-------------------------------------------------Alarms Total Number--------------------------------------------------------
		set @wherecode=''
				if(@City!='' or @City!=null)
				begin
					set @wherecode+='CityTitle1='''+@City+''' AND '
				end 

				if(@Station!='' or @Station!=null)
				begin
					set @wherecode+='  [StationTitle1]='''+@Station+''' AND '
				end 

				if(@Level!='' or @Level!=null)
				begin
					set @wherecode+='  [LevelTitle1]='''+@Level+''' AND'
				end 

				if(@Zone!='' or @Zone!=null)
				begin
					set @wherecode+='  [ZoneTitle1]='''+@Zone+''' AND'
				end 

				if(@Camera!='' or @Camera!=null)
				begin
					set @wherecode+='  [TouchPointTitle1]='''+@Camera+''' AND'
				end 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(10), @StartDate, 110)+''' AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(10),DATEADD (day , 1 , @EndDate )   , 110)+''' AND'
				end

				if(@wherecode='')
				begin
						set @sqlstr='	select ResponseTimeDifference,Response_Date,ExpectedResponseTime, Occurance_Date from UDV_AllAlarms'
									
				end
				else
				begin
				set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
						set @sqlstr='	select ResponseTimeDifference,Response_Date,ExpectedResponseTime, Occurance_Date  from UDV_AllAlarms Where '+@wherecode
									
				end
				print(@sqlstr)
				--execute(@sqlstr)
				EXECUTE sp_executesql @sqlstr
---------------------------------------------------Total Alarm------------------------------------------------------isnull(isnull(NULLIF(@City, ''),null),

--	 select @TotalAlarm=count(*)  from [dbo].[UDV_AllAlarms] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(nullif(@Station,''),[StationTitle1])				AND 
--													[LevelTitle1]=isnull(nullif(@Level,''),[LevelTitle1])						AND 
--													[ZoneTitle1]=isnull(nullif(@Zone,''),[ZoneTitle1])							AND 
--													[TouchPointTitle1]=isnull(nullif(@Camera,''),[TouchPointTitle1])			AND
--													[Occurance_Date]>=isnull(nullif(@StartDate,''),[Occurance_Date])			AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,nullif(@EndDate,'')),[Occurance_Date])	
		
	
------------------------------------------------------------------------------------------------

---------------------------------------------------Total Number Taken Actions-------------------	

--			 select @TotalTakenAlarm=count(*)  from [dbo].[UDV_AllAlarmsActions] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1, NULLIF(@EndDate,'')),[Occurance_Date])	
		
-------------------------------------------------------------------------------------------------

---------------------------------------------------AVG. Alarms/Day-------------------------------

--			 select @AverageBerDay= @TotalAlarm/( 
--						 select  isnull(NULLIF(count(a.cx), '0'),1) from ( 
--													select count(*) as 'cx',day(Occurance_Date) as 'day'
--													from [dbo].[UDV_AllAlarms] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1, NULLIF(@EndDate,'')),[Occurance_Date]) 
														
--													 group by day(Occurance_Date)) a) 

------------------------------------------------------------------------------------------------

---------------------------------------------------AVG.Alarms/Hour------------------------------
 
--		 --select @AverageBerHour=cast(round(@TotalAlarm/( 
--			--		select isnull(NULLIF(count(a.cx), '0'),1) from ( 
--			--								   select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour' 
--			--								   from [dbo].[UDV_AllAlarms] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--			--										[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--			--										[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--			--										[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--			--										[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--			--										[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--			--										[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
--			--								    group by DATEPART(HOUR,Occurance_Date)) a),0) as int)

--			select @AverageBerHour=@TotalAlarm/( 
--					select isnull(NULLIF(count(a.cx), '0'),1) from ( 
--											   select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour' 
--											   from [dbo].[UDV_AllAlarms] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
--											    group by DATEPART(HOUR,Occurance_Date)) a)
		
------------------------------------------------------------------------------------------------

---------------------------------------------------AVG.Alarms/10Minute-------------------------- 
		
--			 select @AverageBerMinute=cast(round(@TotalAlarm/( 
--					select  isnull(NULLIF(count(a.cx), '0'),1) from ( 
--											   select count(*) as 'cx',DATEPART(MINUTE,Occurance_Date)/10 as '10minute' 
--											   from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])
--											    group by DATEPART(MINUTE,Occurance_Date)/10 
--											   ) a),0) as int)
		
		
------------------------------------------------------------------------------------------------

---------------------------------------------------Active Alarms AVG.time-------------------------
		
--		 select @ActiveAlarmAvgTime=cast(round( @TotalAlarm/( 
--					select isnull(NULLIF(count(a.cx), '0'),1) from ( 
--												select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour'
--												from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
--												 AND Response_Date is null 
--												 group by DATEPART(HOUR,Occurance_Date)) a),0) as int)
		
------------------------------------------------------------------------------------------------

---------------------------------------------------Peek date alarm------------------------------ 
		
--		select @PeekDate=a.date from( 
--							select top(1) count(*) as 'cx',convert(varchar(50),Occurance_Date,105) as 'date'  
--							from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])
--							 group by CONVERT(varchar(50), Occurance_Date,105) 
--							order by 1 desc) a
		
--		set @PeekDate=isnull(@PeekDate,'00')
--		print @PeekDate
-------------------------------------------------------------------------------------------------
---------------------------------------------------Peek Time alarm------------------------------- 
		
--		 select @PeekTime=a.hour from( 
--							select top(1) count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour'
--							from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])
--							 group by DATEPART(HOUR,Occurance_Date) 
--							order by 1 desc) a
--		set @PeekTime=isnull(@PeekTime,'0')
--		print @PeekTime
------------------------------------------------------------------------------------------------
---------------------------------------------------Acknowledgement Average time------------------- 
		
--		 select  @AckAverageTime=cast(round((sum(isnull(ResponseTimeDifference,0))/ isnull(NULLIF(count(*), '0'),1)),0) as int) 
--										from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date]) AND
--													ResponseTimeDifference!=0
--		set @AckAverageTime=isnull(@AckAverageTime,'0')
--		print @AckAverageTime
------------------------------------------------------------------------------------------------SELECT dbo.MinutesToDuration(750)

---------------------------------------------------Peek Time Acknowledgement---------------------
		
--			 select @PeekTimeAck=a.hour from( 
--						select top(1) count(*) as 'cx',DATEPART(HOUR,Response_Date) as 'hour'
--						from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date]) AND
--													ResponseTimeDifference!=0
--						 group by DATEPART(HOUR,Response_Date) 
--						order by 1 desc) a
--	set @PeekTimeAck=isnull(@PeekTimeAck,'0')
--		print @PeekTimeAck
------------------------------------------------------------------------------------------------

---------------------------------------------------Peek Time Active alarm------------------------ 
	
--		 select @PeekTimeActive=a.hour from( 
--						select top(1) count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour'
--						from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
--													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
--													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
--													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
--													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
--													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
--													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])
--						 and Response_Date is null 
--						 group by DATEPART(HOUR,Occurance_Date) order by 1 desc) a
--set @PeekTimeActive=isnull(@PeekTimeActive,'0')
--print @PeekTimeActive
------------------------------------------------------------------------------------------------------

-------------------------------------------------Get All Data----------------------------------------

--	 select  cast(@TotalAlarm as varchar(20)) as 'TotalAlarm',
--						cast(@TotalTakenAlarm as varchar(20)) as 'TotalTakenAlarm',
--						cast (@AverageBerDay as varchar(20)) as 'AverageBerDay',
--						cast(@AverageBerHour as varchar(20)) as 'AverageBerHour', 
--						cast(@AverageBerMinute as varchar(20)) as 'AverageBerMinute',
--						cast(@PeekDate as varchar(30)) as 'PeekDate', 
--						cast (dbo.MinutesToDuration(@PeekTime) as varchar(20)) as 'PeekTime', 
--						cast(dbo.MinutesToDuration( @AckAverageTime) as varchar(20)) as 'AckAverageTime', 
--						cast(@PeekTimeAck as varchar(20))+':00' as 'PeekTimeAck', 
--						cast(dbo.MinutesToDuration( @ActiveAlarmAvgTime) as varchar(20)) as 'ActiveAlarmAvgTime', 
--						cast(@PeekTimeActive as varchar(20)) +':00' as 'PeekTimeActive'

------------------------------------------------------------------------------------------------

END