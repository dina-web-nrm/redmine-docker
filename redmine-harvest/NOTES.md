**describing the files in this directory**

* copy .env.template to .env
* update the credentials in the .env-file (user=emailaddress and psw=secretpassword)

* The .env-file is used by the script 'receive_imap.sh'.
* the script 'receive_imap.sh' links the emailaddress to a redmine-project ( make sure it is present)
* make sure that the port is 993 in the file 'receive_imap.sh'
* don't read the mail in i.e thunderbird, if you do ... redmine will not read it and will not create an issue ....

* 20170814, working now with *.for_debugging_cron-script

