#!/bin/sh

# Location of hosts file.
HOSTS_FILE=/etc/hosts

# Default docker-machine name.
DOCKER_MACHINE_NAME=default

# IP address regex
REGEX_IP_ADDRESS="^\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"

# Check the name of the docker machine to probe.
if [ ! -z "$1" ]; then
    DOCKER_MACHINE_NAME=$1
fi
echo "Using docker machine: \"$DOCKER_MACHINE_NAME\""

# Get the IP address of specified docker machine. If the machine is not found, exit.
DM_IP=`docker-machine ip $DOCKER_MACHINE_NAME`
if [ $? == 1 ]; then
    exit 1
fi
echo "IP address: \"$DM_IP\""

# Check if the target docker-machine-{name} entry already exists.
DM_ENTRY_EXISTS=$(grep -Eo "$REGEX_IP_ADDRESS.*docker-machine-$DOCKER_MACHINE_NAME" $HOSTS_FILE)

# Replace or append docker-machine-{name}.
DM_ENTRY="$DM_IP docker-machine-$DOCKER_MACHINE_NAME"
if [ ! -z "$DM_ENTRY_EXISTS" ]; then
    sed -i .bak "s/$DM_ENTRY_EXISTS/$DM_ENTRY/1" $HOSTS_FILE
else
    # Create a backup of existing hosts file.
    cp $HOSTS_FILE $HOSTS_FILE.bak
    echo "$DM_ENTRY" >> $HOSTS_FILE
fi

# Show what was added/changed.
echo "$HOSTS_FILE: $DM_ENTRY"
