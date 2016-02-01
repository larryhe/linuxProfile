#!/bin/bash
PROJ_DIR="/Users/larryhe/workspace/vault.git"
DST_TOMCAT="/usr/local/apache-tomcat/vault.1"
SRC_WEBAPP=$PROJ_DIR/WzlUI/src/main/webapp
SRC_JSPX=$PROJ_DIR/WzlUI/src/main/webapp/WEB-INF/views 
DST_WEBAPP="${DST_TOMCAT}/webapps/ROOT/ui-resources"
DST_JSPX="${DST_TOMCAT}/webapps/ROOT/WEB-INF/views"

execute_command(){
    file=$1 
    target="${file/$SRC_JSPX/$DST_JSPX}" 
    target="${target/$SRC_WEBAPP/$DST_WEBAPP}" 
    #command="echo $file $target" 
    command="scp -P 2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $file root@my.vaultdev.com:${target}" 
    echo "executing ${command}" 
    eval $command
}

execute_command $*
