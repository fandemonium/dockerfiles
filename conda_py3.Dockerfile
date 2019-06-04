# build on top of r.Dockerfile image
FROM r_docker
MAINTAINER Fan Yang

#########
### Aptitude packages
#########
RUN apt-get update
RUN apt-get install -y 2to3 python3-lib2to3 python3-toolz parallel

#########
### Working dir
#########
RUN	mkdir tools 

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
     && conda install -c conda-forge awscli \
     && conda install -c anaconda numpy \
     && conda install -c anaconda biopython \
     && conda install -c anaconda pandas \
     && conda install -c anaconda click \
     && conda install -c anaconda nltk \
     && conda install -c anaconda joblib \
     && conda install -c bioconda biom-format \
     && conda install -c bioconda nextflow \
     && conda install perl \
     && conda install -c bioconda perl-net-ssleay \
     && conda install -c bioconda entrez-direct \
     && conda install -c bioconda bwa \
     && conda install -c bioconda samtools \
     && conda install -c bioconda bedtools
     
ENV PATH="/usr/local/anaconda/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile
RUN echo "export LC_ALL=C.UTF-8" >> /home/.profile
RUN echo "export LANG=C.UTF-8" >> /home/.profile

#######
# install redbiom to interact with emp
#######
RUN pip install --upgrade pip
RUN pip install redbiom

######
# vsearch
######
WORKDIR /tools
RUN wget https://github.com/torognes/vsearch/releases/download/v2.10.4/vsearch-2.10.4-linux-x86_64.tar.gz && \
    tar -xzvf vsearch-2.10.4-linux-x86_64.tar.gz
    
######
# cdhit 4.6.8
######
WORKDIR /tools
RUN wget https://github.com/weizhongli/cdhit/releases/download/V4.8.1/cd-hit-v4.8.1-2019-0228.tar.gz && \
    tar -xzvf cd-hit-v4.8.1-2019-0228.tar.gz && \
    cd cd-hit-v4.8.1-2019-0228 && \
    make

######
# sra toolkit
######
WORKDIR /tools
RUN wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.2-1/sratoolkit.2.8.2-1-ubuntu64.tar.gz -O sratoolkit.tar.gz && \
    tar -xzvf srtoolkit.tar.gz

######
# hmmer3.1b2
######
WORKDIR /tools
RUN wget http://eddylab.org/software/hmmer/hmmer-3.1b2.tar.gz && \
    tar -xzvf hmmer-3.1b2.tar.gz
 
######
# blast +
######
WORKDIR /tools
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.8.1/ncbi-blast-2.8.1+-x64-linux.tar.gz && \
    tar -xzvf ncbi-blast-2.8.1+-x64-linux.tar.gz
    
#########
### Clean up
#########
WORKDIR /tools
RUN rm -rf *.tgz *.tar.gz *.zip *.bz2

ENV PATH="/tools/vsearch-2.10.4-linux-x86_64/bin:$PATH"
ENV PATH="/tools/cd-hit-v4.8.1-2019-0228:$PATH"
ENV PATH="/tools/srtoolkit.2.8.2-1-ubuntu64/bin:$PATH"
ENV PATH="/tools/hmmer-3.1b2/binaries:$PATH"
ENV PATH="/tools/ncbi-blast-2.8.1+/bin:$PATH"

RUN echo "export PATH=$PATH" >> /home/.profile

#########
### Volumes
#########
RUN mkdir /home/share
VOLUME /home/share

#########
### Ports and CMD
#########
EXPOSE 22 80 443

