# airflow

Airflow with:
- mysql backend
- multiple workers (with RabbitMQ broker)


## Usage

1. Run MySQL Container.

  ```
docker run --name airflow-db -e MYSQL_ROOT_PASSWORD=airflow-db -d -v /docker_volumes/airflow-db:/var/lib/mysql mysql:latest
  ```

loging mysql and make database named airflow.
  ```
docker exec -it airflow-db bash
mysql -u root -p
  ```

2. Run RabbitMQ Container.
  ```
docker run --name airflow-broker -d rabbitmq:3.7-alpine
  ```

3. Run Airflow scheduler container.

  ```
docker run --name airflow-scheduler --link airflow-db:mysql --link airflow-broker:rabbit -v /docker_volumes/airflow/dags:/airflow/dags -v /docker_volumes/airflow/logs:/airflow/logs -d drunkar/airflow-alpine
  ```

3. Run Airflow webserver container.

  ```
docker run --name airflow-webserver --link airflow-db:mysql --link airflow-broker:rabbit -p 8080:8080 -d --entrypoint="/root/entrypoint_webserver.sh"  drunkar/airflow-alpine
  ```

4. Run Airflow worker container.

  ```
docker run --name airflow-worker --link airflow-db:mysql --link airflow-broker:rabbit -d --entrypoint="/root/entrypoint_worker.sh" drunkar/airflow-alpine
  ```

Then you can access to ``http://localhost:8080``.
