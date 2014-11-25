#!/bin/sh

## setuid 비트가 설정된 프로그램 검색
find /bin /usr/bin /sbin -perm -4000 -exec ls -ldb {} \;

## httpd 프로세스의 컨텍스트 확인
ps -ZC httpd

## 현재 동작 모드 확인
getenforce

## permissive 모드로 변경
setenforce 0

## SELinux 상태 출력
sestatus

## SELinux 의 모든 boolean 확인
getsebool -a

## 특정 SELinux boolean 확인
getsebool httpd_can_sendmail 

## boolean 값 설정(재부팅후 사라짐)
setsebool httpd_can_sendmail true

## boolean 값 영구 설정
setsebool -P httpd_can_sendmail true

## 파일의 컨텍스트 복구
restorecon -R /var/www/html/test.html

## 파일의 컨텍스트 설정
chcon -R -t httpd_sys_content_t /var/www/html/test.html

## 경로에 필요한 보안 컨텍스트 출력
matchpathcon /var/log/ /var/www/ /etc/


### semanage 패키지 설치
yum install policycoreutils-python  

## httpd 가 연결 가능한 포트 확인
semanage port -l | grep http_port_t 

## http 가 연결 가능한 포트 추가
semanage port -a -p tcp -t http_port_t 800 

## httpd_sys_content_t 가 할당된 파일 컨텍스트 확인
semanage fcontext -l|grep httpd_sys_content_t

## /data/www 디렉터리 아래는 httpd_sys_content_t 를 자동으로 부여
semanage fcontext -a -t httpd_sys_content_t "/data/www(/.*)?"

## audit.log 확인
audit2why < /var/log/audit/audit.log   

## setroubleshoot-server 패키지 설치 및 dbus 데몬 재구동
yum install setroubleshoot-server 
service messagebus restart

## SELinux audit 로그 분석
sealert -a /var/log/audit/audit.log

## 로그파일에서 SELinux 관련 내용 추출
grep "SELinux is preventing" /var/log/messages 
grep "type=AVC" /var/log/audit/audit.log

## aureport 로 로그 필터링(3월 10일 이후 audit 관련 로그만 출력)
aureport -a -ts "2014년 3월 10일" 

## !주의 httpd 프로세스를 제한없이 실행되도록 도메인 설정
chcon -t unconfined_exec_t /usr/sbin/httpd
