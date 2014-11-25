#!/bin/sh

## MySQL DBMS 와 개발 라이브러리 설치
yum install mysql mysql-devel mysql-server mysql-libs

## 부팅과 동시에 실행되도록 설정
chkconfig mysqld on 

## 설치후 관리자 암호를 new-password 로 설정
mysql -u root -p'new-password'

## MySQL 관리자 로그인
mysql -u root -p'new-password'
