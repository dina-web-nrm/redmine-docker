# Dockerized Redmine with themes and plugins

[![AGPLv3 License](http://img.shields.io/badge/license-AGPLv3-blue.svg)](LICENSE)

This project is based on the docker redmine version 3.3.2 (http://www.redmine.org/projects/redmine/wiki/Download) <p>
**Additional** 3 themes + 1 agile-plugin (agile-light) <p>

**NB-1: How to Import a database** <p>
if you would like to export your redmine-databas from an earlier version to this on, put the sql-file in the redminedb-init.d-directory before you do: <p>
```
make 
```

**NB-2: How to configure the setting for the email-server** <p> 
If you would like to use a mailserver.<p>
1. copy the configuration.yml.example file to configuration.yml

```
cp ~/redmine-mail_config/configuration.yml.example to ~/redmine-mail_config/configuration.yml 
```
2. Then edit the email-credentials in the  file ~/redmine-mail_config/configuration.yml <p>


**NB-3: How to install the Agile-plugin, need to run a 'post-script'** <p>
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

**special file : docker-compose.prod.yml ** <p>
```
'make up-prod'
```

* redmine 
* mariadb 

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

# Configurating SSL

## Development: Certificates and setting up SSL in 
Put the certification, crt- and key-file,  in the 'nginx-proxy-certs'-directory 

## Production: Certificates and setting up SSL in development
An external proxy (e.g DINA-Web/proxy-docker)
Put the certification, crt- and key-file,  in the approriate directory

## Gotcha

For testing locally, remember to add `support.dina-web.net` to your /etc/hosts file...