import os
import duckdb

class ReadSQLFileError(Exception):
    print("Error from read SQL file")

class ReadSeedFilesError(Exception):
    print("Error from read seed files")

def read_sql_file(filepath):
    try:
        with open(filepath,"r") as sql:
            sql_file = sql.read()
        return sql_file
    except ReadSQLFileError as err:
        raise err



def create_tables_from_csv_seeds(connection, folder_path):
    """
    Create tables from CSV files in a folder. Table names correspond to filenames without the file extension.

    Parameters:
    - connection (str): Path to the DuckDB database file.
    - folder_path (str): Path to the folder containing CSV files.
    """
    # Connect to the DuckDB database file
    # Iterate over each CSV file in the folder
    try:
        for file_name in os.listdir(folder_path):
            if file_name.endswith('.csv'):
                table_name = os.path.splitext(file_name)[0]
                df = connection.read_csv(os.path.join(folder_path, file_name))
                connection.register(table_name, df)
    except ReadSeedFilesError as err:
        raise err
    
conn = duckdb.connect(database='exe.db',read_only=False)
create_tables_from_csv_seeds(conn,'seeds') 