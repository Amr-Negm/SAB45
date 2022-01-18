/****** Object:  Table [dbo].[T_Location]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Location](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](2000) NULL,
	[CreationUserID] [nvarchar](50) NULL,
	[CreationDate] [datetime2](7) NULL,
	[LocationTypeId] [int] NULL,
	[LocationCategoryId] [int] NULL,
	[ParentLocationID] [int] NULL,
	[StateID] [int] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_LocationCategory] ON [dbo].[T_Location]
(
	[LocationCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_LocationState] ON [dbo].[T_Location]
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_LocationType] ON [dbo].[T_Location]
(
	[LocationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ParentLocation] ON [dbo].[T_Location]
(
	[ParentLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Location]  WITH CHECK ADD  CONSTRAINT [FK_LocationCategory] FOREIGN KEY([LocationCategoryId])
REFERENCES [dbo].[LT_LocationCategory] ([LocationCategoryId])
ALTER TABLE [dbo].[T_Location] CHECK CONSTRAINT [FK_LocationCategory]
ALTER TABLE [dbo].[T_Location]  WITH CHECK ADD  CONSTRAINT [FK_LocationType] FOREIGN KEY([LocationTypeId])
REFERENCES [dbo].[LT_LocationType] ([LocationTypeId])
ALTER TABLE [dbo].[T_Location] CHECK CONSTRAINT [FK_LocationType]
ALTER TABLE [dbo].[T_Location]  WITH CHECK ADD  CONSTRAINT [FK_ParentLocation] FOREIGN KEY([ParentLocationID])
REFERENCES [dbo].[T_Location] ([LocationID])
ALTER TABLE [dbo].[T_Location] CHECK CONSTRAINT [FK_ParentLocation]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



-- =============================================
-- Author:		Shahed
-- Create date: 16 July 2020
-- Description:	To keep event definition iin sab events db updated
-- =============================================
CREATE TRIGGER [dbo].[NewLocation]
   ON  [dbo].[T_Location]
   AFTER INSERT , UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	
ALTER TABLE [SAB45_Events].[dbo].[T_LocationMapData] DROP CONSTRAINT [FK_LocationMapData]

ALTER TABLE [SAB45_Events].[dbo].[T_TouchPointLocation] DROP CONSTRAINT [FK_Location_TouchPointLocation]

ALTER TABLE [SAB45_Events].[dbo].[T_TouchPointLocationTrack] DROP CONSTRAINT [FK_Location_TouchPointLocationTrack]

ALTER TABLE  [SAB45_Events].[dbo].[T_Location] DROP CONSTRAINT [FK_ParentLocation]

DELETE [SAB45_Events].[dbo].[T_Location] WHERE LocationID IN (SELECT LocationID FROM deleted d)

INSERT [SAB45_Events].[dbo].[T_Location] SELECT * FROM inserted i

ALTER TABLE [SAB45_Events].[dbo].[T_LocationMapData]  WITH NOCHECK ADD  CONSTRAINT [FK_LocationMapData] FOREIGN KEY([LocationID])
REFERENCES [SAB45_Events].[dbo].[T_Location] ([LocationID])

ALTER TABLE [SAB45_Events].[dbo].[T_TouchPointLocation]  WITH CHECK ADD  CONSTRAINT [FK_Location_TouchPointLocation] FOREIGN KEY([LocationID])
REFERENCES  [SAB45_Events].[dbo].[T_Location] ([LocationID])

ALTER TABLE [SAB45_Events].[dbo].[T_TouchPointLocationTrack]  WITH CHECK ADD  CONSTRAINT [FK_Location_TouchPointLocationTrack] FOREIGN KEY([LocationID])
REFERENCES  [SAB45_Events].[dbo].[T_Location] ([LocationID])

ALTER TABLE [SAB45_Events].[dbo].[T_Location]  WITH CHECK ADD  CONSTRAINT [FK_ParentLocation] FOREIGN KEY([ParentLocationID])
REFERENCES [SAB45_Events].[dbo].[T_Location] ([LocationID])

END

ALTER TABLE [dbo].[T_Location] ENABLE TRIGGER [NewLocation]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE trigger [dbo].[UDT_DeleteLocationRole] on [dbo].[T_Location]
after update
as
begin
declare @LocationID int = (select LocationID from deleted)
declare @LocationOldName nvarchar(50) = (select Name from deleted)
declare @LocationNewName nvarchar(50) = (select Name from T_Location where LocationID=@LocationID)

declare @Code				nvarchar(200) = (select Code				from t_location where locationid=@locationID)
declare @Description		nvarchar(200) = (select Description			from t_location where locationid=@locationID)
declare @CreationUserID int				  = (select CreationUserID 	from t_location where locationid=@locationID)
declare @CreationDate datetime			  = (select CreationDate from t_location where locationid=@locationID)
declare @LocationTypeId int				  = (select LocationTypeId from t_location where locationid=@locationID)
declare @LocationCategoryId int 		  = (select LocationCategoryId	from t_location where locationid=@locationID)
declare @ParentLocationID int			  = (select ParentLocationID 	from t_location where locationid=@locationID)
declare @StateID int			  = (select StateID 	from t_location where locationid=@locationID)
if (select StateID from T_Location where LocationID = @LocationID) = 3
	begin
		update T_Role set StateID = 3 where RoleName = (select [Name] from T_Location where LocationID = @LocationID) 
	end
update T_Role set RoleName = @LocationNewName where RoleName = @LocationOldName and StateID <> 3
end

ALTER TABLE [dbo].[T_Location] ENABLE TRIGGER [UDT_DeleteLocationRole]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE trigger [dbo].[UDT_SetLocationRole] on [dbo].[T_Location]
after Insert
as
begin
Declare @LocationID int = (select i.LocationID from Inserted i);
Declare @LocationName nvarchar(100) = (select i.Name from Inserted i);
Declare @LocationCode nvarchar(100) = (select i.Code from Inserted i);
Declare @RoleTypeID int= (SELECT [RoleTypeID] FROM [dbo].[LT_RoleType] where [RoleTypeName] =N'Location' )
insert into [dbo].[T_Role]([RoleCode],[RoleName],[RoleTypeID],[StateID],[RoleDescription]) values (@LocationCode,@LocationName,@RoleTypeID,1,null); --select * FROM [SAB45].[dbo].[T_Role]
declare @RoleID int = (select top 1 RoleID from T_Role where RoleName=@LocationName and StateID = 1 order by RoleID desc)
insert into [dbo].[T_RoleInformation]([RoleID],[Title],[Value]) values (@RoleID,@LocationName,@LocationID)--SELECT *  FROM [SAB45].[dbo].[T_RoleInformation]
end

ALTER TABLE [dbo].[T_Location] ENABLE TRIGGER [UDT_SetLocationRole]