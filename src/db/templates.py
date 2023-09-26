from db.connection import PostgresConnect
from os import environ

repo_path = "/".join([str(environ.get("PYTHONPATH")), ".."])
TEMPLATES_RELPATH = f"{repo_path}/src/sql/templates"


class Templates:
    def __init__(self) -> None:
        self.connection = PostgresConnect()

    def fromSqlFile(self, template_filename: str, values: list[str] = []):
        file_relpath = f"{TEMPLATES_RELPATH}/{template_filename}"
        with open(file_relpath, "r") as sql_string:
            return self.connection.query(sql_string.read(), tuple(values))
