#!/bin/bash

launchctl list | awk '{print $3}' | grep sophos | while read -r line ; do
   echo "Processing current user: $line"
      launchctl remove $line
  done

  sudo launchctl list | awk '{print $3}' | grep sophos | while read -r line ; do
     echo "Processing root: $line"
        sudo launchctl remove $line
    done
