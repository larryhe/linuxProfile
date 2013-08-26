# customized alias
alias rsvlocal='sudo ssh -p 2222 root@my.veevavault.com -L 443:127.0.0.1:8443'
alias deployall="ssh -p 2222 root@my.veevavault.com '~/Scripts/deployall.sh'"
alias shtwn='sudo shutdown -h now'
alias vpn-conn='sudo vpnc-connect --enable-1des'
alias vpn-disconn='sudo vpnc-disconnect'
alias jbossrun='jboss_run_main.sh'
alias jeclipse='$DEV_HOME/eclipse/eclipse'
alias sqldev='$DEV_HOME/SQLDeveloper/sqldeveloper.sh'
alias gototrk='cd $DEV_HOME/vault.git'
alias mvncln='mvn clean install -DskipTests'
alias mvnbld='mvn install -DskipTests'
alias jssearch='grep --exclude-dir="*target*" --include="*.js"'
alias jspsearch='grep --exclude-dir="*target*" --include="*.jspx"'
alias github="cd ~/workspace/github/"
alias psh_git="git pull --rebase && git push"
alias allinone='git pull --rebase && mvncln && deployall'
