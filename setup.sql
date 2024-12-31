-- File Path: /employee_management_rbac/setup.sql

-- Step 1: Create Database
CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

-- Step 2: Create Tables

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DepartmentID INT,
    RoleID INT,
    HireDate DATE NOT NULL
);

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

-- Roles Table
CREATE TABLE Roles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL UNIQUE
);

-- Audit Logs Table
CREATE TABLE AuditLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Action VARCHAR(255) NOT NULL,
    PerformedBy INT NOT NULL,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PerformedBy) REFERENCES Employees(EmployeeID)
);

-- Step 3: Populate Initial Data

-- Insert Departments
INSERT INTO Departments (DepartmentName) VALUES
('Human Resources'),
('Engineering'),
('Sales'),
('Marketing');

-- Insert Roles
INSERT INTO Roles (RoleName) VALUES
('Admin'),
('Manager'),
('Employee');

-- Insert Employees
INSERT INTO Employees (FullName, Email, DepartmentID, RoleID, HireDate) VALUES
('Alice Johnson', 'alice.johnson@example.com', 1, 1, '2020-01-15'),
('Bob Smith', 'bob.smith@example.com', 2, 2, '2021-06-10'),
('Charlie Brown', 'charlie.brown@example.com', 2, 3, '2022-03-22');

-- Step 4: Create Stored Procedures

-- Add Employee
DELIMITER //
CREATE PROCEDURE AddEmployee (
    IN p_FullName VARCHAR(100),
    IN p_Email VARCHAR(100),
    IN p_DepartmentID INT,
    IN p_RoleID INT,
    IN p_HireDate DATE
)
BEGIN
    INSERT INTO Employees (FullName, Email, DepartmentID, RoleID, HireDate)
    VALUES (p_FullName, p_Email, p_DepartmentID, p_RoleID, p_HireDate);

    INSERT INTO AuditLogs (Action, PerformedBy)
    VALUES (CONCAT('Added new employee: ', p_FullName), LAST_INSERT_ID());
END //
DELIMITER ;

-- Promote Employee
DELIMITER //
CREATE PROCEDURE PromoteEmployee (
    IN p_EmployeeID INT,
    IN p_NewRoleID INT,
    IN p_PerformedBy INT
)
BEGIN
    UPDATE Employees
    SET RoleID = p_NewRoleID
    WHERE EmployeeID = p_EmployeeID;

    INSERT INTO AuditLogs (Action, PerformedBy)
    VALUES (CONCAT('Promoted employee ID ', p_EmployeeID, ' to role ID ', p_NewRoleID), p_PerformedBy);
END //
DELIMITER ;

-- View Audit Logs
DELIMITER //
CREATE PROCEDURE ViewAuditLogs()
BEGIN
    SELECT * FROM AuditLogs;
END //
DELIMITER ;

-- Step 5: Implement Role-Based Access Control (RBAC)

-- Example Query: Fetch all employees with roles and departments
SELECT 
    e.EmployeeID, 
    e.FullName, 
    e.Email, 
    d.DepartmentName, 
    r.RoleName, 
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Roles r ON e.RoleID = r.RoleID;

-- Grant Role-Specific Permissions
-- Example: Grant SELECT to Managers
GRANT SELECT ON EmployeeManagement.Employees TO 'manager_user'@'localhost';
