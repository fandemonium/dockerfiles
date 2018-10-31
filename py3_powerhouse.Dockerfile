#FROM fy_conda_base
FROM docker-registry.science-at-scale.io/genome-analytics/fy_conda_py3
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
### vsearch 2.9.1
#########
WORKDIR /tools
RUN wget https://github.com/torognes/vsearch/releases/download/v2.9.1/vsearch-2.9.1-linux-x86_64.tar.gz && \
    tar -xzvf vsearch-2.9.1-linux-x86_64.tar.gz && \
    cd  vsearch-2.9.1-linux-x86_64/bin

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
### sra toolkit 2.9.2
#########
WORKDIR /tools
RUN wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.9.2/sratoolkit.2.9.2-ubuntu64.tar.gz -O sratoolkit.tar.gz \
	&& tar -zxvf sratoolkit.tar.gz

#########
### hmmer 3.2.1
#########
WORKDIR /tools
RUN wget http://eddylab.org/software/hmmer/hmmer-3.2.1.tar.gz -O hmmer.tar.gz && \
    tar -xzvf hmmer.tar.gz 

#########
### bowtie2-2.3.3.2
#########
RUN conda install -c bioconda bowtie2

#########
### samtools and related
#########
RUN conda install -c bioconda samtools
RUN conda install -c bioconda bcftools

#########
### blast+
#########
WORKDIR /tools
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz && \
	tar -xzvf ncbi-blast-2.7.1+-x64-linux.tar.gz

#########
### clean up and set env
#########
WORKDIR /tools
RUN rm -rf *.tgz *.tar.gz *.zip *.bz2

ENV PATH="/tools/vsearch-2.4.3-linux-x86_64/bin:$PATH"
ENV PATH="/tools/cd-hit-v4.6.8-2017-0621:$PATH"
ENV PATH="/tools/edirect:$PATH"
ENV PATH="/tools/sratoolkit.2.8.2-1-ubuntu64/bin:$PATH"
ENV PATH="/tools/hmmer-3.1b2-linux-intel-x86_64/binaries:$PATH"

RUN echo "export PATH=$PATH" >> /home/.profile

#########
### Volumes
#########
VOLUME /home/share

#########
### Ports and CMD
#########
EXPOSE 22 80 443
