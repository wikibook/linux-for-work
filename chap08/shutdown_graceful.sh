#!/bin/sh

## https://gist.github.com/lesstif/18c9923c46aa4341b83b 참고

killproc() {
    local servicename=$1
    local user=$2
    local signal="TERM"

    if [ "$#" = 0 ] ; then
        echo $"Usage: killproc {servicename} {user} {signal}"
        return 1
    fi

    if [ "$#" = 3 ]; then
        signal=$3
    fi
    PID=`ps -eaf|grep ${servicename}|grep -v grep|grep ${user}|awk '{print $2}'`
    ## process still running..
    if [ ! -z ${PID} ] && [ ${PID} -gt 0 ];then
        echo "kill -${signal} ${PID}"
        kill -${signal} ${PID};
        return 1;
    else
        return 0;
    fi
}

## tomcat instance 이름. setenv.sh 에 지정한 이름으로 변경 필요
SERVICE_NAME=myWebApp

## tomcat home. 변경 필요
TC_HOME=/var/tomcat/tomcat-7.0.55
if [ ! -d ${TC_HOME} ];then
        TC_HOME=`pwd`
fi

## tomcat process 소유자 이름
USER=`whoami`

cd ${TC_HOME}
./bin/shutdown.sh >& /dev/null
sleep 3 # delay 3 sec for tomcat shutting down..

## 
for i in 1 2;do
    killproc ${SERVICE_NAME} ${USER}
    RET=$?
    if [ $RET = 0 ];then
        break;
    fi;
    sleep $i;
done

## 아직도 살아 있으면 KILL 시그널 전송
killproc "${SERVICE_NAME}" "${USER}" "KILL"
