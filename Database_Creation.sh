source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL


INSERT INTO sys_param (tag, type, value, active, feature_name) VALUES ('edr_table_clean_days', 0, 30, 0, 'etl_edr_p4');

#Create Below indexes if not exists on those columns 
 ALTER TABLE app.duplicate_device_detail ADD INDEX(expiry_date,status);
ALTER TABLE app.imei_manual_pair_mgmt ADD INDEX (status,created_on);
ALTER TABLE app.mobile_device_repository ADD INDEX (device_id);
ALTER TABLE app.national_whitelist ADD INDEX(imei,gdce_imei_status);
ALTER TABLE app.active_msisdn_list ADD INDEX(imsi);
ALTER TABLE app.operator_series ADD INDEX(series_start,series_end,series_type);
ALTER TABLE app.imei_pair_detail ADD INDEX(record_time,pairing_date);
ALTER TABLE app.imei_pair_detail ADD INDEX(expiry_date,pairing_date);

EOFMYSQL
