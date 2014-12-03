#!/bin/bash

## 기본적으로 설치돼 있는 깃 1.7 삭제.
yum -y remove git 

## git 1.8 내려받기
wget http://springdale.math.ias.edu/data/puias/computational/6/x86_64/git-1.8.3.1-1.sdl6.x86_64.rpm
wget http://springdale.math.ias.edu/data/puias/computational/6/x86_64/perl-Git-1.8.3.1-1.sdl6.noarch.rpm

## 설치
yum localinstall git-*.rpm perl-Git-*.noarch.rpm


