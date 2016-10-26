#!/bin/bash
# Program
#    use mysqldump to Fully backup mysql data per week!
# 	 and Delete old Backup 
# Path
BakDir=/data/mysql/backup
LogFile=/data/mysql/backup/bak.log
Date=`date +%Y%m%d`
Begin=`date +"%Y年%m月%d日 %H:%M:%S"`
MYSQLDUMP="/usr/local/mysql/bin/mysqldump"
DBUSER="root"
DBPASSWD="Baipeng2016"
DBNAME="mediaman messagecenter usercenter weiphp"


DumpFile=$Date.sql
GZDumpFile=$Date.sql.tgz

cd $BakDir

# $MYSQLDUMP -h 127.0.0.1 -u $DBUSER -p$DBPASSWD --quick --all-databases --flush-logs --delete-master-logs --single-transaction > $DumpFile
$MYSQLDUMP -h 127.0.0.1 -u$DBUSER -p$DBPASSWD --quick --flush-logs --delete-master-logs --single-transaction --databases $DBNAME> $DumpFile
tar czf $GZDumpFile $DumpFile
rm $DumpFile
Last=`date +"%Y年%m月%d日 %H:%M:%S"`
echo 开始:$Begin 结束:$Last $GZDumpFile succ >> $LogFile
find $BakDir -name "*.sql.tgz" -type f -mtime +30 -exec rm {} \; > /dev/null 2>&1
#cd $BakDir/daily
#rm -f *