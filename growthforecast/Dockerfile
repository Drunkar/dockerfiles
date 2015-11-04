FROM ubuntu:trusty
MAINTAINER drunkar <drunkars.p@gmail.com>

# locale for tokyo
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install GrowthForecast
RUN apt-get update
RUN apt-get install -y librrd4 librrds-perl curl build-essential
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN apt-get install -y libdbd-sqlite3-perl libwww-perl

RUN apt-get -y build-dep rrdtool && \
    rm -rf /var/lib/apt/lists/*

RUN cpanm --notest File::Which File::chdir File::ShareDir
RUN cpanm --notest --installdeps Alien::RRDtool
RUN cpanm --notest --verbose Alien::RRDtool
RUN cpanm --notest GrowthForecast

# Define mountable directories.
RUN mkdir /data
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

EXPOSE 5125

# Define default command.
ENTRYPOINT ["growthforecast.pl", "--data-dir", "/data"]
