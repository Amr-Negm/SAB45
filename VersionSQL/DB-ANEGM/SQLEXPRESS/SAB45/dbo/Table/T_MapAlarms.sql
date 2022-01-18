/****** Object:  Table [dbo].[T_MapAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_MapAlarms](
	[MapAlarmsID] [int] IDENTITY(1,1) NOT NULL,
	[Longitude] [nvarchar](200) NULL,
	[Latitude] [nvarchar](200) NULL,
	[StationTitle1] [nvarchar](200) NULL,
	[AlarmID] [int] NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_T_MapAlarms] PRIMARY KEY CLUSTERED 
(
	[MapAlarmsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_MapAlarms] ADD  CONSTRAINT [DF_T_MapAlarms_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE trigger [dbo].[UDT_MapAlarmsListener] on [dbo].[T_MapAlarms]
for update
as
begin
insert into [dbo].[T_MapAlarmsLog]
(MapAlarmsLogID, Longitude, Latitude, StationTitle1, AlarmID, ActionDate)
select d.MapAlarmsID, d.Longitude, d.Latitude, d.StationTitle1, d.AlarmID, d.ActionDate from deleted d
end
ALTER TABLE [dbo].[T_MapAlarms] DISABLE TRIGGER [UDT_MapAlarmsListener]