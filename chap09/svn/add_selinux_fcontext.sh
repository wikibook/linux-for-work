#!/bin/sh

# /var/svn 디렉터리를 SElinux 의 File context 에 추가
semanage fcontext -a -t httpd_sys_content_t "/var/svn(/.*)?"
