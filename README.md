# Dockerized Redmine with themes and plugins

<!-- [![AGPLv3 License](http://img.shields.io/badge/license-AGPLv3-blue.svg)](LICENSE) -->

- This project is based on the docker redmine version 3.3.2 (http://www.redmine.org/projects/redmine/wiki/Download)
- **Additional** 3 themes + 1 agile-plugin (agile-light) 

##  How to Import a database
if you would like to export your redmine-databas from an earlier version:

1. run  ``` mysqldump -u root -p<secret> redmine > redmine_<date>.sql ```
2. copy the ``` redmine_<date>.sql ``` to the redminedb-init.d-directory
3. ``` make ```
4. **NB** before running 4.1 make sure you ```cp .env.template .env``` and update the credentials
4.1 verify by running ```make test-db``` which runs ```select count(*) from users```

## How to configure the settings for an email-server
**2023-03-30**  - the mailserver `mail.dina-web.net` is **not** running anymore , if you would like alerts, then config!

### If you would like to use a mailserver for sending alerts
1. copy the configuration.yml.example file to configuration.yml

```
cp ~/redmine-mail_config/configuration.yml.example to ~/redmine-mail_config/configuration.yml 
```
2. Then enter the email-credentials in the  file ~/redmine-mail_config/configuration.yml with 4 entries<p>
```
 # email_delivery:
      delivery_method: :smtp
      smtp_settings:
        enable_starttls_auto: true
        address: <your email server>
        port: 587
        domain: <your email server>
        authentication: :plain
        user_name: <the email address that you will use to send alerts>
        password:  <password to the email-address above>
```
3. ``` make ```
4. check by logging in to the site -> go to 'administration' -> 'settings' -> 'Email notifications' -> check the settings ( Emission email address should point to a valid email)
 
## The Agile-plugin, you must run the  'post-script'-recipe
This 'recipe' logs into the redmine-container and runs a bash-script -be sure that you have the correct container name for 'redmine' before running it
```
make post-install
```

## In Development

**special file : docker-compose.dev.yml** <p>
```
'make up-dev'
```

* redmine 
* mariadb 
* dnsmasq
    * for developement convenience purposes
* proxy
    * you puth your *.crt and *.key file in the 'nginx-proxy-certs'-directory

## In Production

**special file : docker-compose.prod.yml** <p>
```
'make up-prod'
```

* redmine 
* mariadb 

##  Backup and restoring a backup.
Date: 2017-07-20
### backup
Today the Redmine-service is running on a machine at Digitalocean (https://www.digitalocean.com/)
Backup is stored on the 'biobackup'-machine, maintained by NRM it-department.
The backup script is 'backup-to-isit.sh', it is ran by cron ( owned by root ).
```
> crontab -l
30 13 * * * cd /root/repos/redmine-docker && ./backup-to-isit.sh
```
The *files* are backed-up and the *databasedump*, these files are 'tarred' and the filename has a datestamp.

The backup-to-isit.sh has the following dependencies.

* .env-file with environement-varibles for the redmine-database
* configuration of the file /root/.ssh/config ( ip-address for biobackup + user on biobackup and the private-key)
* access to the biobackup-machine has to be granted to be able to perform an 'secure copy' (scp)




### restoring a backup
Do the following steps before performing 'make up'

1. put the *databasedump* in the  'redminedb-init.d'-directory
2. put the *files* in the 'redmine-files-directory

## Components

### redmine
* based on official redmine version 3.3.2
* https://hub.docker.com/_/redmine/

### mariadb
* based on official maridab  version 10.1.
* https://hub.docker.com/_/mariadb/



## Themes and plugins
### themes
* number of themes : 3
* see the fetch_themes_and_plugins.sh

### plugins
* number of plugins : 1
* see the fetch_themes_and_plugins.sh

## mail-harvesting , how to create a couple between an email-address and a project

**NB 1:** before using cron test the `receive_imap.sh` manually
**NB 2:** cron-daemon is not started automatically in the redmine-docker container.

* /etc/init.d/cron status
* /etc/init.d/cron start
* /etc/init.d/cron stop

`$ crontab -l` <p>
`* * * * * /bin/bash -l -c '/usr/src/redmine/mail-script/receive_imap.sh'`

### the harvesting-script and  the .env-file
* /usr/src/redmine/mail-script/receive_imap.sh
* /usr/src/redmine/mail-script/.env

**NB 2:for test** This cron-job runs once a minute.

coupling between an email-address and a project is done in the file /usr/src/redmine/mail-script/receive_imap.sh

**NB 3:for test** The 'harvesting'-script creates a log file ( not necessary)

# Configurating SSL

## Development: Certificates and setting up SSL in 
Put the certification, crt- and key-file,  in the local 'nginx-proxy-certs'-directory 

## Production: Certificates and setting up SSL in development
An external proxy (e.g DINA-Web/proxy-docker)
Put the certification, crt- and key-file,  in the approriate directory

## Gotchas

### For testing locally:
1. remember to add `support.dina-web.net` to your /etc/hosts file...
2. if you are using a locally deployed mail-server (https://github.com/DINA-Web/mail-docker) add `mail.dina-web.net` to your /etc/hosts file...

### redmine harvesting mail and creating issues:
1. when sending mails that becomes issue in project x , remember that the mail must be sent from an account that is a registered user in the current redmine-project (in the `support.dina-web.net`-system)
2. obs. the receive_imap.sh must use the port 993
3. **NB** if you read the incoming mail in i.e. thunderbird then redmine will not read and create an issue from that incoming email
