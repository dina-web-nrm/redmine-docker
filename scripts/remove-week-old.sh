#!/bin/bash

TARGET=../backup-daily
FILE_PREFIX=backup_
FILE_SUFFIX=.tar.gz
WEEK_AGO_DATE=$(date +%Y-%m-%d -d "-7 days")

# delete directory
if [ -d $TARGET/$WEEK_AGO_DATE ]
   then
	rm -r $TARGET/$WEEK_AGO_DATE
   else 
	echo "Nothing to do, there is no directory yet"
fi

# delete tar-zip
if [ -f $TARGET/$FILE_PREFIX$WEEK_AGO_DATE$FILE_SUFFIX ]
   then 
	rm $TARGET/$FILE_PREFIX$WEEK_AGO_DATE$FILE_SUFFIX
   else
	echo "Nothing to do, there is no file yet"
fi
