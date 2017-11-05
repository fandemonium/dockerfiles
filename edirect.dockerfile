FROM fy_conda_base
MAINTAINER Fan Yang (snisiarc@gmail.com)

#########
### gnu parallel
#########
RUN apt-get update && apt-get install -y parallel

#########
### aws cli
#########
RUN pip install awscli

#########
### Working dir
#########
RUN	mkdir tools 
WORKDIR /tools

#########
### edirect
#########
WORKDIR /tools
RUN perl -MNet::FTP -e \
    '$ftp = new Net::FTP("ftp.ncbi.nlm.nih.gov", Passive => 1);
     $ftp->login; $ftp->binary;
     $ftp->get("/entrez/entrezdirect/edirect.tar.gz");' \
     && gunzip -c edirect.tar.gz | tar xf - \
     && ./edirect/setup.sh

#########
### clean up and set env
#########
WORKDIR /tools
RUN rm edirect.tar.gz
ENV export PATH=$PATH:$HOME/edirect >& /dev/null || setenv PATH "${PATH}:$HOME/edirect"
ENV PATH="/usr/local/anaconda/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/.profile

