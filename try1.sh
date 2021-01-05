#!/bin/bash

cmd=$(timedatectl list-timezones | tr "\n" "!")

dat=$(date '+%Y-%m-%d %H:%M:%S')

r=$(yad --title="Time" --form --separator=" " --field="System Time:RO" --field="Time Zone:CBE" --field="Date:TM" --field="Synchronize with NTP:CHK" "$dat" "$cmd" "$dat")

tz=$(echo $r | awk '{print $3}')
dt1=$(echo $r | awk '{print $4}')
dt2=$(echo $r | awk '{print $5}')
dt=$(echo $dt1 $dt2)
ntp=$(echo $r | awk '{print $6}')

timedatectl set-timezone $tz 

date -s "$dt"

case $ntp in
   TRUE*) cmd="systemctl start ntp" ;;
   FALSE*) cmd="systemctl stop ntp" ;;
esac

eval exec $cmd


