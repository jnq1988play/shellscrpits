#!/bin/bash
funcpu(){
uptime |awk '{print $(NF-2)}' | sed 's/,//g'
}
funmem(){
free -m | awk '/Mem:/ {print int($3/($3+$4)*100)}'
}
fundisk(){
df | grep /$ |awk '{print $5}'|sed s/\%//g
}
Used=$(uptime |awk '{print $(NF-2)}' | sed 's/,//g')
UNum=$(echo $Used*100 | bc | sed "s/\..*//g")
Cpunum=$(grep 'model name' /proc/cpuinfo | wc -l)
CNum=$(echo $Cpunum*100-50 | bc | sed "s/\..*//g")
funCpu=$(funcpu)
funMem=$(funmem)
funDisk=$(fundisk)
if [ $UNum -ge $CNum ]
then
    echo "CPU使用率为:"$funCpu 
    echo "CPU负载过高" | mail -s "CPU负载过高" XXXXXXXXXXXXX@XXX.XXXX
else
    echo "CPU it's fine"
fi
if [ $funMem -ge 85 ]
then
    echo "内存使用率为:"$funMem%
    echo "可用内存低" | mail -s "可用内存低" XXXXXXXXXXXXXX@XXX.XXX
else
    echo "Memory also fine"
fi
if [ $funDisk -ge 90 ]
then
    echo "磁盘使用率为:"$funDisk%
    echo "可用磁盘低" | mail -s "可用磁盘低" XXXXXXXXXXX@XXX.XXX
else
    echo "Dist still fine"
fi
