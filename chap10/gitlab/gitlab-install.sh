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

## 3. gitlab-shell 설치
cd /home/git

### gitlab 의 branch 이름이 v1.9.1 에서 version-1-9 로 변경됨.
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-shell.git -b version-1-9
cd gitlab-shell
sudo -u git -H cp config.yml.example config.yml
## config.xml 편집
vi config.yml

## 4. MySQL DB 와 계정 생성
# CREATE DATABASE IF NOT EXISTS gitlabhq_production CHARACTER SET utf8 COLLATE utf8_bin;
# GRANT ALL PRIVILEGES ON gitlabhq_production.* TO 'gitlab'@'localhost' IDENTIFIED BY 'secure_password';


## MySQL 계정 정상 동작 여부 확인
mysql -u gitlab -psecure_password -D gitlabhq_production

### 4. gitlab 설치
cd /home/git
sudo -u git -H git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b 6-7-stable gitlab
cd /home/git/gitlab
sudo -u git -H cp config/gitlab.yml.example config/gitlab.yml

## config/gitlab.yml 설정 편집
vi config/gitlab.yml

## 소유자 및 모드 변경
chown -R git log/ tmp/
chmod -R u+rwX  log/ tmp/

sudo -u git -H mkdir tmp/{pids,sockets}
chmod -R u+rwX  tmp/{pids,sockets}

## 백업 디렉터리 생성
sudo -u git -H mkdir public/uploads
chmod -R u+rwX  public/uploads

## 유니콘 설정 파일 복사
sudo -u git -H cp config/unicorn.rb.example config/unicorn.rb
## 유니콘 설정
vi config/unicorn.rb

## 웹을 통한 외부 공격을 막기 위한 프레임워크인 Rack Attack을 설정한다
sudo -u git -H cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb

## git 사용자 설정
sudo -u git -H git config --global user.name "GitLab"
sudo -u git -H git config --global user.email gitlab@gitlab.example.com
sudo -u git -H git config --global core.autocrlf input

## MySQL 설정 파일 복사
sudo -u git -H cp config/database.yml.mysql config/database.yml
## DB 연결 정보 설정
vi config/database.yml

## 루비 번들 설치
gem install bundle
sudo -u git -H bundle install --deployment --without development test postgres aws

## 데이타베이스 초기화
sudo -u git -H bundle exec rake gitlab:setup RAILS_ENV=production


