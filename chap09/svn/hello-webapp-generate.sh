#!/bin/sh

## maven 프로젝트 생성
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DgroupId=com.example -DartifactId=hello-webapp -Dversion=1.0-SNAPSHOT

## svn 임포트
cd hello-webapp
svn import http://svn.example.com/repos/hello-webapp/trunk -m "hello-webapp 트렁크 디렉터리 추가"

## project 생성 확인
svn list -R http://svn.example.com/repos/hello-webapp

## svn 체크아웃
svn co http://svn.example.com/repos/hello-webapp/trunk hello-webapp
