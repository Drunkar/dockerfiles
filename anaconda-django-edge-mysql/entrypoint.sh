#!/bin/sh

CMD="python manage.py runserver 0.0.0.0:8000"

django-admin.py startproject --template=https://github.com/arocks/edge/archive/master.zip --extension=py,md,html,env my_proj

cd my_proj

pip install -r requirements.txt

mysql -h"$DB_PORT_3306_TCP_ADDR" -P"$DB_PORT_3306_TCP_PORT" -uroot -p"$DB_ENV_MYSQL_ROOT_PASSWORD" -e"create database django_edge;"

cd src

  printf "DATABASE_URL=mysql://root:${DB_ENV_MYSQL_ROOT_PASSWORD}@${DB_PORT_3306_TCP_ADDR}:${DB_PORT_3306_TCP_PORT}/django_edge\n\nSECRET_KEY=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | sort | uniq`\n" > my_proj/settings/local.env

python manage.py migrate

exec $CMD
