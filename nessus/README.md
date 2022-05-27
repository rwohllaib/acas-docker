These images are built ontop of the Iron Bank provided RHEL UBI 8 hardened images which can be obtained from 'https://ironbank.dso.mil/repomap/details;image=ubi8;vendor=Red%2520Hat;product=UBI8'


DISA often releases new install files for ACAS, so it may be necessary to update the DockerFile to contain the new file names and replace the file in the installers directory with the latest edition.

> sudo docker run -itd p 8834:8834 imagename
