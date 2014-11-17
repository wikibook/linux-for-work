#!/bin/sh

######### 패키지 관리
## rpm 패키지 설치
rpm -ivh mod_ssl-2.2.15-29.el6.centos.x86_64.rpm

## 패키지 업그레이드
rpm -Uvh mod_ssl-2.2.16-29.el6.centos.x86_64.rpm

## 원격지에 있는 rpm 설치
rpm -ivh http://centos.mirror.cdnetworks.com/6.5/os/x86_64/Packages/mod_ssl-2.2.15-29.el6.centos.x86_64.rpm

## 패키지 삭제
rpm -e httpd

######## 질의 모드
## 설치된 전체 패키지 보기
rpm -qa | less

## 패키지의 자세한 정보 보기
rpm -qi libssh2

## 패키지내 파일의 설치 목록 보기
rpm -ql httpd

## 설치전 패키지내 파일들의 설치 목록 보기
rpm -qpl http://centos.mirror.cdnetworks.com/6.5/os/x86_64/Packages/mod_ssl-2.2.15-29.el6.centos.x86_64.rpm

## 파일이 포함된 패키지 알아내기
rpm -qf /etc/httpd/conf/magic /usr/bin/vim

## 패키지 의존성 목록 보기
rpm -qR mod_ssl

## 패키지의 변경 이력 보기
rpm -q --changelog openssl

## 패키지 서명 검증
rpm -K http://centos.mirror.cdnetworks.com/6.5/os/x86_64/Packages/mod_ssl-2.2.15-29.el6.centos.x86_64.rpm

## 설치 패키지 검증
rpm -V httpd
