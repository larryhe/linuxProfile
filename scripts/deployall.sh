#!/bin/bash
ssh -p 2222 root@my.vaultdev.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no 'cd ~/RHEL5 && ./ServerDeploy.pl -r `ls /media/sf_repository/veeva/ecm/ui/ui/ -t | grep SNAPSHOT | head -1`'
