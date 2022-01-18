/****** Object:  Table [dbo].[T_PriorityChart]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_PriorityChart](
	[PriorityID] [int] NOT NULL,
	[AlarmPriority] [nvarchar](100) NULL,
	[AlarmTotalNumber] [int] NULL,
	[AvgResponseTime] [int] NULL,
	[ExpectedResponseTime] [int] NULL,
	[Comment] [nvarchar](200) NULL,
	[ActionDate] [datetime] NULL,
	[CountResponseAlarm] [int] NULL,
 CONSTRAINT [PK_T_PriorityChart] PRIMARY KEY CLUSTERED 
(
	[PriorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_PriorityChart] ADD  CONSTRAINT [DF_T_PriorityChart_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE trigger [dbo].[UDT_PriorityChartListener] on [dbo].[T_PriorityChart]
for insert
as
begin
insert into [dbo].[T_PriorityChartLog]
(PriorityID, AlarmPriority, AlarmTotalNumber, AvgResponseTime, ExpectedResponseTime, Comment, ActionDate,CountResponseAlarm)
select PriorityID,AlarmPriority,AlarmTotalNumber,AvgResponseTime,ExpectedResponseTime,Comment,ActionDate,CountResponseAlarm 
from [dbo].[T_PriorityChart]

end

ALTER TABLE [dbo].[T_PriorityChart] ENABLE TRIGGER [UDT_PriorityChartListener]