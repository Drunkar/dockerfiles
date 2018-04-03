#!/bin/sh

CMD="airflow scheduler"

cat airflow.cfg > $AIRFLOW_HOME/airflow.cfg

airflow initdb

exec $CMD
