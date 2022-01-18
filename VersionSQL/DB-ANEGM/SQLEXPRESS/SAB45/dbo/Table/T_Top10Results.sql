/****** Object:  Table [dbo].[T_Top10Results]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Top10Results](
	[Top10ID] [int] IDENTITY(1,1) NOT NULL,
	[StoredProcedureID] [int] NULL,
	[StoredProcedureValueName] [nvarchar](200) NULL,
	[StoredProcedureValue] [int] NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_T_Top10Results] PRIMARY KEY CLUSTERED 
(
	[Top10ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_Top10Results] ADD  CONSTRAINT [DF_T_Top10Results_ActionDate]  DEFAULT (sysdatetime()) FOR [ActionDate]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

Create trigger [dbo].[UDT_Top10ResultListener] on [dbo].[T_Top10Results]
for insert
as
begin
insert into [dbo].[T_Top10ResultsLog]
(Top10LogID, StoredProcedureID, StoredProcedureValueName, StoredProcedureValue, ActionDate)
select Top10ID, StoredProcedureID, StoredProcedureValueName, StoredProcedureValue, ActionDate
from [dbo].[T_Top10Results]

end

ALTER TABLE [dbo].[T_Top10Results] ENABLE TRIGGER [UDT_Top10ResultListener]