#!/bin/bash

# This checks the SSH log for suspicious lines which might
# indicate break-in attempts. It uses a simple list of keywords.

if [ -z "$1" ] || [ -z "$2" ];
then

  echo "Missing parameter"
  echo "Example:"
  echo "$0 from@example.com to@example.com"
  exit 1

fi

scriptPath="`dirname \"$0\"`"                  # Get absolute location of this script
scriptPath="`( cd \"$scriptPath\" && pwd )`"

mailFrom="$1"                                  # Email sender, e.g. from@example.com
mailTo="$2"                                    # Email receiver, e.g. to@example.com

# Look for lines containing these keywords. The pipe means OR-expression.
keywords="bad|fail|not|err|warn|wrong|invalid|pass"

logEntries=`grep "ssh" /var/log/auth.log | grep --context=3 -n -i -E "$keywords"`

if [ ! -z "$logEntries" ];
then

  bash $scriptPath/lib/mail.sh "$mailFrom" "$mailTo" "SSH log excerpt from `hostname`" "$logEntries"

fi
