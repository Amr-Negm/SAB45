/****** Object:  Table [dbo].[HBB_UDTB_AlarmsPerCamera]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_UDTB_AlarmsPerCamera](
	[ActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[SourceName] [nvarchar](150) NULL,
	[No_OF_Alarm] [nvarchar](150) NULL,
	[StoredProcedureID] [int] NULL,
	[Periodid] [int] NULL
) ON [PRIMARY]