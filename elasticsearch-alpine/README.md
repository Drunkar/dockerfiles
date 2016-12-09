# elasticsearch-alpine
elasticsearch on alpine.

## Usage

* in your host pc, run below command:

```
sudo sysctl -w vm.max_map_count=262144
```

* then run container

```
docker run -d  -p 9200:9200 -v <path_you_like>:/usr/share/elasticsearch/data drunkar/elasticsearch-alpine
```

* if on ec2 t2.micro instance

```
docker run -d  -p 9200:9200 -e ES_JAVA_OPTS="-Xmx512m -Xms512m" -v <path_you_like>:/usr/share/elasticsearch/data drunkar/elasticsearch-alpine
```
