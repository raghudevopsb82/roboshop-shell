echo Disable default redis
dnf module disable redis -y &>>$log_file
Status_Print $?

echo Enable Redis 7 Version
dnf module enable redis:7 -y &>>$log_file
Status_Print $?

echo Install Redis
dnf install redis -y &>>$log_file
Status_Print $?

echo Update Redis Listen address and protected mode
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$log_file
Status_Print $?

echo Start Redis Service
systemctl enable redis &>>$log_file
systemctl restart redis &>>$log_file
Status_Print $?

