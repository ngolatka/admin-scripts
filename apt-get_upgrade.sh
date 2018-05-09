#!/bin/bash

# This script updates all packages on the system and removes any
# packages that are no longer required. It summarizes everything
# and creates a report file which can e.g. be emailed to someone.

# This is intended for use in Cronjobs, therefore no output is
# shown on the terminal. STDERR from executed commands will also
# be redirected.


output_file="/var/log/apt/apt-get_upgrade.log"
commands=(
  "apt-get check"
  "apt-get update -q"
  "apt-get upgrade -q -y"
  "apt-get autoremove -y"
)

echo "apt-get on `hostname` on `date "+%d.%m.%Y, %H:%M"`
" >> $output_file

for command in "${commands[@]}";
do

  echo -e "$command\n--------" >> $output_file

  eval "$command" >> $output_file 2>&1     # Redirect STDERR to STDOUT, which then goes into the file

  if [ $? -eq 0 ];
  then

    echo -e "OK\n" >> $output_file

  else

    echo -e "Aborting\n\nFinished with errors" >> $output_file
    exit 1

  fi

  sleep 2

done

echo "Finished, no errors" >> $output_file
exit 0
