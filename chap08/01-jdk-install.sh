#!/bin/sh

############## JDK 설치 & 설정
## download 받은 jdk 설치
yum localinstall jdk-7u*.rpm

## 기존 심볼릭 링크 삭제
rm -f /usr/java/jdk1.7
## 심볼릭 링크 생성(디렉터리는 설치한 JDK 버전에 따라 다르므로 수정해야 한다.)
ln -s /usr/java/jdk1.7.0_60 /usr/java/jdk1.7

## alternatives 에 자바 관련 명령어 등록
alternatives --install /usr/bin/java java /usr/java/jdk1.7/bin/java 20000
alternatives --install /usr/bin/javac javac /usr/java/jdk1.7/bin/javac 20000
alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.7/jre/bin/javaws 20000
alternatives --install /usr/bin/jar jar /usr/java/jdk1.7/bin/jar 20000
alternatives --install /usr/bin/keytool keytool /usr/java/jdk1.7/bin/keytool 20000

## JDK 메이저 업그레이드일 경우 기존 자바 명령어 교체
alternatives --set java /usr/java/jdk1.7/bin/java
alternatives --set javac /usr/java/jdk1.7/bin/javac
alternatives --set javaws /usr/java/jdk1.7/jre/bin/javaws
alternatives --set jar /usr/java/jdk1.7/bin/jar
alternatives --set keytool /usr/java/jdk1.7/bin/keytool



