--1. Procedure 1 For Train Schedule Out Bound.
CREATE PROCEDURE TrainScheduleOutbound @Source VARCHAR(25), @Destination VARCHAR(25), @StartTime TIME, @EndTime TIME
AS
BEGIN
SELECT  t1.trainID, s1.StationName,t1.Arrival, s2.StationName, t1.[Date]
FROM TrainSchedule t1 inner join TrainSchedule t2 on t1.RunningTrainID = t2.RunningTrainID and t1.RouteID = t2.RouteID
inner join Station s1 on s1.StationStopID=t1.StationStopID inner join Station s2 on s2.StationStopID=t2.StationStopID
inner join Route r on s1.RouteID=r.RouteID
where (t1.Arrival between @StartTime and @EndTime) and s1.StationName = @Source and s2.StationName=@Destination and (t1.RouteID='GE1' OR t1.RouteID='GD1' OR t1.RouteID='GC1' OR t1.RouteID='GB1'
OR t1.RouteID='B1' OR t1.RouteID='RA1'OR  t1.RouteID='O1'OR t1.RouteID='RB1' OR t1.RouteID='RM1')
END
EXECUTE TrainScheduleOutbound
@Source = 'Prudential'
, @Destination = 'North Station'
, @StartTime = '15:00'
, @EndTime = '19:00'
GO


--2. Procedure 2 For Train Schedule In Bound.
CREATE PROCEDURE TrainScheduleInbound @Source VARCHAR(25), @Destination VARCHAR(25), @StartTime TIME, @EndTime TIME
AS
BEGIN
SELECT  t1.trainID, s1.StationName,t1.Arrival, s2.StationName, t1.[Date]
FROM TrainSchedule t1 inner join TrainSchedule t2 on t1.RunningTrainID = t2.RunningTrainID and t1.RouteID = t2.RouteID
inner join Station s1 on s1.StationStopID=t1.StationStopID inner join Station s2 on s2.StationStopID=t2.StationStopID
inner join Route r on s1.RouteID=r.RouteID
where (t1.Arrival between @StartTime and @EndTime) and s1.StationName = @Source and s2.StationName=@Destination and (t1.RouteID='GE2' OR t1.RouteID='GD2' OR t1.RouteID='GC2' OR t1.RouteID='GB2'
OR t1.RouteID='B2' OR t1.RouteID='RA2'OR  t1.RouteID='O2'OR t1.RouteID='RB2' OR t1.RouteID='RM2')
END
EXECUTE TrainScheduleInbound
@Source = 'Kenmore'
, @Destination = 'Boston University West'
, @StartTime = '15:00'
, @EndTime = '19:00'
GO


--3. Procedure 3 for Addition of Passenger details in Passenger and Passenger Address.
CREATE PROCEDURE AddPassengerDetails @passengerID int, @passengerName varchar(25), @DOB date, @contactInfo int, @addressID int, @emailID VARCHAR(225), @address VARCHAR(255), @state VARCHAR(225), @country VARCHAR(225), @zipcode int
AS
BEGIN
INSERT INTO PassengerAddress(AddressID,[Address],[State],Country,ZipCode) VALUES (@addressID, @address ,@state, @country, @zipcode);
INSERT INTO Passenger(PassengerID,PassengerName,DateOfBirth,ContactInformation,AddressID,EmailID) VALUES (@passengerID, @passengerName, @DOB, @contactInfo,@addressID,@emailID);
SELECT * FROM Passenger
END
EXECUTE AddPassengerDetails
   @passengerID = 182
  ,@passengerName = 'Milan Yewale'
  ,@DOB = '1996-12-12'
  ,@contactInfo = 13847333
  ,@addressID = 111
  ,@emailID = 'ry@gmail.com'
  ,@address='69 South Huntington'
  ,@state= 'MA'
  ,@country= 'USA'
  ,@zipcode = 02130
  PRINT('Passenger Details added successfully!')
GO

SELECT * FROM PassengerAddress


--4. Procedure 4 For getting Reaching time at Our Desired Location.
GO
CREATE PROCEDURE ReachingTimeForDesiredDestination @SOURCE VARCHAR(50), @DESTINATION VARCHAR (50), @RunningTrainID VARCHAR (20)
AS
BEGIN
SELECT TrainID,RunningTrainID, s.StationName, Arrival,
( select Arrival from Station join TrainSchedule on Station.StationStopID=TrainSchedule.StationStopID where (StationName=@DESTINATION and RunningTrainID =@RunningTrainID)) as ReachingTimeAtDesiredDestination
FROM TrainSchedule t INNER JOIN Station s on
t.StationStopID=s.StationStopID where (s.StationName = @SOURCE ) and (RunningTrainID = @RunningTrainID)
END
EXECUTE ReachingTimeForDesiredDestination
@SOURCE = 'Davis',
@DESTINATION ='Park Street',
@RunningTrainID = 'RRA3'
GO



--5 Procedure 5 For getting Exact Detailed Schedule of Particular Driver.
GO
CREATE PROCEDURE DriverSchedule @DriverID INT
AS
BEGIN
SELECT Driver.DriverID, Driver.DriverName, TrainSchedule.Arrival, TrainSchedule.TrainID, TrainSchedule.RouteID, TrainSchedule.[Date]
FROM Driver INNER JOIN TrainSchedule ON TrainSchedule.DriverID = Driver.DriverID WHERE Driver.DriverID = @DriverID
END
EXECUTE DriverSchedule
@DriverID  = 3
GO








