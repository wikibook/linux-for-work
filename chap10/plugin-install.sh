#!/bin/sh

### 플로그인 설치 스크립트. redmine 설치 디렉터리에서 수행해야 한다.
## 설치가 완료되면 redmine 을 재구동해야 한다.

##### CKEditor 설치
git clone https://github.com/a-ono/redmine_ckeditor.git plugins/redmine_ckeditor
bundle install --without development test
bundle exec rake redmine:plugins:migrate RAILS_ENV=production
./redmine_unicorn.sh restart

#### screen shot paste 
git clone https://github.com/undx/redmine_screenshot_paste.git plugins/redmine_screenshot_paste
./redmine_unicorn.sh restart

### lightbox x
git clone https://github.com/thorin/redmine_lightbox.git plugins/redmine_lightbox
bundle exec rake redmine:plugins:migrate RAILS_ENV=production
./redmine_unicorn.sh restart

### 대시보드
git clone https://github.com/jgraichen/redmine_dashboard.git plugins/redmine_dashboard
cd plugins/redmine_dashboard
git checkout v2.3.3
cd ../..
bundle install --without development test
./redmine_unicorn.sh restart


