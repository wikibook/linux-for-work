#!/bin/sh

## root 로 실행
mkdir -p /var/redmine/git-repos
chown -R redmine  /var/redmine/

## redmine 계정으로 실행
cd /var/redmine/git-repos

## gitlab 에 등록한 공개키와 일치하는 개인키를 ~/.ssh/id_rsa 에 복사한 후에
## 소유자만 읽을 수 있도록 설정한다. 
chmod 600 ~/.ssh/id_rsa

## bare 저장소 생성. 저장소 URL 은 독자의 환경에 따라 다를수 있다.
git clone --mirror git@gitlab.example.com:lesstif/hello-webapp.git

## 저장소의 모든 브랜치를 가져온다.
git fetch -q --all -p
