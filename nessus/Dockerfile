# Use official/pre-hardened RHEL UBI8 Image
ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/redhat/ubi/ubi8
ARG BASE_TAG=latest
FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

# Default Nessus Web GUI port
EXPOSE 8834
# Specify an account if you want
ENV NON_PRIV_USER ""

#RedHat reccomended commands to ease container errors
RUN rm -rf /var/log/*
RUN mkdir -p /var/log/rhsm

# Default Nessus Web GUI port
EXPOSE 8834

# Ensure you have acas files in same directory as dockerfile
COPY ./installers/CM-265613-Nes-8.15.0-es8.x86_64.rpm /acas/
COPY ./scripts/nessusconfig.sh /acas/
# Nessus Package Install
RUN yum -y --nogpgcheck localinstall /acas/CM-265613-Nes-8.15.0-es8.x86_64.rpm && yum -y update && yum clean all && rm -rf /var/cache/yum

# Configure and run nessus
RUN chmod 755 /acas/nessusconfig.sh
CMD ["/acas/nessusconfig.sh"]

HEALTHCHECK --interval=60s CMD curl -f http://127.0.0.1:8834/ || exit 1
