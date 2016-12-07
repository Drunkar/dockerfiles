# cuda-caffe-anaconda3-chainer

* python 3 version of cuda-caffe-anaconda-chainer.

default endpoint is ipython notebook

```
DOCKER_NVIDIA_DEVICES="--device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm"

sudo docker run --name caffe -v $PWD/notebook:/notebook -v $PWD/workspace:/workspace -p 8888:8888 -d $DOCKER_NVIDIA_DEVICES drunkar/cuda-caffe-anaconda-chainer /bin/bash
```

If you want to run bash on this container, docker exec command is a good way.

After docker run, 

```
sudo docker exec -it caffe bash
```
