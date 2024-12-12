source ./common.sh
app_name=catalogue

NODEJS

echo Copy MongoDB repo file
cp $dir_path/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
Status_Print $?

echo Install Mongo Client
dnf install mongodb-mongosh -y &>>$log_file
Status_Print $?

echo Load Master Data
mongosh --host mongodb-dev.azdevopsb82.online </app/db/master-data.js &>>$log_file
Status_Print $?
