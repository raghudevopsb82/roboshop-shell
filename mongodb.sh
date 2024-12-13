source ./common.sh

echo Copy MongoDB repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
Status_Print $?

echo Install MongoDB
dnf install mongodb-org -y &>>$log_file
Status_Print $?

echo Update MongoDB listen address
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file
Status_Print $?

echo Start MongoDB service
systemctl enable mongod &>>$log_file
systemctl restart mongod &>>$log_file
Status_Print $?
