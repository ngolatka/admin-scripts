#!/bin/bash

# This script updates all packages on the system and removes any packages
# that are no longer required. It summarizes everything and creates a
# report file which can e.g. be emailed to someone.

# The general aim is to keep the system up to date, and automatically
# remove anything that is no longer needed (e.g. old dependencies) so
# that nothing grows out of control (apt caches, storage use, etc.).

# This is intended for use in Cronjobs, therefore no output is shown
# on the terminal. STDERR from executed commands will also be redirected.
# The terminal will be completely silent in any case.


logfile="/var/log/apt/apt-get_upgrade.log"

commands=(
  "DEBIAN_FRONTEND=noninteractive"     # Needed to supress warnings from debconf
  "apt-get update -q"
  "apt-get upgrade -q -y"
  "apt-get autoremove -y"
  "apt-get autoclean"
  "apt-get check"
)

echo -e "apt-get on `hostname` on `date "+%d.%m.%Y, %H:%M"`\n" > $logfile

for command in "${commands[@]}";
do

  echo -e "$command\n--------" >> $logfile
  eval "$command" >> $logfile 2>&1     # Redirect STDERR to STDOUT, which then goes into the logfile

  if [ $? -eq 0 ];
  then

    echo -e "OK\n" >> $logfile         # Not all commands say if they executed ok, so we add that here

  else

    echo -e "Aborting\n\nFinished with errors\n------------------------\n" >> $logfile
    exit 1

  fi

  sleep 2

done

echo -e "Finished, no errors\n------------------------\n" >> $logfile
exit 0
