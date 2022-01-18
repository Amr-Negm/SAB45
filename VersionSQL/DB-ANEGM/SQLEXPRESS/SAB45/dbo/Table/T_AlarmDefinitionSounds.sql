/****** Object:  Table [dbo].[T_AlarmDefinitionSounds]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmDefinitionSounds](
	[AlarmDefinitionSoundID] [int] IDENTITY(1,1) NOT NULL,
	[StopNotificationSoundManually] [bit] NULL,
	[NoOfSoundRepeats] [int] NULL,
	[SoundID] [int] NULL,
	[SoundSiteID] [int] NULL,
	[AlarmDefinitionID] [int] NULL,
	[AlarmDefinitionSiteID] [int] NULL,
 CONSTRAINT [PK_T_AlarmDefinitionSounds] PRIMARY KEY CLUSTERED 
(
	[AlarmDefinitionSoundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlarmDefinitionID] ON [dbo].[T_AlarmDefinitionSounds]
(
	[AlarmDefinitionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_SoundID] ON [dbo].[T_AlarmDefinitionSounds]
(
	[SoundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_AlarmDefinitionSounds] ADD  DEFAULT ((1)) FOR [NoOfSoundRepeats]
ALTER TABLE [dbo].[T_AlarmDefinitionSounds]  WITH CHECK ADD  CONSTRAINT [FK_AlarmDefinitionSounds] FOREIGN KEY([AlarmDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_AlarmDefinitionSounds] CHECK CONSTRAINT [FK_AlarmDefinitionSounds]
ALTER TABLE [dbo].[T_AlarmDefinitionSounds]  WITH CHECK ADD  CONSTRAINT [FK_SoundsOfAlarmDefinition] FOREIGN KEY([SoundID], [SoundSiteID])
REFERENCES [dbo].[T_Sounds] ([SoundID], [SoundSiteID])
ALTER TABLE [dbo].[T_AlarmDefinitionSounds] CHECK CONSTRAINT [FK_SoundsOfAlarmDefinition]