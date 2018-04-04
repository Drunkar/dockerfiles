# airflow

Airflow with:
- mysql backend
- multiple workers (with redis broker)


## Usage

0. Change s3 bucket name at `S3_LOG_FOLDER` in `log_config.py`.

1. Run MySQL Container.

  ```
docker run --name airflow-db -e MYSQL_ROOT_PASSWORD=airflow-db -d -v /docker_volumes/airflow-db:/var/lib/mysql mysql:latest
  ```

loging mysql and make database named airflow.
  ```
docker exec -it airflow-db bash
mysql -u root -p
create database airflow
  ```

2. Run redis Container.
  ```
docker run --name airflow-broker -d redis:4-alpine
  ```

3. Run Airflow scheduler container.

  ```
docker run --name airflow-scheduler --link airflow-db:mysql --link airflow-broker:redis -v /path/to/dags/airflow/dags:/airflow/dags -d drunkar/airflow-alpine
  ```

4. Run Airflow webserver container.

  ```
docker run --name airflow-webserver --link airflow-db:mysql --link airflow-broker:redis -v /path/to/dags/airflow/dags:/airflow/dags  -p 8080:8080 -d --entrypoint="/root/entrypoint_webserver.sh"  drunkar/airflow-alpine
  ```

5. Run Airflow worker container.

  ```
docker run --name airflow-worker --link airflow-db:mysql --link airflow-broker:redis -v /path/to/dags/airflow/dags:/airflow/dags -d --entrypoint="/root/entrypoint_worker.sh" drunkar/airflow-alpine
  ```

6. Run Airflow celery flower(optionally).

  ```
docker run --name airflow-flower --link airflow-broker:redis -p 5555:5555 -d --entrypoint="/root/entrypoint_flower.sh" drunkar/airflow-alpine
  ```

7. Make connection for s3 from web UI > Admin > Connections > Create

```
Conn Id: my_conn_S3

Conn Type: S3

Extra: {"aws_access_key_id":"your_aws_key_id", "aws_secret_access_key": "your_aws_secret_key"}
```


Then you can access to ``http://localhost:8080``.
