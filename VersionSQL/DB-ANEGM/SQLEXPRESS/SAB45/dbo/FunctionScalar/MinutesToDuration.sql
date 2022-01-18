/****** Object:  Function [dbo].[MinutesToDuration]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[MinutesToDuration]
(
    @minutes int 
)
RETURNS nvarchar(30)

AS
BEGIN
declare @hours  nvarchar(20)

SET @hours = 
    CASE WHEN @minutes >= 60 THEN
        (SELECT case when CAST((@minutes / 60) AS int)>9
						then  CAST((@minutes / 60) AS varchar(2))+ ':' +
								case when CAST((@minutes % 60) AS int) >9
								then  CAST((@minutes % 60) AS varchar(2))+':00'
								else
									'0'+CAST((@minutes % 60) AS varchar(2))+':00'
								end
						else
						'0'+CAST((@minutes / 60) AS varchar(2))+ ':' +
								case when CAST((@minutes % 60) AS int) >9
								then  CAST((@minutes % 60) AS varchar(2))+':00'
								else
									'0'+CAST((@minutes % 60) AS varchar(2))+':00'
								end
						end  
                )
    ELSE 
        case when CAST((@minutes % 60) AS int) >9
								then '00:'+ CAST((@minutes % 60) AS varchar(2))+':00'
								else
									'00:0'+CAST((@minutes % 60) AS varchar(2))+':00'
								end
    END

return @hours
END