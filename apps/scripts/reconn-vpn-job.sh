#!/bin/sh
#make sure if vpnc is active
VPNC_LOCK="/tmp/vpnc_hangup"
export DISPLAY=:0.0
vpn=`ps -e|grep vpnc-connect -o`
if [ -z "$vpn" ]; then 
    if [ -d "${VPNC_LOCK}" ]; then
        /usr/bin/notify-send "vpnc disconnection mode is on, reconnect 5 minutes later"
        exit
    fi
    /usr/bin/notify-send "vpnc disconnected, start connecting..."
    echo "p@ssw0rd"|sudo -S vpnc-connect --enable-1des
else
/usr/bin/notify-send "vpnc-connect is active"
fi
