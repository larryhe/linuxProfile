#!/bin/bash
echo "SYNTAX: ./tcgit.sh [bt2|bt8|bt11 DEFAULT:bt2]"

# Did they provide SHA1?
#will workout all commits to be dcommitted and then grab change list inside them. so below is not needed any more..
#if [ -z "$1" ]; then
#    echo "You must provide the first 6 characters of the commited SHA1"
#    exit -1
#fi

# Set the TEAMCITY project id
if [ -z "$1" ]; then
    PROJECT_NAME=bt2
else
    PROJECT_NAME=$1
fi

url=`git svn info --url`
origin=svn/${url##https*/}

git log --pretty="format:" --name-only ${origin}.. | sort | uniq > checkinfiles.txt

#git show --pretty="format:" --name-only $1 > checkinfiles.txt

echo "Working on the following files:"
cat checkinfiles.txt
echo "If successful, will be committed" 

echo "Logging into teamcity"
logintc.sh

echo "Pushing code to teamcity"
retncode=`java -jar ~/tcc.jar  run --host http://teamcity.successfactors.com:8111 -m "$(echo $USER) checked in via CLI on QACAND" -c $PROJECT_NAME @checkinfiles.txt`
checkcode=`echo $retncode | egrep -l "Build for Change .* ran successfully"`
if [ -z "$checkcode" ]; then
    echo "Build failed. Check http://teamcity.successfactors.com/viewType.html?tab=buildTypeStatusDiv&buildTypeId=bt2 for details"
else
    echo "Committing to SVN via git"
    git svn dcommit 
fi 
