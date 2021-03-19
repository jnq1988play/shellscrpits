#!/bin/bash
Used=$(uptime |awk '{print $(NF-2)}' | sed 's/,//g')
UNum=$(echo $Used*100 | bc | sed "s/\..*//g")
Cpunum=$(grep 'model name' /proc/cpuinfo | wc -l)
CNum=$(echo $Cpunum*100-50 | bc | sed "s/\..*//g")
i=1
while [ $i -le 5 ]
do
if [ $UNum -ge $CNum ]
then
    echo "CPU负载过高" #|#mail -s "CPU负载过高"  XXXXXXXXXX@XXX.com
else
    echo "it's ok"
fi
let i++
sleep 5s
done

