if not "%JAVA_HOME%" == "" goto jh_ok
echo The JAVA_HOME environment variable is not defined.
echo This environment variable is needed to run this program.
goto end

:jh_ok

set APP_DIR=.
set CLASSPATH=%APP_DIR%;%APP_DIR%\lib\ext\*;%APP_DIR%\lib\app\*

cd %APP_DIR%

"%JAVA_HOME%\bin\java" -Xmx256m -cp %CLASSPATH% ru.bitel.bgbilling.utils.apps.update.AppsUpdate