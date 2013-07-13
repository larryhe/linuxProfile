#!/bin/sh
SUBJECT="IP of test server changed"
ADMIN="lerryhe@gmail.com"
IPFILE="/tmp/.hostip"
DEBUG_FILE="/tmp/.debug"
IPADDR=`ifconfig eth4 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'`
echo "$IPADDR" >> "$DEBUG_FILE"
if [ -f "$IPFILE" ];then
    echo "file existed and will check if IP of host changed"
    RESULT=`grep $IPADDR $IPFILE`
    echo "result: $RESULT" >> "$DEBUG_FILE"
    if [ -z "$RESULT" ];then
        echo "IP of host changed, send email to notify administrator"
        echo "IP: $IPADDR" > "$IPFILE"
        echo "IP: $IPADDR" > "$DEBUG_FILE"
        mail -s "$SUBJECT" "$ADMIN" < "$IPFILE"
    fi
else
    echo "IP: $IPADDR" > "$IPFILE"
fi
exit 0

