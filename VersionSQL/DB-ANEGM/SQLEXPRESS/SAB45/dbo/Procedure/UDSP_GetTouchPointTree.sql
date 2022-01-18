/****** Object:  Procedure [dbo].[UDSP_GetTouchPointTree]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE Procedure [dbo].[UDSP_GetTouchPointTree] (
									@tpTitle nvarchar(100)= null ,
									@Type nvarchar(100) =null
									)
as 

declare @temp table (
      [TouchPointID] int
      ,[TouchPointTitle1] nvarchar(100)
      ,[TouchPointDescriptionTitle1] nvarchar(100)
      ,[TouchPointTypeID] int
	  ,Lat nvarchar(100)
	  ,Long nvarchar(100)
	  ,ZoomLevel int
	  ,MapTypeID int
)
declare @wherecode nvarchar(max)
set @wherecode=''
				 				
if(@Type!='' or @Type!=null)
begin
	set @wherecode+='  tp.TouchPointTypeID in '+@Type+' AND '
end 
if(@tpTitle!='' or @tpTitle!=null)
begin
	set @wherecode+='  tp.TouchPointTitle1 like ''%'+@tpTitle+'%'' AND '
end 

if(@wherecode !='')
begin
set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
--set @tpTitle ='obile'
insert into @temp execute 
('SELECT tp.[TouchPointID] '+
'     ,tp.[TouchPointTitle1] '+
'     ,tp.[TouchPointDescriptionTitle1] '+
'     ,tp.[TouchPointTypeID] '+
--'	  ,tpg.GeographyPoint.Long as "Lat" '+
--'	  ,tpg.GeographyPoint.Lat as "Long" '+
'	  ,tpg.ZoomLevel '+
'	  ,tpg.MapTypeID '+
'  FROM [dbo].[T_TouchPoints] tp  '+
'  left join [dbo].[T_TouchPointGeographyDetails] tpg on tpg.TouchPointID = tp.TouchPointID where' + @wherecode )
 end 

if(@wherecode = '')
begin
insert into @temp execute
('SELECT tp.[TouchPointID] '+
'     ,tp.[TouchPointTitle1] '+
'     ,tp.[TouchPointDescriptionTitle1] '+
'     ,tp.[TouchPointTypeID] '+
--'	  ,tpg.GeographyPoint.Long as "Lat" '+
--'	  ,tpg.GeographyPoint.Lat as "Long" '+
'	  ,tpg.ZoomLevel '+
'	  ,tpg.MapTypeID '+
'  FROM [dbo].[T_TouchPoints] tp  '+
'  left join [dbo].[T_TouchPointGeographyDetails] tpg on tpg.TouchPointID = tp.TouchPointID ' )
 end 
 select * from @temp