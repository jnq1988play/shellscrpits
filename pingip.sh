#!/bin/bash
read -p "请输入要ping的网段(例:192.168.1):" num
for i in {2..253}
  do
  ip=$num.$i
  {
   count=1
   while [ $count -le 3 ]
   do
    ping -c 1 $ip &>/dev/null
    if [ $? -eq 0 ]
    then
        echo $ip ping成功
    fi
    let count++
done
}&
done

