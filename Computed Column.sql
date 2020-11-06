--------------------Computed Columns based on a Function-------------------------


ALTER TABLE Passenger ADD CurrentAge AS DATEDIFF(YEAR, DateofBirth, GETDATE())

SELECT * FROM Passenger
