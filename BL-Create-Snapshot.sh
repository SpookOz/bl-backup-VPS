#!/bin/bash

# Creates a new temporary snapshot of the current VPS.


# Enter BL API Token below and remove hash

# APITOKEN=

# Retrieves Hostname
tmphostname=$(hostname --long)

# Installs jq if needed
. /etc/os-release
DIST=$ID
if [ $DIST = "centos" ]; then
	sudo yum install jq -y
elif [ $DIST = "rocky" ]; then
	sudo dnf install jq -y
elif [ $DIST = "ubuntu" ]; then
	sudo apt install jq -y
elif [ $DIST = "debian" ]; then
	sudo apt install jq -y
fi

# Gets BL server ID
echo "Retrieving ID for $tmphostname"
serverid=$(curl -X GET "https://api.binarylane.com.au/v2/servers?hostname=$tmphostname" -H "Authorization: Bearer $APITOKEN" | jq '.servers[0].id')
echo "The ID for $tmphostname is: $serverid"

# Makes new temp backup
curl -X POST "https://api.binarylane.com.au/v2/servers/$serverid/actions" -H "Authorization: Bearer $APITOKEN" -H "Content-Type: application/json" -d '{"type": "take_backup", "backup_type": "temporary", "replacement_strategy": "oldest", "label": "script-backup"}'

# Check for errors
if [ $? -eq 0 ]
then
  echo "Backup apparently succeeded."
else
  echo "Backup may have failed."
fi