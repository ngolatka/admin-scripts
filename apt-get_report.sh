#!/bin/bash

# This script executes apt-get upgrade in dry-run-mode and
# creates a report file which can e.g. be emailed to someone.

# This is intended for use in Cronjobs, therefore no output is shown.


seconds=2                                        # Delay time after execution
output_file="/var/log/apt/apt-get_report.log"    # Report file

echo "apt-get report for `hostname` from `date "+%d.%m.%Y, %H:%M"`
________________________________________

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
upgrade (dry run)
-----------------" >> $output_file

apt-get upgrade -s >> $output_file

echo "
________________________________________

End of report." >> $output_file
