-- Create Database
CREATE DATABASE GreenCar_database;
USE GreenCar_database;
GO
-- Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address TEXT NOT NULL
);
-- Vehicle Table
CREATE TABLE Vehicle (
    VehicleID INT PRIMARY KEY IDENTITY(1,1),
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    Mileage INT NOT NULL,
    AvailabilityStatus VARCHAR(20) CHECK (AvailabilityStatus IN ('Available', 'Rented', 'Maintenance')) NOT NULL,
    GPSInstalled BIT NOT NULL
);
-- Reservation Table
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    VehicleID INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);
-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    ReservationID INT,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'PayPal')) NOT NULL,
    PaymentStatus VARCHAR(10) CHECK (PaymentStatus IN ('Paid', 'Pending', 'Failed')) NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);
-- Rental Agreement Table
CREATE TABLE RentalAgreement (
    AgreementID INT PRIMARY KEY IDENTITY(1,1),
    ReservationID INT,
    PickUpLocation VARCHAR(100) NOT NULL,
    DropOffLocation VARCHAR(100) NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);
-- Branch Table
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    Location VARCHAR(100) NOT NULL,
    ManagerName VARCHAR(100) NOT NULL
);
-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(20) CHECK (Role IN ('Manager', 'Sales', 'Maintenance')) NOT NULL,
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
-- Maintenance Table
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    VehicleID INT,
    Date DATE NOT NULL,
    ServiceType VARCHAR(100) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID)
);
-- Insurance Table
CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY IDENTITY(1,1),
    AgreementID INT,
    PolicyType VARCHAR(15) CHECK (PolicyType IN ('Basic', 'Comprehensive')) NOT NULL,
    CoverageAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (AgreementID) REFERENCES RentalAgreement(AgreementID)
);
-- Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment VARCHAR(MAX),
    Date DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Customer (Name, Email, Phone, Address)
VALUES 
('John Doe', 'john.doe@email.com', '1234567890', '123 Main St, City, Country'),
('Jane Smith', 'jane.smith@email.com', '2345678901', '456 Elm St, City, Country'),
('Alice Johnson', 'alice.johnson@email.com', '3456789012', '789 Oak St, City, Country'),
('Bob Brown', 'bob.brown@email.com', '4567890123', '101 Pine St, City, Country'),
('Charlie Davis', 'charlie.davis@email.com', '5678901234', '202 Maple St, City, Country');


INSERT INTO Vehicle (Make, Model, Type, Year, Mileage, AvailabilityStatus, GPSInstalled)
VALUES 
('Toyota', 'Corolla', 'Sedan', 2020, 15000, 'Available', 1),
('Honda', 'Civic', 'Sedan', 2019, 30000, 'Rented', 0),
('Ford', 'Focus', 'Hatchback', 2021, 12000, 'Available', 1),
('Chevrolet', 'Malibu', 'Sedan', 2018, 45000, 'Maintenance', 0),
('BMW', 'X5', 'SUV', 2022, 5000, 'Available', 1);

INSERT INTO Reservation (CustomerID, VehicleID, StartDate, EndDate, Status)
VALUES 
(1, 1, '2025-02-01', '2025-02-05', 'Confirmed'),
(2, 2, '2025-02-02', '2025-02-06', 'Pending'),
(3, 3, '2025-02-03', '2025-02-07', 'Cancelled'),
(4, 4, '2025-02-04', '2025-02-08', 'Confirmed'),
(5, 5, '2025-02-05', '2025-02-09', 'Pending');

INSERT INTO Payment (ReservationID, Amount, PaymentMethod, PaymentStatus)
VALUES 
(1, 150.00, 'Credit Card', 'Paid'),
(2, 200.00, 'Debit Card', 'Pending'),
(3, 100.00, 'PayPal', 'Failed'),
(4, 250.00, 'Credit Card', 'Paid'),
(5, 180.00, 'Debit Card', 'Pending');

INSERT INTO RentalAgreement (ReservationID, PickUpLocation, DropOffLocation, TotalCost)
VALUES 
(1, 'Downtown Branch', 'Airport', 200.00),
(2, 'Airport', 'Suburban Branch', 250.00),
(3, 'Suburban Branch', 'Downtown Branch', 180.00),
(4, 'Airport', 'Downtown Branch', 220.00),
(5, 'Downtown Branch', 'Suburban Branch', 240.00);

INSERT INTO Branch (Location, ManagerName)
VALUES 
('Downtown', 'Alice Williams'),
('Suburban', 'Bob Miller'),
('Airport', 'Charlie Brown'),
('City Center', 'Diana Green'),
('Uptown', 'Evan White');

INSERT INTO Employee (Name, Role, BranchID)
VALUES 
('Mike Johnson', 'Manager', 1),
('Emma Davis', 'Sales', 2),
('Daniel Lee', 'Maintenance', 3),
('Sophia Harris', 'Sales', 4),
('Oliver Clark', 'Manager', 5);

INSERT INTO Maintenance (VehicleID, Date, ServiceType, Cost)
VALUES 
(1, '2025-01-15', 'Oil Change', 50.00),
(2, '2025-01-16', 'Tire Replacement', 120.00),
(3, '2025-01-17', 'Brake Service', 80.00),
(4, '2025-01-18', 'Engine Repair', 200.00),
(5, '2025-01-19', 'Battery Replacement', 150.00);

INSERT INTO Insurance (AgreementID, PolicyType, CoverageAmount)
VALUES 
(1, 'Basic', 5000.00),
(2, 'Comprehensive', 10000.00),
(3, 'Basic', 4000.00),
(4, 'Comprehensive', 12000.00),
(5, 'Basic', 6000.00);


INSERT INTO Feedback (CustomerID, Rating, Comment, Date)
VALUES 
(1, 5, 'Great service, highly recommend!', '2025-01-25'),
(2, 4, 'Good experience, but could be faster.', '2025-01-26'),
(3, 2, 'The car had issues, not satisfied.', '2025-01-27'),
(4, 5, 'Excellent, the car was in great condition!', '2025-01-28'),
(5, 3, 'Okay service, the car was a bit dirty.', '2025-01-29');

SELECT Name, Email, Phone FROM Customer;

 SELECT * FROM Vehicle WHERE AvailabilityStatus = 'Available' ORDER BY Type, Year DESC;
 SELECT * FROM Reservation WHERE Status = 'Confirmed';
 SELECT SUM(Amount) AS Total_Revenue FROM Payment WHERE PaymentStatus = 'Paid';

 SELECT BranchID, COUNT(VehicleID) AS TotalVehicles FROM Vehicle GROUP BY BranchID;

 -- Add BranchID column to the Vehicle table
ALTER TABLE Vehicle
ADD BranchID INT;

-- Update the vehicles with the appropriate BranchID values (assuming you have branch IDs ready)
UPDATE Vehicle SET BranchID = 1 WHERE VehicleID IN (1, 3, 5);  -- Example vehicles for Downtown branch
UPDATE Vehicle SET BranchID = 2 WHERE VehicleID = 2;  -- Example vehicle for Suburban branch
UPDATE Vehicle SET BranchID = 3 WHERE VehicleID = 4;  -- Example vehicle for Airport branch

SELECT * FROM Employee WHERE Role = 'Maintenance';

SELECT r.ReservationID, c.Name AS CustomerName, v.Model FROM Reservation r JOIN Customer c ON r.CustomerID = c.CustomerID JOIN Vehicle v ON r.VehicleID = v.VehicleID;

SELECT c.Name, f.Rating, f.Comment FROM Feedback f JOIN Customer c ON f.CustomerID = c.CustomerID WHERE f.Rating = 5;

SELECT TOP 1 * FROM RentalAgreement
ORDER BY TotalCost DESC;


SELECT e.Name, e.Role, e.BranchID 
FROM Employee e
JOIN (
    SELECT TOP 1 BranchID, COUNT(*) AS TotalVehicles 
    FROM Vehicle 
    GROUP BY BranchID 
    ORDER BY TotalVehicles DESC
) AS MaxBranch
ON e.BranchID = MaxBranch.BranchID;
