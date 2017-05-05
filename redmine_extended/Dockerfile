FROM redmine:3.3.2

MAINTAINER "Swedish Natural History Museum, BIO-unit" <inkimar at gmail.com>

RUN apt-get update -q && apt-get install -y unzip vim  cron 

# nya för cronjobbet
RUN apt-get install -y make gcc  pkg-config imagemagick libmagickwand-dev libmysqlclient-dev 

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

#root certificate 
RUN wget -O /usr/local/share/ca-certificates/bundle.zip https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/COMODO_DV_SHA-256_bundle.crt.zip && cd /usr/local/share/ca-certificates && unzip bundle.zip && rm -rf __MACOSX
RUN dpkg-reconfigure -f noninteractive ca-certificates

# preparing cronjob, environments variables and Gemfile
COPY etc.env /etc/environment
COPY Gemfile /root

RUN bundle install --gemfile=/usr/src/redmine/Gemfile
RUN bundle install --gemfile=/root/Gemfile


RUN mkdir -p \
/usr/src/redmine/mail-script

USER root
#testing cron, check cron with -> /etc/init.d/cron status
COPY cronjob/harvest_mail-cron /etc/cron.d/harvest_mail-cron
RUN crontab /etc/cron.d/harvest_mail-cron

#test 
#CMD cron

