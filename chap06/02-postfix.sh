#!/bin/sh

## MySQL DBMS 와 개발 라이브러리 설치
yum install postfix -y 

## 부팅과 동시에 실행되도록 설정
chkconfig postfix on 

## 테스트를 위해 터미널에서 메일 전송
mail -s "email subject" user@example.com   
