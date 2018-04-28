#!/bin/bash

# This script executes apt-get upgrade in dry-run-mode and
# creates a report file which can e.g. be emailed to someone.

output_file=/var/log/apt/apt-get.log

echo "apt-get report for `hostname` from `date "+%d.%m.%Y, %H:%M"`
________________________________________


check
-----" > $output_file
apt-get check >> $output_file


echo "

update + upgrade (dry run)
--------------------------" >> $output_file
apt-get update -q
apt-get upgrade -s >> $output_file

echo "
________________________________________

End of report." >> $output_file
