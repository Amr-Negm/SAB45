/****** Object:  Table [dbo].[T_Top10ResultsSourceAndZone]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Top10ResultsSourceAndZone](
	[Top10ID] [int] IDENTITY(1,1) NOT NULL,
	[StoredProcedureID] [int] NULL,
	[RName] [nvarchar](200) NULL,
	[NoOfAlarm] [nvarchar](200) NULL,
	[AvgPerHour] [nvarchar](200) NULL,
	[RLevel] [nvarchar](200) NULL,
	[RID] [int] NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_T_Top10ResultsSource&Zone] PRIMARY KEY CLUSTERED 
(
	[Top10ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_Top10ResultsSourceAndZone] ADD  CONSTRAINT [DF_T_Top10ResultsSource&Zone_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

Create trigger [dbo].[UDT_Top10ResultsSourceAndZoneListener] on [dbo].[T_Top10ResultsSourceAndZone]
for insert
as
begin
insert into [dbo].[T_Top10ResultsSourceAndZoneLog]
(Top10LogID, StoredProcedureID, RName, NoOfAlarm, AvgPerHour, RLevel, RID, ActionDate)
select Top10ID, StoredProcedureID, RName, NoOfAlarm, AvgPerHour, RLevel, RID, ActionDate
from [dbo].[T_Top10ResultsSourceAndZone]

end

ALTER TABLE [dbo].[T_Top10ResultsSourceAndZone] ENABLE TRIGGER [UDT_Top10ResultsSourceAndZoneListener]