if "%BG_APP_HOME%" == "" set BG_APP_HOME=.
cd %BG_APP_HOME%

set CLASSPATH=%BG_APP_HOME%;%BG_APP_HOME%/lib/*;%BG_APP_HOME%/lib/app/*;%BG_APP_HOME%/lib/ext/*;%BG_APP_HOME%/lib/custom/*;

java -Xmx256m -cp %CLASSPATH% ru.bitel.bgbilling.kernel.application.server.Application $1