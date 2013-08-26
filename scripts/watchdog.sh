#!/bin/bash
PROJ_DIR="/Users/larryhe/workspace/vault.git"
SRC_JMVC=$PROJ_DIR/WzlUI/src/main/webapp/JMVC 
SRC_UI_VIEW=$PROJ_DIR/WzlUI/src/main/webapp/WEB-INF/views 
SRC_VMC_VIEW=$PROJ_DIR/WzlVMC/src/main/webapp/WEB-INF/views 
SRC_ANNOTATE=$PROJ_DIR/Annotate/src/main/webapp/annotate
watchmedo shell-command --pattern="*.js;*.jspx;*.css" --recursive --command='\
watchdog_execute "${watch_src_path}"' \
	$SRC_JMVC $SRC_UI_VIEW $SRC_VMC_VIEW $SRC_ANNOTATE_JS \
