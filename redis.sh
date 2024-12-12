dnf module disable redis -y &>>$log_file
Status_Print $?

dnf module enable redis:7 -y &>>$log_file
Status_Print $?

dnf install redis -y &>>$log_file
Status_Print $?

sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$log_file
Status_Print $?

systemctl enable redis &>>$log_file
systemctl restart redis &>>$log_file
Status_Print $?

