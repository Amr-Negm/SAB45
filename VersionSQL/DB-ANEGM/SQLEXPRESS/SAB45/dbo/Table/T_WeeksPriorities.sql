/****** Object:  Table [dbo].[T_WeeksPriorities]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_WeeksPriorities](
	[WPID] [int] IDENTITY(1,1) NOT NULL,
	[WPValue] [int] NULL,
	[WPWeek] [nvarchar](100) NULL,
	[PriorityTitle1] [nvarchar](100) NULL,
	[StoredProcedureID] [int] NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_T_WeeksPriorities] PRIMARY KEY CLUSTERED 
(
	[WPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_WeeksPriorities] ADD  CONSTRAINT [DF_T_WeeksPriorities_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

Create trigger [dbo].[UDT_WeeksPrioritiesListener] on [dbo].[T_WeeksPriorities]
for insert
as
begin
insert into [dbo].[T_WeeksPrioritiesLog]
(WPID, WPValue, WPWeek, PriorityTitle1, StoredProcedureID,[ActionDate])
select WPID, WPValue, WPWeek, PriorityTitle1, StoredProcedureID,[ActionDate] from [dbo].[T_WeeksPriorities]
end


ALTER TABLE [dbo].[T_WeeksPriorities] ENABLE TRIGGER [UDT_WeeksPrioritiesListener]