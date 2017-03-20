#!make

PWD = $(shell pwd)

all: up

up: build
	@docker-compose up -d

down:
	@docker-compose down

fetch:
	./fetch_themes_and_plugins.sh

post-install:
	docker exec redmine_inki bash -c '/usr/src/redmine/plugins/post-install.sh'

build: 
	./fetch_themes_and_plugins.sh
	@docker build --tag=ink/redmine redmine_extended

test:
	#xdg-open http://127.0.0.1:10095
	xdg-open http://support.dina-web.net
