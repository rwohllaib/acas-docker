FROM registry.access.redhat.com/ubi8/ubi:8.4-209

LABEL com.redhat.component="ubi8-container" \
      name="ubi8" \
      version="8.4"

#label for EULA
LABEL com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI"

#labels for container catalog
LABEL summary="Provides the latest release of Red Hat Universal Base Image 8."
LABEL description="The Universal Base Image is designed and engineered to be the base layer for all of your containerized applications, middleware and utilities. This base image is freely redistributable, but Red Hat only supports Red Hat technologies through subscriptions for Red Hat products. This image is maintained by Red Hat and updated regularly."
LABEL io.k8s.display-name="Red Hat Universal Base Image 8"
LABEL io.openshift.expose-services=""
LABEL io.openshift.tags="base rhel8"

ENV container oci
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/bin/bash"]

RUN rm -rf /var/log/*
#rhbz 1609043
RUN mkdir -p /var/log/rhsm

# Nessus Web GUI port
# EXPOSE 8834
EXPOSE 443

# Ensure you have acas files in same directory as dockerfile
# ADD CM-265613-Nes-8.15.0-es8.x86_64.rpm /ACAS/
ADD CM-267388-SecurityCenter-5.19.0-el8.x86_64.rpm /ACAS/
# ADD CM-263467-acas_configure-21.04-0.noarch.rpm /ACAS/

# Replacement systemctl.py file to enable centOS systemd to work
# COPY systemctl.py /usr/bin/systemctl
# RUN chmod a+x /usr/bin/systemctl

# Needed for troubleshooting
# RUN yum -y install iproute
# RUN yum -y install iputils
# These packages come from dependencies referenced in ACAS documentation
RUN yum -y install initscripts
# RUN yum -y install unzip
# RUN yum -y install sudo
# RUN yum -y install java
# RUN yum -y install rsync
# Literally just enable every repo
# RUN sed -i 's/enabled = 0/enabled = 1/' /etc/yum.repos.d/ubi.repo
# RUN yum -y install dialog
# RUN yum -y install opensc
# RUN yum -y install aide
# RUN yum -y install logwatch
# RUN yum -y install chrony
# RUN yum -y install ansible
# run yum -y install httpd
RUN yum -y update && yum clean all && rm -rf /var/cache/yum

# ACAS Packages
# RUN yum -y localinstall /ACAS/CM-263467-acas_configure-21.04-0.noarch.rpm && yum clean all && rm -rf /var/cache/yum
RUN yum -y localinstall /ACAS/CM-267388-SecurityCenter-5.19.0-el8.x86_64.rpm && yum clean all && rm -rf /var/cache/yum

# Auto run installers (Not working)
# RUN yum -y localinstall /ACAS/CM-265613-Nes-8.15.0-es8.x86_64.rpm

RUN service SecurityCenter start