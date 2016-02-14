# caffe-anaconda

default endpoint is ipython notebook

```
sudo docker run --name caffe -v $PWD/notebook:/notebook -v $PWD/workspace:/workspace -p 8888:8888 -d drunkar/caffe-anaconda /bin/bash
```

If you want to run bash on this container, docker exec command is a good way.

After docker run, 

```
sudo docker exec -it caffe bash
```
