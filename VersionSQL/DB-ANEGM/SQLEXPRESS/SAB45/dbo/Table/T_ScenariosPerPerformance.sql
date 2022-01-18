/****** Object:  Table [dbo].[T_ScenariosPerPerformance]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ScenariosPerPerformance](
	[ScenarioID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Impact] [int] NULL,
	[Count] [int] NULL,
	[ResponseTime] [nvarchar](100) NULL,
	[ExpectedTime] [nvarchar](100) NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_T_ScenariosPerPerformance] PRIMARY KEY CLUSTERED 
(
	[ScenarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_ScenariosPerPerformance] ADD  CONSTRAINT [DF_T_ScenariosPerPerformance_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

Create trigger [dbo].[UDT_ScenariosPerPerformance] on [dbo].[T_ScenariosPerPerformance]
for insert 
as
begin
insert into [dbo].[T_ScenariosPerPerformanceLog]
(ScenarioLogID, Title, Impact, Count, ResponseTime, ExpectedTime, ActionDate)
select ScenarioID,Title, Impact, Count, ResponseTime, ExpectedTime, ActionDate from [dbo].[T_ScenariosPerPerformance]
end
ALTER TABLE [dbo].[T_ScenariosPerPerformance] ENABLE TRIGGER [UDT_ScenariosPerPerformance]