#!/bin/sh

########## nexus 백업

## 모든 아티팩트를 backup.example.com 에 백업
rsync -avzh /home/nexus/nexus/sonatype-work nexus@backup.example.com:/home/nexus/nexus/sonatype-work

## proxy 저장소는 제외하고 hosted저장소만 백업
rsync -avzh /home/nexus/nexus/sonatype-work --exclude=nexus/storage/central* --exclude=nexus/storage/codehaus-snapshots --exclude=nexus/storage/apache-snapshots nexus@backup.example.com:/home/nexus/nexus/sonatype-work
