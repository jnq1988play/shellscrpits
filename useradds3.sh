#!/bin/bash
read -p "创建用户数量:" num
for i in `seq $num`
do
UserName=User$i
Passwd=`echo $RANDOM |md5sum |cut -c 8-15`
useradd -m -s /bin/bash $UserName ####创建用户
echo $Passwd | passwd --stdin $UserName ####指定密码
echo "用户已创建完成" ####打印信息
chage -d 1 $UserName  #### 设置密码失效时间为1,强制登陆时修改密码
echo $UserName:$Passwd >>/root/UserPass.txt ####追加用户密码信息到root目录下
echo $UserName:$Passwd >>/home/$UserName/Passwd.txt ####追加用户名信息到用户家目录下
done 
