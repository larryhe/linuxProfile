#!/bin/bash
PROJ_DIR="/Users/larryhe/workspace/vault.git"
DST_TOMCAT="/usr/local/apache-tomcat/6.0.32"
DST_DIR="${DST_TOMCAT}/webapps/ROOT/WEB-INF/classes"

PROGRAMNAME=`basename $0`
if [ $# -lt 1 ];then
    echo "Usage: $PROGRAMNAME modules (ui,doc,core etc)"
    echo "For example: $PROGRAMNAME ui"
    exit 1
fi

case $1 in 
    ui)
        module="WzlUI"
        ;;
    doc)
        module="WzlDocs"
        ;;
    *)
        echo "Not supported yet"
        exit 1
        ;;
esac

cd "$PROJ_DIR/$module"
SRC_DIR="$PROJ_DIR/$module/target/classes/*"
mvn clean install -DskipTests 
command="scp -r -P 2222 $SRC_DIR root@my.vaultdev.com:${DST_DIR}" 
echo "executing ${command}" 
eval $command
ssh -p 2222 root@my.vaultdev.com '/etc/init.d/tomcat6 stop' 
ssh -p 2222 root@my.vaultdev.com '/etc/init.d/tomcat6 start' 
echo "sleeping 120 seconds"
sleep 120
