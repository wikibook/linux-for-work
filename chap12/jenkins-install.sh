#!/bin/sh

########## jenkins 설치 절차

##### root 로 실행
groupadd jenkins
adduser jenkins -g jenkins
mkdir /var/jenkins
chown jenkins:jenkins /var/jenkins 

######  jenkins 계정으로 실행

## tomcat 설치
curl -L -O  http://apache.mirror.cdnetworks.com/tomcat/tomcat-7/v7.0.57/bin/apache-tomcat-7.0.57.tar.gz
tar zxvf apache-tomcat*gz
ln -s apache-tomcat-7.0.57 jenkins
cd jenkins

## bin/setenv.sh 파일 생성
## ServerPort와 Connector port 설정
vi conf/server.xml

## .bash_profile 에 아래의 jekins home 변수 설정한 후에 source 명령어로 반영
export JENKINS_HOME="/var/jenkins"

## jenkins 설치
##  안정 버전 다운로드
curl -L -O http://mirrors.jenkins-ci.org/war-stable/1.565.1/jenkins.war

## 기존 ROOT 디렉터리 삭제
rm -rf webapps/ROOT

## war 를 webapps/ROOT.war 로 이동(ROOT Context 로 구동)
mv jenkins.war webapps/ROOT.war

## 톰캣 구동
./bin/startup.sh

### root 로 실행
## apache httpd가 연결할 수 있도록 SELinux 설정. 
## 다른 포트일 경우 -m 대신 -a  옵션을 사용
semanage port -m -p tcp -t http_port_t 8080
