# anaconda-tensorflow-gpu


default endpoint is jupyter notebook

```
sudo docker run --name tensorflow -v $PWD/notebook:/notebook -p 8888:8888 -p 6006:6006 -d $DOCKER_NVIDIA_DEVICES drunkar/anaconda-tensorflow-gpu /bin/bash
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
