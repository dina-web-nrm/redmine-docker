#!/bin/bash
source /usr/src/redmine/mail-script/.env
echo "Mail 25april klockan 14:52, create a task $(date)"   >>/tmp/cron-mail.log 2>&1 
/usr/local/bin/bundle exec /usr/local/bundle/bin/rake -f /usr/src/redmine/Rakefile redmine:email:receive_imap RAILS_ENV=production host=imap.gmail.com port=993 ssl=1 username=$user password=$psw project=myproject tracker=Support --trace >> /tmp/cron-mail.log 2>&1
