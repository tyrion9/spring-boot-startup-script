#!/bin/bash

######################################################
# Copyright 2019 Pham Ngoc Hoai
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#    
# Repo: https://github.com/tyrion9/spring-boot-startup-script
# 
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
