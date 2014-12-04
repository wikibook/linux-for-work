#!/bin/sh

########## jenkins 백업

rsync -avzh /var/jenkins jenkins@backup.example.com:/var/jenkins/ --exclude=tools --exclude=cache
