#!/usr/local/bin/ruby
require 'listen'
PROJ_DIR="/Users/larryhe/workspace/vault.git"
SRC_JMVC=PROJ_DIR + "/WzlUI/src/main/webapp/JMVC" 
SRC_UI_VIEW=PROJ_DIR + "/WzlUI/src/main/webapp/WEB-INF/views"
SRC_VMC_VIEW=PROJ_DIR + "/WzlVMC/src/main/webapp/WEB-INF/views"
SRC_ANNOTATE=PROJ_DIR + "/AnnotateApp/src/main/webapp/annotate"
SRC_PHP=PROJ_DIR + "/WzlUI/src/main/webapp/annotate"

listener = Listen.to(SRC_JMVC, SRC_UI_VIEW, SRC_VMC_VIEW, SRC_ANNOTATE, SRC_PHP) do |modified|
    modified.each do |f|
        system("exe_watchdog #{f}")
    end
end
listener.start # not blocking
sleep
