#!/bin/bash
if [ -f ~/build.log ];then
	revNum=`cat ~/build.log`
fi
if [ -n "$1" ];then
	revNum=$1
	echo revNum > ~/build.log
fi

if [ -z "$revNum" ];then
	echo "Specify a revision number (for example: 6.5.3-SNAPSHOT)"
	exit 0
fi
cat ~/.ssh/config.local > ~/.ssh/config;cd ~/RHEL5;./veeva_deploy.sh -a vaultauth -e vm -s localhost -t localhost -R no -m localhost -r $revNum
cat ~/.ssh/config.local > ~/.ssh/config;cd ~/RHEL5;./veeva_deploy.sh -a vmc -e vm -s localhost -t localhost -R no -m localhost -r $revNum
cat ~/.ssh/config.local > ~/.ssh/config;cd ~/RHEL5;./veeva_deploy.sh -a vault-fast -e vm -s localhost -t localhost -R yes -m localhost -j -r $revNum
