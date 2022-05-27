#!/bin/bash
#This .sh file was built with assistance from from Steve McGrath & Brendan Dalpe projects

if [ ! -n "${NON_PRIV_USER}" ];then
    NON_PRIV_USER=nessus
fi

# Reset Nessus licensing and settings
yes | /opt/nessus/sbin/nessuscli fix --reset

echo "-- Registering as a SecurityCenter-linked scanner"
/opt/nessus/sbin/nessuscli fetch --security-center

echo "-- Reconfiguring Nessus for a non-root configuration..."
echo "-- Creating user ${NON_PRIV_USER} to run the Nessus services..."
useradd -r ${NON_PRIV_USER}
usermod -a -G tty ${NON_PRIV_USER}

echo "-- Setting the appropriate permissions for the Nessus services..."
setcap "cap_net_admin,cap_net_raw,cap_sys_resource+eip" /opt/nessus/sbin/nessusd
setcap "cap_net_admin,cap_net_raw,cap_sys_resource+eip" /opt/nessus/sbin/nessus-service

echo "-- Changing the ownership of the Nessus installation to ${NON_PRIV_USER}"
chmod 750 /opt/nessus/sbin/*
chown -R ${NON_PRIV_USER}:${NON_PRIV_USER} /opt/nessus

# Create the first_run file so that we know the initialization is complete.
touch /opt/nessus/var/nessus/first_run

echo "-- Starting the Nessus service as ${NON_PRIV_USER}"
su ${NON_PRIV_USER} -c '/opt/nessus/sbin/nessus-service --no-root'
