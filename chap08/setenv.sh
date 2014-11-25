#!/bin/sh

## 자바 가상 머신에 초기 할당되는 메모리 풀의 크기. -Xms 옵션의 파라미터로 전달된다.
MIN_MEMORY="128m"

## 자바 가상 머신에 할당되는 메모리의 최대 크기. 
## 규모가 큰 애플리케이션을 구동하거나 시스템에 메모리 여유가 있다면 늘리는 것을 권장한다
MAX_MEMORY="512m"

## 자바 가상 머신의 PermGen(Permanent Generation) 영역의 크기. 
## 클래스나 메서드, 기타 객체가 저장되는 영역이며 부족할 경우 OutOfMemoryError가 발생할 수 있다. 
## 특히 톰캣의 manager를 이용해 핫 디플로이(Hot deploy)를 한다면 크기를 더 늘려야 한다.
MAX_PERM_SIZE="256m"

## ps 명령어로 현재 구동된 톰캣 애플리케이션의 이름을 가져올 경우 여러 개의 JVM이 구동 중이면 grep java로도 원하는 JVM 프로세스를 찾기가 어려울 수 있다. 
## 이를 방지하고 현재 톰캣의 인스턴스를 명확히 구분하기 위해 구동 시 서비스명을 지정하면 grep을 이용해 손쉽게 프로세스 정보를 가져올 수 있다.
SERVICE_NAME="myWebApp"

## 최종 실행 옵션
JAVA_OPTS="-Dcom.example.servicename=${SERVICE_NAME} -Xms${MIN_MEMORY} -Xmx${MAX_MEMORY} -XX:MaxPermSize=${MAX_PERM_SIZE} ${JAVA_OPTS}"
