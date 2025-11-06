# Role-Based Hospital Management System

This project is a web-based Hospital Management System (HMS) built with Flask and a Microsoft SQL Server database. It features a role-based access control system, allowing different users (doctors, patients, and management) to interact with the database according to their permissions.

## Features

- **Role-Based Access Control:** Users can select a role (doctor, patient, or management) to access specific database tables and functionalities.
- **CRUD Operations:** The application provides a user-friendly web interface to perform Create, Read, Update, and Delete (CRUD) operations on the database.
- **Custom SQL Queries:** A dedicated section allows users to execute custom SQL queries for advanced data retrieval and manipulation.
- **Dynamic Web Interface:** The frontend is built with HTML, Bootstrap, and jQuery, providing a responsive and interactive user experience.

## Project Structure

```
.
├── app.py              # Main Flask application
├── queries/            # SQL scripts for database schema and operations
│   ├── Create.sql
│   ├── H_Functions.sql
│   ├── H_Procedure.sql
│   ├── H_Trigger.sql
│   ├── Insert_H.sql
│   └── Operations.sql
└── templates/          # HTML templates for the web interface
    ├── index.html
    └── select_role.html
```

## Technologies Used

- **Backend:** Flask, Python
- **Database:** Microsoft SQL Server
- **Frontend:** HTML, CSS, Bootstrap, JavaScript, jQuery
- **Database Driver:** pyodbc

## Setup and Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    ```
2.  **Install Python dependencies:**
    ```bash
    pip install Flask pyodbc
    ```
3.  **Database Setup:**
    - Make sure you have Microsoft SQL Server installed and running.
    - Create a new database named `HOSPITAL_DB`.
    - Execute the SQL scripts in the `queries/` directory in the following order to set up the database schema and initial data:
        1.  `Create.sql`
        2.  `Insert_H.sql`
        3.  `H_Functions.sql`
        4.  `H_Procedure.sql`
        5.  `H_Trigger.sql`

4.  **Configure the database connection:**
    - Open `app.py` and update the `server` variable in the connection string to match your SQL Server instance name.
    ```python
    # Connection parameters
    server = 'YOUR_SQL_SERVER_INSTANCE'
    database = 'HOSPITAL_DB'
    conn_str = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes'
    ```

5.  **Run the application:**
    ```bash
    python app.py
    ```
    The application will be running at `http://127.0.0.1:5000`.

## How to Use

1.  Open your web browser and navigate to `http://127.0.0.1:5000`.
2.  You will be prompted to select a role (Doctor, Patient, or Management).
3.  Based on your selected role, you will be redirected to the main page where you can interact with the allowed database tables.
4.  You can view data, insert new records, update existing records, or delete records.
5.  There is also a text area to execute custom SQL queries.

## Database Schema

The database consists of the following tables:

-   `Doctor`: Stores information about doctors.
-   `Staff`: Stores information about hospital staff.
-   `Lab`: Contains details of lab tests conducted.
-   `Inpatient`: Manages information about admitted patients.
-   `Outpatient`: Manages information about outpatients.
-   `Room`: Keeps track of room allocation and status.
-   `Bill`: Stores billing information for patients.

The `queries` directory also includes SQL scripts for creating functions, procedures, and triggers to automate and manage database operations.
