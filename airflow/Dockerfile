FROM ubuntu:trusty
MAINTAINER drunkar <drunkars.p@gmail.com>

# Install Anaconda
RUN apt-get update && \
    apt-get install -y wget bzip2 ca-certificates libmysqlclient-dev mysql-client

RUN wget --quiet https://repo.continuum.io/archive/Anaconda-2.3.0-Linux-x86_64.sh && \
    /bin/bash Anaconda-2.3.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm Anaconda-2.3.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.10.1

ENV PATH /opt/conda/bin:$PATH

# language
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# install airflow
ENV AIRFLOW_HOME /airflow
ENV C_FORCE_ROOT true  # run airflow worker by root
RUN pip install --default-timeout 6000 celery airflow[mysql]
ADD entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

VOLUME ["/airflow/dags", "airflow/logs"]
WORKDIR /airflow

EXPOSE 8080
EXPOSE 5555
EXPOSE 8793

ENTRYPOINT ["/root/entrypoint.sh"]
