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
IA_ID=backup_${THISHOST}_$NOW
sleep 2
#echo "encrypting the tar-file"
#gpg2 --yes --batch --passphrase-file .passfile_backup -c  $TARGET/backup_$NOW.tar.gz &&
#/usr/local/bin/ia upload $IA_ID $TARGET/backup_$NOW.tar.gz.gpg --metadata="mediatype:texts" --retries 6
#echo "uploaded to IA on with identifier=$IA_ID" >> backup.log

# uploading to biobackup
#scp $TARGET/backup_$NOW.tar.gz.gpg biobackup:/backup/DINA-redmine
scp $TARGET/backup_$NOW.tar.gz biobackup:/backup/DINA-redmine
echo "uploaded '$TARGET/backup_$NOW.tar.gz.gpg' to biobackup " >> backup-logs/biobackup.log

