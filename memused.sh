#!/bin/bash
Mem=$(free -m | awk '/Mem:/ {print int($3/($3+$4)*100)}')
if [ $Mem -ge 70 ]
then
    echo 内存使用率超过90% | mail -s "内存使用率超过90%" XXXXXXXXXXXX@XXX.com
else
    echo 内存占用正常
fi
    
