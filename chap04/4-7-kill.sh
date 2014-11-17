#!/bin/sh

## ps 와 awk 로 httpd 프로세스 종료
ps -eaf httpd|grep -v grep|awk '{print "kill -TERM "$2}' | sh -x
