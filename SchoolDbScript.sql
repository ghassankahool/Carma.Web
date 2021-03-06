USE [SchoolDb]
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'View_Students', NULL,NULL))
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Students'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'View_Students', NULL,NULL))
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Students'
GO
/****** Object:  StoredProcedure [dbo].[Students_SelectList]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[Students_SelectList]
GO
/****** Object:  StoredProcedure [dbo].[Students_Save]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[Students_Save]
GO
/****** Object:  StoredProcedure [dbo].[Students_List]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[Students_List]
GO
/****** Object:  StoredProcedure [dbo].[Students_Delete]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[Students_Delete]
GO
/****** Object:  StoredProcedure [dbo].[Genders_Names]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[Genders_Names]
GO
/****** Object:  StoredProcedure [dbo].[Classrooms_Names]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[Classrooms_Names]
GO
/****** Object:  View [dbo].[View_Students]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP VIEW IF EXISTS [dbo].[View_Students]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP TABLE IF EXISTS [dbo].[Genders]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP TABLE IF EXISTS [dbo].[Students]
GO
/****** Object:  Table [dbo].[Classrooms]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP TABLE IF EXISTS [dbo].[Classrooms]
GO
USE [master]
GO
/****** Object:  Database [SchoolDb]    Script Date: 5/16/2018 9:28:03 PM ******/
DROP DATABASE IF EXISTS [SchoolDb]
GO
/****** Object:  Database [SchoolDb]    Script Date: 5/16/2018 9:28:03 PM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'SchoolDb')
BEGIN
CREATE DATABASE [SchoolDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\SchoolDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SchoolDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\SchoolDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [SchoolDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchoolDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SchoolDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SchoolDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SchoolDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SchoolDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SchoolDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [SchoolDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SchoolDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SchoolDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SchoolDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SchoolDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SchoolDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SchoolDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SchoolDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SchoolDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SchoolDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SchoolDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SchoolDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SchoolDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SchoolDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SchoolDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SchoolDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SchoolDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SchoolDb] SET  MULTI_USER 
GO
ALTER DATABASE [SchoolDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SchoolDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SchoolDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SchoolDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SchoolDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SchoolDb] SET QUERY_STORE = OFF
GO
USE [SchoolDb]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [SchoolDb]
GO
/****** Object:  Table [dbo].[Classrooms]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Classrooms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Classrooms](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[classroom_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Classrooms] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Students]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Students](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[classroom_id] [int] NULL,
	[student_image] [nvarchar](50) NULL,
	[balance] [decimal](18, 2) NULL,
	[gender] [int] NULL,
	[dob] [date] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Genders]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Genders](
	[id] [int] NOT NULL,
	[gender_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Genders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[View_Students]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[View_Students]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[View_Students]
AS
SELECT        dbo.Students.id, dbo.Students.name, dbo.Students.classroom_id, dbo.Students.student_image, dbo.Students.balance, dbo.Students.gender, dbo.Students.dob, dbo.Classrooms.classroom_name, 
                         dbo.Genders.gender_name
FROM            dbo.Classrooms INNER JOIN
                         dbo.Students ON dbo.Classrooms.id = dbo.Students.classroom_id INNER JOIN
                         dbo.Genders ON dbo.Students.gender = dbo.Genders.id
' 
GO
SET IDENTITY_INSERT [dbo].[Classrooms] ON 
GO
INSERT [dbo].[Classrooms] ([id], [classroom_name]) VALUES (1, N'Grade 1')
GO
INSERT [dbo].[Classrooms] ([id], [classroom_name]) VALUES (2, N'Grade 2')
GO
SET IDENTITY_INSERT [dbo].[Classrooms] OFF
GO
INSERT [dbo].[Genders] ([id], [gender_name]) VALUES (1, N'Male')
GO
INSERT [dbo].[Genders] ([id], [gender_name]) VALUES (2, N'Female')
GO
SET IDENTITY_INSERT [dbo].[Students] ON 
GO
INSERT [dbo].[Students] ([id], [name], [classroom_id], [student_image], [balance], [gender], [dob]) VALUES (2, N'Aliaa Galal', 2, N'fd36c916-6034-4c4b-aca3-c3a72eaa66d7.jpg', CAST(70.00 AS Decimal(18, 2)), 2, CAST(N'2018-05-23' AS Date))
GO
INSERT [dbo].[Students] ([id], [name], [classroom_id], [student_image], [balance], [gender], [dob]) VALUES (3, N'mm', 2, N'5791dc31-1dd4-4eae-ada3-ecef632df5f2.jpg', CAST(545.00 AS Decimal(18, 2)), 2, CAST(N'2018-05-16' AS Date))
GO
INSERT [dbo].[Students] ([id], [name], [classroom_id], [student_image], [balance], [gender], [dob]) VALUES (4, N'gfg', 2, N'e8243d5f-844f-455e-bf7d-299be130d441.jpg', CAST(453.00 AS Decimal(18, 2)), 2, CAST(N'2018-05-16' AS Date))
GO
INSERT [dbo].[Students] ([id], [name], [classroom_id], [student_image], [balance], [gender], [dob]) VALUES (5, N'fdfd', 1, N'4966474b-4811-43d0-be91-06e96398e45a.jpg', CAST(43.00 AS Decimal(18, 2)), 2, CAST(N'2018-05-16' AS Date))
GO
INSERT [dbo].[Students] ([id], [name], [classroom_id], [student_image], [balance], [gender], [dob]) VALUES (6, N'Ahmed Gamal', 2, N'b319d82a-456e-4ce0-b33e-0de83317d1b0.jpg', CAST(22.00 AS Decimal(18, 2)), 1, CAST(N'2018-05-16' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
/****** Object:  StoredProcedure [dbo].[Classrooms_Names]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Classrooms_Names]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Classrooms_Names] AS' 
END
GO
ALTER Procedure [dbo].[Classrooms_Names]
	@pageNum int = 1,
	@pageSize int= 10,
	@key nvarchar(50) = NULL
As
Begin
	-- get list
	SELECT id, classroom_name as [text1] FROM (
		Select distinct id,classroom_name,
		(row_number() over(ORDER BY classroom_name ASC)) As RowNo From Classrooms Where (@key IS NULL) OR (classroom_name LIKE @key +'%')
		) [Classrooms]
	Where RowNo > ((@pageNum - 1) * @pageSize)  AND RowNo <= (@pageNum * @pageSize);
	
	-- get count
	SELECT Count(*) AS CNT FROM Classrooms Where (@key IS NULL) OR ([classroom_name] LIKE @key +'%');
End
GO
/****** Object:  StoredProcedure [dbo].[Genders_Names]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Genders_Names]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Genders_Names] AS' 
END
GO

ALTER Procedure [dbo].[Genders_Names]
	@pageNum int = 1,
	@pageSize int= 10,
	@key nvarchar(50) = NULL
As
Begin
	-- get list
	SELECT id, Gender_name as [text1] FROM (
		Select distinct id,Gender_name,
		(row_number() over(ORDER BY Gender_name ASC)) As RowNo From Genders Where (@key IS NULL) OR (Gender_name LIKE @key +'%')
		) [Genders]
	Where RowNo > ((@pageNum - 1) * @pageSize)  AND RowNo <= (@pageNum * @pageSize);
	
	-- get count
	SELECT Count(*) AS CNT FROM Genders Where (@key IS NULL) OR ([Gender_name] LIKE @key +'%');
End

GO
/****** Object:  StoredProcedure [dbo].[Students_Delete]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Students_Delete] AS' 
END
GO


-- ==========================================================================================
-- Entity Name:	Students_Delete
-- Create date:	5/15/2018 7:48:43 AM
-- Description:	This stored procedure is intended for deleting a specific row from Students table
-- ==========================================================================================
ALTER Procedure [dbo].[Students_Delete]
	@id int
As
BEGIN
	DELETE Students  WHERE  [id] = @id
	RETURN @@ROWCOUNT;
END

GO
/****** Object:  StoredProcedure [dbo].[Students_List]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students_List]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Students_List] AS' 
END
GO


-- ==========================================================================================
-- Entity Name:	Students_List
-- Create date:	5/15/2018 7:48:43 AM
-- Description:	This stored procedure is intended for selecting a specific row from Students table
-- ==========================================================================================
ALTER Procedure [dbo].[Students_List]
	@DisplayStart int=0,
	@DisplayLength int=10,
	@SearchParam nvarchar(50) = NULL,
	@SortColumn nvarchar(3) = '0',
	@SortDirection nvarchar(4) = 'desc'
As
Begin
	SELECT * FROM (SELECT [id],[name],[classroom_id],[student_image],[balance],[gender],[dob]
	,(ROW_NUMBER() OVER(ORDER BY
		 CASE WHEN @SortColumn = '0' AND @SortDirection = 'asc' THEN [id] END ASC,
		 CASE WHEN @SortColumn = '0' AND @SortDirection = 'desc' THEN [id] END desc,
		 CASE WHEN @SortColumn = '1' AND @SortDirection = 'asc' THEN [name] END ASC,
		 CASE WHEN @SortColumn = '1' AND @SortDirection = 'desc' THEN [name] END desc,
		 CASE WHEN @SortColumn = '2' AND @SortDirection = 'asc' THEN [classroom_id] END ASC,
		 CASE WHEN @SortColumn = '2' AND @SortDirection = 'desc' THEN [classroom_id] END desc,
		 CASE WHEN @SortColumn = '3' AND @SortDirection = 'asc' THEN [student_image] END ASC,
		 CASE WHEN @SortColumn = '3' AND @SortDirection = 'desc' THEN [student_image] END desc,
		 CASE WHEN @SortColumn = '4' AND @SortDirection = 'asc' THEN [balance] END ASC,
		 CASE WHEN @SortColumn = '4' AND @SortDirection = 'desc' THEN [balance] END desc,
		 CASE WHEN @SortColumn = '5' AND @SortDirection = 'asc' THEN [gender] END ASC,
		 CASE WHEN @SortColumn = '5' AND @SortDirection = 'desc' THEN [gender] END desc,
		 CASE WHEN @SortColumn = '6' AND @SortDirection = 'asc' THEN [dob] END ASC,
		 CASE WHEN @SortColumn = '6' AND @SortDirection = 'desc' THEN [dob] END desc)) AS RowNo
	FROM Students Where @SearchParam IS NULL 
		 OR [id] LIKE '%'+ @SearchParam + '%'
		 OR [name] LIKE '%'+ @SearchParam + '%'
		 OR [classroom_id] LIKE '%'+ @SearchParam + '%'
		 OR [student_image] LIKE '%'+ @SearchParam + '%'
		 OR [balance] LIKE '%'+ @SearchParam + '%'
		 OR [gender] LIKE '%'+ @SearchParam + '%'
		 OR [dob] LIKE '%'+ @SearchParam + '%'
	) Students Where RowNo > @DisplayStart AND RowNo <= (@DisplayStart + @DisplayLength)

	SELECT Count(*) AS TableCount FROM Students Where @SearchParam IS NULL
		 OR [id] LIKE '%'+ @SearchParam + '%'
		 OR [name] LIKE '%'+ @SearchParam + '%'
		 OR [classroom_id] LIKE '%'+ @SearchParam + '%'
		 OR [student_image] LIKE '%'+ @SearchParam + '%'
		 OR [balance] LIKE '%'+ @SearchParam + '%'
		 OR [gender] LIKE '%'+ @SearchParam + '%'
		 OR [dob] LIKE '%'+ @SearchParam + '%'
END

GO
/****** Object:  StoredProcedure [dbo].[Students_Save]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students_Save]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Students_Save] AS' 
END
GO


-- ==========================================================================================
-- Entity Name:	Students_Save
-- Create date:	5/15/2018 7:48:43 AM
-- Description:	This stored procedure is intended for updating Students table
-- ==========================================================================================
ALTER Procedure [dbo].[Students_Save]
	@id int,
	@name nvarchar(50),
	@classroom_id int,
	@student_image nvarchar(50),
	@balance decimal,
	@gender int,
	@dob date
As
Begin
	DECLARE @RefID int;
	IF EXISTS (SELECT NULL FROM Students WHERE  [id] = @id)
	Begin
		Update Students
		Set
			[name] = @name,
			[classroom_id] = @classroom_id,
			[student_image] = @student_image,
			[balance] = @balance,
			[gender] = @gender,
			[dob] = @dob
		Where [id] = @id;
		SELECT @RefID = 1;
	End
	ELSE
	Begin
		Insert Into Students([name],[classroom_id],[student_image],[balance],[gender],[dob])
			Values(@name,@classroom_id,@student_image,@balance,@gender,@dob);
		SELECT @RefID = @@IDENTITY;
	End
		RETURN @RefID;
End
GO
/****** Object:  StoredProcedure [dbo].[Students_SelectList]    Script Date: 5/16/2018 9:28:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students_SelectList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Students_SelectList] AS' 
END
GO


-- ==========================================================================================
-- Entity Name:	Students_List
-- Create date:	5/15/2018 7:48:43 AM
-- Description:	This stored procedure is intended for selecting a specific row from Students table
-- ==========================================================================================
ALTER Procedure [dbo].[Students_SelectList]
	@DisplayStart int=0,
	@DisplayLength int=10,
	@SearchParam nvarchar(50) = NULL,
	@SortColumn nvarchar(3) = '0',
	@SortDirection nvarchar(4) = 'desc'
As
Begin
	SELECT * FROM (SELECT [id],[name],[classroom_id],[student_image],[balance],[gender],[dob],[classroom_name],[gender_name]
	,(ROW_NUMBER() OVER(ORDER BY
		 CASE WHEN @SortColumn = '0' AND @SortDirection = 'asc' THEN [id] END ASC,
		 CASE WHEN @SortColumn = '0' AND @SortDirection = 'desc' THEN [id] END desc,
		 CASE WHEN @SortColumn = '1' AND @SortDirection = 'asc' THEN [name] END ASC,
		 CASE WHEN @SortColumn = '1' AND @SortDirection = 'desc' THEN [name] END desc,
		 CASE WHEN @SortColumn = '2' AND @SortDirection = 'asc' THEN [gender_name] END ASC,
		 CASE WHEN @SortColumn = '2' AND @SortDirection = 'desc' THEN [gender_name] END desc,
		 CASE WHEN @SortColumn = '3' AND @SortDirection = 'asc' THEN [classroom_name] END ASC,
		 CASE WHEN @SortColumn = '3' AND @SortDirection = 'desc' THEN [classroom_name] END desc,
		 CASE WHEN @SortColumn = '4' AND @SortDirection = 'asc' THEN [dob] END ASC,
		 CASE WHEN @SortColumn = '4' AND @SortDirection = 'desc' THEN [dob] END desc,
		 CASE WHEN @SortColumn = '5' AND @SortDirection = 'asc' THEN [balance] END ASC,
		 CASE WHEN @SortColumn = '5' AND @SortDirection = 'desc' THEN [balance] END desc)) AS RowNo
	FROM View_Students Where @SearchParam IS NULL 
		 OR [name] LIKE '%'+ @SearchParam + '%'
		 OR [classroom_name] LIKE '%'+ @SearchParam + '%'
		 OR [student_image] LIKE '%'+ @SearchParam + '%'
		 OR [balance] LIKE '%'+ @SearchParam + '%'
		 OR [gender_name] LIKE '%'+ @SearchParam + '%'
		 OR [dob] LIKE '%'+ @SearchParam + '%'
	) Students Where RowNo > @DisplayStart AND RowNo <= (@DisplayStart + @DisplayLength)

	SELECT Count(*) AS TableCount FROM View_Students Where @SearchParam IS NULL
		 OR [name] LIKE '%'+ @SearchParam + '%'
		 OR [classroom_name] LIKE '%'+ @SearchParam + '%'
		 OR [student_image] LIKE '%'+ @SearchParam + '%'
		 OR [balance] LIKE '%'+ @SearchParam + '%'
		 OR [gender_name] LIKE '%'+ @SearchParam + '%'
		 OR [dob] LIKE '%'+ @SearchParam + '%'
END
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'View_Students', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Classrooms"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Students"
            Begin Extent = 
               Top = 11
               Left = 294
               Bottom = 279
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Genders"
            Begin Extent = 
               Top = 63
               Left = 643
               Bottom = 159
               Right = 813
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Students'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'View_Students', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Students'
GO
USE [master]
GO
ALTER DATABASE [SchoolDb] SET  READ_WRITE 
GO
