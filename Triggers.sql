-------------------------------------------TRIGGER CANCELLATION-----------------------------------------------
CREATE TABLE Cancellation (
CancellationID int primary key identity (1,1),
BookingID int not null,
PassengerID int not null,
RouteID char(5) not null,
PaymentID int not null,
SourceTrainScheduleID int not null,
DestinationTrainScheduleID int not null,
[Action] char(20) not null,
CancellationTime datetime
)
GO

CREATE TRIGGER TicketCancellation on TicketBooking
FOR DELETE
AS 
BEGIN
insert into Cancellation (BookingID, PassengerID, RouteID, PaymentID, SourceTrainScheduleID, DestinationTrainScheduleID, [Action],  CancellationTime)
SELECT d.BookingID,d.PassengerID,d.RouteID, d.PaymentID, d.SourceTrainScheduleID, d.DestinationTrainScheduleID, 'Ticket Cancelled', GETDATE()
FROM deleted d
END

DELETE FROM TicketBooking where BookingID = 4


--------------------------------------TRIGGER DELAY------------------------------------------------------------


CREATE TABLE DelayMonitor(
DelayID int primary key identity (1,1),
TrainScheduleID int not null,
RunningTrainID varchar(10) not null,
TrainID char(5) not null,
StationStopID int not null,
Arrival time(0),
[Date] date not null,
RouteID char(5) not null,
DriverID int not null,
[Action] char(10),
UpdateTime datetime
)
GO
ALTER TRIGGER [Delay] ON TrainSchedule
AFTER UPDATE
AS
BEGIN
	insert into DelayMonitor(TrainScheduleID, RunningTrainID, TrainID, StationStopID, Arrival, [Date], RouteID, DriverID, [Action], UpdateTime)
	SELECT d.TrainScheduleID, d.RunningTrainID,d.TrainID, d.StationStopID, d.Arrival, d.Date, d.RouteID, d.DriverID, 'Delayed', GETDATE()
	FROM deleted d

END


UPDATE TrainSchedule set Arrival = '06:11' where TrainScheduleID = 2

SELECT * FROM DelayMonitor

SELECT * FROM TrainSchedule