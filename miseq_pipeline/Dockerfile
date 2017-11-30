#FROM fy_conda_base
FROM docker-registry.science-at-scale.io/genome-analytics/fy_conda_base
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### gnu parallel
#########
RUN apt-get update && apt-get install -y parallel liblzma-dev

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
RUN wget ftp://ftp.ncbi.nlm.nih.gov//entrez/entrezdirect/edirect.tar.gz -O edirect.tar.gz \     
  	&& tar -zxvf edirect.tar.gz \
    && ./edirect/setup.sh

#########
### sra toolkit
#########
WORKDIR /tools
RUN wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.2-1/sratoolkit.2.8.2-1-ubuntu64.tar.gz -O sratoolkit.tar.gz \
	&& tar -zxvf sratoolkit.tar.gz

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

#########
### samtools and related
#########
WORKDIR /tools
RUN wget https://github.com/samtools/samtools/releases/download/1.6/samtools-1.6.tar.bz2 && \
    tar -xjf samtools-1.6.tar.bz2 && \
    cd samtools-1.6 && \
    ./configure --prefix=/tools/samtools-1.6 && \
    make && make install

RUN wget https://github.com/samtools/bcftools/releases/download/1.6/bcftools-1.6.tar.bz2 && \
    tar -xjf bcftools-1.6.tar.bz2 && \
    cd bcftools-1.6 && \
    ./configure --prefix=/tools/bcftools-1.6 && \
    make && make install

### clean up and set env
#########
WORKDIR /tools
RUN rm -rf *.tgz *.tar.gz *.zip *.bz2

ENV PATH="/tools/vsearch-2.4.3-linux-x86_64/bin:$PATH"
ENV PATH="/tools/cd-hit-v4.6.8-2017-0621:$PATH"
ENV PATH="/tools/edirect:$PATH"
ENV PATH="/tools/sratoolkit.2.8.2-1-ubuntu64/bin:$PATH"
ENV PATH="/tools/hmmer-3.1b2-linux-intel-x86_64/binaries:$PATH"
ENV PATH="/tools/bowtie2-2.3.3.1-linux-x86_64:$PATH"
ENV PATH="/tools/samtools-1.6/bin:$PATH"
ENV PATH="/tools/bcftools-1.6/bin:$PATH"
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
