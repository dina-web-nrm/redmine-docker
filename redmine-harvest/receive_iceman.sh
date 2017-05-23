#!/bin/bash
source /usr/src/redmine/mail-script/.env
echo "Polling for mail fetched $(date)"   >>/tmp/cron-mail.log 2>&1 
cd /root && bundle exec rake -f /usr/src/redmine/Rakefile redmine:email:receive_imap RAILS_ENV=production host=mail.dina-web.net port=993 ssl=1 username=iceman@mail.dina-web.net password=I-c-i-n-g-I-n-k project=myproject tracker=Support --trace >> /tmp/cron-mail.log 2>&1
