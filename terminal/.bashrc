# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# source git-completion script
#if [ -f ~/scripts/git-completion.sh ]; then
    #. ~/scripts/git-completion.sh
    #PS1='\u@\h:\W$(__git_ps1 " (%s)")\$ '
#fi
#customized utility function goes here
gb (){
    if [[ $1=[0-9]* && $1 -gt 0 ]]; then
        local i=$1;
        while [[ `pwd` != "/" && $[i--] -gt 0 ]]; do
            cd ../;
        done
    fi
}

# customized our bash environment
# shortcut for commands goes here
alias LS='ls -l'
alias Ls='ls -l'
alias shtwn='echo p@ssw0rd | sudo -S shutdown -h now'
alias vpn-conn='sudo vpnc-connect --enable-1des'
alias vpn-disconn='sudo vpnc-disconnect'
alias jbossrun='jboss_run_main.sh'
alias jeclipse='$DEV_HOME/eclipse/eclipse'
alias cppeclipse='$DEV_HOME/eclipsecpp/eclipse'
alias sqldev='$DEV_HOME/SQLDeveloper/sqldeveloper.sh'
alias gototrk='cd $SF_HOME'
alias ghack='cd ~/workspace/prjs'
alias start-openvpn='echo 99999999 | sudo -S /etc/init.d/openvpn start openvpn'
alias stop-openvpn='echo 99999999 | sudo -S /etc/init.d/openvpn stop openvpn'
alias connect_test_server='ssh 192.168.25.37 -l platform'
alias syncBldRun='cd $SF_HOME && git svn rebase && ant rebuild && jboss_run_main.sh'
alias gvim='gvim -f'
#misc variables
export http_proxy=192.168.25.17:9999
#ENV variables go here
export JAVA_HOME=~/workspace/jdk1.6.0_20
#export JBOSS_HOME=~/workspace/jboss
export EDITOR=vim
export JBOSS_HOME=~/workspace/jboss-eap-4.3
export ANT_HOME=~/workspace/apache-ant-1.8.2
export ANT_OPTS='-Xmx1024m -XX:PermSize=256M -XX:MaxPermSize=512M'
export M2_HOME=~/workspace/apache-maven-2.2.1
export ORACLE_HOME=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server
export ORACLE_SID=XE
export PATCH_DIR=/home/larry/workspace/patches
export SCRIPT_HOME=~/scripts
export DEV_HOME=~/workspace
export SF_HOME="$DEV_HOME/v4.git"
export PATH=~/juic-gen/bin:$PATH:$ANT_HOME/bin:$M2_HOME/bin:$ORACLE_HOME/bin:$SCRIPT_HOME:$JAVA_HOME/bin:.
#colorscheme setting for terminal
