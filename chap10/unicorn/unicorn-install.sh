#!/bin/sh

########## unicorn 으로 deploy.
## bundle install 명령어로 유니콘 웹 서버를 vendor/bundle에 설치한다.
## 사전에 Gemfile.local 을 생성해 두어야 한다.
bundle install --without development test --path vendor/bundle

## unicorn 설정파일 복사
cp ./vendor/bundle/ruby/2.0.0/gems/unicorn-4.6.3/examples/unicorn.conf.rb config/unicorn.rb

## 설정 파일 편집. unicorn.rb 파일 참고
vi 	config/unicorn.rb

##  unicorn 웹서버 실행하여 정상 설정 여부를 확인한다.
## 정상적으로 동작한다면 redmine-unicorn.sh 를 통해서 시작/중지한다.
bundle exec unicorn_rails -D -c config/unicorn.rb -E production
