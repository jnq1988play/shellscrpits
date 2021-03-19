#!/bin/bash
Dused=`df | grep /$ |awk '{print $5}'|sed s/\%//g`
if [ $Dused -gt 90 ]
then
    echo 磁盘使用率达到90 ##| mail -s "磁盘使用率达到90以上" XXXXXXXXXXXXX@XXX.com
else 
    echo "it's ok"
fi
