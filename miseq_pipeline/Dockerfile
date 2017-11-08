#FROM fy_conda_base
FROM docker-registry.science-at-scale.io/genome-analytics/fy_conda_base
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### gnu parallel
#########
RUN apt-get update && apt-get install -y parallel

##########
#### aws cli
##########
#RUN pip install awscli

#########
### Working dir
#########
RUN	mkdir tools 
WORKDIR /tools

#########
### RDP pandaseq
#########
WORKDIR /tools
RUN wget http://rdp.cme.msu.edu/download/RDP_Assembler.tgz && \
    tar -xzvf RDP_Assembler.tgz && cd RDP_Assembler/pandaseq && \
    ./configure && make 

#########
### RDP tools
#########
WORKDIR /tools
RUN git clone https://github.com/rdpstaff/RDPTools && \
    cd RDPTools && \
    git submodule init && \
    git submodule update && \
    make

#########
### vsearch
#########
WORKDIR /tools
RUN wget https://github.com/torognes/vsearch/releases/download/v2.4.3/vsearch-2.4.3-linux-x86_64.tar.gz && \
    tar -xzvf vsearch-2.4.3-linux-x86_64.tar.gz && \
    cd  vsearch-2.4.3-linux-x86_64/bin

#########
##3 cdhit 4.6.8
#########
WORKDIR /tools
RUN wget https://github.com/weizhongli/cdhit/releases/download/V4.6.8/cd-hit-v4.6.8-2017-0621-source.tar.gz && \
    tar -xzvf cd-hit-v4.6.8-2017-0621-source.tar.gz && \
    cd cd-hit-v4.6.8-2017-0621 && \
    make

#########
### edirect
#########
WORKDIR /tools
CMD [perl -MNet::FTP -e \
    '$ftp = new Net::FTP("ftp.ncbi.nlm.nih.gov", Passive => 1); \
     $ftp->login; $ftp->binary; \
     $ftp->get("/entrez/entrezdirect/edirect.tar.gz")'] \
     && gunzip -c edirect.tar.gz | tar xf - \
     && ./edirect/setup.sh

#########
### hmmer3.1b2
#########
WORKDIR /tools
RUN wget http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz && \
    tar -xzvf hmmer-3.1b2-linux-intel-x86_64.tar.gz 

#########
### bowtie2-2.3.3.2
#########
WORKDIR /tools
RUN curl -L https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.3.1/bowtie2-2.3.3.1-linux-x86_64.zip > bowtie2.zip && \
    unzip bowtie2.zip

### clean up and set env
#########
WORKDIR /tools
RUN rm -rf *.tgz *.tar.gz

ENV PATH="/tools/vsearch-2.4.3-linux-x86_64/bin:$PATH"
ENV PATH="/tools/cd-hit-v4.6.8-2017-0621:$PATH"
ENV export PATH=$PATH:$HOME/edirect >& /dev/null || setenv PATH "${PATH}:$HOME/edirect"
ENV PATH="/tools/hmmer-3.1b2-linux-intel-x86_64/binaries:$PATH"
ENV PATH="/tools/bowtie2-2.3.3.1-linux-x86_64:$PATH"
#ENV PATH="/usr/local/anaconda/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile

#########
### Supervisor
#########
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#########
### Volumes
#########
VOLUME /home/share

#########
### Ports and CMD
#########
EXPOSE 22 80 443
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
