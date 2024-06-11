CREATE DATABASE RealEstateManagement;

USE RealEstateManagement;

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Property (
    PropertyID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(10),
    Price DECIMAL(10, 2) NOT NULL,
    AgentID INT,
    FOREIGN KEY (AgentID) REFERENCES Agent(AgentID)
);

CREATE TABLE Agent (
    AgentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Sale (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT,
    CustomerID INT,
    SaleDate DATE,
    SalePrice DECIMAL(10, 2),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Lease (
    LeaseID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyID INT,
    CustomerID INT,
    StartDate DATE,
    EndDate DATE,
    Rent DECIMAL(10, 2),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    LeaseID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (LeaseID) REFERENCES Lease(LeaseID)
);

CREATE TABLE Owner (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE PropertyOwner (
    PropertyID INT,
    OwnerID INT,
    OwnershipStartDate DATE,
    OwnershipEndDate DATE,
    PRIMARY KEY (PropertyID, OwnerID),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
);
-- Insert sample data into Customer
INSERT INTO Customer (Name, Address, Phone, Email)
VALUES ('John Doe', '123 Main St', '555-1234', 'johndoe@example.com'),
       ('Jane Smith', '456 Oak St', '555-5678', 'janesmith@example.com');
select * from customer;

-- Insert sample data into Property
INSERT INTO Property (Address, City, State, ZipCode, Price, AgentID)
VALUES ('789 Pine St', 'Springfield', 'IL', '62704', 250000.00, 1),
       ('101 Maple St', 'Springfield', 'IL', '62704', 300000.00, 2);
select * from property;
-- Insert sample data into Agent
INSERT INTO Agent (Name, Phone, Email)
VALUES ('Alice Johnson', '555-8765', 'alicejohnson@example.com'),
       ('Bob Brown', '555-4321', 'bobbrown@example.com');
select * from agent;

-- Insert sample data into Sale
INSERT INTO Sale (PropertyID, CustomerID, SaleDate, SalePrice)
VALUES (3, 1, '2023-01-01', 250000.00),
       (4, 2, '2023-02-01', 300000.00);
select * from sale;
-- Insert sample data into Lease
INSERT INTO Lease (PropertyID, CustomerID, StartDate, EndDate, Rent)
VALUES (3, 1, '2023-01-01', '2024-01-01', 1500.00),
       (4, 2, '2023-02-01', '2024-02-01', 2000.00);
select * from lease;

-- Insert sample data into Payment
INSERT INTO Payment (LeaseID, PaymentDate, Amount)
VALUES (3, '2023-01-15', 1500.00),
       (4, '2023-02-15', 2000.00);
select * from payment;
-- Insert sample data into Owner
INSERT INTO Owner (Name, Address, Phone, Email)
VALUES ('Charles Green', '789 Birch St', '555-6789', 'charlesgreen@example.com'),
       ('Diane White', '101 Elm St', '555-9876', 'dianewhite@example.com');
select * from owner;
-- Insert sample data into PropertyOwner
INSERT INTO PropertyOwner (PropertyID, OwnerID, OwnershipStartDate, OwnershipEndDate)
VALUES (3, 1, '2020-01-01', '2023-01-01'),
       (4, 2, '2021-02-01', '2023-02-01');
select * from propertyowner;

-- Retrieve all properties
SELECT * FROM Property;

-- Retrieve all customers in a specific city
SELECT * FROM Customer WHERE Address LIKE '%Springfield%';

-- Retrieve all sales for a specific customer
SELECT * FROM Sale WHERE CustomerID = 1;

-- Count of properties managed by each agent
SELECT AgentID, COUNT(*) AS PropertyCount
FROM Property
GROUP BY AgentID;

-- Total sales amount
SELECT SUM(SalePrice) AS TotalSales
FROM Sale;

-- Insert a new customer
INSERT INTO Customer (Name, Address, Phone, Email)
VALUES ('George Blue', '111 Cedar St', '555-1111', 'georgeblue@example.com');
select * from customer;

-- Update property price
UPDATE Property
SET Price = 275000.00
WHERE PropertyID = 3;
select * from property;

-- Delete a sale record
DELETE FROM Sale
WHERE SaleID = 5;
select * from sale;

-- Join query to retrieve properties and their agents
SELECT Property.Address, Agent.Name AS AgentName
FROM Property
INNER JOIN Agent ON Property.AgentID = Agent.AgentID;

-- Subquery to find customers who have made a payment
SELECT Customer.*
FROM Customer
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Lease
    INNER JOIN Payment ON Lease.LeaseID = Payment.LeaseID
);

