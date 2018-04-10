#!/bin/bash
for file in `cat ~/tmp/junit4.log`; do
    ~/scripts/migrateJunit4.js $file
done
