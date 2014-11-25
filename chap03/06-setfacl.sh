#!/bin/sh

## lesstif 사용자에게  /etc/sysconfig/iptables 파일 읽기 권한 부여
setfacl -m u:lesstif:r /etc/sysconfig/iptables

## devel 그룹은 /project/config 파일을 읽고 쓸 수 있고 lesstif 사용자는 읽을 수만 있다.
setfacl -m g:devel:rw /project/config 
setfacl -m u:lesstif:r /project/config

##  lesstif 사용자에게 부여한 /etc/sysconfig/iptables 권한 삭제 
setfacl -x u:lesstif /etc/sysconfig/iptables

## lesstif 사용자에게 웹 서버 로그 읽기 권한 부여
setfacl -m u:lesstif:rx /var/log/httpd/

## 아파치 웹 서버에 /var/www/wordpress/wp-content/uploads 디렉터리 읽기, 쓰기 권한 부여
mkdir /var/www/wordpress/wp-content/uploads
setfacl -m u:apache:rwx /var/www/wordpress/wp-content/uploads
