#!/bin/sh

## 1. 테스트 프로젝트 생성
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DgroupId=com.example -DartifactId=hello-webapp -Dversion=1.0

## 메이븐 테스트 프로젝트 디렉터리로 이동한다.
cd hello-webapp

######### 2. http/https 기반의 저장소에 프로젝트 등록
## 이미 http/https 기반의 svn 저장소는 설정되었다고 가정한다.
## 프로젝트 디렉터리 생성
svn mkdir --parents https://svn.example.com/repos/hello-webapp/{trunk,tags,branches} -m "프로젝트 디렉터리 생성"

## svn project import
svn import . https://svn.example.com/repos/hello-webapp/trunk -m "first commit"

##### 저장소내 프로젝트 디렉터리 구성 확인
svn list -R  https://svn.example.com/repos/repos/hello-webapp/



########## 3. http/https 대신 file 기반의 저장소를 사용하려면 다음 절차를 따른다.

## 저장소 생성
svnadmin create ${HOME}/repos
svn mkdir --parents file:///${HOME}/repos/hello-webapp/{trunk,tags,branches} -m "프로젝트 디렉터리 생성"

## 프로젝트 디렉터리 생성
svn import .  file:///${HOME}/repos/hello-webapp/trunk -m "first commit"

##### 저장소내 프로젝트 디렉터리 구성 확인
svn list -R  file:///${HOME}/repos/hello-webapp/
