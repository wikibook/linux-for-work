#!/bin/sh

## /var/log/ 폴더를 /root/log 폴더로 복제
rsync -avzh /var/log/ /root/log


## 로컬의 /home/lesstif/data 디렉터리를 backup.example.com의 /home/lesstif/data-backup에 복제
rsync -avzh /home/lesstif/data/ lesstif@backup.example.com:/home/lesstif/data-backup/

## example.com의 /home/lesstif/data를 로컬의 /home/lesstif/data-backup에 복제
rsync -avzh lesstif@example.com:/home/lesstif/data /home/lesstif/data-backup/

## ssh 공개키와 개인키 쌍 생성( $HOME/.ssh/id_rsa, id_rsa.pub)
ssh-keygen -t rsa -C lesstif@example.com

## 자동으로 로그인하기 위해 ssh 공개키를 원격지에 복사
ssh-copy-id -i ~/.ssh/id_rsa.pub  backup.example.com
