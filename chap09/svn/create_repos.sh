#!/bin/sh

# 1.	/var/에 저장소 루트로 사용할 디렉터리를 생성하고 만들고 해당 디렉터리로 이동한다
mkdir /var/svn/ >& /dev/null
cd /var/svn

# 2. svn 저장소를 생성
svnadmin create /var/svn/myrepos

# 3. 소유자와 그룹 변경
chown -R apache.apache /var/svn/

# 4. SELinux context 설정
chcon -R -t httpd_sys_content_t /var/svn/myrepos
