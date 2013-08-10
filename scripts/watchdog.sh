#!/bin/bash
PROJ_DIR="/Users/larryhe/workspace/Vault"
DST_TOMCAT="/usr/local/apache-tomcat/6.0.32"
SRC_JMVC=$PROJ_DIR/WzlUI/src/main/webapp/JMVC 
SRC_UI_VIEW=$PROJ_DIR/WzlUI/src/main/webapp/WEB-INF/views 
SRC_VMC_VIEW=$PROJ_DIR/WzlVMC/src/main/webapp/WEB-INF/views 
#SRC_ANNOTATE_CSS=$PROJ_DIR/Annotate/src/main/webapp/annotate/css 
#SRC_ANNOTATE_JS=$PROJ_DIR/Annotate/src/main/webapp/annotate/js 
#SRC_ANNOTATE_PHP=$PROJ_DIR/Annotate/src/main/webapp/annotate/php 
SRC_ANNOTATE=$PROJ_DIR/Annotate/src/main/webapp/annotate
DST_JMVC="${DST_TOMCAT}/webapps/ui/JMVC"
DST_UI_VIEW="${DST_TOMCAT}/webapps/ui/WEB-INF/views"
DST_VMC_VIEW="${DST_TOMCAT}/webapps/vmc/WEB-INF/views"
DST_ANNOTATE="${DST_TOMCAT}/webapps/annotate/annotate"
watchmedo shell-command --pattern="*.js;*.jspx;*.css" --recursive --command='\
PROJ_DIR="/Users/larryhe/workspace/Vault"
DST_TOMCAT="/usr/local/apache-tomcat/6.0.32"
SRC_JMVC=$PROJ_DIR/WzlUI/src/main/webapp/JMVC 
SRC_UI_VIEW=$PROJ_DIR/WzlUI/src/main/webapp/WEB-INF/views 
SRC_VMC_VIEW=$PROJ_DIR/WzlVMC/src/main/webapp/WEB-INF/views 
SRC_ANNOTATE=$PROJ_DIR/Annotate/src/main/webapp/annotate
DST_JMVC="${DST_TOMCAT}/webapps/ui/JMVC"
DST_UI_VIEW="${DST_TOMCAT}/webapps/ui/WEB-INF/views"
DST_VMC_VIEW="${DST_TOMCAT}/webapps/vmc/WEB-INF/views"
DST_ANNOTATE="${DST_TOMCAT}/webapps/annotate/annotate"
file=$watch_src_path \
target="${file/$SRC_JMVC/$DST_JMVC}" \
target="${target/$SRC_UI_VIEW/$DST_UI_VIEW}" \
target="${target/$SRC_VMC_VIEW/$DST_VMC_VIEW}" \
target="${target/$SRC_ANNOTATE/$DST_ANNOTATE}" \
#command="echo $file $target" \
command="scp -P 2222 $file root@my.veevavault.com:${target}" \
echo "executing ${command}" \
eval $command' \
	$SRC_JMVC $SRC_UI_VIEW $SRC_VMC_VIEW $SRC_ANNOTATE_JS \
