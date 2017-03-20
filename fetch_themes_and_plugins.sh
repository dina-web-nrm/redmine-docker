#!/bin/bash

THEME_HARDPIXEL=redmine_extended/themes/v0.2.tar.gz
THEME_NITRINO=redmine_extended/themes/v0.1.tar.gz
THEME_TSI=redmine_extended/themes/master.zip

test -f ${THEME_HARDPIXEL} || wget -nc https://github.com/hardpixel/minelab/archive/v0.2.tar.gz -P redmine_extended/themes 
test -f ${THEME_NITRINO} || wget -nc https://github.com/Nitrino/flatly_light_redmine/archive/v0.1.tar.gz -P redmine_extended/themes
test -f ${THEME_TSI} || wget -nc https://github.com/tsi/redmine-theme-flat/archive/master.zip -P redmine_extended/themes

PLUGIN_AGILE_LIGHT=redmine_extended/plugins/redmine_agile-1_4_2-light.zip
PLUGIN_BACKLOG=redmine_extended/plugins/v1.0.6.tar.gz

test -f ${PLUGIN_AGILE_LIGHT} || wget -nc https://archive.org/download/redmine_agile-1_4_2-light_201703/redmine_agile-1_4_2-light.zip -P redmine_extended/plugins
test -f $PLUGIN_BACKLOG} || wget -nc https://github.com/backlogs/redmine_backlogs/archive/v1.0.6.tar.gz -P redmine_extended/plugins
