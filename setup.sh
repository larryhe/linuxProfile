#/bin/bash
#setup soft links to terminal config
LINUX_PROF_HOME=~/linuxProfile
USER_H=~
#setup links to terminal vim and apps in sequence
for conf in terminal vim apps
do
    for fn in `ls -A "$LINUX_PROF_HOME/$conf"`
    do
        if [ -e "$USER_H/$fn" ];then
	    mv "$USER_H/$fn" "$USER_H/${fn}.backup"
        fi
        ln -s "$LINUX_PROF_HOME/$conf/$fn" "$USER_H/$fn"
        echo "link to $LINUX_PROF_HOME/${conf}/${fn} created under $USER_H/$fn"
    done
done

#install vim gvim and exuberant ctags package from debian
sudo apt-get install vim vim-gnome exuberant-ctags
#enable bash completion case in-sensitive
sudo echo "set completion-ignore-case on" >> /etc/inputrc
