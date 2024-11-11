#!/bin/bash

module_name="etl_edr_p4"
main_module="etl_module/etl_edr" #keep it empty "" if there is no main module 
log_level="INFO" # INFO, DEBUG, ERROR

. ~/.bash_profile

set -x
VAR=""
build="${module_name}.jar"
cd ${APP_HOME}/${main_module}/${module_name}
log_path="${LOG_HOME}/${main_module}"

status=`ps -ef | grep $build | grep java`
if [ "$status" != "$VAR" ]
then
 echo "The process is already running"
 echo $status
else
 echo "Starting process"
  java -Dlog4j.configurationFile=./log4j2.xml -Dmodule.name=${module_name} -Dspring.config.location=file:${commonConfigurationFile},file:./application.properties -jar ${build} $(date '+%Y-%m-%d') 1>/dev/null 2>${log_path}/${module_name}.error &

# java -Dmodule.name=ETL_EDR_P4 -Xmx1024m -Xms256m -Dlog4j.configurationFile=./log4j2.xml -Dspring.config.location=file:${commonConfigurationFile},file:./application.properties -jar $PNAME $current_date 1>/u02/eirs 2>error.txt &
 echo "Process started"
fi
