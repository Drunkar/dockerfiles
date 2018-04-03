#!/bin/sh

CMD="airflow worker"

cat airflow.cfg > $AIRFLOW_HOME/airflow.cfg

exec $CMD
