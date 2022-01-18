/****** Object:  Procedure [dbo].[UDSP_GetAlarmDetails]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmDetails](  @Region nvarchar(max)=null		,
													@Camera nvarchar(max)=null     ,
													@Scenario nvarchar(max)=null       ,
													@Priority nvarchar(max)=null        ,
													@Classification nvarchar(max)=null      ,
													@AlarmIDFrom int=null,
													@AlarmIDTo int=null,
													@Limitation int=null,
													@StartDate datetime=null        ,
													@EndDate datetime=null
													,
													@TotalAlarms int OUT
													)
AS
BEGIN


SET FMTONLY OFF; 
			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			declare @sqlstr2 nvarchar(max)
			
			set @sqlstr=' declare @total decimal ';
			set @sqlstr2='    ';
			
			
		
-------------------------------------------------Alarms Total Number--------------------------------------------------------
		set @wherecode=''
				if(@Region!='' or @Region!=null)
				begin
					set @wherecode+='[ZoneID] in ('+@Region+') AND '
				end 

				if(@Camera!='' or @Camera!=null)
				begin
					set @wherecode+='  TouchPointID in ('+@Camera+')  AND '
				end 

				if(@Scenario!='' or @Scenario!=null)
				begin
					set @wherecode+='  ScenarioID in ('+@Scenario+') AND'
				end 

				if(@Classification!='' or @Classification!=null)
				begin
					set @wherecode+='  AlarmStatusID in ('+@Classification+') AND'
				end 

				if(@Priority!='' or @Priority!=null)
				begin
					set @wherecode+='  AlarmClassificationID in ('+@Priority+') AND'
				end 
			


				if(@AlarmIDFrom!='0' or @AlarmIDFrom!=null)
				begin
					set @wherecode+='[AlarmID]>='+cast(@AlarmIDFrom as varchar(20))+' AND'
				end 
					


				if(@AlarmIDTo!='0' or @AlarmIDTo!=null)
				begin
					set @wherecode+='[AlarmID]<='+cast(@AlarmIDTo as varchar(20))+' AND'
				end 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(20), @StartDate, 100)+''' AND'
				end


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(20), @EndDate   , 100)+''' AND'
				end




if(@wherecode='')

--edit by Abouelela 2019-02-13
--set @sqlstr+=' select top('+cast(@Limitation as nvarchar(max))+') [ScenarioTitle1] as ''ScenarioName'',[AlarmID],[ZoneTitle1] as ''RegionName'',[TouchPointTitle1] as ''CameraName'',[Response_User] as ''OperatorName'',[Occurance_Date] as ''OccuranceDate'',[Response_Date] as ''ResponseDate'',[AlarmDefinitionTitle1] as ''AlarmDefinitionTitle'',[AlarmClassificationTitle1] as ''PriorityName'',[AlarmStatusTitle1] as  ''ClassificationName'',[AlarmComment]  as ''Comment'' from UDV_AllScenariosNew order by [Occurance_Date] desc'
	if(@Limitation>=0)
		begin
			set @sqlstr+=' select top('+cast(@Limitation as nvarchar(max))+') [ScenarioTitle1] as ''ScenarioName'',[AlarmID],[ZoneTitle1] as ''RegionName'',[TouchPointTitle1] as ''CameraName'',[Response_User] as ''OperatorName'',[Occurance_Date] as ''OccuranceDate'',[Response_Date] as ''ResponseDate'',[AlarmDefinitionTitle1] as ''AlarmDefinitionTitle'',[AlarmClassificationTitle1] as ''PriorityName'',[AlarmStatusTitle1] as  ''ClassificationName'',[AlarmClassificationTitle2] as ''PriorityName2'',[AlarmStatusTitle2] as  ''ClassificationName2'',[AlarmComment]  as ''Comment'' from UDV_AllScenariosNew order by [Occurance_Date] desc';
			SET @sqlstr2 +=' select @totalA=count(*) from UDV_AllScenariosNew';
		end
	else
		begin
		set @sqlstr+=' select  [ScenarioTitle1] as ''ScenarioName'',[AlarmID],[ZoneTitle1] as ''RegionName'',[TouchPointTitle1] as ''CameraName'',[Response_User] as ''OperatorName'',[Occurance_Date] as ''OccuranceDate'',[Response_Date] as ''ResponseDate'',[AlarmDefinitionTitle1] as ''AlarmDefinitionTitle'',[AlarmClassificationTitle1] as ''PriorityName'',[AlarmStatusTitle1] as  ''ClassificationName'',[AlarmClassificationTitle2] as ''PriorityName2'',[AlarmStatusTitle2] as  ''ClassificationName2'',[AlarmComment]  as ''Comment'' from UDV_AllScenariosNew order by [Occurance_Date] desc'
		SET @sqlstr2 +=' select @totalA=count(*) from UDV_AllScenariosNew';
		end
else
	begin
		set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
		if(@Limitation>0)
			begin
			set @sqlstr+=' select top('+cast(@Limitation as nvarchar(max))+') [ScenarioTitle1] as ''ScenarioName'',[AlarmID],[ZoneTitle1] as ''RegionName'',[TouchPointTitle1] as ''CameraName'',[Response_User] as ''OperatorName'',[Occurance_Date] as ''OccuranceDate'',[Response_Date] as ''ResponseDate'',[AlarmDefinitionTitle1] as ''AlarmDefinitionTitle'',[AlarmClassificationTitle1] as  ''PriorityName'',[AlarmStatusTitle1] as  ''ClassificationName'',[AlarmClassificationTitle2] as  ''PriorityName2'',[AlarmStatusTitle2] as  ''ClassificationName2'',[AlarmComment]  as ''Comment'' from UDV_AllScenariosNew where '+@wherecode+' order by [Occurance_Date] desc';
			SET @sqlstr2 +=' select @totalA=count(*) from UDV_AllScenariosNew where '+@wherecode;
			end
		else
			begin
				set @sqlstr+=' select [ScenarioTitle1] as ''ScenarioName'',[AlarmID],[ZoneTitle1] as ''RegionName'',[TouchPointTitle1] as ''CameraName'',[Response_User] as ''OperatorName'',[Occurance_Date] as ''OccuranceDate'',[Response_Date] as ''ResponseDate'',[AlarmDefinitionTitle1] as ''AlarmDefinitionTitle'',[AlarmClassificationTitle1] as  ''PriorityName'',[AlarmStatusTitle1] as  ''ClassificationName'',[AlarmClassificationTitle2] as  ''PriorityName2'',[AlarmStatusTitle2] as  ''ClassificationName2'',[AlarmComment]  as ''Comment'' from UDV_AllScenariosNew where '+@wherecode+' order by [Occurance_Date] desc'
			end	
	End

	
	print @sqlstr	
	print @sqlstr2
	execute(@sqlstr)
	
	DECLARE @ParmDefinition nvarchar(500);
	SET @ParmDefinition = N'@totalA int OUTPUT';
	EXECUTE sp_executesql @sqlstr2,@ParmDefinition,@totalA=@TotalAlarms OUTPUT;
	
END