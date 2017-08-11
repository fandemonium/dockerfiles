FROM fy/conda_base
MAINTAINER Fan Yang (snisiarc@gmail.com)

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
### Clean up
#########
WORKDIR /tools
RUN rm -rf *.tgz

#########
### Supervisor
#########
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#########
### Ports and CMD
#########
EXPOSE 22 80 443
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
