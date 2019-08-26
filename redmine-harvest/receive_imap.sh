#!/bin/bash
source /usr/src/redmine/mail-script/.env
echo "starting"
echo "Polling for mail fetched $(date)" >>/tmp/cron-mail.log 2>&1 
cd /root && bundle exec rake -f /usr/src/redmine/Rakefile redmine:email:receive_imap RAILS_ENV=production host=$host port=993 ssl=1 username=$user password=$psw project=Myproject tracker=Support --trace >> /tmp/cron-mail.log 2>&1
#echo "ending $user and $psw"
