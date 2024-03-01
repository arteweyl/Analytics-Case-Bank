import os
import duckdb


class ReadSQLFileError(Exception):
    code='001'


class ReadSeedFilesError(Exception):
    code='002'


def read_sql_file(filepath):
    try:
        with open(filepath, "r") as sql:
            sql_file = sql.read()
        return sql_file
    except ReadSQLFileError as err:
        raise err


def create_tables_from_csv_seeds(connection, seeds_path):
    try:
        for file_name in os.listdir(seeds_path):
            if file_name.endswith(".csv"):
                table_name = os.path.splitext(file_name)[0]
                df = connection.read_csv(os.path.join(seeds_path, file_name))
                connection.register(table_name, df)

    except ReadSeedFilesError as err:
        raise err
