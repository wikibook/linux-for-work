#!/bin/sh

## lesstif 사용자가 연 파일 출력
lsof -u lesstif 


## TCP 80 포트를 사용하는 프로세스 정보 출력
lsof -i TCP:80


## Process id 가 15879 인 프로세스 정보 출력
lsof -p 15879

## 명령어가 httpd 인 프로세스가 연 파일 정보 출력
lsof -c httpd
