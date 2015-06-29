# airflow
dockerfile for airbnb/airflow ( https://github.com/airbnb/airflow )

Use CeleryExecutor and MySQL as its backend.

## Usage

1. Run MySQL Container.

  ```
sudo docker run --name airflow-db -e MYSQL_ROOT_PASSWORD=airflow-db -d -v /var/lib/mysql:/var/lib/mysql mysql
  ```

2. Run Airflow container.

  ```
sudo docker run --name airflow --link airflow-db:mysql -v /docker_volumes/airflow/dags:/airflow/dags -v /docker_volumes/airflow/logs:/airflow/logs -p 8080:8080 -p 5555:5555 -d drunkar/airflow

  ```

Then you can access to ``http://localhost:8080``.
