#!/bin/sh

CMD="airflow webserver"

cat airflow.cfg > $AIRFLOW_HOME/airflow.cfg

exec $CMD
