FROM fy/conda_base
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### gnu parallel
#########
RUN apt-get update && apt-get install -y parallel

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

ENV PATH="/tools/vsearch-2.4.3-linux-x86_64/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile

#########
##3 cdhit 4.6.8
#########
WORKDIR /tools
RUN wget https://github.com/weizhongli/cdhit/releases/download/V4.6.8/cd-hit-v4.6.8-2017-0621-source.tar.gz && \
    tar -xzvf cd-hit-v4.6.8-2017-0621-source.tar.gz && \
    cd cd-hit-v4.6.8-2017-0621 && \
    make

#########
### Clean up
#########
WORKDIR /tools
RUN rm -rf *.tgz *.tar.gz

#########
### Supervisor
#########
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#########
### Ports and CMD
#########
EXPOSE 22 80 443
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
