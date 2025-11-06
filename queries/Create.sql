use HOSPITAL_DB;
CREATE TABLE Doctor (
    Doctor_id INT PRIMARY KEY,
    Doctor_name VARCHAR(255),
    Dept VARCHAR(255)
);

CREATE TABLE Staff (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(255),
    NID VARCHAR(255),
    salary DECIMAL(10, 2)
);

CREATE TABLE Lab (
    lab_no INT PRIMARY KEY,
    patient_id INT,
    weight DECIMAL(6, 2),
    DOCTOR_ID INT,
    visit_date DATE,
    category VARCHAR(255),
    patient_type VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (DOCTOR_ID) REFERENCES Doctor(Doctor_id)
);

CREATE TABLE Inpatient (
    patient_id INT PRIMARY KEY,
    name VARCHAR(255),
    gender VARCHAR(10),
    address VARCHAR(255),
    room_no INT,
    date_of_admit DATE,
    date_of_discharge DATE,
    advance DECIMAL(10, 2),
    lab_no INT,
    Doctor_id INT,
    disease VARCHAR(255),
    FOREIGN KEY (lab_no) REFERENCES Lab(lab_no),
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
);

CREATE TABLE Outpatient (
    patient_id INT PRIMARY KEY,
    visit_date DATE,  
    lab_no INT,
    FOREIGN KEY (lab_no) REFERENCES Lab(lab_no)
);

CREATE TABLE Room (
    room_no INT PRIMARY KEY,
    room_type VARCHAR(255),
    status VARCHAR(255),
    patient_id INT,
    FOREIGN KEY (patient_id) REFERENCES Inpatient(patient_id)
);

CREATE TABLE Bill (
    bill_no INT PRIMARY KEY,
    patient_id INT,
    patient_type VARCHAR(255),
    doctor_charge DECIMAL(10, 2),
    medicine_charge DECIMAL(10, 2),
    operation_charge DECIMAL(10, 2),
    number_of_days INT,
    nursing_charge DECIMAL(10, 2),
    advance DECIMAL(10, 2),
    health_card VARCHAR(255),
    lab_charge DECIMAL(10, 2),
    total_bill DECIMAL(10, 2),  
    FOREIGN KEY (patient_id) REFERENCES Outpatient(patient_id)
);
