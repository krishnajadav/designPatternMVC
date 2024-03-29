USE [master]
GO
/****** Object:  Database [College]    Script Date: 6/19/2018 9:46:14 PM ******/
CREATE DATABASE [College]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'College', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\College.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'College_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\College_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [College] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [College].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [College] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [College] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [College] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [College] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [College] SET ARITHABORT OFF 
GO
ALTER DATABASE [College] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [College] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [College] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [College] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [College] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [College] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [College] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [College] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [College] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [College] SET  ENABLE_BROKER 
GO
ALTER DATABASE [College] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [College] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [College] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [College] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [College] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [College] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [College] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [College] SET RECOVERY FULL 
GO
ALTER DATABASE [College] SET  MULTI_USER 
GO
ALTER DATABASE [College] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [College] SET DB_CHAINING OFF 
GO
ALTER DATABASE [College] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [College] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [College] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'College', N'ON'
GO
USE [College]
GO
/****** Object:  Table [dbo].[faculty]    Script Date: 6/19/2018 9:46:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[faculty](
	[fid] [int] NOT NULL,
	[fname] [varchar](30) NULL,
	[femail] [varchar](30) NULL,
	[fpass] [varchar](40) NULL,
	[fdept] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student]    Script Date: 6/19/2018 9:46:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[student](
	[stuid] [int] NOT NULL,
	[sfname] [varchar](30) NULL,
	[slname] [varchar](30) NULL,
	[semail] [varchar](40) NULL,
	[smno] [varchar](10) NULL,
	[sdept] [varchar](20) NULL,
	[fid] [int] NULL,
	[spass] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[stuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test]    Script Date: 6/19/2018 9:46:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[test](
	[id] [int] NOT NULL,
	[name] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[faculty] ([fid], [fname], [femail], [fpass], [fdept]) VALUES (1, N'krishna', N'abc@gmail.com', N'password', N'computer')
INSERT [dbo].[faculty] ([fid], [fname], [femail], [fpass], [fdept]) VALUES (2, N'Jadav', N'xyz@gmail.com', N'password', N'Electronics')
INSERT [dbo].[student] ([stuid], [sfname], [slname], [semail], [smno], [sdept], [fid], [spass]) VALUES (1, N'krishnads', N'ZczXC', N'abc@gmail.com', N'9537650656', N'computer', 1, N'aaa')
/****** Object:  StoredProcedure [dbo].[InUPStudent]    Script Date: 6/19/2018 9:46:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[InUPStudent]
	@stuid        int,
	@sfname      varchar(30),
	@slname     varchar(30),
	@semail varchar(45),
	@smno varchar(30),
	@sdept varchar(20),
	@fid int,
	@spass varchar(30)
	AS
BEGIN


    if exists (Select 1 from student where stuid=@stuid)
    begin
		update student set sfname=@sfname,slname=@slname,semail=@semail,sdept=@sdept,smno=@smno,spass=@spass,@fid=@fid where stuid=@stuid
    End
    Else
    Begin
		       --declare the variable with it's datatype
		set @stuid= (select (isnull(MAX(stuid),0) +1) from student)  -- set value in variable
		insert into student(stuid,sfname,slname,semail,smno,sdept,fid,spass)values(@stuid,@sfname,@slname,@semail,@smno,@sdept,@fid,@spass)  --fire insert query
End


End
GO
USE [master]
GO
ALTER DATABASE [College] SET  READ_WRITE 
GO
