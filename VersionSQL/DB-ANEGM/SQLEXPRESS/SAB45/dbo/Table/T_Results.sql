/****** Object:  Table [dbo].[T_Results]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Results](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[StoredProcedureID] [int] NULL,
	[StoredProcedureValue] [nvarchar](100) NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_Results] PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

create trigger [dbo].[UDT_ResultListener] on [dbo].[T_Results]
for update
as
begin
insert into [dbo].[T_ResultsLog]([StoredProcedureID],[StoredProcedureValue],[ActionDate])
select d.[StoredProcedureID],d.[StoredProcedureValue],d.[ActionDate]
from
deleted d
end

ALTER TABLE [dbo].[T_Results] ENABLE TRIGGER [UDT_ResultListener]