/****** Object:  Procedure [dbo].[UDSP_GetTop10Alarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetTop10Alarm](
											@City nvarchar(100)=null		,
													@Station nvarchar(100)=null   ,
													@Level nvarchar(100)=null     ,
													@Zone nvarchar(100)=null      ,
													@Camera nvarchar(100)=null    ,
													@StartDate datetime=null    ,
													@EndDate datetime=null
											)
AS
BEGIN

declare @wherecode nvarchar(max)
declare @sqlstr nvarchar(max)


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
				
				
				
				
print @wherecode
if(@wherecode='')
set @sqlstr=
			'select top(10) count(*) as value,AlarmDefinitionTitle1 as Name  '+
						 'from [dbo].[UDV_AllAlarmsActions] 	 '+
						  'group by  AlarmDefinitionTitle1 order by 1 desc'


else
begin
set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
set @sqlstr=
			'select top(10) count(*) as value,AlarmDefinitionTitle1 as Name  '+
						 'from [dbo].[UDV_AllAlarmsActions] 	 where '+@wherecode+
						  ' group by  AlarmDefinitionTitle1 order by 1 desc'

						  print @sqlstr
end
exec(@sqlstr)

			--select top(10) count(*) as value,AlarmDefinitionTitle1 as Name 
			--			 from [dbo].[UDV_AllAlarmsActions] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
			--										[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
			--										[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
			--										[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
			--										[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
			--										[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
			--										[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])		
			--			  group by  AlarmDefinitionTitle1 order by 1 desc



END