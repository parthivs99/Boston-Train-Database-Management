USE [Test]
GO

/****** Object:  Table [dbo].[PassengerAddress]    Script Date: 11/27/2019 7:18:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PassengerAddress](
	[AddressID] [int] NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[State] [varchar](5) NOT NULL,
	[Country] [varchar](25) NOT NULL,
	[ZipCode] [int] NOT NULL,
 CONSTRAINT [PassengerAddress_PK] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Passenger]    Script Date: 11/27/2019 7:18:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Passenger](
	[PassengerID] [int] NOT NULL,
	[PassengerName] [varchar](25) NOT NULL,
	[DateofBirth] [date] NOT NULL,
	[ContactInformation] [int] NOT NULL,
	[AddressID] [int] NOT NULL,
	[EmailID] [varchar](225) NOT NULL,
	[CurrentAge]  AS (datediff(year,[DateofBirth],getdate())),
 CONSTRAINT [Passenger_PK] PRIMARY KEY CLUSTERED 
(
	[PassengerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Passenger]  WITH CHECK ADD  CONSTRAINT [Passenger_FK] FOREIGN KEY([AddressID])
REFERENCES [dbo].[PassengerAddress] ([AddressID])
GO

ALTER TABLE [dbo].[Passenger] CHECK CONSTRAINT [Passenger_FK]
GO



/****** Object:  Table [dbo].[Driver]    Script Date: 11/27/2019 7:20:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Driver](
	[DriverID] [int] NOT NULL,
	[DriverName] [varchar](100) NOT NULL,
	[DateofBirth] [date] NOT NULL,
	[Contact Information] [int] NOT NULL,
	[Address] [varchar](255) NOT NULL,
 CONSTRAINT [Driver_PK] PRIMARY KEY CLUSTERED 
(
	[DriverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Route]    Script Date: 11/27/2019 7:21:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Route](
	[RouteID] [char](5) NOT NULL,
	[StartPoint] [varchar](25) NOT NULL,
	[EndPoint] [varchar](25) NOT NULL,
 CONSTRAINT [Route_PK] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Station]    Script Date: 11/27/2019 7:22:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Station](
	[StationStopID] [int] NOT NULL,
	[Longitude] [decimal](10, 8) NOT NULL,
	[Latitude] [decimal](10, 8) NOT NULL,
	[RouteID] [char](5) NOT NULL,
	[StationName] [varchar](50) NOT NULL,
 CONSTRAINT [Station_PK] PRIMARY KEY CLUSTERED 
(
	[StationStopID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Station]  WITH CHECK ADD  CONSTRAINT [Station_FK] FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([RouteID])
GO

ALTER TABLE [dbo].[Station] CHECK CONSTRAINT [Station_FK]
GO


/****** Object:  Table [dbo].[Payment]    Script Date: 11/27/2019 7:25:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Payment](
	[PaymentID] [int] NOT NULL,
	[Amount] [decimal](5, 2) NOT NULL,
	[CardNumber] [varchar](25) NULL,
	[Credit_card_number_encrypt] [varbinary](max) NULL,
 CONSTRAINT [Payment_PK] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Payment]  WITH CHECK ADD CHECK  (([Amount]=(2.50)))
GO



/****** Object:  Table [dbo].[Train]    Script Date: 11/27/2019 7:28:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Train](
	[TrainID] [char](5) NOT NULL,
	[Make] [int] NOT NULL,
	[Model] [varchar](25) NOT NULL,
	[Seats] [int] NOT NULL,
 CONSTRAINT [Train_PK] PRIMARY KEY CLUSTERED 
(
	[TrainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO




/****** Object:  Table [dbo].[TrainSchedule]    Script Date: 11/27/2019 7:26:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TrainSchedule](
	[TrainScheduleID] [int] NOT NULL,
	[RunningTrainID] [varchar](10) NOT NULL,
	[TrainID] [char](5) NOT NULL,
	[StationStopID] [int] NOT NULL,
	[Arrival] [time](0) NOT NULL,
	[Date] [date] NOT NULL,
	[RouteID] [char](5) NOT NULL,
	[DriverID] [int] NOT NULL,
 CONSTRAINT [TrainSchedule_PK] PRIMARY KEY CLUSTERED 
(
	[TrainScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TrainSchedule]  WITH CHECK ADD  CONSTRAINT [TrainSchedule_FK1] FOREIGN KEY([StationStopID])
REFERENCES [dbo].[Station] ([StationStopID])
GO

ALTER TABLE [dbo].[TrainSchedule] CHECK CONSTRAINT [TrainSchedule_FK1]
GO

ALTER TABLE [dbo].[TrainSchedule]  WITH CHECK ADD  CONSTRAINT [TrainSchedule_FK2] FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([RouteID])
GO

ALTER TABLE [dbo].[TrainSchedule] CHECK CONSTRAINT [TrainSchedule_FK2]
GO

ALTER TABLE [dbo].[TrainSchedule]  WITH CHECK ADD  CONSTRAINT [TrainSchedule_FK3] FOREIGN KEY([DriverID])
REFERENCES [dbo].[Driver] ([DriverID])
GO

ALTER TABLE [dbo].[TrainSchedule] CHECK CONSTRAINT [TrainSchedule_FK3]
GO




/****** Object:  Table [dbo].[TicketBooking]    Script Date: 11/27/2019 7:29:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TicketBooking](
	[BookingID] [int] NOT NULL,
	[PassengerID] [int] NOT NULL,
	[RouteID] [char](5) NOT NULL,
	[PaymentID] [int] NOT NULL,
	[SourceTrainScheduleID] [int] NULL,
	[DestinationTrainScheduleID] [int] NULL,
 CONSTRAINT [TicketBooking_PK] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TicketBooking]  WITH CHECK ADD  CONSTRAINT [TicketBooking_FK1] FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([RouteID])
GO

ALTER TABLE [dbo].[TicketBooking] CHECK CONSTRAINT [TicketBooking_FK1]
GO

ALTER TABLE [dbo].[TicketBooking]  WITH CHECK ADD  CONSTRAINT [TicketBooking_FK2] FOREIGN KEY([SourceTrainScheduleID])
REFERENCES [dbo].[TrainSchedule] ([TrainScheduleID])
GO

ALTER TABLE [dbo].[TicketBooking] CHECK CONSTRAINT [TicketBooking_FK2]
GO

ALTER TABLE [dbo].[TicketBooking]  WITH CHECK ADD  CONSTRAINT [TicketBooking_FK3] FOREIGN KEY([DestinationTrainScheduleID])
REFERENCES [dbo].[TrainSchedule] ([TrainScheduleID])
GO

ALTER TABLE [dbo].[TicketBooking] CHECK CONSTRAINT [TicketBooking_FK3]
GO

ALTER TABLE [dbo].[TicketBooking]  WITH CHECK ADD  CONSTRAINT [TicketBooking_FK4] FOREIGN KEY([PaymentID])
REFERENCES [dbo].[Payment] ([PaymentID])
GO

ALTER TABLE [dbo].[TicketBooking] CHECK CONSTRAINT [TicketBooking_FK4]
GO




