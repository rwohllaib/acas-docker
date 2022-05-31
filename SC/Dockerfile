# Use official/pre-hardened RHEL UBI8 Image
ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/redhat/ubi/ubi8
ARG BASE_TAG=latest
FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

# Default tenable.sc Web GUI port
EXPOSE 443
# Specify an account if you want this is not implemented/supported yet
# ENV NON_PRIV_USER ""

#RedHat reccomended commands to ease container errors
RUN rm -rf /var/log/*
RUN mkdir -p /var/log/rhsm

# Ensure you have acas files in the sub directory of dockerfile titled 'installers'
COPY ./installers/CM-267388-SecurityCenter-5.19.0-el8.x86_64.rpm /acas/
# Ensure you have the script file in the sub directory of dockerfile titled 'scripts'

# Necessary for the 'service' command to start SC
RUN yum -y install initscripts
# Neccessary for generating reports in the gui
RUN yum -y install java

# SC Package Install
RUN yum -y --nogpgcheck localinstall /acas/CM-267388-SecurityCenter-5.19.0-el8.x86_64.rpm && yum -y update && yum clean all && rm -rf /var/cache/yum

RUN service SecurityCenter start

HEALTHCHECK --interval=60s CMD curl -f http://127.0.0.1:443/ || exit 1