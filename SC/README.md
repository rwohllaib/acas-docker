These images are built ontop of the Iron Bank provided RHEL UBI 8 hardened images which can be obtained from 'https://ironbank.dso.mil/repomap/details;image=ubi8;vendor=Red%2520Hat;product=UBI8'
DISA often releases new install files for ACAS, so it may be necessary to update the Dockerfile and scripts to contain the new file names and replace the file in the installers directory with the latest edition.

This image is intented to be used in conjuction with the nessus image.

The command to run this image is below, it is necessary to expose port 443 on the container so you can access the SecurityCenter web GUI.
> sudo docker run -itd p 443:443 imagename
