/****** Object:  Procedure [dbo].[UDSP_GetRatioTouchpointTypeAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetRatioTouchpointTypeAlarms]( 
														@StartDate datetime=		null,
														@EndDate datetime=			null,
														@TouchpointTypeID int = null
												)
AS
BEGIN
SET NOCOUNT ON;				
SET FMTONLY OFF; 

			
			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			set @sqlstr='  declare @total decimal '
			set @wherecode='   '
			
-------------------------------------------------Alarms Total Number--------------------------------------------------------

				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(25), @StartDate, 121)+''' AND'
				end 
				if(@StartDate ='' or @StartDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date), 120)+''' AND'
				end 

				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25),  @EndDate    , 121)+''' AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
				end

				if(@TouchpointTypeID ='' or @TouchpointTypeID is null)
				begin
					set @TouchpointTypeID=0
				end
-----------------------------------------------------------------------------------------------------------------------------


if(@wherecode='   ')
	begin
			
			set @sqlstr+=' select AlarmDefinitionTitle1 as ''AlarmName'',count(*) as ''TotalCount''  from [dbo].[UDV_AlarmsTouchpointTypes] where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' group by AlarmDefinitionTitle1 '
			
	end
else
	begin
			set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )

		    set @sqlstr+=' select AlarmDefinitionTitle1 as ''AlarmName'',count(*) as ''TotalCount''  from [dbo].[UDV_AlarmsTouchpointTypes] where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and '+@wherecode+' group by AlarmDefinitionTitle1 '
	End

	execute(@sqlstr)
	print(@sqlstr)

								
SET NOCOUNT OFF;	

END







--alter PROCEDURE [dbo].[UDSP_GetRatioTouchpointTypeAlarms]( 
--														@StartDate datetime=		null,
--														@EndDate datetime=			null,
--														@TouchpointTypeID int = null
--												)
--AS
--BEGIN
--SET NOCOUNT ON;				
--SET FMTONLY OFF; 

--			declare @TouchTypeID int
--			declare @wherecode nvarchar(max)
--			declare @sqlstr nvarchar(max)
--			set @sqlstr='  '
--			set @wherecode='  '
--			set @TouchTypeID=@TouchpointTypeID
---------------------------------------------------Alarms Total Number--------------------------------------------------------

--				if(@StartDate!='' or @StartDate!=null)
--				begin
--					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(25), @StartDate, 121)+''' AND'
--				end 
--				if(@StartDate ='' or @StartDate is null)
--				begin
--					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date), 120)+''' AND'
--				end 

--				if(@EndDate!='' or @EndDate!=null)
--				begin
--					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25),  @EndDate    , 121)+''' AND'
--				end
--				if(@EndDate ='' or @EndDate is null)
--				begin
--					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
--				end
-------------------------------------------------------------------------------------------------------------------------------


--if(@wherecode='')
--	begin
			
--			set @sqlstr+=' select AlarmDefinitionTitle1 as ''Scenario'',count(*) as ''Ratio''  from [dbo].[UDV_AlarmsTouchpointTypes] where TouchPointTypeID = @TouchTypeID  group by AlarmDefinitionTitle1 '
--	end
--else
--	begin
--			set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )

--			set @sqlstr+=' select AlarmDefinitionTitle1 as ''Scenario'',count(*) as ''Ratio''  from [dbo].[UDV_AlarmsTouchpointTypes] where TouchPointTypeID ='+ @TouchTypeID+' and '+@wherecode+' group by AlarmDefinitionTitle1 '
--	End

--	execute(@sqlstr)


								
--SET NOCOUNT OFF;	

--END