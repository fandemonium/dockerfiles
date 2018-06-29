FROM ubuntu
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### basic linux libraries
#########
RUN apt-get update
RUN apt-get install -y build-essential default-jdk ant curl unzip zip apache2 wget git ftp libghc-zlib-dev locales supervisor openssl openssh-server \
	libcairo2-dev libpango1.0-dev libltdl-dev libbz2-dev vim libpq-dev libgeos-dev \
	gfortran libaio1 libaio-dev parallel liblzma-dev

#########
### Working dir
#########
RUN	mkdir build 
WORKDIR /build

#########
### connda py 3.6
#########
RUN \
	wget -q https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O anaconda.sh \ 
	&& yes | bash anaconda.sh -b -p /usr/local/anaconda \ 
	&& export PATH=/usr/local/anaconda/bin:$PATH \
	&& conda config --add channels defaults \
	&& conda config --add channels conda-forge \
	&& conda config --add channels bioconda \
	&& conda update -q -y --all \
	&& conda install -c anaconda biopython \
	&& conda install -c r r r-essentials \
	&& conda install lima \
	&& conda install bam2fastx
	
ENV PATH="/usr/local/anaconda/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile
RUN echo "export LC_ALL=C.UTF-8" >> /home/.profile
RUN echo "export LANG=C.UTF-8" >> /home/.profile

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

