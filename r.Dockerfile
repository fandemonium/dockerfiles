FROM ubuntu
MAINTAINER Fan Yang

#####
# essential linux packages
#####
RUN apt-get update
RUN apt-get install -y --fix-missing software-properties-common \
      build-essential default-jdk curl uzip zip apache2 wget git ftp libghc-zlib-dev locales openssl \
      openssh-server libcairo2-dev libpango1.0-dev libltdl-dev libbz2-dev vim libpq-dev libgeos-dev \
      gfortran libaio1 libaio-dev libssl-dev libcurl4-openssl-dev libxml2-dev
      
#####
# gdal libraries
#####
RUN add-apt-repository ppa:marutter/c3d4u3.5
RUN apt-get update
RUN apt-get install -y libgdal-dev libgdal20

#####
# R 3.5.1
#####
RUN echo "dev https://cloud.r-project.org/bin/linux/ubuntu/ bionic-cran35/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y install tzdata
RUN apt-get -y install r-base
RUN apt-get install r-base-dev
