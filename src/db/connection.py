import psycopg2


class PostgresConnect:
    username = "rs_experimenter"
    password = "gs_experimenter_password"
    host = "sql-algo-workshop-postgres"
    port = 5432
    db_name = "experiments"

    # def __init__(self) -> None:
    # self.connection = self.connect()

    def connect(self):
        return psycopg2.connect(
            dbname=self.db_name,
            user=self.username,
            password=self.password,
            port=self.port,
            host=self.host,
        )

    def query(self, query_string: str, values: tuple[str]):
        # if not self.connection:
        #     self.connection = self.connect()
        connection = self.connect()
        response = []
        with connection.cursor() as cursor:
            cursor.execute(query_string, values)
            response = cursor.fetchall()
        connection.close()
        return response
