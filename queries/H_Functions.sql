use HOSPITAL_DB;

-- Drop existing functions if they exist to avoid conflicts
IF OBJECT_ID('dbo.get_total_bill', 'FN') IS NOT NULL
    DROP FUNCTION dbo.get_total_bill;
GO

IF OBJECT_ID('dbo.get_doctor_department', 'FN') IS NOT NULL
    DROP FUNCTION dbo.get_doctor_department;
GO

IF OBJECT_ID('dbo.count_patients_treated_by_doctor', 'FN') IS NOT NULL
    DROP FUNCTION dbo.count_patients_treated_by_doctor;
GO

IF OBJECT_ID('dbo.check_room_availability', 'FN') IS NOT NULL
    DROP FUNCTION dbo.check_room_availability;
GO

IF OBJECT_ID('dbo.get_total_salary_expense', 'FN') IS NOT NULL
    DROP FUNCTION dbo.get_total_salary_expense;
GO


-- Function to Calculate Total Bill for a Patient
CREATE FUNCTION get_total_bill(@patient_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total_bill DECIMAL(10, 2) = 0;

    -- Safely retrieve the total bill or return 0 if no bill exists
    SELECT @total_bill = ISNULL(total_bill, 0)
    FROM Bill
    WHERE patient_id = @patient_id;

    RETURN @total_bill;
END;
GO


-- Function to Get Doctor's Department
CREATE FUNCTION get_doctor_department(@doctor_id INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @dept NVARCHAR(255) = 'Department Not Found';

    -- Safely retrieve the doctor's department or return a default value
    SELECT @dept = ISNULL(Dept, 'Department Not Found')
    FROM Doctor
    WHERE doctor_id = @doctor_id;

    RETURN @dept;
END;
GO


-- Function to Get the Number of Patients Treated by a Doctor
CREATE FUNCTION count_patients_treated_by_doctor(@doctor_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @patient_count INT = 0;
    DECLARE @outpatient_count INT = 0;

    -- Count inpatients treated by the doctor
    SELECT @patient_count = COUNT(*)
    FROM Inpatient
    WHERE doctor_id = @doctor_id;

    -- Count outpatients treated by the doctor from Lab table
    SELECT @outpatient_count = COUNT(*)
    FROM Outpatient o
    JOIN Lab l ON o.lab_no = l.lab_no
    WHERE l.doctor_id = @doctor_id;

    -- Return total patients treated (inpatients + outpatients)
    RETURN @patient_count + @outpatient_count;
END;
GO


-- Function to Check Room Availability
CREATE FUNCTION check_room_availability(@room_no INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @status NVARCHAR(255) = 'Room Not Found';

    -- Safely retrieve the room status or return 'Room Not Found'
    SELECT @status = ISNULL(status, 'Room Not Found')
    FROM Room
    WHERE room_no = @room_no;

    RETURN @status;
END;
GO


-- Function to Calculate the Total Salary Expense for Staff
CREATE FUNCTION get_total_salary_expense()
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @total_salary DECIMAL(18, 2) = 0;

    -- Safely sum the salary or return 0 if no staff records exist
    SELECT @total_salary = ISNULL(SUM(salary), 0)
    FROM Staff;

    RETURN @total_salary;
END;
GO
