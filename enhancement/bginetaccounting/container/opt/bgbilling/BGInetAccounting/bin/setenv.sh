JAVA_HOME=/usr/local/openjdk-15

if [ -z "$JAVA_HOME" ]; then
  echo "The JAVA_HOME environment variable is not defined"
  echo "This environment variable is needed to run this program"
  exit 1
fi

BGBILLING_JAVA_VERSION_FULL=$($JAVA_HOME/bin/java -version 2>&1 | grep -i version | sed 's/.*version "\(.*\)"/\1/; 1q')
BGBILLING_JAVA_VERSION=$(echo $BGBILLING_JAVA_VERSION_FULL | sed 's/\(.*\..*\)\..*/\1/; 1q')

echo "Java version is $BGBILLING_JAVA_VERSION ($BGBILLING_JAVA_VERSION_FULL)"