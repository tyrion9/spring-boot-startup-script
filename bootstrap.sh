#!/bin/bash

######################################################
# This product includes software developed at
# The Apache Software Foundation (http://www.apache.org/).
# https://github.com/tyrion9/spring-boot-startup-script
######### PARAM ######################################

JAVA_OPT=-Xmx1024m
JARFILE=`ls -1r *.jar 2>/dev/null | head -n 1`
PID_FILE=pid.file
RUNNING=0

######### DO NOT MODIFY ########

if [ -f $PID_FILE ]; then
	pid=`cat $PID_FILE`
	if [ "x$pid" != "x" ] && kill -0 $pid 2>/dev/null; then
		RUNNING=1
	fi
fi

start()
{
	if [ $RUNNING -eq 1 ]; then
		echo "Application already started"
	else
        if [ -z "$JARFILE" ]
        then
            echo "ERROR: jar file not found"
        else
            java  $JAVA_OPT -Djava.security.egd=file:/dev/./urandom -jar $JARFILE &
            echo $! > $PID_FILE
            echo "Application $JARFILE starting..."
        fi
	fi
}

stop()
{
	if [ $RUNNING -eq 1 ]; then
		kill -9 $pid
		echo "Application stopped"
	else
		echo "Application not running"
	fi
}

restart()
{
	stop
	start
}

case "$1" in

	'start')
		start
		;;

	'stop')
		stop
		;;

	'restart')
		restart
		;;

	*)
		echo "Usage: $0 {  start | stop | restart  }"
		exit 1
		;;
esac
exit 0
