source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL

 
INSERT INTO sys_param (tag, type, value, active, feature_name)
VALUES ('edr_table_clean_days', 0, 30, 0, 'etl_edr_p4');
    


EOFMYSQL
