#!/bin/sh

########## 레드마인 설치 절차

##### root 로 실행

### ruby 내려받기
wget https://github.com/lesstif/ruby-rpm/releases/download/v0.1/ruby-2.0.0p451-1.el6.x86_64.rpm 

## EPEL 저장소 설치
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 

## ruby 설치
yum localinstall ruby*

## 네이버 나눔 폰트 설치
wget http://cdn.naver.com/naver/NanumFont/fontfiles/NanumFont_TTF_ALL.zip
unzip NanumFont_TTF_ALL.zip -d /usr/share/fonts/nanum

## MySQL DB 계정 생성
# CREATE DATABASE redmine CHARACTER SET utf8;
# CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'my_password';
# GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';

## 개발도구 설치
yum install gcc -y
## ImageMagick 설치
yum install ImageMagick-devel -y
## 번들러 설치
gem install bundler

## redmine 계정 생성 및 암호 설정
adduser redmine
passwd redmine


###### 레드마인 설치. 이제부터는 redmine 계정으로 실행한다.
svn co http://svn.redmine.org/redmine/branches/2.4-stable redmine-2.4 -r 12449 

ln -s redmine-2.4 redmine
cd redmine

## DB 설정
cp config/database.yml.example config/database.yml 
vi config/database.yml

## Package 와 ImageMagick 설치
bundle install --without development test --path vendor/bundle
bundle install --without development test rmagick

## HTTP의 쿠키 데이터를 암호화하기 위해 사용하는 임의의 키를 생성한다
bundle exec rake generate_secret_token

## 데이터베이스 스키마 오브젝트 생성을 위해 db:migrate 명령어를 실행한다.
RAILS_ENV=production bundle exec rake db:migrate

## 이슈 타입(Issue type), 우선순위(Priority), 상태 등 기본적인 레드마인 데이터를 생성한다
RAILS_ENV=production bundle exec rake redmine:load_default_data

## 임시 디렉터리와 플러그인 디렉터리 생성
mkdir -p tmp tmp/pdf public/plugin_assets

## 
cp config/configuration.yml.example config/configuration.yml
vi config/configuration.yml

## 환경 파일 편집
config/configuration.yml

