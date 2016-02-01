# customized alias
alias rsvlocal='sudo ssh -p 2222 root@my.vaultdev.com -L 443:127.0.0.1:8443 -L 80:127.0.0.1:8080 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias deployall="ssh -p 2222 root@my.vaultdev.com '~/Scripts/deployall.sh'"
alias vpn-conn='sudo vpnc-connect --enable-1des'
alias vpn-disconn='sudo vpnc-disconnect'
alias jeclipse='$DEV_HOME/eclipse/eclipse'
alias sqldev='$DEV_HOME/SQLDeveloper/sqldeveloper.sh'
alias gototrk='cd $DEV_HOME/vault.git'
alias webapp='cd /Users/larryhe/workspace/vault.git/WzlUI/src/main/webapp/'
alias mvncln='mvn clean install -DskipTests'
alias syncbld='git pull --rebase && mvn clean install -DskipTests'
alias jssearch='grep --exclude-dir="*target*" --include="*.js"'
alias jspsearch='grep --exclude-dir="*target*" --include="*.jspx"'
alias github="cd ~/workspace/github/"
alias psh_git="git pull --rebase && git push"
alias allinone='git pull --rebase && mvncln && deployall'
alias antlr4='java -jar /Users/larryhe/tmp/compiler/antlr-4.0-complete.jar'
alias runantlr4='java org.antlr.v4.runtime.misc.TestRig'
alias uitests="cd /Users/larryhe/workspace/vault.git/WzlUI/src/test/js && ./karmaTest.sh"
alias lessgrunt='cd /Users/larryhe/workspace/vault.git/WzlUI/grunt && grunt lesswatcher'
alias uipush="cd /Users/larryhe/workspace/vault.git/WzlUI/src/test/js/ && ./karmaTest.sh && cd /Users/larryhe/workspace/vault.git && git pull --rebase && git push"
alias vup="cd /Users/larryhe/workspace/vagrant/ && vagrant up"
