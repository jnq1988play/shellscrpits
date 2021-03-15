#!/bin/bash
backhost=10.0.0.31  ###设置保存文件的目标主机ip
tarname=shells_`date +"%Y-%m-%d"` ###设置tar文件名 根据时间生产
BACKUPPATH=/shell/ ###数据源地址
cd $BACKUPPATH ###跳转至源地址
tar cvPf "$tarname".tar.gz $BACKUPPATH* ###打包数据并以生成时间命名
rsync -avz $BACKUPPATH*.tar.gz $backhost:/backup  ###rsync增量备份至目标主机位置
ssh root@$backhost "ls -al | grep *.tar.gz;if [ $? -eq 0 ] ;then echo backup complate ;fi" ###判断目标主机是否已经接受压缩文件
if [ $? -eq 0 ] ###如果压缩完成则删除本地生成的压缩文件的
then
	rm -rf /$BACKUPPATH/*.tar.gz
fi
