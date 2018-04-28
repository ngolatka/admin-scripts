#!/bin/bash

# This script builds a (somewhat) valid email and sends it to the
# designated receiver(s). Receiver addresses need to be separated
# with comma + whitespace.
# This is intended for use with SSMTP.

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ];
then

  echo >&2 "Missing parameter

Syntax: `basename $0` <Sender> <Receiver> <Subject> <Body>"

  exit 1

fi

mailSender="$1"
mailReceiver="$2"
mailSubject="$3"
mailContent="$4"

fullMail="From: $mailSender
To: $mailReceiver
Subject: $mailSubject
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

$mailContent
"

echo "$fullMail" | /usr/sbin/ssmtp "$mailReceiver"
