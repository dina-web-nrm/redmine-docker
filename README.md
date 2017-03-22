# Dockerized Redmine with themes and plugins

[![AGPLv3 License](http://img.shields.io/badge/license-AGPLv3-blue.svg)](LICENSE)

This project is based on the docker redmine version 3.3.2 (http://www.redmine.org/projects/redmine/wiki/Download) <p>
**Additional** 3 themes + 1 agile-plugin (agile-light) <p>

**NB-1: Import a database** <p>
if you would like to export your redmine-databas from an earlier version to this on, put the sql-file in the redminedb-init.d-directory before you do: <p>
```
make 
```

**NB-2: configure the email-server** <p> 
If you would like to use the dina-mailserver or any other mailserver.
You must set your email-credentials in the file redmine_extended/config/configuration.yml before you run:<p>
```
make build
```

**NB-3: Agile-plugin fix** <p>
This 'recipe' logs into the redmine-container, be sure that you have the right container name for 'redmine' before running it
```
make post-install
```

## In Development

* redmine 
* mariadb 
* dnsmasq
    * for developement convenience purposes
* proxy
    * you puth your *.crt and *.key file in the 'nginx-proxy-certs'-directory

## In Production

You have to make some adjustment before going to production.
You have to edit the docker-compose.yml-file

* Remove the 'dnsmasq'-service from docker-compose.yml
* If Production already is running a proxy-service remove the 'proxy'-service from docker-compose.yml
    * remember to put your *.crt and *.key-file into the directory of the existing proxy

Your 'pruned' new **docker-compoose.yml** would look like this :

```
redmine:
    image: dina/redmine:v0.1
    environment:
      - VIRTUAL_HOST=support.dina-web.net
      - REDMINE_DB_MYSQL=mariadb_redmine
      - REDMINE_DB_PASSWORD=secr3t
    links:
      - mariadb:mariadb_redmine

  mariadb:
    image: mariadb:10.1
    environment:
      MYSQL_DATABASE: redmine
      MYSQL_ROOT_PASSWORD: secr3t
    volumes:
      - ./redminedb-init.d:/docker-entrypoint-initdb.d
```

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
