#!/bin/sh

CMD="python manage.py runserver 0.0.0.0:8000"

django-admin.py startproject --template=https://github.com/arocks/edge/archive/master.zip --extension=py,md,html,env my_proj

cd my_proj

pip install -r requirements.txt

cd src

printf "DATABASE_URL=postgres://${DB_ENV_POSTGRES_USER}:${DB_ENV_POSTGRES_PASSWORD}@${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}/${DB_ENV_POSTGRES_USER}\n\nSECRET_KEY=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | sort | uniq`\n" > my_proj/settings/local.env

python manage.py migrate

exec $CMD
