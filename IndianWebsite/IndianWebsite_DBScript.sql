USE [master]
GO
/****** Object:  Database [db_abe38f_scbhai0070]    Script Date: 18/10/2025 3:01:24 am ******/
CREATE DATABASE [db_abe38f_scbhai0070]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_abe38f_scbhai0070_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\db_abe38f_scbhai0070_DATA.mdf' , SIZE = 8192KB , MAXSIZE = 1024000KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'db_abe38f_scbhai0070_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\db_abe38f_scbhai0070_Log.LDF' , SIZE = 3072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_abe38f_scbhai0070].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET  MULTI_USER 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET QUERY_STORE = ON
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [db_abe38f_scbhai0070]
GO
/****** Object:  Table [dbo].[PaymentOrders]    Script Date: 18/10/2025 3:01:30 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientTxnId] [varchar](50) NULL,
	[OrderId] [int] NULL,
	[Amount] [decimal](18, 2) NULL,
	[CustomerName] [varchar](100) NULL,
	[CustomerEmail] [varchar](100) NULL,
	[CustomerMobile] [varchar](20) NULL,
	[PaymentUrl] [varchar](max) NULL,
	[CreatedAt] [datetime] NULL,
	[PaymentStatus] [bit] NULL,
	[UserID] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRegistration]    Script Date: 18/10/2025 3:01:30 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRegistration](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](max) NULL,
	[Email] [varchar](max) NULL,
	[Password] [varchar](max) NULL,
	[ConfirmPassword] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VpsOrders]    Script Date: 18/10/2025 3:01:30 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VpsOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientTransactionID] [varchar](100) NOT NULL,
	[IP] [nvarchar](50) NULL,
	[OS] [nvarchar](100) NULL,
	[Username] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[ActionStatus] [nvarchar](50) NULL,
	[MachineStatus] [nvarchar](50) NULL,
	[PowerStatus] [nvarchar](50) NULL,
	[RAM] [nvarchar](50) NULL,
	[ExpiryDate] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[UserID] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[PaymentOrders] ON 
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (67, N'TXN20251016211217', 138475437, CAST(2450.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/11982d007df8060f4f784d981a0dc7f1', CAST(N'2025-10-16T09:12:19.310' AS DateTime), 0, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (68, N'TXN20251016092804', 138476691, CAST(2450.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/42ace369f47b29bd30b55ff13cff8350', CAST(N'2025-10-16T09:28:05.820' AS DateTime), 0, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (69, N'TXN20251016095754', 138479528, CAST(650.00 AS Decimal(18, 2)), N'karma935sc', N'karma935sc@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/fcbb833df7c1ee90e55896afd6a7ed2d', CAST(N'2025-10-16T09:57:55.853' AS DateTime), 0, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (70, N'TXN20251016095756', 138479531, CAST(650.00 AS Decimal(18, 2)), N'karma935sc', N'karma935sc@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/38a65258e46f6755a9e4f0c2f875512f', CAST(N'2025-10-16T09:57:57.867' AS DateTime), 0, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (71, N'TXN20251016111347', 138487073, CAST(900.00 AS Decimal(18, 2)), N'Kartik281328', N'Kartik281328@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/524c6173202f21f33663189f24653e38', CAST(N'2025-10-16T11:13:48.890' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (72, N'TXN20251016232656', 138487645, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/6b8ec19525831b73abdcc06f081cc38e', CAST(N'2025-10-16T11:26:59.573' AS DateTime), 0, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (73, N'TXN20251017000944', 138489860, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/c80d812dff5299c1d2748a91ba68e854', CAST(N'2025-10-16T12:09:47.463' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (74, N'TXN20251017001633', 138490194, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/90d810fc452b1b23cc5ac938725d0013', CAST(N'2025-10-16T12:16:35.927' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (75, N'TXN20251017002723', 138490761, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/7101046f058d8584b4de6890f4f10c94', CAST(N'2025-10-16T12:27:26.627' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (76, N'TXN20251017004548', 138491454, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/ab59d5a15b25a93d7613be4f96efaaa3', CAST(N'2025-10-16T12:45:51.317' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (77, N'TXN20251017005035', 138491626, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/c1401051e6520aa11196bb518ae3d1a1', CAST(N'2025-10-16T12:50:37.080' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (78, N'TXN20251017005915', 138491873, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/263b07aa7f17c6990c30f9d6f8e58ac0', CAST(N'2025-10-16T12:59:18.053' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (79, N'TXN20251017010515', 138492038, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/9c9d7dd13579a062ec1f02f0c5b1bad1', CAST(N'2025-10-16T13:05:16.973' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (80, N'TXN20251017011309', 138492214, CAST(650.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/273ca002c90b8d6fc0f406cdd4656d81', CAST(N'2025-10-16T13:13:12.767' AS DateTime), 1, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (81, N'TXN20251016133059', 138492648, CAST(900.00 AS Decimal(18, 2)), N'dev.info.net.solution', N'dev.info.net.solution@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/221f4e8e037e490e03452b4459fd1575', CAST(N'2025-10-16T13:31:00.650' AS DateTime), 0, NULL)
GO
INSERT [dbo].[PaymentOrders] ([Id], [ClientTxnId], [OrderId], [Amount], [CustomerName], [CustomerEmail], [CustomerMobile], [PaymentUrl], [CreatedAt], [PaymentStatus], [UserID]) VALUES (82, N'TXN20251017122429', 138617155, CAST(650.00 AS Decimal(18, 2)), N'travelchoudhary933', N'travelchoudhary933@gmail.com', N'9132678956', N'https://qrstuff.me/gateway/pay/54716b9eec5b83ddb46b290f7128cd8d', CAST(N'2025-10-17T12:24:30.430' AS DateTime), 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[PaymentOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRegistration] ON 
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (1, N'Muhammad Ahmad Amin', N'dev.info.net.solution@gmail.com', N'123', N'123', CAST(N'2025-09-18T02:31:32.017' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (2, N'ttttt', N'karma935sc@gmail.com', N'123456', N'123456', CAST(N'2025-09-18T09:03:57.637' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (3, N'Sx', N'karma935sc@gmail.com', N'mAula@2019@@', N'mAula@2019@@', CAST(N'2025-09-21T02:31:53.287' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (4, N'Shivam', N'soldusanjana@gmail.com', N'Moto@2001', N'Moto@2001', CAST(N'2025-09-21T07:06:15.580' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (5, N'Kartik', N'Kartik281328@gmail.com', N'pm786786', N'pm786786', CAST(N'2025-09-22T23:26:31.400' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (6, N'ttttt', N'karma936sc@gmail.com', N'mAula@2019@@', N'mAula@2019@@', CAST(N'2025-09-25T08:59:58.967' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (7, N'Sc randi', N'mohanjaiswalmumbai@gmail.com', N'2005', N'2005', CAST(N'2025-09-25T12:23:45.663' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (10, N'Muhammad Ahmad Amin', N'hafizmuhammadahmadamin@gmail.com', N'111', N'111', CAST(N'2025-09-27T04:58:33.960' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (11, N'8092206316', N'nazimdbg794@gmail.com', N'Nazim@123', N'Nazim@123', CAST(N'2025-10-16T10:48:10.040' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (12, N'Kartik', N'Kartik281328@gmail.com', N'pm786786', N'pm786786', CAST(N'2025-10-16T11:11:59.993' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (13, N'Kartik', N'Kartik281328@gmail.com', N'pm786786', N'pm786786', CAST(N'2025-10-16T11:12:53.720' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (14, N'ttttt', N'karma936sc@gmail.com', N'mAula@2019@@', N'mAula@2019@@', CAST(N'2025-10-16T11:29:55.863' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (15, N'ttttt', N'karma936sc@gmail.com', N'mAula@2019@@', N'mAula@2019@@', CAST(N'2025-10-16T13:29:29.170' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (16, N'Rohit singh', N'assamese145@gmail.com', N'Assam@123', N'Assam@123', CAST(N'2025-10-16T13:36:15.767' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (17, N'Gita', N'gitadevi8412211@gmail.com', N'Passwerd420@', N'Passwerd420@', CAST(N'2025-10-16T16:11:55.183' AS DateTime))
GO
INSERT [dbo].[UserRegistration] ([UserID], [FullName], [Email], [Password], [ConfirmPassword], [CreatedDate]) VALUES (18, N'Anshu', N'travelchoudhary933@gmail.com', N'Anshu00', N'Anshu00', CAST(N'2025-10-17T12:20:49.610' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[UserRegistration] OFF
GO
SET IDENTITY_INSERT [dbo].[VpsOrders] ON 
GO
INSERT [dbo].[VpsOrders] ([Id], [ClientTransactionID], [IP], [OS], [Username], [Password], [ActionStatus], [MachineStatus], [PowerStatus], [RAM], [ExpiryDate], [CreatedAt], [UserID]) VALUES (2, N'TXN20250923213146', N'43.225.74.7', N'Windows 2022 64', N'Administrator', N'jYYe98#t5X@vE0+-', N'processing', N'active', N'Offline', N'8192 MB', CAST(N'2025-10-23T20:19:24.027' AS DateTime), CAST(N'2025-09-23T07:49:38.267' AS DateTime), 1)
GO
INSERT [dbo].[VpsOrders] ([Id], [ClientTransactionID], [IP], [OS], [Username], [Password], [ActionStatus], [MachineStatus], [PowerStatus], [RAM], [ExpiryDate], [CreatedAt], [UserID]) VALUES (3, N'TXN20250925091921', N'103.148.66.14', N'Ubuntu 22 64', N'root', NULL, N'pending', N'active', N'Offline', N'4096 MB', CAST(N'2025-10-25T21:51:17.887' AS DateTime), CAST(N'2025-09-25T09:21:18.943' AS DateTime), 6)
GO
INSERT [dbo].[VpsOrders] ([Id], [ClientTransactionID], [IP], [OS], [Username], [Password], [ActionStatus], [MachineStatus], [PowerStatus], [RAM], [ExpiryDate], [CreatedAt], [UserID]) VALUES (6, N'TXN20250927140057', N'103.148.66.3', N'Windows 2022 64', N'Administrator', NULL, N'pending', N'active', N'Offline', N'8192 MB', CAST(N'2025-10-27T14:35:02.267' AS DateTime), CAST(N'2025-09-27T02:05:04.023' AS DateTime), 1)
GO
INSERT [dbo].[VpsOrders] ([Id], [ClientTransactionID], [IP], [OS], [Username], [Password], [ActionStatus], [MachineStatus], [PowerStatus], [RAM], [ExpiryDate], [CreatedAt], [UserID]) VALUES (8, N'TXN20251017004548', N'160.191.29.99', N'Ubuntu 20 64', N'dev.info.net.solution', N'', N'success', N'Running', N'Running', N'4', CAST(N'2025-11-17T00:47:25.233' AS DateTime), CAST(N'2025-10-16T12:47:26.270' AS DateTime), 1)
GO
INSERT [dbo].[VpsOrders] ([Id], [ClientTransactionID], [IP], [OS], [Username], [Password], [ActionStatus], [MachineStatus], [PowerStatus], [RAM], [ExpiryDate], [CreatedAt], [UserID]) VALUES (9, N'TXN20251017011309', N'103.148.66.34', N'Ubuntu 22 64', N'root', NULL, N'pending', N'active', N'Offline', N'4096 MB', CAST(N'2025-11-17T01:46:56.097' AS DateTime), CAST(N'2025-10-16T13:17:25.460' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[VpsOrders] OFF
GO
ALTER TABLE [dbo].[PaymentOrders] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[PaymentOrders] ADD  CONSTRAINT [DF_PaymentOrders_PaymentStatus]  DEFAULT ((0)) FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[UserRegistration] ADD  CONSTRAINT [DF_UserRegistration_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[VpsOrders] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
/****** Object:  StoredProcedure [dbo].[sp_ChangePassword]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Change Password
CREATE PROCEDURE [dbo].[sp_ChangePassword]
    @UserID INT,
    @CurrentPassword NVARCHAR(100),
    @NewPassword NVARCHAR(100)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM UserRegistration WHERE UserID = @UserID AND Password = @CurrentPassword)
    BEGIN
        UPDATE UserRegistration
        SET Password = @NewPassword, ConfirmPassword = @NewPassword
        WHERE UserID = @UserID;
        SELECT 1;
    END
    ELSE
    BEGIN
        SELECT 0;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOrders]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetOrders]
    @UserID INT,
    @Keyword NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Id,
        ClientTransactionID,
        IP,
        OS,
        Username,
        Password,
        ActionStatus,
        MachineStatus,
        PowerStatus,
        RAM,
        ExpiryDate,
        CreatedAt,
        UserID
    FROM VpsOrders
    WHERE UserID = @UserID
      AND (
            @Keyword IS NULL 
            OR @Keyword = ''
            OR IP LIKE '%' + @Keyword + '%'
            OR OS LIKE '%' + @Keyword + '%'
            OR Username LIKE '%' + @Keyword + '%'
            OR ClientTransactionID LIKE '%' + @Keyword + '%'
          )
    ORDER BY ExpiryDate DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPaymentOrder]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPaymentOrder]
    @ClientTxnId NVARCHAR(100)
AS
BEGIN
    SELECT TOP 1 Id, ClientTxnId, CustomerName, CustomerEmail, 
                 CustomerMobile, Amount, PaymentStatus, CreatedAt
    FROM PaymentOrders
    WHERE ClientTxnId = @ClientTxnId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserDashboardData]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserDashboardData]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- User Info 0
    SELECT FullName, Email, CreatedDate
    FROM UserRegistration
    WHERE UserID = @UserID;

    -- Orders Summary 1
    SELECT 
        TotalOrders = COUNT(*),
        ActiveServices = SUM(CASE WHEN MachineStatus = 'active' THEN 1 ELSE 0 END),
        PendingOrders = SUM(CASE WHEN ActionStatus = 'Pending' THEN 1 ELSE 0 END),
        CompletedOrders = SUM(CASE WHEN ActionStatus = 'processing' THEN 1 ELSE 0 END),
        FailedOrders = SUM(CASE WHEN ActionStatus = 'Failed' THEN 1 ELSE 0 END)
    FROM VpsOrders
    WHERE UserID = @UserID;

    -- Payments (Total Spent) 2
	SELECT SUM(PO.Amount) AS TotalSpent FROM PaymentOrders PO
	INNER JOIN VpsOrders VO ON VO.ClientTransactionID = PO.ClientTxnId 
	WHERE VO.UserID = @UserID --AND PO.PaymentStatus = 1

    -- Recent Orders 3
    SELECT TOP 5 
        ClientTransactionID, IP, OS, RAM, ActionStatus, ExpiryDate, CreatedAt
    FROM VpsOrders
    WHERE UserID = @UserID
    ORDER BY CreatedAt DESC;
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserProfile]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserProfile]
    @UserID INT
AS
BEGIN
    SELECT UserID, FullName, Email, Password, CreatedDate
    FROM UserRegistration
    WHERE UserID = @UserID;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertVpsOrder]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertVpsOrder]
    @ClientTransactionID NVARCHAR(100),
    @UserID INT,
    @IP NVARCHAR(50),
    @OS NVARCHAR(100),
    @Username NVARCHAR(100),
    @Password NVARCHAR(200),
    @ActionStatus NVARCHAR(50),
    @MachineStatus NVARCHAR(50),
    @PowerStatus NVARCHAR(50),
    @RAM NVARCHAR(50),
    @ExpiryDate DATETIME
AS
BEGIN
    INSERT INTO VpsOrders
    (ClientTransactionID, UserID, IP, OS, Username, Password, ActionStatus, MachineStatus, PowerStatus, RAM, ExpiryDate, CreatedAt)
    VALUES
    (@ClientTransactionID, @UserID, @IP, @OS, @Username, @Password, @ActionStatus, @MachineStatus, @PowerStatus, @RAM, @ExpiryDate, GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentStatus]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdatePaymentStatus]
    @ClientTxnId NVARCHAR(100)
AS
BEGIN
    UPDATE PaymentOrders
    SET PaymentStatus = 1
    WHERE ClientTxnId = @ClientTxnId;
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UserRegistration]    Script Date: 18/10/2025 3:01:36 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UserRegistration]
@Mode INT = NULL,
@FullName VARCHAR(MAX) = NULL,
@Email VARCHAR(MAX) = NULL,
@Password VARCHAR(MAX) = NULL,
@ConfirmPassword VARCHAR(MAX) = NULL
AS
BEGIN
	IF @Mode = 1 
	BEGIN 
		INSERT INTO [UserRegistration]
			   ([FullName]
			   ,[Email]
			   ,[Password]
			   ,[ConfirmPassword]
			   )
		 VALUES
			   (@FullName
			   ,@Email
			   ,@Password
			   ,@ConfirmPassword)

	END
	ELSE IF @Mode = 2 
	BEGIN 
		 SELECT TOP 1 *
    FROM [UserRegistration]
    WHERE Email = @Email AND Password = @Password
	END
END
GO
USE [master]
GO
ALTER DATABASE [db_abe38f_scbhai0070] SET  READ_WRITE 
GO
