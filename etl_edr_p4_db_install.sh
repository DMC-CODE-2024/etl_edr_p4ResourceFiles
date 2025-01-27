#!/bin/bash
conf_file=${APP_HOME}/configuration/configuration.properties
typeset -A config # init array

while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
    fi
done < $conf_file
dbPassword=$(java -jar  ${APP_HOME}/utility/pass_dypt/pass_dypt.jar spring.datasource.password)
conn="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${dbPassword} ${config[appdbName]}"

`${conn} <<EOFMYSQL


INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('Drop EDR table No of days back', 'edr_table_clean_days', 0, '30', 1, 'etl_edr_p4', NULL, 'system', 'system');


EOFMYSQL`

echo "DB Script Execution Completed"
