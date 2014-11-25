#!/bin/sh

## httpd 설치
yum install httpd

## 부팅과 동시에 실행되도록 설정
chkconfig httpd on 

## 환경 정상 여부 테스트
service httpd configtest 

## httpd 가 클라이언트 요청을 처리한 후에 재시작
service httpd graceful 
