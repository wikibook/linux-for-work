#!/bin/sh

## ps 와 awk 로 httpd 프로세스 종료
## grep -v grep 은 grep 프로세스 제거를 위해 필요하다.
ps -eaf httpd|grep -v grep|awk '{print "kill -TERM "$2}' | sh -x
