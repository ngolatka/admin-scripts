#!/bin/bash

# Helper script to easily start or stop VNC on a machine
# with usefull default settings.

display=1

if [ "$1" = "start" ];
then

  echo "Using display :$display, port 590$display"
  vncserver :$display -geometry 1280x800 -depth 16 -nevershared

elif [ "$1" = "stop" ];
then

  echo "Display :$display"
  vncserver -kill :$display -clean

else

  echo "Please say 'start' or 'stop'"

fi
