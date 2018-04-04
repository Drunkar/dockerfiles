#!/bin/sh

CMD="airflow flower"

cat airflow.cfg > $AIRFLOW_HOME/airflow.cfg

exec $CMD
