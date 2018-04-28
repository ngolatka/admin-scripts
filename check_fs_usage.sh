#!/bin/bash

# This checks if a specific volume has reached the given storage or
# Inode limit. If yes, an email will be sent.

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ];
then

  echo "Missing parameter"
  echo "Example:"
  echo "$0 /dev/sda1 85 from@example.com to@example.com"
  exit 1

fi

scriptPath="`dirname \"$0\"`"                  # Get absolute location of this script
scriptPath="`( cd \"$scriptPath\" && pwd )`"

fsPath="$1"                                    # Filesystem path, e.g. /dev/sda1
maxPercentage="$2"                             # Upper limit (%), e.g. 90
mailFrom="$3"                                  # Email sender, e.g. from@example.com
mailTo="$4"                                    # Email receiver, e.g. to@example.com

capPercentage=`df -h   | grep $fsPath | awk '{print $5}' | tr -d %`
inodePercentage=`df -i | grep $fsPath | awk '{print $5}' | tr -d %`

if [[ $capPercentage -ge $maxPercentage ]];    # Send email if capacity limit exceeded
then

  bash $scriptPath/lib/mail.sh "$mailfrom" "$mailTo" "Check capacity on $HOSTNAME" "Capacity of $fsPath has reached its limit!\nCurrently at $capPercentage%, limit is $maxPercentage%."

fi

if [[ $inodePercentage -ge $maxPercentage ]];  # Send email if inode count limit exceeded
then

  bash $scriptPath/lib/mail.sh "$mailFrom" "$mailTo" "Check Inodes on $HOSTNAME" "Inode count of $fsPath has reached its limit!\nCurrently at $inodePercentage%, limit is $maxPercentage%."

fi

exit 0
