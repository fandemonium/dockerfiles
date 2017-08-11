FROM ubuntu
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### Aptitude packages
#########
RUN apt-get update
RUN apt-get install -y build-essential default-jdk ant curl unzip zip apache2 wget git ftp libghc-zlib-dev locales supervisor openssl openssh-server \
	libcairo2-dev libpango1.0-dev libltdl-dev libbz2-dev 

#########
### Working dir
#########
RUN	mkdir build 
WORKDIR /build


#########
### Java tools: Trimmomatic, FastQC
#########
RUN \
     # install anaconda for python 2.7 and R
     wget -q https://repo.continuum.io/archive/Anaconda2-4.4.0-Linux-x86_64.sh -O anaconda.sh \
     && yes | bash anaconda.sh -b -p /usr/local/anaconda \ 
     && export PATH=/usr/local/anaconda/bin:$PATH \
     && conda update -q -y --all \
     && conda install r-essentials \
     && conda update r-essentials \
     && conda install -c r r-irkernel \
     && ipython kernel install

ENV PATH="/usr/local/anaconda/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile

#########
### Clean up
#########
WORKDIR /
RUN rm -rf build

#########
### Supervisor
#########
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#########
### Volumes
#########
RUN mkdir /home/share
VOLUME /home/share

#########
### Ports and CMD
#########
EXPOSE 22 80 443
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]