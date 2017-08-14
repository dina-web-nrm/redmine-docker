#!/bin/bash
source /usr/src/redmine/mail-script/.env
echo "starting"
cd /root && bundle exec rake -f /usr/src/redmine/Rakefile redmine:email:receive_imap RAILS_ENV=production host=$host port=993 ssl=1 username=$user password=$psw project=myproject tracker=Support --trace  --trace
#echo "ending $user and $psw"
