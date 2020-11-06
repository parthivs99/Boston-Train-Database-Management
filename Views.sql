-------------------------VIEW [PassengersPerRunningTrain]-----------------------------
GO
CREATE VIEW [PassengersPerRunningTrain] AS
select TrainSchedule.RunningTrainID, Count(TicketBooking.PassengerID) as NumberofPassenger from TrainSchedule inner join TicketBooking on
TrainSchedule.TrainScheduleID = TicketBooking.SourceTrainScheduleID
Group By RunningTrainID

SELECT * FROM PassengersPerRunningTrain



--------------------------VIEW  REVENUE BY Route-----------------------------------
GO
CREATE VIEW [Revenue by Route] AS
SELECT RouteID, Count(p.BookingID)*2.5 AS Revenue from Payment p inner join TicketBooking t
on p.BookingID = t.BookingID
GROUP BY RouteID

