FROM ubuntu
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### Aptitude packages
#########
RUN apt-get update
RUN apt-get install -y build-essential default-jdk ant curl unzip zip apache2 wget git ftp libghc-zlib-dev locales supervisor openssl openssh-server \
	libcairo2-dev libpango1.0-dev libltdl-dev libbz2-dev vim 

#########
### Working dir
#########
RUN	mkdir build 
WORKDIR /build


#########
### connda py 3.6
#########
RUN \
     # install anaconda for python 3.6
     wget -q https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O anaconda.sh \
     && yes | bash anaconda.sh -b -p /usr/local/anaconda \ 
     && export PATH=/usr/local/anaconda/bin:$PATH \
     && conda update -q -y --all \
     && conda install -c anaconda biopython

ENV PATH="/usr/local/anaconda/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile

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

