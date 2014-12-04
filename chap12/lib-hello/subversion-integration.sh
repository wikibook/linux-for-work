#!/bin/sh

## project 생성
./create-libhello.sh

## 메이븐 테스트 프로젝트 디렉터리로 이동한다.
cd lib-hello

## 저장소 생성
svnadmin create ${HOME}/svnrepos
svn mkdir --parents file:///${HOME}/svnrepos/lib-hello/{trunk,tags,branches} -m "프로젝트 디렉터리 생성"

## 프로젝트 디렉터리 생성
svn import .  file:///${HOME}/svnrepos/lib-hello/trunk -m "project import"

##### 저장소내 프로젝트 디렉터리 구성 확인
svn list -R  file:///${HOME}/svnrepos/lib-hello/

## checkout
cd ..
mv lib-hello lib-hello-org
svn co file:///${HOME}/svnrepos/lib-hello/trunk lib-hello
