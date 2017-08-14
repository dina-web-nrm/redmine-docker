**describing the files in this directory**

* copy .env.template to .env
* update the credentials in the .env-file (user=emailaddress and psw=secretpassword)

* The .env-file is used by the script 'receive_imap.sh'.
* the script 'receive_imap.sh' links the emailaddress to a redmine-project ( make sure it is present)
* make sure that the port is 993 in the file 'receive_imap.sh'

