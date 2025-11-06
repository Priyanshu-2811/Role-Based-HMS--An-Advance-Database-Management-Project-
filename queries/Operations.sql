use HOSPITAL_DB;

Select * from Doctor;

Update Doctor set Dept='Gastrology' where Doctor_id=5;


DELETE FROM Doctor
WHERE Doctor_id = 0;