#!/bin/bash

cd ${0%${0##*/}}../

if [[ -e bin/setenv.sh ]]
then
    . bin/setenv.sh
fi

APP_DIR=.
CLASSPATH=${APP_DIR}:${APP_DIR}/lib/ext/*:${APP_DIR}/lib/app/*

${JAVA_HOME}/bin/java -Xmx256m -cp ${CLASSPATH} ru.bitel.bgbilling.utils.apps.update.AppsUpdate