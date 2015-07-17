#!/usr/local/bin/ruby
require 'listen'
PROJ_DIR="/Users/larryhe/workspace/vault.git"
SRC_JMVC=PROJ_DIR + "/WzlUI/src/main/webapp/JMVC" 
SRC_COMMON=PROJ_DIR + "/WzlUI/src/main/webapp/components" 
SRC_PKG=PROJ_DIR + "/WzlUI/src/main/webapp/scripts"
SRC_UI_VIEW=PROJ_DIR + "/WzlUI/src/main/webapp/WEB-INF/views"
SRC_VMC_VIEW=PROJ_DIR + "/WzlVMC/src/main/webapp/WEB-INF/views"
SRC_PHP=PROJ_DIR + "/WzlUI/src/main/webapp/annotate"
SRC_TMPL=PROJ_DIR + "/WzlUI/src/main/webapp/templates"
SRC_LESS=PROJ_DIR + "/WzlUI/src/main/webapp/styles/less"

listener = Listen.to(SRC_JMVC,SRC_COMMON,SRC_PKG, SRC_UI_VIEW, SRC_VMC_VIEW, SRC_PHP, SRC_TMPL, SRC_LESS) do |modified|
    modified.each do |f|
        system("exe_watchdog #{f}")
    end
end
listener.start # not blocking
sleep
