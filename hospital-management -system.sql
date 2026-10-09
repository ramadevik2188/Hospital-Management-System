-- =====================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- DATABASE, TABLE CREATION AND DATA INSERTION
-- =====================================================


-- =====================================================
-- CREATE DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS hospital_db;

USE hospital_db;


-- =====================================================
-- DROP EXISTING TABLES
-- =====================================================

DROP TABLE IF EXISTS Bill;
DROP TABLE IF EXISTS Medicine;
DROP TABLE IF EXISTS Treatment;
DROP TABLE IF EXISTS Admission;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Patient;


-- =====================================================
-- 1. PATIENT TABLE
-- =====================================================

CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT NOT NULL CHECK (Age >= 0),
    Gender VARCHAR(10) NOT NULL
        CHECK (Gender IN ('Male', 'Female', 'Other')),
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Blood_Group VARCHAR(5) NOT NULL
);


-- =====================================================
-- 2. DEPARTMENT TABLE
-- =====================================================

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL
);


-- =====================================================
-- 3. DOCTOR TABLE
-- =====================================================

CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Specialization VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Department_ID INT NOT NULL,

    CONSTRAINT fk_doctor_department
        FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);


-- =====================================================
-- 4. APPOINTMENT TABLE
-- =====================================================

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Scheduled'
        CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled')),

    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID),

    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
);


-- =====================================================
-- 5. ADMISSION TABLE
-- =====================================================

CREATE TABLE Admission (
    Admission_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Room_No VARCHAR(10) NOT NULL,
    Admission_Date DATE NOT NULL,
    Discharge_Date DATE,

    CONSTRAINT fk_admission_patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
);


-- =====================================================
-- 6. TREATMENT TABLE
-- =====================================================

CREATE TABLE Treatment (
    Treatment_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    Diagnosis VARCHAR(100) NOT NULL,
    Treatment_Date DATE NOT NULL,
    Description VARCHAR(255),

    CONSTRAINT fk_treatment_patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID),

    CONSTRAINT fk_treatment_doctor
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctor(Doctor_ID)
);


-- =====================================================
-- 7. MEDICINE TABLE
-- =====================================================

CREATE TABLE Medicine (
    Medicine_ID INT PRIMARY KEY,
    Medicine_Name VARCHAR(100) NOT NULL UNIQUE,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0)
);


-- =====================================================
-- 8. BILL TABLE
-- =====================================================

CREATE TABLE Bill (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Bill_Date DATE NOT NULL,
    Treatment_Charge DECIMAL(10,2) NOT NULL
        CHECK (Treatment_Charge >= 0),
    Medicine_Charge DECIMAL(10,2) NOT NULL
        CHECK (Medicine_Charge >= 0),
    Total_Amount DECIMAL(10,2) NOT NULL
        CHECK (Total_Amount >= 0),

    CONSTRAINT fk_bill_patient
        FOREIGN KEY (Patient_ID)
        REFERENCES Patient(Patient_ID)
);


-- =====================================================
-- INSERT DATA
-- =====================================================


-- =====================================================
-- 1. DEPARTMENT DATA
-- =====================================================

INSERT INTO Department
(Department_ID, Department_Name, Location)
VALUES
(101, 'Cardiology', 'Block A'),
(102, 'Neurology', 'Block B'),
(103, 'Orthopedics', 'Block C'),
(104, 'Pediatrics', 'Block D'),
(105, 'General Medicine', 'Block E');


-- =====================================================
-- 2. PATIENT DATA
-- =====================================================

INSERT INTO Patient
(Patient_ID, Name, Age, Gender, Phone, Address, Blood_Group)
VALUES
(1001, 'Ravi Kumar', 45, 'Male', '9876543210', 'Guntur', 'A+'),
(1002, 'Priya Sharma', 32, 'Female', '9876543211', 'Vijayawada', 'B+'),
(1003, 'Arjun Reddy', 55, 'Male', '9876543212', 'Hyderabad', 'O+'),
(1004, 'Anjali Rao', 28, 'Female', '9876543213', 'Rajahmundry', 'AB+'),
(1005, 'Suresh Kumar', 60, 'Male', '9876543214', 'Kakinada', 'A-'),
(1006, 'Lakshmi Devi', 40, 'Female', '9876543215', 'Guntur', 'O+'),
(1007, 'Rahul Verma', 25, 'Male', '9876543216', 'Visakhapatnam', 'B-'),
(1008, 'Sneha Reddy', 35, 'Female', '9876543217', 'Eluru', 'A+'),
(1009, 'Kiran Kumar', 50, 'Male', '9876543218', 'Tenali', 'AB-'),
(1010, 'Divya Rao', 22, 'Female', '9876543219', 'Vijayawada', 'O-');


-- =====================================================
-- 3. DOCTOR DATA
-- =====================================================

INSERT INTO Doctor
(Doctor_ID, Name, Specialization, Phone, Email, Department_ID)
VALUES
(201, 'Dr. Rajesh', 'Cardiologist', '9000000001', 'rajesh@hospital.com', 101),
(202, 'Dr. Meena', 'Neurologist', '9000000002', 'meena@hospital.com', 102),
(203, 'Dr. Arvind', 'Orthopedic', '9000000003', 'arvind@hospital.com', 103),
(204, 'Dr. Kavya', 'Pediatrician', '9000000004', 'kavya@hospital.com', 104),
(205, 'Dr. Sandeep', 'General Physician', '9000000005', 'sandeep@hospital.com', 105),
(206, 'Dr. Priyanka', 'Cardiologist', '9000000006', 'priyanka@hospital.com', 101),
(207, 'Dr. Naveen', 'Orthopedic', '9000000007', 'naveen@hospital.com', 103),
(208, 'Dr. Anusha', 'General Physician', '9000000008', 'anusha@hospital.com', 105);


-- =====================================================
-- 4. APPOINTMENT DATA
-- =====================================================

INSERT INTO Appointment
(Appointment_ID, Patient_ID, Doctor_ID, Appointment_Date,
 Appointment_Time, Status)
VALUES
(301, 1001, 201, '2025-01-05', '09:00:00', 'Completed'),
(302, 1002, 202, '2025-01-06', '10:00:00', 'Completed'),
(303, 1003, 203, '2025-01-07', '11:00:00', 'Completed'),
(304, 1004, 204, '2025-01-08', '09:30:00', 'Scheduled'),
(305, 1005, 205, '2025-01-09', '10:30:00', 'Completed'),
(306, 1006, 206, '2025-01-10', '11:30:00', 'Cancelled'),
(307, 1007, 207, '2025-01-11', '12:00:00', 'Scheduled'),
(308, 1008, 208, '2025-01-12', '09:00:00', 'Completed'),
(309, 1009, 201, '2025-01-13', '10:00:00', 'Scheduled'),
(310, 1010, 205, '2025-01-14', '11:00:00', 'Completed'),
(311, 1001, 206, '2025-01-15', '09:30:00', 'Completed'),
(312, 1002, 202, '2025-01-16', '10:30:00', 'Scheduled'),
(313, 1003, 207, '2025-01-17', '11:30:00', 'Completed'),
(314, 1004, 204, '2025-01-18', '12:00:00', 'Scheduled'),
(315, 1005, 205, '2025-01-19', '09:00:00', 'Completed');


-- =====================================================
-- 5. ADMISSION DATA
-- =====================================================

INSERT INTO Admission
(Admission_ID, Patient_ID, Room_No, Admission_Date, Discharge_Date)
VALUES
(401, 1001, 'A101', '2025-01-05', '2025-01-10'),
(402, 1002, 'B202', '2025-01-06', '2025-01-09'),
(403, 1003, 'C303', '2025-01-07', '2025-01-12'),
(404, 1004, 'D404', '2025-01-08', '2025-01-11'),
(405, 1005, 'E505', '2025-01-09', '2025-01-15'),
(406, 1006, 'A102', '2025-01-10', '2025-01-13'),
(407, 1007, 'C304', '2025-01-11', '2025-01-14'),
(408, 1008, 'E506', '2025-01-12', '2025-01-16');


-- =====================================================
-- 6. TREATMENT DATA
-- =====================================================

INSERT INTO Treatment
(Treatment_ID, Patient_ID, Doctor_ID, Diagnosis, Treatment_Date, Description)
VALUES
(501, 1001, 201, 'Heart Checkup', '2025-01-05', 'ECG and regular cardiac examination'),
(502, 1002, 202, 'Migraine', '2025-01-06', 'Medication and neurological examination'),
(503, 1003, 203, 'Knee Pain', '2025-01-07', 'X-ray and orthopedic treatment'),
(504, 1004, 204, 'Fever', '2025-01-08', 'General examination and medication'),
(505, 1005, 205, 'Diabetes', '2025-01-09', 'Blood sugar monitoring'),
(506, 1006, 206, 'Chest Pain', '2025-01-10', 'ECG and cardiac consultation'),
(507, 1007, 207, 'Fracture', '2025-01-11', 'Bone examination and treatment'),
(508, 1008, 208, 'Cold and Cough', '2025-01-12', 'General medication'),
(509, 1009, 201, 'Blood Pressure', '2025-01-13', 'BP monitoring and consultation'),
(510, 1010, 205, 'Fever', '2025-01-14', 'General examination'),
(511, 1001, 206, 'Hypertension', '2025-01-15', 'Blood pressure treatment'),
(512, 1002, 202, 'Headache', '2025-01-16', 'Neurological examination'),
(513, 1003, 207, 'Back Pain', '2025-01-17', 'Physical examination'),
(514, 1004, 204, 'Viral Fever', '2025-01-18', 'Medication and observation'),
(515, 1005, 205, 'Diabetes Follow-up', '2025-01-19', 'Follow-up consultation');


-- =====================================================
-- 7. MEDICINE DATA
-- =====================================================

INSERT INTO Medicine
(Medicine_ID, Medicine_Name, Quantity, Price)
VALUES
(601, 'Paracetamol', 100, 5.00),
(602, 'Amoxicillin', 80, 12.00),
(603, 'Ibuprofen', 75, 8.00),
(604, 'Aspirin', 120, 4.00),
(605, 'Metformin', 90, 10.00),
(606, 'Cetirizine', 100, 6.00),
(607, 'Omeprazole', 70, 9.00),
(608, 'Azithromycin', 60, 15.00),
(609, 'Insulin', 40, 25.00),
(610, 'Vitamin D', 100, 7.00);


-- =====================================================
-- 8. BILL DATA
-- =====================================================

INSERT INTO Bill
(Bill_ID, Patient_ID, Bill_Date, Treatment_Charge,
 Medicine_Charge, Total_Amount)
VALUES
(701, 1001, '2025-01-10', 5000.00, 1000.00, 6000.00),
(702, 1002, '2025-01-09', 3500.00, 800.00, 4300.00),
(703, 1003, '2025-01-12', 7000.00, 1500.00, 8500.00),
(704, 1004, '2025-01-11', 2500.00, 500.00, 3000.00),
(705, 1005, '2025-01-15', 6000.00, 1200.00, 7200.00),
(706, 1006, '2025-01-13', 4500.00, 900.00, 5400.00),
(707, 1007, '2025-01-14', 8000.00, 2000.00, 10000.00),
(708, 1008, '2025-01-16', 3000.00, 600.00, 3600.00),
(709, 1009, '2025-01-13', 4000.00, 700.00, 4700.00),
(710, 1010, '2025-01-14', 2000.00, 400.00, 2400.00);


-- =====================================================
-- DISPLAY ALL TABLES
-- =====================================================

SHOW TABLES;


-- =====================================================
-- DISPLAY TABLE STRUCTURES
-- =====================================================

DESCRIBE Patient;
DESCRIBE Department;
DESCRIBE Doctor;
DESCRIBE Appointment;
DESCRIBE Admission;
DESCRIBE Treatment;
DESCRIBE Medicine;
DESCRIBE Bill;


-- =====================================================
-- DISPLAY INSERTED DATA
-- =====================================================

SELECT * FROM Patient;

SELECT * FROM Department;

SELECT * FROM Doctor;

SELECT * FROM Appointment;

SELECT * FROM Admission;

SELECT * FROM Treatment;

SELECT * FROM Medicine;

SELECT * FROM Bill;