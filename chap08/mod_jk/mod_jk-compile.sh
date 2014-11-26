#!/bin/sh

## mod_jk 컴파일을 위한 개발 패키지 설치
yum install gcc gcc-c++ httpd-devel

## connector source 다운로드
wget http://www.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.40-src.tar.gz

## 압축 해제 및 이동
tar zxvf tomcat-connector*
cd tomcat-connec*src/native

## Makefile 생성
./configure --with-apxs=/usr/sbin/apxs

## compile
make

## httpd modules 디렉터리에 설치
make install

## SELinux 컨텍스트 확인(httpd_modules_t 여야 함)
ls -lZ /etc/httpd/modules/mod_jk.so
