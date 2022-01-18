/****** Object:  Procedure [dbo].[UDSP_CardTouchpointTypeTotalEvents]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardTouchpointTypeTotalEvents]  
													  @StartDate datetime=null  ,
													  @EndDate datetime=null ,
													  @TouchpointTypeID int=0
													  

AS
BEGIN
SET NOCOUNT ON;		

SET FMTONLY OFF; 

declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)


			set @sqlstr=''
			set @wherecode=''
-------------------------------------------------Filter--------------------------------------------------------
				set @wherecode=''
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
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25), @EndDate    , 121)+''' AND'
				end

				if(@TouchpointTypeID ='' or @TouchpointTypeID is null)
				begin
					set @TouchpointTypeID=0
				end	
-------------------------------------------------Query--------------------------------------------------------	


			  set @sqlstr='select count(*) as Total   FROM  dbo.T_Events INNER JOIN '+
											' dbo.T_EventDefinitions ON dbo.T_Events.EventDefinitionID = dbo.T_EventDefinitions.EventDefinitionID AND '+ 
											' dbo.T_Events.EventDefinitionSiteID = dbo.T_EventDefinitions.EventDefinitionSiteID INNER JOIN '+
											' dbo.T_TouchPoints ON dbo.T_EventDefinitions.TouchPointIDSource = dbo.T_TouchPoints.TouchPointID '+
										' where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and '+@wherecode+' 1=1'
										
										
									
execute(@sqlstr)
print @sqlstr	
				
SET NOCOUNT OFF;	
SET FMTONLY OFF; 	
END