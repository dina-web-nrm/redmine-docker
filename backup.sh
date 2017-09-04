#!/bin/bash
source .env/.env.db

NOW=`date +"%Y-%m-%d"`

TARGET=backup-daily
TARGET_DIR=$TARGET/$NOW

if [ -d $TARGET_DIR ] 
then
    echo "Directory exists." 
else
    echo "Creates directory $TARGET_DIR "
    mkdir -p $TARGET_DIR
fi

#test -d $TARGET_DIR | mkdir $TARGET_DIR

docker exec -it mariadb_redmine sh -c "mysqldump -u $user -p$psw $db > /tmp/redmine_$NOW.sql"
docker cp mariadb_redmine:/tmp/redmine_$NOW.sql $TARGET_DIR

# tar the redmine-files
tar -zcvf $TARGET_DIR/redmine-files_$NOW.tar.gz redmine-files

# tar the redmine-files&sql-dump
tar -zcvf $TARGET/backup_$NOW.tar.gz $TARGET/$NOW

# sudo apt-get install gnupg2
echo "encrypting the tar-file"
gpg2 --yes --batch --passphrase-file ./.env/.passfile -c  $TARGET/backup_$NOW.tar.gz

# TODO
##secure copy , scp, backup_$NOW.tar.gz

