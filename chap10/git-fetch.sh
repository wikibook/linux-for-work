#!/bin/sh

### 주기적으로 저장소에서 remote 의 내용을 pull 받는 스크립트

## pull 할 저장소로 이동
cd /var/redmine/git-repos/hello-webapp.git
git fetch -q --all -p
cd ~/redmine
./script/rails runner "Repository.fetch_changesets" -e production
