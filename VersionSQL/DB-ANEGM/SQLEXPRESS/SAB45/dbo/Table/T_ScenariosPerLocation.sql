/****** Object:  Table [dbo].[T_ScenariosPerLocation]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ScenariosPerLocation](
	[ScenarioID] [int] IDENTITY(1,1) NOT NULL,
	[CityTitle] [nvarchar](100) NULL,
	[Priority] [nvarchar](100) NULL,
	[PTotal] [int] NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_T_ScenariosPerLocation] PRIMARY KEY CLUSTERED 
(
	[ScenarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_ScenariosPerLocation] ADD  CONSTRAINT [DF_T_ScenariosPerLocation_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

create trigger [dbo].[UDT_ScenariosPerLocationListener] on [dbo].[T_ScenariosPerLocation]
for insert 
as
begin
insert into [dbo].[T_ScenariosPerLocationLog]
(ScenarioLogID, CityTitle, Priority, PTotal, ActionDate)
select ScenarioID, CityTitle, Priority, PTotal, ActionDate from [dbo].[T_ScenariosPerLocation]
end

ALTER TABLE [dbo].[T_ScenariosPerLocation] ENABLE TRIGGER [UDT_ScenariosPerLocationListener]