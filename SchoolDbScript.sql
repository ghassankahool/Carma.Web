USE [SchoolDb]
GO
/****** Object:  StoredProcedure [dbo].[Students_Save]    Script Date: 5/15/2018 7:55:24 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[Students_Save]
GO
/****** Object:  StoredProcedure [dbo].[Students_List]    Script Date: 5/15/2018 7:55:24 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[Students_List]
GO
/****** Object:  StoredProcedure [dbo].[Students_Delete]    Script Date: 5/15/2018 7:55:24 AM ******/
DROP PROCEDURE IF EXISTS [dbo].[Students_Delete]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 5/15/2018 7:55:24 AM ******/
DROP TABLE IF EXISTS [dbo].[Students]
GO
/****** Object:  Table [dbo].[Classrooms]    Script Date: 5/15/2018 7:55:24 AM ******/
DROP TABLE IF EXISTS [dbo].[Classrooms]
GO
/****** Object:  Table [dbo].[Classrooms]    Script Date: 5/15/2018 7:55:24 AM ******/
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
/****** Object:  Table [dbo].[Students]    Script Date: 5/15/2018 7:55:24 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Students_Delete]    Script Date: 5/15/2018 7:55:24 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Students_List]    Script Date: 5/15/2018 7:55:24 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Students_Save]    Script Date: 5/15/2018 7:55:24 AM ******/
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
