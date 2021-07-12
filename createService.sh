#!/bin/ env bash
funMenu(){
	cat <<EOF
___________________________________
##############菜单#################
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
1.DHCP服务
2.NFS服务
3.FTP服务
4.SAMBA服务
5.DNS服务
6.Rsync服务
7.MySQL服务
8.Keepalive服务
9.NTP服务
10.Squit服务
11.Postfix服务
12.搭建所有服务
13.退出
___________________________________
###################################
‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
EOF
}
funDHCP(){
	insornot=`dpkg --get-selections | grep isc-dhcp-server |awk -F" " '{print $2}'`
	if [ $insornot = install ]
	then
		echo dhcp 服务已安装显示配置信息
		cat /etc/default/isc-dhcp-server |grep ^INTERFACES
		cat /etc/dhcp/dhcpd.conf | sed -n '52,62p'
	else
		echo dhcp服务未安装,开始安装
		apt-get install isc-dhcp-server -y
	        if [ $? -eq 0 ]
	           then
		       echo DHCP服务安装完成
		       interF=`ifconfig | sed -n '1p' |awk -F: '{print $1}'`
		       ipaddr=`ifconfig |grep inet |awk -F" " '{print $2}'|sed -n '1p'`
		       echo 网卡名:$interF
		       echo 本机IP:$ipaddr
                       sed -i s/INTERFACESv4=\"\"/INTERFACESv4=$interF/g /etc/default/isc-dhcp-server
		       sed -i '63a subnet 10.0.0.0 netmask 255.255.255.0 {\nrange 10.0.0.2 10.0.0.200;\noption subnet-mask 255.255.255.0;\noption routers 10.0.0.1;\noption broadcast-address 10.0.0.255;\ndefaault-lease-time 600;\nmax-lease-time 7200;\n}' /etc/dhcp/dhcpd.conf 
		       cat /etc/default/isc-dhcp-server |grep ^INTERFACES
		       cat /etc/dhcp/dhcpd.conf | sed -n '52,62p'
                fi
fi
}
while true
do
funMenu
read -p "请输入要搭建的服务:" Num
  case $Num in
	  1)echo DHCP服务
          funDHCP
          ;;
	  2)echo NFS服务
          ;;
	  3)echo FTP服务
          ;;
	  4)echo SAMBA服务
          ;;
	  5)echo DNS服务
          ;;
	  6)echo Rsync服务
          ;;
	  7)echo MySQL服务
          ;;
	  8)echo Keepalive服务
          ;;
	  9)echo NTP服务
          ;;
	  10)echo Squit服务
          ;;
	  11)echo Postfix服务
          ;;
	  12)echo 搭建所有服务
          ;;
          q|quit|Quit|exit|13)echo 退出
	  exit
esac
done
