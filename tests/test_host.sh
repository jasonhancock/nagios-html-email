#!/bin/bash

function usage() {
    echo
    echo
    echo "Usage:   $0 email nagios_location"
    echo "   email = email address to send messages to"
    echo "   nagios_location = url of your nagios instance. Used to build links"
    echo
    echo "Example: $0 joe@example.com https://nagios.example.com/nagios"
    exit 1
}

EMAIL=$1
LOCATION=$2

if [ -z "$EMAIL" ]
then
   echo "No email address specified"
   usage
fi

if [ -z "$LOCATION" ]
then
   echo "No nagios location specified"
   usage
fi



# Host 
export NAGIOS_CONTACTEMAIL=$EMAIL
export NAGIOS_HOSTNAME='server.example.com'
export NAGIOS_HOSTALIAS='server.example.com'
export NAGIOS_HOSTADDRESS='192.168.1.2'
export NAGIOS_HOSTGROUPNAMES='Linux Servers'
export NAGIOS_SHORTDATETIME='05-10-2012 22:22:23'


export NAGIOS_NOTIFICATIONTYPE='PROBLEM'
export NAGIOS_HOSTSTATE='DOWN'
export NAGIOS_HOSTOUTPUT='CRITICAL - Host Unreachable (192.168.1.2)'
../plugins/notify-html-email $LOCATION 

export NAGIOS_NOTIFICATIONTYPE='RECOVERY'
export NAGIOS_HOSTSTATE='UP'
export NAGIOS_HOSTOUTPUT='It is up'
../plugins/notify-html-email $LOCATION 

export NAGIOS_NOTIFICATIONTYPE='ACKNOWLEDGEMENT'
export NAGIOS_HOSTSTATE='UP'
export NAGIOS_HOSTOUTPUT='It is up'
export NAGIOS_NOTIFICATIONAUTHORALIAS='Some Username'
export NAGIOS_NOTIFICATIONCOMMENT='this is an ack message'
../plugins/notify-html-email $LOCATION 
