#!/bin/bash

## gitlab 설치 절차

#### 1. 사전 작업

## epel 저장소 추가
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 

## ruby 2.0 내려받고 설치
curl -O -L https://github.com/lesstif/ruby-rpm/releases/download/v0.1/ruby-2.0.0p451-1.el6.x86_64.rpm
yum localinstall ruby*

## 개발 도구 설치
yum -y groupinstall 'Development Tools'

## gitlab 이 사용하는 라이브러리와 유틸리티 설치
yum -y install vim-enhanced readline readline-devel ncurses-devel gdbm-devel glibc-devel tcl-devel openssl-devel curl-devel expat-devel db4-devel byacc sqlite-devel gcc-c++ libyaml libyaml-devel libffi libffi-devel libxml2 libxml2-devel libxslt libxslt-devel libicu libicu-devel system-config-firewall-tui redis     sudo crontabs logwatch logrotate perl-Time-HiRes patch 

## 2. DBMS, EMail 서버와 redis 설정
chkconfig redis on
service redis restart

##  사용자 계정 생성
adduser --system --shell /sbin/nologin --comment ‘GitLab’ --create-home --home-dir /home/git/ git
usermod -s /bin/bash git 

## 3. gitlab shell 설치
cd /home/git
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-shell.git -b v1.9.1 
sudo -u git -H cp gitlab-shell/config.yml.example gitlab-shell/config.yml

## 4. MySQL DB 와 계정 생성
# CREATE DATABASE IF NOT EXISTS gitlabhq_production CHARACTER SET utf8 COLLATE utf8_bin;
# GRANT ALL PRIVILEGES ON gitlabhq_production.* TO 'gitlab'@'localhost' IDENTIFIED BY 'secure_password';




