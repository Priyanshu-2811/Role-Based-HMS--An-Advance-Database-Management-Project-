USE HOSPITAL_DB;

-- Insert into Doctor
INSERT INTO Doctor (Doctor_id, Doctor_name, Dept) VALUES (1, 'Dr. John Smith', 'Cardiology');
INSERT INTO Doctor (Doctor_id, Doctor_name, Dept) VALUES (2, 'Dr. Sarah Lee', 'Neurology');

-- Insert into Staff
INSERT INTO Staff (s_id, s_name, NID, salary) VALUES (1, 'Alice Brown', 'NID001', 45000.50);
INSERT INTO Staff (s_id, s_name, NID, salary) VALUES (2, 'Bob Harris', 'NID002', 52000.75);

-- Insert into Lab
INSERT INTO Lab (lab_no, patient_id, weight, DOCTOR_ID, visit_date, category, patient_type, amount) 
VALUES (101, 1, 75.5, 1, '2023-09-25', 'Blood Test', 'Inpatient', 1500.00);
INSERT INTO Lab (lab_no, patient_id, weight, DOCTOR_ID, visit_date, category, patient_type, amount) 
VALUES (102, 2, 68.2, 2, '2023-09-26', 'MRI', 'Outpatient', 2500.00);

-- Insert into Inpatient
INSERT INTO Inpatient (patient_id, name, gender, address, room_no, date_of_admit, date_of_discharge, advance, lab_no, Doctor_id, disease) 
VALUES (1, 'John Doe', 'Male', '123 Main St', 101, '2023-09-20', NULL, 10000.00, 101, 1, 'Cardiac Arrest');
INSERT INTO Inpatient (patient_id, name, gender, address, room_no, date_of_admit, date_of_discharge, advance, lab_no, Doctor_id, disease) 
VALUES (2, 'Jane Doe', 'Female', '456 Elm St', 102, '2023-09-22', NULL, 8000.00, 102, 2, 'Migraine');

-- Insert into Outpatient
INSERT INTO Outpatient (patient_id, visit_date, lab_no) 
VALUES (3, '2023-09-23', 102);

-- Insert into Room
INSERT INTO Room (room_no, room_type, status, patient_id) 
VALUES (101, 'Private', 'Occupied', 1);
INSERT INTO Room (room_no, room_type, status, patient_id) 
VALUES (102, 'General', 'Occupied', 2);

-- Insert into Doctor
INSERT INTO Doctor (Doctor_id, Doctor_name, Dept) 
VALUES (3, 'Dr. Rajesh Sharma', 'Orthopedics');
INSERT INTO Doctor (Doctor_id, Doctor_name, Dept) 
VALUES (4, 'Dr. Priya Mehta', 'Pediatrics');

-- Insert into Staff
INSERT INTO Staff (s_id, s_name, NID, salary) 
VALUES (3, 'Suresh Kumar', 'NID003', 42000.50);
INSERT INTO Staff (s_id, s_name, NID, salary) 
VALUES (4, 'Meena Gupta', 'NID004', 47000.00);

-- Insert into Lab
INSERT INTO Lab (lab_no, patient_id, weight, DOCTOR_ID, visit_date, category, patient_type, amount) 
VALUES (103, 3, 60.8, 3, '2023-09-27', 'X-ray', 'Inpatient', 1200.00);
INSERT INTO Lab (lab_no, patient_id, weight, DOCTOR_ID, visit_date, category, patient_type, amount) 
VALUES (104, 4, 65.5, 4, '2023-09-28', 'Ultrasound', 'Outpatient', 2000.00);

-- Insert into Inpatient
INSERT INTO Inpatient (patient_id, name, gender, address, room_no, date_of_admit, date_of_discharge, advance, lab_no, Doctor_id, disease) 
VALUES (3, 'Rahul Verma', 'Male', '789 Ashoka Road', 103, '2023-09-21', NULL, 9000.00, 103, 3, 'Fracture');
INSERT INTO Inpatient (patient_id, name, gender, address, room_no, date_of_admit, date_of_discharge, advance, lab_no, Doctor_id, disease) 
VALUES (4, 'Neha Patil', 'Female', '12 MG Road', 104, '2023-09-24', NULL, 8500.00, 104, 4, 'Pneumonia');

-- Insert into Outpatient
INSERT INTO Outpatient (patient_id, visit_date, lab_no) 
VALUES (5, '2023-09-29', 104);
use HOSPITAL_DB;
-- Insert into Room
INSERT INTO Room (room_no, room_type, status, patient_id) 
VALUES (103, 'Private', 'Occupied', 3);
INSERT INTO Room (room_no, room_type, status, patient_id) 
VALUES (104, 'General', 'Occupied', 4);

-- Insert into Bill
INSERT INTO Bill (bill_no, patient_id, patient_type, doctor_charge, medicine_charge, operation_charge, number_of_days, nursing_charge, advance, health_card, lab_charge, total_bill) 
VALUES (1001, 3, 'Inpatient', 5000.00, 3000.00, 12000.00, 5, 1500.00, 9000.00, 'Yes', 1500.00, 23000.00);

INSERT INTO Bill (bill_no, patient_id, patient_type, doctor_charge, medicine_charge, operation_charge, number_of_days, nursing_charge, advance, health_card, lab_charge, total_bill) 
VALUES (1002, 4, 'Inpatient', 6000.00, 2500.00, 11000.00, 7, 1800.00, 8500.00, 'No', 1200.00, 25600.00);

INSERT INTO Bill (bill_no, patient_id, patient_type, doctor_charge, medicine_charge, operation_charge, number_of_days, nursing_charge, advance, health_card, lab_charge, total_bill) 
VALUES (1003, 5, 'Outpatient', 2000.00, 1000.00, 0.00, 1, 500.00, 0.00, 'Yes', 1000.00, 4500.00);

INSERT INTO Bill (bill_no, patient_id, patient_type, doctor_charge, medicine_charge, operation_charge, number_of_days, nursing_charge, advance, health_card, lab_charge, total_bill) 
VALUES (1004, 1, 'Outpatient', 2500.00, 1200.00, 0.00, 1, 600.00, 0.00, 'No', 800.00, 5100.00);
