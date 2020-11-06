CREATE VIEW Onboarders AS
SELECT  Station.StationStopID, Count(PassengerID) as NumberOfPassengers from TicketBooking inner join TrainSchedule 
on TicketBooking.SourceTrainScheduleID = TrainSchedule.TrainScheduleID
inner join Station on TrainSchedule.StationStopID = Station.StationStopID
Group By Station.StationStopID



CREATE VIEW Deboarders AS
SELECT  Station.StationStopID, Count(PassengerID) as NumberOfPassengers from TicketBooking inner join TrainSchedule 
on TicketBooking.DestinationTrainScheduleID = TrainSchedule.TrainScheduleID
inner join Station on TrainSchedule.StationStopID = Station.StationStopID
Group By Station.StationStopID