#!/bin/bash
PRONAME=`basename $0`
USAGE="Usage : $PRONAME [OPTION] js-msg-keys.xml jsFiles"   
usage(){
    echo $USAGE
    echo "Try $PRONAME -h|--help for more information"
    exit 0
}
info(){
    echo "extract all the message keys from JUIC files and inserted to js-msg-keys.xml"
    echo "options available"
    echo "-d|--delete    delete message keys of specified JavaScript file first from js-msg-keys.xml then do insert. this option is very useful if some message keys were removed later from your JavaScript files, so they are not needed any more"
    echo "-h|--help      print help information"
    echo "examples : $PRONAME js-msg_key.xml rbpComponents.js  Just insert new message keys to js-msg-keys.xml. obsolete keys will be kept"
    echo "           $PRONAME -d js-msg-keps.xml rbpConst.js   delete all the keys first then insert. obsolete keys will be removed"
    exit 0
}
set +x
for parm in $*;
do
    case $parm in
    -d|--delete) DOPTION="-d";;
    -h|--help) info;;
    *) 
    if [ -z "$XMLFILE" ];then
         XMLFILE="$parm"
    elif [ -z "$JSFILES" ];then
        JSFILES="$parm"
    else
        JSFILES+=" $parm"
    fi
    ;;
    esac
done
if [ -z "$XMLFILE" ];then
    echo "js-msg-keys.xml file is missing"
    usage
elif [ -z "$JSFILES" ];then
    echo "js files are missing"
    usage
fi
OUT="`basename $XMLFILE`.out"
set +x
#function to work out path of UI component
get_path(){
    path=`dirname $1`
    filename=`basename $1`
    path=`cd $path;pwd`
    path=${path##[a-zA-Z/]*web}
    path=${path##/ui}
    echo "/ui$path/$filename"
}
#get_path $*
#function to update js-msg-keys.xml
update_msg_keys(){
    awk '
    BEGIN{
        in_tag_body = 0
        fld_entry_found = 0
        file_entry_found = 0
    }
    {
        if(match($0,current_file)){
            in_tag_body = 1
            file_entry_found = 1
        }
        if(in_tag_body == 1 && match($0,current_fld))
            fld_entry_found = 1
        #file not found so create new file entry <jsfile src=xx>
        if(match($0,"</jsmsgkeys>") && file_entry_found == 0){
            printf("  <jsfile src=\"%s\">\n",current_file)
            printf("    <key>%s</key>\n",current_fld)
            printf("  </jsfile>\n")
            print $0
        }else if(in_tag_body == 1 && fld_entry_found == 0 && match($0,"</jsfile>")){
            in_tag_body = 0;
            printf("    <key>%s</key>\n",current_fld)
            print
        }else{
            print 
        }
    }
    ' "current_file=$1" "current_fld=$2" "$3" 
}
#update_msg_keys $*
#delete all the entries enclosed by the file found
delete_msg_keys(){
    awk '
    BEGIN{
        in_tag_body=0
    }
    {
        if(match($0,file_entry)){
            in_tag_body=1
        }else if(in_tag_body ==1 && match($0,"</jsfile>")){
            in_tag_body=0
        }
        if(match($0,file_entry) || in_tag_body==0)
            print
    }
    ' "file_entry=$1" "$2"
}
#delete_msg_keys $*
#stripe jsSFMessage. before message key
strip_prefix(){
    str=$1
    str=${str##jsSFMessages.}
    echo "$str"
}
#strip_prefix jsSFMessages.COMMON_All
#update_msg_keys /ui/rbp/Xomponents.js COMMON_RBP_LBL_FILTER_TIP $XMLFILE
#get files to be processed (support file globbing)
for fn in `ls $JSFILES`
do
        if [ -f $fn ]; then
                echo "process file $fn"
                file_entry="`get_path $fn`"
#dump all the entries enclosed by file entry found first if -d|--delete option existing
                if [ -n "$DOPTION" ]; then
                    echo "deleting $file_entry entry from $XMLFILE first"
                    delete_msg_keys $file_entry $XMLFILE > "$OUT"
                    mv $OUT $XMLFILE
                fi
#end dump process
                flds=`grep -o "jsSFMessages\.[1-9a-zA-Z_]*" $fn`
                fld_count=`echo $flds|wc -l`
                if [ $fld_count -gt 0 ]; then
                    for fld in `echo "$flds" | sort | uniq`
                    do
                        msg_key=`strip_prefix $fld`
                        update_msg_keys $file_entry $msg_key $XMLFILE > "$OUT"
                        mv $OUT $XMLFILE
                    done
                fi
        fi
done
