/****** Object:  Table [dbo].[T_TotalNumberOfAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TotalNumberOfAlarm](
	[TotalNumberOfAlarmID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmID] [int] NULL,
	[OccuranceDate] [date] NULL,
	[PriorityID] [int] NULL,
	[StoredProcedureID] [int] NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_T_TotalNumberOfAlarm] PRIMARY KEY CLUSTERED 
(
	[TotalNumberOfAlarmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_TotalNumberOfAlarm] ADD  CONSTRAINT [DF_T_TotalNumberOfAlarm_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
create trigger UDT_TotalNumberOfAlarmListener on [dbo].[T_TotalNumberOfAlarm]
for insert 
as
begin
insert into [dbo].[T_TotalNumberOfAlarmLog]
(TotalNumberOfAlarmLogID, AlarmID, OccuranceDate, PriorityID, StoredProcedureID, ActionDate)
select TotalNumberOfAlarmID, AlarmID, OccuranceDate, PriorityID, StoredProcedureID, ActionDate from [dbo].[T_TotalNumberOfAlarm]
end
ALTER TABLE [dbo].[T_TotalNumberOfAlarm] ENABLE TRIGGER [UDT_TotalNumberOfAlarmListener]