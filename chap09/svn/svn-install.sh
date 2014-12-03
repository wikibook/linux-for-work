#!/bin/sh

## 패키지 내려받기
wget http://opensource.wandisco.com/rhel/6/svn-1.8/RPMS/x86_64/mod_dav_svn-1.8.5-1.x86_64.rpm
wget http://opensource.wandisco.com/rhel/6/svn-1.8/RPMS/x86_64/subversion-1.8.5-1.x86_64.rpm
wget http://opensource.wandisco.com/rhel/6/svn-1.8/RPMS/x86_64/subversion-tools-1.8.5-1.x86_64.rpm
wget http://opensource.wandisco.com/rhel/6/svn-1.8/RPMS/x86_64/serf-1.3.2-2.x86_64.rpm

## 서브버전 설치
yum localinstall mod_dav_svn* subversion* serf*


