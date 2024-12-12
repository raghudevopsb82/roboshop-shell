cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
Status_Print $?

dnf install mongodb-org -y &>>$log_file
Status_Print $?

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file
Status_Print $?

systemctl enable mongod &>>$log_file
systemctl restart mongod &>>$log_file
Status_Print $?
