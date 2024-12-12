dnf module disable nginx -y &>>$log_file
Status_Print $?

dnf module enable nginx:1.24 -y &>>$log_file
Status_Print $?

dnf install nginx -y &>>$log_file
Status_Print $?

cp nginx.conf /etc/nginx/nginx.conf &>>$log_file
Status_Print $?

rm -rf /usr/share/nginx/html/* &>>$log_file
Status_Print $?

rm -f /tmp/frontend.zip &>>$log_file
Status_Print $?

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$log_file
Status_Print $?

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$log_file
Status_Print $?

systemctl enable nginx
systemctl restart nginx &>>$log_file
Status_Print $?


