#!/bin/bash
TOMCAT_HOME="/usr/local/apache-tomcat/6.0.32"
WEBAPPS_HOME="$TOMCAT_HOME/webapps"
VAULT_CODE_BASE=/Users/larryhe/workspace/vault.git
VHOME="/data2/annotate/data"
ANNOTATE_HOME="$WEBAPPS_HOME/annotate/annotate"
# set default values 
release_version=`ls $VAULT_CODE_BASE/AnnotateApp/target/*.war`
release_version=${release_version##*/}
release_directory="develop"
build_options=""

while getopts "r:d:o:" OPTION; do
    case $OPTION in
        r)  
                release_version=$OPTARG
                ;;
        d)  
            release_directory=$OPTARG
            ;;
    o)
        build_options=$OPTARG
        ;;
        *)     exit 1
    esac
done

echo $release_version
cd $VAULT_CODE_BASE
cd AnnotateApp
mvn clean install -DskipTests $build_options
ssh -p 2222 root@my.vaultdev.com "/etc/init.d/tomcat6 stop; rm -rf $WEBAPPS_HOME/annotate; rm -f $WEBAPPS_HOME/annotate.war" 
ssh -p 2222 root@my.vaultdev.com "rm -f $TOMCAT_HOME/coverage.ec" 
scp -P 2222 $VAULT_CODE_BASE/AnnotateApp/target/$release_version root@my.vaultdev.com:$WEBAPPS_HOME/annotate.war
ssh -p 2222 root@my.vaultdev.com '/etc/init.d/tomcat6 start' 

sleep 30

ssh -p 2222 root@my.vaultdev.com "ln -s $VHOME/public $ANNOTATE_HOME/docs;ln -s $VHOME/work $ANNOTATE_HOME/work;chown -h -R tomcat6:tomcat6 $ANNOTATE_HOME;chmod -R 755 $ANNOTATE_HOME/bin"
