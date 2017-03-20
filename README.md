# docker_redmine

This project is based on the version 3.3.2.stable.<p>
It has 3 additional themes + 1 agile-plugin.<p>

NB-1: if you would like to export your redmine-databas from an earlier version to this on, put the sql-file in the redminedb-init.d-directory before you do the 'make' <p>

NB-1.1: if you would like to user the dina-mailserver, you must set the email-credentials in the file redmine_extended/config/configuration.yml before you run 'make build' <p>

NB-2: run the project in this order 
1. make build
2. make up
3. make post-install (to get the agile-plugin to work)

Summary v0.1 : 
*only 2 containers

V0.2 : add dns, ngnx ++

## redmine
* based on official redmine version 3.3.2
* https://hub.docker.com/_/redmine/

### themes
* number of themes : 3
* see the fetch_themes_and_plugins.sh

### plugins
* number of plugins : 1
* see the fetch_themes_and_plugins.sh

## mariadb
* based on official maridab  version 10.1.
* https://hub.docker.com/_/mariadb/
