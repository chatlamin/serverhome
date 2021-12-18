#!/bin/bash

cd ${0%${0##*/}}./..

. ./bin/setenv.sh

PWD="$($(which pwd))"
NAME_SHORT=${PWD##*/}

APP_HOME=.
CLASSPATH=$APP_HOME:$APP_HOME/lib/*:$APP_HOME/lib/app/*:$APP_HOME/lib/ext/*:$APP_HOME/lib/custom/*
COMMON_PARAMS="-Dapp.name=$NAME_SHORT -Dnetworkaddress.cache.ttl=3600 -Djava.net.preferIPv4Stack=true -Dboot.info=1"
LOG_PARAMS="-Dlog.dir.path=log/ -Dlog4j.configuration=conf/log4j-application.xml -Dlog.prefix=$NAME_SHORT -Dlog4j.configurationFile=conf/log4j2.xml"
MEMORY=-Xmx256m

if [ "$1" = "start" ]; then
	${JAVA_HOME}/bin/java ${COMMON_PARAMS} ${LOG_PARAMS} ${MEMORY} -cp ${CLASSPATH} ru.bitel.bgbilling.kernel.application.server.Application > ./log/${NAME_SHORT}.out 2>&1
else
	if [ "$1" = "debug" ]; then
		#starting in debug mode
	    ${JAVA_HOME}/bin/java ${COMMON_PARAMS} ${MEMORY} -cp ${CLASSPATH} -enableassertions -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=5589,server=y,suspend=n ru.bitel.bgbilling.kernel.application.server.Application > ./log/${NAME_SHORT}.out 2>&1
	else
		#execute command
		${JAVA_HOME}/bin/java ${COMMON_PARAMS} -cp ${CLASSPATH} ru.bitel.bgbilling.kernel.application.server.Application $1 $2 $3 $4 $5 $6
	fi
fi