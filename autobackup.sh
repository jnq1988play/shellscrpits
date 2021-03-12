#!/bin/bash
backhost=10.0.0.31
tarname=shells_`date +"%Y-%m-%d"`
BACKUPPATH=/shell/
cd $BACKUPPATH
tar cvPf "$tarname".tar.gz $BACKUPPATH*
rsync -avz $BACKUPPATH*.tar.gz $backhost:/backup
ssh root@10.0.0.31 "ls -al | grep *.tar.gz;if [ $? -eq 0 ] ;then echo backup complate ;fi"
if [ $? -eq 0 ]
then
	rm -rf /$BACKUPPATH/*.tar.gz
fi
