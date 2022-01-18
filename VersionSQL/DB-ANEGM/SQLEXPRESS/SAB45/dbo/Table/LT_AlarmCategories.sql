/****** Object:  Table [dbo].[LT_AlarmCategories]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_AlarmCategories](
	[AlarmCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmCategoryTitle1] [nvarchar](200) NULL,
	[AlarmCategoryTitle2] [nvarchar](200) NULL,
	[AlarmCategoryDescriptionTitle1] [nvarchar](4000) NULL,
	[AlarmCategoryDescriptionTitle2] [nvarchar](4000) NULL,
	[DashboardColor] [nvarchar](20) NULL,
	[ComponentURL] [nvarchar](250) NULL,
	[AlarmCategoryCode] [nvarchar](250) NULL,
 CONSTRAINT [AlarmCategories_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_AlarmCat] UNIQUE NONCLUSTERED 
(
	[AlarmCategoryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE trigger [dbo].[UDT_DeleteAlarmCategoryRole] on [dbo].[LT_AlarmCategories]
for delete
as
begin

declare @roleID int = (select roleid from T_Role where RoleName = (select [AlarmCategoryTitle1] from deleted )and StateID = 1)
update T_Role set StateID = 3 where roleid= @roleID 
end

ALTER TABLE [dbo].[LT_AlarmCategories] ENABLE TRIGGER [UDT_DeleteAlarmCategoryRole]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE trigger [dbo].[UDT_SetAlarmCategoryRole] on [dbo].[LT_AlarmCategories]
after Insert
as
begin
Declare @alarmCatID int = (select [AlarmCategoryID] from inserted);
Declare @AlarmCatName nvarchar(100) = (select [AlarmCategoryTitle1] from inserted );
Declare @RoleTypeID int = (SELECT [RoleTypeID] FROM [dbo].[LT_RoleType] where [RoleTypeName] ='Alarm Category'  )
insert into [dbo].[T_Role] ([RoleCode],[RoleName],[RoleTypeID],[StateID],[RoleDescription])  values (@AlarmCatName,@AlarmCatName,@RoleTypeID,1,null); --select * FROM [SAB45].[dbo].[T_Role]
declare @RoleID int = (select TOP 1  RoleID from T_Role where RoleName=@AlarmCatName and StateID = 1 ORDER BY RoleID DESC)
insert into [dbo].[T_RoleInformation] ([RoleID],[Title],[Value]) values (@RoleID,@AlarmCatName,@alarmCatID)--SELECT *  FROM [SAB45].[dbo].[T_RoleInformation]
end

ALTER TABLE [dbo].[LT_AlarmCategories] ENABLE TRIGGER [UDT_SetAlarmCategoryRole]