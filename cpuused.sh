#!/bin/bash
Used=$(uptime |awk '{print $(NF-2})' | sed 's/,//g')
#um=$(grep 'model name' /proc/cpuinfo | wc -l)
i=1
while [ $i -le 5 ]
do
if [ $Used -ge 2 ]
then
    echo "CPU负载过高"|mail -s "CPU负载过高"  XXXXXXXXXX@XXX.com
fi
let i++
sleep 5s
done

