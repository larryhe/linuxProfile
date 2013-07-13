#!/bin/bash
usage(){
    echo "Usage: $PROGRAMNAME class-full-name path-to-search"
    echo "for examples $PROGRAMNAME java.util.Date /"
}
#set -x
PROGRAMNAME=`basename $0`
if [ $# -lt 1 ];then
    usage
    exit 1
fi
SEARCH_DIR=$2
if [ -z "$SEARCH_DIR" ];then
    SEARCH_DIR="."
fi
#command tips defined
find $SEARCH_DIR -type f -name "*.jar" | awk '{print "jarfile:",$1;system(sprintf("jar -tvf %s",$1))}' | awk 'BEGIN{RS="jarfile:";FS="\n"}{if(match($0,pattern)) print $1}' pattern=$1
