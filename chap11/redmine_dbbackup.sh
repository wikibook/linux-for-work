#!/bin/sh

## yyyy-mm-dd_hh:mm format
TIME=`date "+%Y-%m-%d_%H:%M"`

mysqldump --single-transaction -u redmine -pmy_password  redmine >  /var/redmine/db-backup/${TIME}-redmine_backup.sql

