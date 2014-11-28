#!/bin/sh

export RAILS_ENV=production
USER=`whoami`

PIDS=""
getpids() {
    local procname=$1
    if [ "$#" = 0 ] ; then
        echo $"Usage: killproc {procname} "
        return 
    fi
 
    PIDS=`ps -eaf|grep unicorn|grep ${procname}|grep -v grep|grep ${USER}|awk '{print $2}'|paste -d" " -s`
}

start() {
	bundle exec unicorn_rails -D -c config/unicorn.rb
	RETVAL=$?
	if [ $RETVAL != 0 ];then
		echo "start failed..."
		tail log/unicorn.stderr.log
	fi
}

stop() {
	getpids "master"
	if [ ! -z ${PIDS} ];then
		echo "sending TERM signal to unicorn master ${PIDS}"
		kill -TERM ${PIDS}
		sleep 1
	fi
}

status() {
	getpids "master"
	if [ "x"${PIDS} = "x" ];then
		echo "unicorn redmine not running.."
		exit 0
	fi
	MASTER=${PIDS}
	getpids "worker"
	WORKER=${PIDS}
	echo "Unicorn master $MASTER and worker ($WORKER) is running..."
}

case "$1" in
  start)
	start
	status
	;;
  stop)
	stop
	;;
  about)
	ruby script/about
	;;
  status)
	status
	;;
  restart)
	stop
	start
	status
	;;
  *)
        echo $"Usage: $0 {start|stop|restart|about|status|restart}"
        RETVAL=2
esac
