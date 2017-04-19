#!/bin/bash
source /usr/src/redmine/mail-script/.env
echo "Mail, create a task $(date)"   >>/tmp/cron-mail.log 2>&1 
echo "Mail, echoes the path again  =  $PATH"   >>/tmp/cron-path.log 2>&1 
rake -f /usr/src/redmine/Rakefile redmine:email:receive_imap RAILS_ENV=production host=imap.gmail.com port=993 ssl=1 username=inki.dummy@gmail.com password=ingimarnrm project=myproject tracker=Support --trace >> /tmp/cron-mail.log 2>&1
