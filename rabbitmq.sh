cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$log_file
Status_Print $?


dnf install rabbitmq-server -y &>>$log_file
Status_Print $?

systemctl enable rabbitmq-server &>>$log_file
systemctl start rabbitmq-server &>>$log_file
Status_Print $?

rabbitmqctl add_user roboshop roboshop123 &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
Status_Print $?


