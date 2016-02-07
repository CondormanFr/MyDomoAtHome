# DOCKER-VERSION 0.3.4
#FROM        perl:latest
FROM ubuntu:latest
MAINTAINER Romain GOUYET "docker@gouyet.com"
USER root
RUN apt-get update
RUN apt-get -y install curl make gcc git
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm --verbose --self-upgrade
RUN cpanm --reinstall App::cpanminus
RUN perl -MCPAN -e 'force install HTML::Parser'
RUN cpanm --force Carton Starman

RUN apt-get -y install libdancer-perl libfile-slurp-perl  liblwp-protocol-psgi-perl  
RUN apt-get -y install libtime-piece-perl libjson-perl libplack-perl starman  libcrypt-ssleay-perl libdatetime-perl 
RUN apt-get -y install libdbd-sqlite3-perl libdbi-perl sqlite3 
RUN apt-get -y install libaudio-mpd-perl libnet-upnp-perl libpoe-component-client-mpd-perl  

RUN cachebuster=0a2ffc7 git clone http://github.com/empierre/MyDomoAtHome.git
#RUN cd MyDomoAtHome && bash run-once.sh
RUN cd MyDomoAtHome
#rUN carton install --deployment

EXPOSE 3002

WORKDIR MyDomoAtHome
# Set the default command to execute
# when creating a new container
#CMD ["carton", "exec starman --port 3002 bin/app.pl"]
