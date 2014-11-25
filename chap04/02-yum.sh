#!/bin/sh

## mod_ssl 패키지 설치
yum install mod_ssl

## 이름이 httpd 로 시작하는 모든 패키지 설치
yum install httpd*

## httpd 패키지 삭제
yum remove httpd

## openssl 패키지 업데이트
yum update openssl

## 업데이트 가능한 패키지 확인
yum check-update

## 패키지와 메타 데이터 캐시 삭제
yum clean packages metadata

## 저장소 목록 보기
yum repolist

## 패키지 이름과 설명에 mysql 과 php 가 들어가는 패키지 검색
yum search mysql php

### httpd 로 시작하는 모든 패키지 목록 보기
yum  list httpd*

## 설치된 패키지 목록 보기
yum list installed

## httpd 패키지 정보 보기
yum info httpd

### httpd.conf 파일이 있는 패키지 검색
yum provides '*/httpd.conf'

### /etc/httpd* 경로 아래에 httpd.conf 파일이 있는 패키지 검색
yum provides '/etc/httpd*/httpd.conf'


## 로컬에 있는 rpm 패키지 설치
yum localinstall mod_dav_svn* subversion* serf-1.3*

## 패키지 그룹목록
yum grouplist


## "웹 서버" 그룹에 포함된 패키지 목록 출력
yum groupinfo "Web Server"

## 한글 패키지 그룹명도 사용 가능
yum groupinfo "웹 서버"

## "웹 서버" 그룹 패키지 설치
yum groupinstall "웹 서버"

### yum 플러그인 검색
yum search yum plugin

### 체인지 로그와 다운로드 플러그인 설치
yum install yum-plugin-changelog yum-plugin-downloadonly 

## openssl 의 2014년 5월 이후의 변경 이력 확인
yum changelog 2014-05 openssl

## 패키지를 설치하지 않고 내려받기
yum install postfix -y --downloadonly

## 트랜잭션 목록 보기
yum history list

## 4번 트랜잭션의 자세한 이력 확인
yum history info 4

### 4번 트랜잭션 되돌리기
yum history undo 4

### 4번 트랜잭션 되살리기
yum history redo 4
