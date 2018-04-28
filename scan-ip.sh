#!/bin/bash

# This scans a given range of IP addresses and pings every
# address to see if there's a machine on that address.

ipSegment="$1"
ipStart="$2"
ipEnd="$3"


if [[ "$ipSegment" == "" ]];
then

  echo "Syntax error."
  echo ""
  echo "Example: `basename $0`  192.168.1  50  80"
  echo ""
  echo "This will scan IPs from 192.168.1.50 to 192.168.1.80 and ping every IP."
  echo "If no or an incomplete range is given, scan will go from .1 to .254"
  exit 1

fi

if [[ "$ipStart" -gt "254" || "$ipEnd" -gt "254" ]];
then

  echo "Invalid range. Allowed: 1 - 254"
  exit 1

fi

if [[ "$ipStart" == "" || "$ipEnd" == "" ]];
then

  ipStart="1"
  ipEnd="254"

fi

echo "Scanning range from $ipSegment.$ipStart - $ipSegment.$ipEnd"
echo ""

while [[ "$ipStart" -le "$ipEnd" ]]
do

  result=`ping -W 1 -c 1 "$ipSegment"."$ipStart" | grep "bytes from"`

  if [[ "$result" == "" ]];
  then

    echo "$ipSegment.$ipStart ... nothing"

  else

    echo "$ipSegment.$ipStart --> $result"

  fi
  ((ipStart++))

done
