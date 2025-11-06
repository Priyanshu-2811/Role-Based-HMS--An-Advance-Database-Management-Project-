use HOSPITAL_DB;

-- Trigger to Auto-Update Room Status on Insertion into Inpatient
CREATE TRIGGER Update_Room_Status
ON Inpatient
AFTER INSERT
AS
BEGIN
    UPDATE Room
    SET status = 'Occupied',
        patient_id = i.patient_id
    FROM Room r
    JOIN inserted i ON r.room_no = i.room_no;

    PRINT 'Room status updated to Occupied.';
END;
GO  -- Separate batch

-- Trigger to Ensure Doctor's Department Consistency on Insert or Update in Lab
CREATE TRIGGER Check_Doctor_Exists_In_Lab
ON Lab
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (SELECT 1 FROM Doctor WHERE Doctor_id = i.DOCTOR_ID)
    )
    BEGIN
        RAISERROR('One or more doctors do not exist.', 16, 1);
        ROLLBACK TRANSACTION; -- Optionally rollback
    END

    PRINT 'Doctor validation passed for inserted doctors.';
END;
GO  -- Separate batch

-- Trigger to Automatically Calculate Total_Bill in Bill Table
CREATE TRIGGER Calculate_Total_Bill
ON Bill
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE b
    SET total_bill = ISNULL(i.doctor_charge, 0) + 
                     ISNULL(i.medicine_charge, 0) + 
                     ISNULL(i.operation_charge, 0) + 
                     ISNULL(i.nursing_charge, 0) + 
                     ISNULL(i.lab_charge, 0) - 
                     ISNULL(i.advance, 0)
    FROM Bill b
    JOIN inserted i ON b.bill_no = i.bill_no;  -- Use the correct primary key name

    PRINT 'Total bill calculated.';
END;
GO  -- Separate batch

-- Trigger to Prevent Duplicate NID in the Staff Table
CREATE TRIGGER Prevent_Duplicate_NID
ON Staff
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Staff s
        JOIN inserted i ON s.NID = i.NID AND s.s_id != i.s_id
    )
    BEGIN
        RAISERROR('Duplicate NID found.', 16, 1);
        ROLLBACK TRANSACTION; -- Optionally rollback
    END

    PRINT 'NIDs are unique for the inserted staff.';
END;
GO  -- Separate batch

-- Trigger to Update Room Status on Discharge of Inpatient
CREATE TRIGGER Room_Status_Discharge
ON Inpatient
AFTER UPDATE
AS
BEGIN
    IF UPDATE(date_of_discharge)
    BEGIN
        UPDATE Room
        SET status = 'Available',
            patient_id = NULL
        FROM Room r
        JOIN deleted d ON r.room_no = d.room_no
        WHERE d.date_of_discharge IS NOT NULL;

        PRINT 'Room status updated to Available.';
    END
END;
GO  -- Separate batch

-- Trigger to Prevent Insert of Outpatient with Invalid lab_no
CREATE TRIGGER Check_Valid_Lab_No
ON Outpatient
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (SELECT 1 FROM Lab WHERE lab_no = i.lab_no)
    )
    BEGIN
        RAISERROR('One or more lab numbers are invalid.', 16, 1);
        ROLLBACK TRANSACTION; -- Optionally rollback
    END

    PRINT 'Lab numbers are valid for outpatients.';
END;
GO  -- Separate batch
