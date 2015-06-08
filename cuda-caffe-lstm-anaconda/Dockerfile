FROM ubuntu:14.04
MAINTAINER drunkar <drunkars.p@gmail.com>

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget


##############################################################################
# cuda
##############################################################################
# CUDA version - as the kernel is shared the host and container must correspond
ENV CUDA_MAJOR=7.0 \
  CUDA_VERSION=7.0.28 \
  CUDA_MAJOR_U=7_0

# Change to the /tmp directory
RUN cd /tmp && \
# Download run file
  wget http://developer.download.nvidia.com/compute/cuda/${CUDA_MAJOR_U}/Prod/local_installers/cuda_${CUDA_VERSION}_linux.run && \
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

RUN wget --quiet https://repo.continuum.io/archive/Anaconda-2.2.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda-2.2.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda-2.2.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.10.1

ENV PATH /opt/conda/bin:$PATH

RUN pip install --default-timeout 6000 tornado pycrypto elasticsearch mysql-python


##############################################################################
# caffe-gpu lstm
##############################################################################
# Get dependencies
RUN apt-get update && apt-get install -y \
  libprotobuf-dev \
  libleveldb-dev \
  libsnappy-dev \
  libopencv-dev \
  libboost-all-dev \ 
  libhdf5-serial-dev \ 
  protobuf-compiler \ 
  gcc-4.8 \ 
  g++-4.8 \ 
  gcc-4.8-multilib \  
  g++-4.8-multilib \ 
  gfortran \ 
  libjpeg62 \ 
  libfreeimage-dev \  
  libatlas-base-dev \  
  libopenblas-dev \
  git \ 
  bc \ 
  wget \ 
  curl \ 
  unzip \ 
  cmake \ 
  liblmdb-dev \  
  pkgconf

# Use gcc 4.8
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-4.8 30 && \
  update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-4.8 30 && \ 
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 30 && \
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 30

# Clone the Caffe repo 
RUN cd /opt && git clone https://github.com/jeffdonahue/caffe.git
RUN cd /opt/caffe && git checkout -b recurrent origin/recurrent

# Glog 
RUN cd /opt && wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz && \
  tar zxvf glog-0.3.3.tar.gz && \
  cd /opt/glog-0.3.3 && \
  ./configure && \
  make && \
  make install

# Workaround for error loading libglog: 
#   error while loading shared libraries: libglog.so.0: cannot open shared object file
# The system already has /usr/local/lib listed in /etc/ld.so.conf.d/libc.conf, so
# running `ldconfig` fixes the problem (which is simpler than using $LD_LIBRARY_PATH)
# TODO: looks like this needs to be run _every_ time a new docker instance is run,
#       so maybe LD_LIBRARY_PATh is a better approach (or add call to ldconfig in ~/.bashrc)
RUN ldconfig

# Gflags
RUN cd /opt && \
  wget https://github.com/schuhschuh/gflags/archive/master.zip && \
  unzip master.zip && \
  cd /opt/gflags-master && \
  mkdir build && \
  cd /opt/gflags-master/build && \
  export CXXFLAGS="-fPIC" && \
  cmake .. && \ 
  make VERBOSE=1 && \
  make && \
  make install

# Build Caffe core
RUN cd /opt/caffe && cp Makefile.config.example Makefile.config
RUN cd /opt/caffe && echo "CXX := /usr/bin/g++-4.8" >> Makefile.config 
RUN cd /opt/caffe && sed -i 's/atlas/open/' Makefile.config
RUN cd /opt/caffe && sed -i 's/CXX :=/CXX ?=/' Makefile
RUN cd /opt/caffe && make all

##############################################################################
# pycaffe
##############################################################################
RUN cd /opt/caffe/python
RUN pip install -r requirements.txt
RUN cd ../
RUN make pycaffe

ENV PYTHONPATH /opt/caffe/python/:${PYTHONPATH}


##############################################################################
# settings
##############################################################################
RUN mkdir /workspace
VOLUME ["/workspace"]
WORKDIR /workspace
