FROM redmine:3.3.2

MAINTAINER "Swedish Natural History Museum, BIO-unit" <inkimar at gmail.com>

RUN apt-get update -q && apt-get install unzip && apt-get install cron -y

WORKDIR /usr/src/redmine

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

RUN mkdir -p \
/usr/src/redmine/mail-script

#testing cron, fungerar
COPY cronjob/harvest_mail-cron /etc/cron.d/harvest_mail-cron
RUN crontab /etc/cron.d/harvest_mail-cron

#CMD ["cron", "-f"] #2017-04-17 (https://github.com/docker-library/redmine/blob/5453a92c4f8d18e59de9162c4030fb277bc72e8f/3.3/Dockerfile)
