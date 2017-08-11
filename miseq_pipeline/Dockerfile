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
