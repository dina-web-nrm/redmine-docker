#!make
include .env

PWD = $(shell pwd)
DOCKERHUB_VER=v0.3

all: up

up: 
	@docker-compose up -d

down:
	@echo "be careful if you want to run 'docker-compose down' "

ps:
	@docker-compose  ps

fetch:
	./fetch_themes_and_plugins.sh

#post-install, final step to get the agile plugin working.
post-install: 
	docker exec redmine_server bash -c '/usr/src/redmine/plugins/post-install.sh'

build: 
	./fetch_themes_and_plugins.sh
	@docker build -t dina/redmine:${DOCKERHUB_VER} redmine_extended

release:
	docker push dina/redmine:${DOCKERHUB_VER}

test-ping:
	@echo "checking to see if the mailserver is present"
	@docker exec -it redmine_server bash -c 'ping mail.dina-web.net'

test-db:
	@echo "\ncheck the number of users"
	@docker exec -it redmine_database sh -c "mysql -u $(user) -p$(psw) -D$(database) -e 'select count(*) from users;'"

test-web:
	xdg-open https://support-test.dina-web.net

#check the connection to mailserver, openssl
test-openssl:
	@docker exec -it redminedocker_redmine_1 bash -c 'openssl s_client -connect mail.dina-web.net:993'

logs:
	docker-compose logs -f
