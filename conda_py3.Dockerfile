FROM ubuntu
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### Aptitude packages
#########
RUN apt-get update
RUN apt-get install -y build-essential default-jdk ant curl unzip zip apache2 wget git ftp libghc-zlib-dev locales supervisor openssl openssh-server \
	libcairo2-dev libpango1.0-dev libltdl-dev libbz2-dev vim libpq-dev gfortran libaio1 libaio-dev \
	2to3 python3-lib2to3 python3-toolz

#########
### Working dir
#########
RUN	mkdir build 
WORKDIR /build


#########
### connda py 3.7
#########
RUN \
     # install anaconda for python 3.7
     wget -q https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O anaconda.sh \
     && yes | bash anaconda.sh -b -p /usr/local/anaconda \ 
     && export PATH=/usr/local/anaconda/bin:$PATH \
     && conda update -q -y --all \
     && conda install -c anaconda gcc_linux-64 \
     && conda install -c anaconda biopython \
     && conda install r-essentials

ENV PATH="/usr/local/anaconda/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile
RUN echo "export LC_ALL=C.UTF-8" >> /home/.profile
RUN echo "export LANG=C.UTF-8" >> /home/.profile

#########
### aws cli
#########
RUN pip install awscli

#########
### install redbiom to interact with emp
#########
RUN pip install redbiom

#########
### Clean up
#########
WORKDIR /
RUN rm -rf build

#########
### Volumes
#########
RUN mkdir /home/share
VOLUME /home/share

#########
### Ports and CMD
#########
EXPOSE 22 80 443

