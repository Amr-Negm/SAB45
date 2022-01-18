/****** Object:  Procedure [dbo].[USDP_GetTPParms]    Committed by VersionSQL https://www.versionsql.com ******/

-- exec [dbo].[USDP_GetTPParms] '(117535,117537)' 
CREATE procedure [dbo].[USDP_GetTPParms] @TPIDs nvarchar(max)
as

Declare @result table (
TouchPointID int , 
TouchpointName nvarchar(50),
TPParmID int ,
TouchPointParmKey nvarchar(50),
TouchPointParmTitle1 nvarchar(50),
StringValue nvarchar(max),
BinaryValue nvarchar(max)
--OnOffState Nvarchar(250)

)
INSERT INTO @result
execute (
'
select 
TP.TouchPointID, 
TP.TouchPointTitle1 AS TouchpointName,
tpp.TPParmID,
tptp.TouchPointParmKey,
tptp.TouchPointParmTitle1,
Case when pkt.[ParmKeyTypeTitle1] = ''ComboBox'' then pl.[ParmLookupTitle1] 
else tpp.StringValue end  as StringValue,
tpp.BinaryValue

FROM		
T_TouchPoints			TP	
inner join T_TouchPointTypeParms tptp on tptp.TouchPointTypeID = tp.TouchPointTypeID
left join LT_ParmKeyTypes pkt on pkt.ParmKeyTypeID = tptp.ParmKeyTypeID
inner join T_TouchPointParms tpp on tpp.TouchPointID = tp.TouchPointID and tpp.TPParmID=tptp.TPParmID
left join LT_ParmLookups pl on pl.[ParmLookupID] = try_convert(int,tpp.StringValue)

WHERE TP.StateID = 1 and TP.TouchPointID in '+@TPIDs)

select * from @result