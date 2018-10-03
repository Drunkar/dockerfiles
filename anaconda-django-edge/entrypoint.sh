#!/bin/sh

CMD="python manage.py runserver 0.0.0.0:8000"

django-admin.py startproject --template=https://github.com/arocks/edge/archive/master.zip --extension=py,md,html,env my_proj

cd my_proj

pip install django-authtools==1.6.0
pip install django-braces==1.12.0
pip install django-crispy-forms==1.7.2
pip install django-environ==0.4.4
pip install easy-thumbnails==2.5
pip install pillow==5.1.0
pip install pytz==2018.3
pip install django-debug-toolbar==1.9.1
pip instal sqlparse==0.2.4
pip install werkzeug==0.14.1

cd src

printf "DEBUG=True\n\nDATABASE_URL=postgres://${DB_ENV_POSTGRES_USER}:${DB_ENV_POSTGRES_PASSWORD}@${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}/${DB_ENV_POSTGRES_USER}\n\nSECRET_KEY=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | sort | uniq`\n" > my_proj/settings/local.env

python manage.py migrate

exec $CMD
