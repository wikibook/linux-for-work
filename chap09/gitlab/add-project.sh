#!/bin/bash

### 메이븐으로 예제 프로젝트를 생성하고 gitlab 에 push 하는 예제
## gitlab 에는 프로젝트를 생성했으며 URL 은 git@gitlab.example.com:lesstif/demo-webapp.git 로 가정한다.

## 메이븐 프로젝트 생성
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DgroupId=com.example -DartifactId=demo-webapp -Dversion=1.0-SNAPSHOT

##  
cd demo-webapp

## 저장소 초기화
git init

## 저장소에 파일과 폴더 추가
git add src pom.xml

## 커밋
git commit -m "최초 커밋"

## 원격저장소 정보 추가
git remote add origin git@gitlab.example.com:lesstif/demo-webapp.git

## push
git push origin master
