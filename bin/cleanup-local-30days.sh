#!/bin/bash
find /root/repos/redmine-docker/backup-daily -type f -mtime +5 -exec rm -f {} \;
