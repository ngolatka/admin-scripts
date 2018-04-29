#!/bin/bash

# This script updates all packages on the system and removes any
# packages that are no longer required. It summarizes everything
# and creates a report file which can e.g. be emailed to someone.

# This is intended for use in Cronjobs, therefore no output is shown.


seconds=2                                        # Delay time after execution
output_file="/var/log/apt/apt-get_upgrade.log"   # Report file

echo "apt-get on `hostname` from `date "+%d.%m.%Y, %H:%M"`
______________________________________________

check
-----" > $output_file

apt-get check >> $output_file
sleep $seconds

echo "
update
------" >> $output_file

apt-get update -q >> $output_file
sleep $seconds

echo "
upgrade
-------" >> $output_file

apt-get upgrade -y >> $output_file
sleep $seconds

echo "
autoremove
----------" >> $output_file

apt-get autoremove -y >> $output_file

echo "
______________________________________________

End of report." >> $output_file
