#!/bin/bash
read -p "请输入要监控的文件路径:" FilePath
#read -p "请输入监控记录的保存路径:" logPath
inotifywait -m -r --timefmt '%d/%m/%y/%H:%M' --format '%T %w %f %e' -e modify,delete,create,access,,open,attrib $FilePath -o /var/log/iontify.log &


