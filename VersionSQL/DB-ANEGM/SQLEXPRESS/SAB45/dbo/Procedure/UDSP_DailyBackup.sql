/****** Object:  Procedure [dbo].[UDSP_DailyBackup]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_DailyBackup] @FilePath nvarchar(200),@DatabaseName sysname
as
begin
declare @FileName nvarchar(300)
SELECT @FileName=@FilePath +N'\'+ @DatabaseName+N'_V1.0_' + REPLACE(convert(nvarchar(20),GetDate(),120),':','-') + '.bak'
BACKUP DATABASE @DatabaseName TO DISK=@FileName WITH CHECKSUM
RESTORE VERIFYONLY FROM  DISK = @FileName
end;