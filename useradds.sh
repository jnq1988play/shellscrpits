#!/bin/bash
read -p "输入用户名:" UserName ####设置用户变量
read -s -p "输入密码:" Passwd ####设置密码变量
useradd -m -s /bin/bash $UserName ####创建用户
echo $Passwd | passwd --stdin $UserName ####指定密码
echo "用户已创建完成" ####打印信息
chage -d 0 $UserName  #### 设置密码失效时间为0,强制登陆时修改密码
