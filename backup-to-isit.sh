#!/bin/bash
source .env

NOW=`date +"%Y-%m-%d"`

TARGET=backup-daily
TARGET_DIR=$TARGET/$NOW
echo "$NOW" >> backup-logs/biobackup.log
if [ -d $TARGET_DIR ] 
then
    echo "Directory exists." >> backup-logs/biobackup.log
else
    echo "Creates directory $TARGET_DIR " >> backup-logs/biobackup.log
    mkdir -p $TARGET_DIR
fi

docker exec redmine_database sh -c "mysqldump -u $user -p$psw $database > /tmp/redmine_$NOW.sql"
docker cp redmine_database:/tmp/redmine_$NOW.sql $TARGET_DIR

# tar the redmine-files
tar -zcvf $TARGET_DIR/redmine-files_$NOW.tar.gz redmine-files

# tar the redmine-files&sql-dump
tar -zcvf $TARGET/backup_$NOW.tar.gz $TARGET/$NOW
THISHOST=$(hostname)
#IA_ID=backup_${THISHOST}_$NOW
sleep 2

# uploading to biobackup
scp $TARGET/backup_$NOW.tar.gz biobackup:/backup/DINA-redmine
echo "uploaded '$TARGET/backup_$NOW.tar.gz.gpg' to biobackup " >> backup-logs/biobackup.log
