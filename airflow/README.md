# airflow
dockerfile for airbnb/airflow ( https://github.com/airbnb/airflow )

```
sudo docker run --name airflow -p 8080:8080 -d drunkar/airflow
```

or


```
sudo docker run --name airflow -v /your/workin/dir:/airflow -p 8080:8080 -d drunkar/airflow
```

Then you can access to ``http://localhost:8080``.
