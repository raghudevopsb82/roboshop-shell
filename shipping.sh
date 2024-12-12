source ./common.sh
app_name=shipping

JAVA

dnf install mysql -y &>>$log_file
Status_Print $?

mysql -h mysql-dev.azdevopsb82.online -uroot -pRoboShop@1 < /app/db/schema.sql &>>$log_file
Status_Print $?

mysql -h mysql-dev.azdevopsb82.online -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$log_file
Status_Print $?

mysql -h mysql-dev.azdevopsb82.online -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$log_file
Status_Print $?

