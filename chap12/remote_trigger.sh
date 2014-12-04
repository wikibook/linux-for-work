#!/bin/sh

curl -u devel:myPasswd "http://jenkins.example.com/job/lib-hello/build" --data-urlencode "token=mySecretToken" --data-urlencode "cause=원격 빌드 테스트
