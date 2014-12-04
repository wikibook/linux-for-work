#!/bin/sh

# VM의 초기 크기
MIN_MEMORY="512m"

# VM의 최대 크기. 규모가 큰 애플리케이션을 구동하거나 시스템에 메모리 여유가 있다면 늘리는 것을 권장한다.
MAX_MEMORY="2048m"

# permanent space 영역의 크기를 지정한다.
MAX_PERM_SIZE="512m"

# 최종 JVM 옵션
JAVA_OPTS="-Xms${MIN_MEMORY} -Xmx${MAX_MEMORY} -XX:MaxPermSize=${MAX_PERM_SIZE} ${JAVA_OPTS}"
