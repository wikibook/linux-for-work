#!/bin/bash

## gitlab 설치 절차

#### 1. 사전 작업

## epel 저장소 추가
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 

## ruby 2.0 내려받고 설치
curl -O -L https://github.com/lesstif/ruby-rpm/releases/download/v0.1/ruby-2.0.0p451-1.el6.x86_64.rpm
yum localinstall ruby*
## 루비 번들러 설치
gem install bundle

## 개발 도구 설치
yum -y groupinstall 'Development Tools'

## gitlab 이 사용하는 라이브러리와 유틸리티 설치
yum -y install vim-enhanced readline readline-devel ncurses-devel gdbm-devel glibc-devel tcl-devel openssl-devel curl-devel expat-devel db4-devel byacc sqlite-devel gcc-c++ libyaml libyaml-devel libffi libffi-devel libxml2 libxml2-devel libxslt libxslt-devel libicu libicu-devel system-config-firewall-tui redis     sudo crontabs logwatch logrotate perl-Time-HiRes patch 

## 2. DBMS, EMail 서버와 redis 설정
chkconfig redis on
service redis restart

##  사용자 계정 생성
adduser --comment 'GitLab' --create-home --home-dir /home/git/ git

### 이제부터는 git 사용자로 작업한다.
su - git

## 3. gitlab-shell 설치
cd /home/git

### gitlab 의 branch 이름이 v1.9.1 에서 version-1-9 로 변경됨.
git clone https://gitlab.com/gitlab-org/gitlab-shell.git -b version-1-9
cd gitlab-shell
cp config.yml.example config.yml
## config.xml 편집
vi config.yml

## gitlab-shell 설정 및 결과 출력
ruby ./bin/install

## gitlab-shell 이 생성한 .ssh 디렉터리는 적절한 SELinux 컨텍스트(ssh_home_t)가 부여되지 않아서 문제가 발생한다.
## restorecon 명령어로 컨텍스트를 복구한다.
restorecon -Rv ~/.ssh

## ls 명령어로 ssh_home_t 가 부여되어 있는지 확인해 본다.
ls -ldZ ~/.ssh/  

## 4. MySQL DB 와 계정 생성
# CREATE DATABASE IF NOT EXISTS gitlabhq_production CHARACTER SET utf8 COLLATE utf8_bin;
# GRANT ALL PRIVILEGES ON gitlabhq_production.* TO 'gitlab'@'localhost' IDENTIFIED BY 'secure_password';

## MySQL 계정 정상 동작 여부 확인
mysql -u gitlab -psecure_password -D gitlabhq_production

#####  gitlab 설치
cd /home/git
git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b 6-7-stable gitlab
cd /home/git/gitlab
cp config/gitlab.yml.example config/gitlab.yml

## config/gitlab.yml 설정 편집
vi config/gitlab.yml

## 소유자 및 모드 변경
chown -R git log/ tmp/
chmod -R u+rwX  log/ tmp/

## satellites 모듈 디렉터리 생성
mkdir /home/git/gitlab-satellites

## sockets와 pids 기록을 위한 디렉터리 생성
mkdir tmp/{pids,sockets}
chmod -R u+rwX  tmp/{pids,sockets}

## 백업 디렉터리 생성
mkdir public/uploads
chmod -R u+rwX  public/uploads

## 유니콘 설정 파일 복사
cp config/unicorn.rb.example config/unicorn.rb
## 유니콘 설정
vi config/unicorn.rb

## 웹을 통한 외부 공격을 막기 위한 프레임워크인 Rack Attack을 설정한다
cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb

## git 사용자 전역 설정
git config --global user.name "GitLab"
git config --global user.email gitlab@gitlab.example.com
git config --global core.autocrlf input

## MySQL 설정 파일 복사
cp config/database.yml.mysql config/database.yml
## DB 연결 정보 설정
vi config/database.yml

## bundle 로 의존성 있는 루비 패키지 설치
bundle install --deployment --without development test postgres aws

## 데이타베이스 초기화
bundle exec rake gitlab:setup RAILS_ENV=production

##### 이제부터는 root 로 실행
## gitlab 용 init.d 스크립트 내려받기
curl -k -o /etc/init.d/gitlab https://raw.githubusercontent.com/wikibook/linux-for-work/master/chap09/gitlab/gitlab
## 실행 속성을 부여하고 부팅과 동시에 구동되도록 설정
chmod +x /etc/init.d/gitlab
chkconfig --add gitlab
chkconfig gitlab on

## gitlab 의 log rotate 설정
cp /home/git/gitlab/lib/support/logrotate/gitlab /etc/logrotate.d/gitlab

#### 아래 명령어는 git 계정으로 실행 
##gitlab 설치 정보 출력
cd ~/gitlab
bundle exec rake gitlab:env:info RAILS_ENV=production

##gitlab 이 사용하는 asset 파일 컴파일
cd ~/gitlab
bundle exec rake assets:precompile RAILS_ENV=production

## gitlab 정상 설치여부 확인
bundle exec rake gitlab:check RAILS_ENV=production

#### root 로 실행
## SELinux port context 추가
semanage port -a -t http_port_t -p tcp 8085

## httpd config 내려받기
curl -k -o /etc/httpd/conf.d/gitlab.conf https://raw.githubusercontent.com/wikibook/linux-for-work/master/chap09/gitlab/gitlab.conf
