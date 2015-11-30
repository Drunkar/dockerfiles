#!/bin/sh

CMD="bash"

echo "
[core]
airflow_home = /airflow
dags_folder = /airflow/dags
base_log_folder = /airflow/logs
executor = CeleryExecutor
sql_alchemy_conn = mysql://root:${MYSQL_ENV_MYSQL_ROOT_PASSWORD}@${MYSQL_PORT_3306_TCP_ADDR}:3306/airflow
parallelism = 60
load_examples = False

[webserver]
base_url = http://localhost:8080
web_server_host = 0.0.0.0
web_server_port = 8080

[smtp]
smtp_host = localhost
smtp_user = airflow
smtp_port = 25
smtp_password = airflow
smtp_mail_from = airflow@airflow.com

[celery]
celery_app_name = airflow.executors.celery_executor
celeryd_concurrency = 60
worker_log_server_port = 8793
broker_url = sqla+mysql://root:${MYSQL_ENV_MYSQL_ROOT_PASSWORD}@${MYSQL_PORT_3306_TCP_ADDR}:3306/airflow
;broker_url = amqp://guest:guest@${RABBIT_PORT_5672_TCP_ADDR}:5672/airflow
celery_result_backend = db+mysql://root:${MYSQL_ENV_MYSQL_ROOT_PASSWORD}@${MYSQL_PORT_3306_TCP_ADDR}:3306/airflow
;celery_result_backend = amqp://guest:guest@${RABBIT_PORT_5672_TCP_ADDR}:5672/airflow
flower_port = 8383
default_queue = default

[scheduler]
job_heartbeat_sec = 5
scheduler_heartbeat_sec = 5
" \
> $AIRFLOW_HOME/airflow.cfg


airflow initdb
airflow worker &
airflow scheduler &
exec $CMD
