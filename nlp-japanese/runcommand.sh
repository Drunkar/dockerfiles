#!/bin/bash
sudo docker run --name nlp -v $PWD/notebook:/notebook -v $PWD/workspace:/workspace -p 8800:8888 -d $DOCKER_NVIDIA_DEVICES drunkar/nlp-japanese /bin/bash
