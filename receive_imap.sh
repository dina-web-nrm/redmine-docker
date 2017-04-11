#!/bin/bash
source .env
rake -f /usr/src/redmine/Rakefile redmine:email:receive_imap RAILS_ENV=production host=imap.gmail.com port=993 ssl=1 username=$user password=$psw project=myproject tracker=Support
