#!/bin/bash
funMenu(){
cat <<EOF
___________________________________
##############菜单#################
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
1.创建用户
2.批量创建用户
3.删除用户
4.用户组管理
5.用户管理
6.退出
___________________________________
###################################
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
EOF
}
funaddUser(){
    read -p "输入用户名:" UserName
    Passwd=`echo $RANDOM |md5sum |cut -c 8-15`
    useradd -m -s /bin/bash $UserName
    chage -d 1 $UserName
    echo $UserName:$Passwd >>/root/UserPass.txt
    grep ^$UserName /etc/passwd
    if [ $? -eq 0 ]
      then
        echo 用户创建完成
      else
        echo nothing hanpend
   fi
}
funaddUsers(){
     read -p "创建用户数量:" num
     read -p "请输入用户名:" name
     for i in `seq $num`
     do
         UserName=$name$i
         Passwd=`echo $RANDOM |md5sum |cut -c 8-15`
         useradd -m -s /bin/bash $UserName
         echo $Passwd | passwd --stdin $UserName
         echo "用户已创建完成" 
         chage -d 1 $UserName
         echo $UserName:$Passwd >>/root/UserPass.txt
         echo $UserName:$Passwd >>/home/$UserName/Passwd.txt
         done
}

funDeluser(){
    grep /bin/bash$ /etc/passwd |sort -n
   # while true
   #   do
    read -p "请输入要删除的用户:" DelUser
    grep ^$DelUser /etc/passwd | grep /bin/bash$
    if [ $? -eq 0 ]
      then
        userdel -r $DelUser
        echo  用户已删除
    fi
   # done
}
funGroup(){
cat <<EOF
___________________________________
##############菜单#################
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
1.添加用户组
2.删除用户组
3.用户组添加用户
4.用户组删除用户
5.返回
___________________________________
###################################
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
EOF
}
funGMenu(){
                         while true
                            do
                            read -p "请输入要执行的操作:" Gmenu
                            case $Gmenu in
                              1)echo 添加用户组
                              read -p "请输入用户组名:" Gname
                              groupadd $Gname
                              funGroup
                              continue
                              ;;
                              2)echo 删除用户组
                              egrep [1-9][0-9][0-9][0-9] /etc/group
                              read -p "请输入要删除的用户组:" Dgroup
                              groupdel $Dgroup
                              funGroup
                              continue
                              ;;
                              3)echo 添加用户至用户组
                              read -p "请输入要加入组的用户:" Uname
                              read -p "请输入要加入的组:" Ugroup
                              usermod -a -G $Ugroup $Uname
                              funGroup
                              continue
                              ;;
                              4)echo 移除用户从用户组
                              read -p "请输入要移除的用户:" RUser
                              read -p "请输入移除用户的组:" Rgroup
                              gpasswd -d $RUser $Rgroup
                              funGroup
                              continue
                              ;;
                              q|quit|exit|5)echo 返回
                              break
                              ;;
                            esac
                         done
}
while true
  do
    funMenu
    read -p "请输入要执行的功能:" Num
      case $Num in
                  1)echo 创建用户
                         funaddUser
                         continue
                  ;;
                  2)echo 批量创建用户
                         funaddUsers
                         continue
                  ;;
                  3)echo 删除用户
                         funDeluser
                         continue
                  ;;
                  4)funGroup
                    funGMenu
                  ;;
                  5)echo 用户管理
                  ;;
                  q|quit|Quit|exit|6)echo 退出
                         exit
                  ;;
esac
done
