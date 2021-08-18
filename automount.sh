#!/usr/bin/env bash
##显示当前已挂载的磁盘
df -h |awk '{print $1}' | grep "/dev/sd"
##显示当前用户
userinfo=$(whoami)
##定义fdisk -l变量 查看当前系统磁盘信息
diskinfo=$(sudo fdisk -l | grep "^Disk /dev/sd*")
echo $diskinfo
##根据实际情况输入磁盘挂载点与要挂载磁盘的设备文件路径 
read -p "请输入要挂载的磁盘(例:/dev/sdb)：" tomount
read -p "请输入磁盘挂载点(输入绝对路径)：" diskpath
##创建磁盘挂载目录
mkdir $diskpath 
##查看磁盘创建信息
ls -dl $diskpath
##挂载磁盘
sudo mount -t ext4 $tomount $diskpath
##如果上一条挂载命令执行失败则删除创建的挂载目录
if [ $? -ne 0 ]
  then
    rm -rf $diskpath
fi
##打印挂载信息 验证是否成功 挂载成功返回磁盘已挂载
df -h | grep $tomount
if [ $? -eq 0 ]
  then
    echo $tomount 挂载完成
    sudo  chmod 777 $diskpath
    sudo chown -R $userinfo:$userinfo $diskpath
    ls -dl $diskpath
fi
 
