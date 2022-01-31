/****** Object:  Table [dbo].[T_EventAttachedFile]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_EventAttachedFile](
	[EventAttachedFileID] [int] IDENTITY(1,1) NOT NULL,
	[AttachedFile] [nvarchar](max) NULL,
	[EventID] [int] NULL,
	[EventSiteID] [int] NULL,
	[EventAttachedTypeID] [int] NULL,
	[AttachedFileName] [nvarchar](100) NULL,
 CONSTRAINT [PK_AlarmAttachedFile] PRIMARY KEY CLUSTERED 
(
	[EventAttachedFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER [dbo].[DeleteEventAttachement] ON  [dbo].[T_EventAttachedFile]
   AFTER delete
AS 
BEGIN
	SET NOCOUNT ON;
	Delete from SAB45_EVENTS.dbo.[T_EventAttachedFile] where EventAttachedFileID = (select EventAttachedFileID from deleted)
END

ALTER TABLE [dbo].[T_EventAttachedFile] ENABLE TRIGGER [DeleteEventAttachement]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER [dbo].[NewEventAttachement] ON  [dbo].[T_EventAttachedFile]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	insert into SAB45_EVENTS.dbo.[T_EventAttachedFile] select * from inserted i
END

ALTER TABLE [dbo].[T_EventAttachedFile] DISABLE TRIGGER [NewEventAttachement]Delete from SAB45_EVENTS.dbo.[T_EventAttachedFile] where EventAttachedFileID = (select EventAttachedFileID from deleted)
END

ALTER TABLE [dbo].[T_EventAttachedFile] ENABLE TRIGGER [DeleteEventAttachement]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER [dbo].[NewEventAttachement] ON  [dbo].[T_EventAttachedFile]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	insert into SAB45_EVENTS.dbo.[T_EventAttachedFile] select * from inserted i
END

ALTER TABLE [dbo].[T_EventAttachedFile] ENABLE TRIGGER [NewEventAttachement]