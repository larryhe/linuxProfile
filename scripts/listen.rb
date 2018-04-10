#!/usr/local/bin/ruby
require 'listen'
PROJ_DIR="/Users/larryhe/workspace/vault.git"
SRC_WEBAPP=PROJ_DIR + "/WzlUI/src/main/webapp"
puts "start watching #{SRC_WEBAPP}"
listener = Listen.to(SRC_WEBAPP) do |modified|
    modified.each do |f|
        system("~/scripts/exe_watchdog #{f}")
    end
end
listener.start # not blocking
sleep
