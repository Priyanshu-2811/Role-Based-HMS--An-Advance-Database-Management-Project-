use HOSPITAL_DB;

-- Drop and recreate the Insert_Doctor procedure
IF OBJECT_ID('dbo.Insert_Doctor', 'P') IS NOT NULL
    DROP PROCEDURE dbo.Insert_Doctor;
GO

CREATE PROCEDURE Insert_Doctor (
    @Doctor_id INT,
    @Doctor_name NVARCHAR(255),
    @Dept NVARCHAR(255)
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Doctor (Doctor_id, Doctor_name, Dept)
        VALUES (@Doctor_id, @Doctor_name, @Dept);
        
        PRINT 'Doctor inserted successfully: ' + @Doctor_name;
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting doctor: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Drop and recreate the Insert_Inpatient procedure
IF OBJECT_ID('dbo.Insert_Inpatient', 'P') IS NOT NULL
    DROP PROCEDURE dbo.Insert_Inpatient;
GO

CREATE PROCEDURE Insert_Inpatient (
    @Patient_id INT,
    @Name NVARCHAR(255),
    @Gender NVARCHAR(10),
    @Address NVARCHAR(255),
    @Room_no INT,
    @Date_of_admit DATE,
    @Date_of_discharge DATE,
    @Advance DECIMAL(10,2),
    @Lab_no INT,
    @Doctor_id INT,
    @Disease NVARCHAR(255)
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Inpatient (patient_id, name, gender, address, room_no, date_of_admit, date_of_discharge, advance, lab_no, doctor_id, disease)
        VALUES (@Patient_id, @Name, @Gender, @Address, @Room_no, @Date_of_admit, @Date_of_discharge, @Advance, @Lab_no, @Doctor_id, @Disease);
        
        PRINT 'Inpatient inserted successfully: ' + @Name;
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting inpatient: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Drop and recreate the Insert_Lab procedure
IF OBJECT_ID('dbo.Insert_Lab', 'P') IS NOT NULL
    DROP PROCEDURE dbo.Insert_Lab;
GO

CREATE PROCEDURE Insert_Lab (
    @Lab_no INT,
    @Patient_id INT,
    @Weight DECIMAL(6,2),
    @Doctor_id INT,
    @Visit_date DATE,
    @Category NVARCHAR(255),
    @Patient_type NVARCHAR(255),
    @Amount DECIMAL(10,2)
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Lab (lab_no, patient_id, weight, doctor_id, visit_date, category, patient_type, amount)
        VALUES (@Lab_no, @Patient_id, @Weight, @Doctor_id, @Visit_date, @Category, @Patient_type, @Amount);
        
        PRINT 'Lab entry inserted successfully for patient ID: ' + CAST(@Patient_id AS NVARCHAR(10));
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting lab entry: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Drop and recreate the Insert_Bill procedure
IF OBJECT_ID('dbo.Insert_Bill', 'P') IS NOT NULL
    DROP PROCEDURE dbo.Insert_Bill;
GO

CREATE PROCEDURE Insert_Bill (
    @Bill_no INT,
    @Patient_id INT,
    @Patient_type NVARCHAR(255),
    @Doctor_charge DECIMAL(10,2),
    @Medicine_charge DECIMAL(10,2),
    @Operation_charge DECIMAL(10,2),
    @Number_of_days INT,
    @Nursing_charge DECIMAL(10,2),
    @Advance DECIMAL(10,2),
    @Health_card NVARCHAR(255),
    @Lab_charge DECIMAL(10,2),
    @Total_bill DECIMAL(10,2)
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Bill (bill_no, patient_id, patient_type, doctor_charge, medicine_charge, operation_charge, number_of_days, nursing_charge, advance, health_card, lab_charge, total_bill)
        VALUES (@Bill_no, @Patient_id, @Patient_type, @Doctor_charge, @Medicine_charge, @Operation_charge, @Number_of_days, @Nursing_charge, @Advance, @Health_card, @Lab_charge, @Total_bill);
        
        PRINT 'Bill inserted successfully for patient ID: ' + CAST(@Patient_id AS NVARCHAR(10));
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting bill: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Drop and recreate the update_doctor_details procedure
IF OBJECT_ID('dbo.update_doctor_details', 'P') IS NOT NULL
    DROP PROCEDURE dbo.update_doctor_details;
GO

CREATE PROCEDURE update_doctor_details(
    @Doctor_id INT,
    @Doctor_name NVARCHAR(255),
    @Dept NVARCHAR(255)
)
AS
BEGIN
    BEGIN TRY
        UPDATE Doctor
        SET Doctor_name = @Doctor_name,
            Dept = @Dept
        WHERE Doctor_id = @Doctor_id;
        
        PRINT 'Doctor details updated successfully';
    END TRY
    BEGIN CATCH
        PRINT 'Error updating doctor details: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Drop and recreate the delete_outpatient procedure
IF OBJECT_ID('dbo.delete_outpatient', 'P') IS NOT NULL
    DROP PROCEDURE dbo.delete_outpatient;
GO

CREATE PROCEDURE delete_outpatient(
    @Patient_id INT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM Outpatient
        WHERE patient_id = @Patient_id;
        
        PRINT 'Outpatient record deleted successfully';
    END TRY
    BEGIN CATCH
        PRINT 'Error deleting outpatient record: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Drop and recreate the assign_room procedure
IF OBJECT_ID('dbo.assign_room', 'P') IS NOT NULL
    DROP PROCEDURE dbo.assign_room;
GO

CREATE PROCEDURE assign_room(
    @Room_no INT,
    @Patient_id INT
)
AS
BEGIN
    BEGIN TRY
        UPDATE Room
        SET patient_id = @Patient_id,
            status = 'Occupied'
        WHERE room_no = @Room_no;
        
        PRINT 'Room assigned successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error assigning room: ' + ERROR_MESSAGE();
    END CATCH
END;
GO



