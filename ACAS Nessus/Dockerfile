# Make sure to publish port 8834:8834 when building
# docker run -v /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it -P IMAGENAME

FROM centos:8
ENV container docker
# Commands from centos documentation
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
CMD ["/bin/bash"]

# Nessus Web GUI port
# EXPOSE 8834
# Default SC Web GUI port
EXPOSE 443

# Ensure you have acas files in same directory as dockerfile
ADD CM-265613-Nes-8.15.0-es8.x86_64.rpm /ACAS/
ADD CM-267388-SecurityCenter-5.19.0-el8.x86_64.rpm /ACAS/
# ADD CM-263467-acas_configure-21.04-0.noarch.rpm /ACAS/

# Replacement systemctl.py file to enable centOS systemd to work
COPY systemctl.py /usr/bin/systemctl
RUN chmod a+x /usr/bin/systemctl

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