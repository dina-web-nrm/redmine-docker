#!make

PWD = $(shell pwd)
DOCKERHUB_VER=v0.1

all: up

up: 
	@docker-compose up -d

down:
	@docker-compose down

fetch:
	./fetch_themes_and_plugins.sh

post-install:
	docker exec redmine_inki bash -c '/usr/src/redmine/plugins/post-install.sh'

build: 
	./fetch_themes_and_plugins.sh
	@docker build -t dina/redmine:${DOCKERHUB_VER} redmine_extended

release:
	docker push dina/redmine:${DOCKERHUB_VER}

test:
	xdg-open https://support.dina-web.net
