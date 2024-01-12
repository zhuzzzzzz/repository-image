ARG BASE=base-7.0.7
FROM base:dev

# install IOC modules.
COPY SUPPORT/ ./SUPPORT
RUN cd /opt/EPICS/SUPPORT; ./automake.sh

# generate template IOC.
COPY IOC/ ./IOC
ENV USER=root
RUN . ~/.bash_aliases; cd /opt/EPICS/IOC/ioc-tools; ./ioc-generator.py






