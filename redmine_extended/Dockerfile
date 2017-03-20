FROM redmine:3.3.2

MAINTAINER "Swedish Natural History Museum, BIO-unit" <inkimar@gmail.com>

RUN apt-get update -q && apt-get install unzip

WORKDIR /usr/src/redmine

#mail-configuration
COPY config/configuration.yml config

# THEMES
COPY themes/v0.1.tar.gz public/themes
COPY themes/v0.2.tar.gz public/themes
COPY themes/master.zip  public/themes

RUN tar xf public/themes/v0.1.tar.gz -C public/themes/
RUN tar xf public/themes/v0.2.tar.gz -C public/themes/
RUN unzip  public/themes/master.zip  -d public/themes/

#PLUGINS
COPY plugins/redmine_agile-1_4_2-light.zip plugins
RUN unzip  plugins/redmine_agile-1_4_2-light.zip  -d plugins

#COPY plugins/v1.0.6.tar.gz plugins
#RUN tar xf plugins/v1.0.6.tar.gz -C plugins

# work-in-progress : necessary to get the plugins working
COPY plugins/post-install.sh plugins
RUN chmod 755 plugins/post-install.sh
