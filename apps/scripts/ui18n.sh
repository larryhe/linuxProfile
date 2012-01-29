#!/bin/bash
PRONAME=`basename $0`
USAGE="Usage : $PRONAME sfmessages.properties.utf8 jsFiles"   
usage(){
    echo $USAGE
    exit 0
}
MINARGS=2
TMPFILE=".msgs-keys"

extract_msgs(){
#message pattern defined in JS code
    msgs_pattern_sgl="'\$\$[^']*'"
    msgs_pattern_dbl='"\$\$[^"]*"'
    msgs=`grep -oH -e "$msgs_pattern_sgl" -e "$msgs_pattern_dbl" $*`
    echo "#add message key at left side of equal sign(=) for each messages. Save & exit and then all the messages appeared in specified JS file will be replaced with the key you just assigned" >> "$TMPFILE"
#extract all the messages from specified js files to a temparary file
    echo "$msgs" | sort | uniq | awk '
        {
            fn=substr($0,1,index($0,":"));
            msg=substr($0,index($0,":")+1);
            if(fn in fileNames){
                print "="msg;
            }else{
                fileNames[fn]=fn;
                print "#below messages are from file "fn;
                print "="msg;
            }
        }
    ' >> "$TMPFILE"
}

escape_str(){
    #escape forward slash and backslash in message
    echo $* | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g'
}

replace_msgs(){
    OLDIFS="$IFS"
    NFS=$'\n'
    IFS="$NFS"
    for line in `cat "$TMPFILE"`
        do
            IFS="$OLDIFS"
            case $line in
            \#*);;
            *)
            leng=${#line}
            delidx=`expr index "$line" =`
            let "keyidx=$delidx-1"
            msgKey=${line:0:$keyidx}
            let "msgl=$leng - $delidx"
            msg=${line:$delidx:$msgl}
            msg=`escape_str $msg`
            echo "replace message ${msg} with MSGS.${msgKey}"
            sed -i "s/$msg/MSGS.$msgKey/g" $*
            ;;
            esac
            IFS="$NFS"
        done
    IFS="$OLDIFS"
}
#check if lines match message define pattern (message key=message content also message key has at least 1 letters and only [a-zA-Z0-9_] are allowed) and then check if there are any duplicated message keys
check_tmp_file(){
    awk '
        BEGIN{
            LINENUM=0;
            FS="=";
            MSG_KEYS["0"]=LINENUM;
            msg_def_format="[a-zA-Z0-9_]+=.+";
        }
        {
            LINENUM++;
            if(!match($0,"^#.*")){
                if(!match($0, msg_def_format)){
                    printf("line %s is invalid, message definition does not match specified format(key=message and key has at least 1 letters and only[a-zA-Z0-9_] are allowed)", LINENUM);
                    exit 1;
                }else if($1 in MSG_KEYS){
                    printf("%s was already defined in line %s", $1, MSG_KEYS[$1]);
                    exit 1;
                }else{
                    MSG_KEYS[$1]=LINENUM;
                }
            }
        }
    ' $TMPFILE
}

#echo "count of argument= $#"
#sleep 5
if [ $# -lt $MINARGS ];then
    usage
elif [ ! -f $1 ];then
    echo "file $1 does not exist"
    exit 0
else
    messagefile=$1
    shift 1
    echo "#lines start with # are comments and will be ignored." > "$TMPFILE"
    echo "#override envrionment variable EDITOR to change the text editor to your favoriate one, vim will be used be default." >> "$TMPFILE"
    extract_msgs $*
    if [ -z "$EDITOR" ];then
        EDITOR=vim
    fi
    $EDITOR $TMPFILE
    check_result=`check_tmp_file`
    while [ -n "$check_result" ]
    do
        echo $check_result
        echo -n "do you want to continue editing it (y to continue, n to exit)?"
        read answer
        if [ "$answer" = "n" ];then
            echo "messages have not been replaced. you can run command again to complete it"
            rm $TMPFILE
            exit 0
        else
            $EDITOR $TMPFILE
            check_result=`check_tmp_file`
        fi
    done
    echo "replacing all messages with message keys"
    replace_msgs $*
    echo "append message definitions to sfmessages.properties.utf8 file"
    startQt="=['\"]\\$\\$"
    endQt="['\"]$"
    sed '/^#/ d' $TMPFILE | sed "s/$endQt//" | sed "s/$startQt/=/" >> $messagefile
    rm $TMPFILE
    echo "All messages replaced successfully!"
fi
