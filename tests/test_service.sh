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

# Service          
export NAGIOS_CONTACTEMAIL=$EMAIL
export NAGIOS_HOSTALIAS='server.example.com'
export NAGIOS_HOSTNAME='server.example.com'
export NAGIOS_NOTIFICATIONTYPE='PROBLEM'
export NAGIOS_SERVICEDESC='Memory Usage'
export NAGIOS_HOSTGROUPNAME='Linux Servers';
export NAGIOS_SHORTDATETIME='05-10-2012 21:30:17'
export NAGIOS_SERVICESTATE='WARNING'
export NAGIOS_HOSTADDRESS='192.168.1.2'
export NAGIOS_SERVICEOUTPUT='WARNING'
export NAGIOS_SERVICEATTEMPT=1

../plugins/notify-html-email $LOCATION 

export NAGIOS_NOTIFICATIONAUTHORALIAS='Some Username'
export NAGIOS_NOTIFICATIONTYPE='ACKNOWLEDGEMENT'
export NAGIOS_NOTIFICATIONCOMMENT='this is an ack message'
../plugins/notify-html-email $LOCATION
