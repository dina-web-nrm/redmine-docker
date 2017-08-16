#!make

PWD = $(shell pwd)
DOCKERHUB_VER=v0.3

all: up-dev

up-dev: 
	@docker-compose -f docker-compose.dev.yml up -d

up-prod:
	@docker-compose -f docker-compose.prod.yml up -d

down-dev:
	@docker-compose -f docker-compose.dev.yml down

ps-dev:
	@docker-compose -f docker-compose.dev.yml ps

fetch:
	./fetch_themes_and_plugins.sh

#post-install, final step to get the agile plugin working.
post-install: 
	docker exec dina_redmine bash -c '/usr/src/redmine/plugins/post-install.sh'

build: 
	./fetch_themes_and_plugins.sh
	@docker build -t dina/redmine:${DOCKERHUB_VER} redmine_extended

release:
	docker push dina/redmine:${DOCKERHUB_VER}

test-ping:
	@echo "checking to see if the mailserver is present"
	@docker exec -it dina_redmine bash -c 'ping mail.dina-web.net'

test-web:
	xdg-open https://support.dina-web.net

#check the connection to mailserver, openssl
test-openssl:
	@docker exec -it dina_redmine bash -c 'openssl s_client -connect mail.dina-web.net:993'

logs-dev:
	docker-compose -f docker-compose.dev.yml logs -f
