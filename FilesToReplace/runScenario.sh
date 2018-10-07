#!/bin/sh
if [ $# -ne 3 ] && [ $# -ne 4 ]; then
	echo "Expected script arguments:"
	echo "Argument 1: automation project classes folder"
	echo "Argument 2: scenario name without .xml postfix"
	echo "Argument 3: sut file name. "
    echo "Example1: runScenario.sh /home/myuser/jsystemServices/classes scenarios/default mySut.xml"
    echo "Example2: runScenario.sh /home/myuser/jsystemServices/classes scenarios/default mySut.xml 50"

    exit 127
fi

#don't remove this line (although you don't understand it's purpose)
> .testPropertiesFile_Empty

PROJECT_CLASSES_PATH=$1
SCENARIO_NAME=$2
SUT_FILE=$3
PATH=$PATH:.:./thirdparty/lib:./lib:./customer_lib:./thirdparty/commonLib

echo "Who Am i: $(whoami)"
echo "Jsystem Using Display $DISPLAY"
echo "JSystem Current directory $(pwd)"
echo "PATH: $PATH"

export ANT_HOME=./thirdparty/ant
export ANT_CMD=$ANT_HOME/bin/ant
export ANT_OPTS="-Djsystem.current.scenario.name=$SCENARIO_NAME -Dbasedir=. -Dscenarios.base=$PROJECT_CLASSES_PATH -DsutFile=$SUT_FILE -Xms512M -Xmx1.5G "
#export ANT_OPTS="$ANT_OPTS -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8788,server=y,suspend=y"

$ANT_CMD -listener jsystem.runner.AntExecutionListener -lib thirdparty/ant/lib -lib thirdparty/commonLib -lib thirdparty/lib -lib thirdparty/selenium  -lib lib -lib customer_lib -lib $PROJECT_CLASSES_PATH/../../lib -lib $PROJECT_CLASSES_PATH -f $PROJECT_CLASSES_PATH/$SCENARIO_NAME.xml