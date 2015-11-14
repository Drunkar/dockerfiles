FROM ubuntu:14.04
MAINTAINER drunkar <drunkars.p@gmail.com>

# locale for tokyo
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget


##############################################################################
# cuda
##############################################################################
# CUDA version - as the kernel is shared the host and container must correspond
ENV CUDA_MAJOR=7_0 \
  CUDA_VERSION=7.0.28

# Change to the /tmp directory
RUN cd /tmp && \
# Download run file
  wget --quiet http://developer.download.nvidia.com/compute/cuda/${CUDA_MAJOR}/Prod/local_installers/cuda_${CUDA_VERSION}_linux.run && \
# Make the run file executable and extract
  chmod +x cuda_*_linux.run && ./cuda_*_linux.run -extract=`pwd` && \
# Install CUDA drivers (silent, no kernel)
  ./NVIDIA-Linux-x86_64-*.run -s --no-kernel-module && \
# Install toolkit (silent)  
  ./cuda-linux64-rel-*.run -noprompt && \
# Clean up
  rm -rf *

# Add to path
ENV PATH /usr/local/cuda/bin:${PATH}
# Configure dynamic link
RUN echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf && ldconfig


##############################################################################
# anaconda python
##############################################################################
# Install Anaconda
RUN apt-get update && \
    apt-get install -y wget bzip2 ca-certificates libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.continuum.io/archive/Anaconda-2.3.0-Linux-x86_64.sh && \
    /bin/bash Anaconda-2.3.0-Linux-x86_64.sh -b -p /opt/conda && \                                 
    rm Anaconda-2.3.0-Linux-x86_64.sh && \                                                         
    /opt/conda/bin/conda install --yes conda==3.10.1

ENV PATH /opt/conda/bin:$PATH

# change default encoding
RUN echo "import sys\n\
sys.setdefaultencoding('utf-8')" >> /opt/conda/lib/python2.7/sitecustomize.py


##############################################################################
# ipython notebook
##############################################################################
RUN ipython profile create nbserver
# Configure "nbserver" profile
RUN sed -i \
        -e "s/^# c.NotebookApp.ip = 'localhost'$/c.NotebookApp.ip = '0.0.0.0'/" \
        -e "s/^# c.NotebookApp.port = 8888$/c.NotebookApp.port = 8888/" \
        -e "s;^# c.NotebookApp.notebook_dir = '/.*'$;c.NotebookApp.notebook_dir = '/notebook';" \
        -e "s/^# c.NotebookApp.open_browser = True$/c.NotebookApp.open_browser = False/" \
        -e "s/^# c.IPKernelApp.matplotlib = None$/c.IPKernelApp.matplotlib = 'inline'/" \
        -e "s/^# c.IPKernelApp.extensions = \[\]$/c.IPKernelApp.extensions = ['version_information']/" \
        /root/.ipython/profile_nbserver/ipython_notebook_config.py

EXPOSE 8888

##############################################################################
# tensorflow
##############################################################################
RUN pip install --default-timeout 6000 https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.5.0-cp27-none-linux_x86_64.whl

EXPOSE 6006

##############################################################################
# settings
##############################################################################
RUN mkdir /notebook
VOLUME ["/notebook"]

ENTRYPOINT ipython notebook --profile=nbserver
WORKDIR /notebook
