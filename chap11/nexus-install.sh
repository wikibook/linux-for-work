#!/bin/sh

########## nexus 설치 절차

##### root 로 실행
groupadd nexus
adduser nexus -g nexus

#####  nexus 계정으로 실행

## 내려받기
curl -L -O http://www.sonatype.org/downloads/nexus-2.7.2-bundle.tar.gz
tar zxvf nexus-2.7.2-bundle.tar.gz
cd nexus-2.7.2-03

### nexus 설정 수정
vi conf/nexus.properties 

## nexus 구동
./bin/nexus start

### root 로 실행
## apache httpd 연결 허용
semanage port -m -p tcp -t http_port_t 8081
