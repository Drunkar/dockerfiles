# caffe-lstm-anaconda

lstm implementation on caffe https://github.com/jeffdonahue/caffe/tree/recurrent

default endpoint is ipython notebook

```
sudo docker run --name caffe -v $PWD:/notebook -p 8888:8888 -d drunkar/cuda-caffe-lstm-anaconda /bin/bash
```

If you want to run bash on this container, docker exec command is a good way.

After docker run, 

```
sudo docker exec -it caffe bash
```
