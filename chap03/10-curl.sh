#!/bin/sh

## HTTP/HTTPS 연결
curl http://www.gnu.org/software/bash/manual/html_node/index.html

## 서버의 콘텐츠를  bash_manual.html 로 저장
curl -o bash_manual.html http://www.gnu.org/software/bash/manual/html_node/index.html

## -O, --remote-name 옵션으로 URL 에서 파일 이름 추출하여 저장(index.html)
curl -O http://www.gnu.org/software/bash/manual/html_node/index.html

## -L, --location 옵션으로 HTTP 301, 302 처리
curl -L http://www.google.com

## HTTP 기본 인증
curl -u myuserid:mypwd http://www.example.com

## HTTP 헤더 설정
curl -u userid:password -H "Content-Type: application/json" http://www.example.com/user/login

## HTTP 데이터 포스트
curl -d "name=Bruce+Wayne&age=30" http://requestb.in/1ap5m1g1

## data encoding
curl --data-urlencode "name=Bruce Wayne" --data-urlencode "age=30"  http://requestb.in/1ap5m1g1

## data.js 파일을 POST
curl -d @data.js -u userid:password  -H "Content-Type: application/json" http://requestb.in/1ap5m1g1

## binary 데이터 업로드
curl --data-binary @myBinary.jpg http://requestb.in/1ap5m1g1


