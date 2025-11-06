# app.py
from flask import Flask, render_template, request, jsonify, session, redirect, url_for
import pyodbc
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Replace with a real secret key in production

# Connection parameters
server = 'LAPTOP-M5FIB60P\\SQLEXPRESS'
database = 'HOSPITAL_DB'
conn_str = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes'

def get_db_connection():
    return pyodbc.connect(conn_str)

# Table columns
table_columns = {
    "Doctor": ["Doctor_id", "Doctor_name", "Dept"],
    "Staff": ["s_id", "s_name", "NID", "salary"],
    "Lab": ["lab_no", "patient_id", "weight", "DOCTOR_ID", "visit_date", "category", "patient_type", "amount"],
    "Inpatient": ["patient_id", "name", "gender", "address", "room_no", "date_of_admit", "date_of_discharge", "advance", "lab_no", "Doctor_id", "disease"],
    "Outpatient": ["patient_id", "visit_date", "lab_no"],
    "Room": ["room_no", "room_type", "status", "patient_id"],
    "Bill": ["bill_no", "patient_id", "patient_type", "doctor_charge", "medicine_charge", "operation_charge", "number_of_days", "nursing_charge", "advance", "health_card", "lab_charge", "total_bill"]
}

# Role-based table access
role_tables = {
    "doctor": ["Doctor"],
    "patient": ["Inpatient", "Outpatient"],
    "management": ["Room", "Lab", "Staff", "Bill"]
}

def safe_date_convert(date_string):
    if date_string.strip().upper() == 'NULL':
        return None
    try:
        date_obj = datetime.strptime(date_string, '%Y-%m-%d').date()
        return date_obj.strftime('%Y-%m-%d')
    except ValueError:
        return None

@app.route('/')
def index():
    if 'role' not in session:
        return redirect(url_for('select_role'))
    return render_template('index.html', tables=role_tables[session['role']])

@app.route('/select_role', methods=['GET', 'POST'])
def select_role():
    if request.method == 'POST':
        role = request.form['role']
        if role in role_tables:
            session['role'] = role
            return redirect(url_for('index'))
    return render_template('select_role.html', roles=role_tables.keys())

@app.route('/logout')
def logout():
    session.pop('role', None)
    return redirect(url_for('select_role'))

@app.route('/get_columns', methods=['POST'])
def get_columns():
    table_name = request.form['table_name']
    return jsonify(table_columns.get(table_name, []))

@app.route('/execute_query', methods=['POST'])
def execute_query():
    table_name = request.form['table_name']
    if table_name not in role_tables[session['role']]:
        return jsonify({'success': False, 'error': 'Access denied'})
    query = f"SELECT * FROM {table_name}"
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        columns = [column[0] for column in cursor.description]
        return jsonify({'success': True, 'data': [dict(zip(columns, row)) for row in rows]})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})
    finally:
        cursor.close()
        conn.close()

@app.route('/insert_record', methods=['POST'])
def insert_record():
    table_name = request.form['table_name']
    if table_name not in role_tables[session['role']]:
        return jsonify({'success': False, 'error': 'Access denied'})
    columns = table_columns[table_name]
    values = []
    for column in columns:
        value = request.form.get(column, '').strip()
        if column in ['date_of_admit', 'date_of_discharge', 'visit_date']:
            value = safe_date_convert(value)
        values.append(value if value != '' else None)

    placeholders = ', '.join(['?' for _ in columns])
    query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({placeholders})"
    
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query, values)
        conn.commit()
        return jsonify({'success': True, 'message': 'Record inserted successfully!'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})
    finally:
        cursor.close()
        conn.close()

@app.route('/update_record', methods=['POST'])
def update_record():
    table_name = request.form['table_name']
    if table_name not in role_tables[session['role']]:
        return jsonify({'success': False, 'error': 'Access denied'})
    columns = table_columns[table_name]
    values = []
    for column in columns:
        value = request.form.get(column, '').strip()
        if column in ['date_of_admit', 'date_of_discharge', 'visit_date']:
            value = safe_date_convert(value)
        values.append(value if value != '' else None)
    
    set_clause = ', '.join([f"{col} = ?" for col in columns[1:]])
    query = f"UPDATE {table_name} SET {set_clause} WHERE {columns[0]} = ?"
    
    # Reorder values to put the ID at the end
    values = values[1:] + [values[0]]
    
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query, values)
        conn.commit()
        return jsonify({'success': True, 'message': 'Record updated successfully!'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})
    finally:
        cursor.close()
        conn.close()

@app.route('/delete_record', methods=['POST'])
def delete_record():
    table_name = request.form['table_name']
    if table_name not in role_tables[session['role']]:
        return jsonify({'success': False, 'error': 'Access denied'})
    id_column = table_columns[table_name][0]
    id_value = request.form.get(id_column)
    
    query = f"DELETE FROM {table_name} WHERE {id_column} = ?"
    
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query, (id_value,))
        conn.commit()
        return jsonify({'success': True, 'message': 'Record deleted successfully!'})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})
    finally:
        cursor.close()
        conn.close()

@app.route('/execute_custom_query', methods=['POST'])
def execute_custom_query():
    query = request.form['query']
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query)
        
        if cursor.description:
            columns = [column[0] for column in cursor.description]
            rows = cursor.fetchall()
            return jsonify({'success': True, 'data': [dict(zip(columns, row)) for row in rows], 'message': f"Query executed successfully. {len(rows)} rows returned."})
        else:
            affected_rows = cursor.rowcount
            conn.commit()
            return jsonify({'success': True, 'message': f"Query executed successfully. {affected_rows} rows affected."})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})
    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)