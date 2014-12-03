#!/bin/sh

########## 레드마인 upgrade 절차

## 레드마인 설치 디렉터리
cd redmine

## 서브버전 저장소의 소스 및 번들 업데이트
svn update
bundle update

## db 이관
bundle exec rake db:migrate RAILS_ENV=production

## 플러그인 이관
bundle exec rake redmine:plugins:migrate RAILS_ENV=production

## 캐시와 세션 정보 삭제
bundle exec rake tmp:cache:clear bundle exec rake tmp:sessions:clear

## 재구동
./redmine_unicorn.sh restart
