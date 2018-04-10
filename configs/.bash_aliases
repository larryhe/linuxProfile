# customized alias
cleangitbranch() {
    git branch -D "$1" &&  git push origin :"$1" 
}

vault_pom=~/workspace/vault.git/pom.xml
review () {
    version=`grep '<version>\d*\.\d*\.\d*-SNAPSHOT</version>' $vault_pom | grep -o '\d*\.\d*\.\d*'`
    name=`git log -1 --pretty=%B | tr '|' '-' | tr ' ' '-'`
    branch="r${version}/larry.he/${name}"
    git checkout -b $branch
    git push origin $branch
    echo "branch $branch pushed to remote"
}

closereview() {
    branch=`git branch | grep '^\*' | cut -d ' ' -f2`
    git checkout develop
    git branch -D $branch && git push origin :$branch
    echo "$branch removed"
}

alias rsvlocal='sudo ssh -p 2222 root@my.vaultdev.com -L 443:127.0.0.1:8443 -L 80:127.0.0.1:8080 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias vpn-conn='sudo vpnc-connect --enable-1des'
alias vpn-disconn='sudo vpnc-disconnect'
alias jeclipse='$DEV_HOME/eclipse/eclipse'
alias sqldev='$DEV_HOME/SQLDeveloper/sqldeveloper.sh'
alias gototrk='cd $DEV_HOME/vault.git'
alias home='cd $DEV_HOME'
alias vpm='cd $DEV_HOME/vpm'
alias webapp='cd /Users/larryhe/workspace/vault.git/WzlUI/src/main/webapp/'
alias webtest='cd /Users/larryhe/workspace/vault.git/WzlUI/src/test/js'
alias wzlui='cd /Users/larryhe/workspace/vault.git/WzlUI'
alias gruntapp='cd /Users/larryhe/workspace/vault.git/WzlUI/grunt'
alias mvncln='mvn clean install -DskipTests'
alias syncbld='git pull --rebase && mvn clean install -DskipTests'
alias github="cd ~/workspace/github/"
alias psh_git="git pull --rebase && git push"
alias cln_git_br=cleangitbranch
alias antlr4='java -jar /Users/larryhe/tmp/compiler/antlr-4.0-complete.jar'
alias runantlr4='java org.antlr.v4.runtime.misc.TestRig'
alias uitests="cd /Users/larryhe/workspace/vault.git/WzlUI/ && npm test"
alias jslint='cd /Users/larryhe/workspace/vault.git/WzlUI/grunt && grunt eslint:console'
alias lessgrunt='cd /Users/larryhe/workspace/vault.git/WzlUI/grunt && grunt lesswatcher'
alias uipush="cd /Users/larryhe/workspace/vault.git/WzlUI/src/test/js/ && ./karmaTest.sh && cd /Users/larryhe/workspace/vault.git && git pull --rebase && git push"
alias uideploy="pushd /Users/larryhe/workspace/vault.git/DevTools/src/main/resources/deployment/ && ./hot_deploy.sh -a vault -s av -w -d WzlUI && popd"
alias vup="cd /Users/larryhe/workspace/vagrant/ && vagrant up"
alias allinone="git pull --rebase && mvn clean install -DskipTests && ~/scripts/deployall.sh"
alias deployVM="~/scripts/deployall.sh"
alias dev="ssh -i ~/.ssh/dev.pem larry.he@dev.vaultdev.com"
alias dev3="ssh -i ~/.ssh/dev.pem larry.he@dev3.vaultdev.com"
alias keyappend="ssh-copy-id -i ~/.ssh/id_rsa.pub -p 2222 root@my.vaultdev.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias portalDev="ssh -i ~/.ssh/dev.pem larry.he@uiplatform-dev.vaultdev.com"
alias portalQA="ssh centos@uiplatform.vaultdev.com"
alias mgth='git commit -am "merge local change to HEAD" && git rebase -i HEAD~2'
alias gpll='git pull --rebase'
