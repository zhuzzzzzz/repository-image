#
FROM ubuntu

# install packages.
# build-essential needed by execute make
# re2c needed by seq
RUN apt update && apt install -y build-essential re2c vim net-tools inetutils-ping python3 

# EPICS_BASE here should be modified accordingly.
ARG BASE=base-7.0.7

# epics-base.
WORKDIR /opt/EPICS
ADD $BASE.tar.gz .
RUN cd $BASE; make

# set environment variable(using .bash_aliases file).
ENV EPICS_BASE=/opt/EPICS/$BASE
COPY .bash_aliases /root/
COPY setENV.sh /root/

#
