# anaconda-tensorflow-gpu-keras

## Caution

You have to write ``cudnn-7.5-linux-x64-v5.0-ga`` path into ``cuDNN_path.txt``.

During Docker build, it will be downloaded and extracted.

## Usage

default endpoint is jupyter notebook

```
DOCKER_NVIDIA_DEVICES="--device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm"

sudo docker run --name tensorflow -v $PWD/notebook:/notebook -p 8888:8888 -p 6006:6006 -d $DOCKER_NVIDIA_DEVICES drunkar/anaconda-tensorflow-gpu-keras /bin/bash
```

If you want to run bash on this container, docker exec command is a good way.

After docker run, 

```
sudo docker exec -it tensorflow bash
```

You can also use TensorBoard in exec process

```
tensorboard --logdir=/data/dir
```
