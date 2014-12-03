#!/bin/sh

## SSL 인증서 검증 해제. 아래 내용을 .bash_profile 에 추가
export MAVEN_OPTS="-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true"
