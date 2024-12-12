dnf install mysql-server -y
Status_Print $?

systemctl enable mysqld
systemctl start mysqld
Status_Print $?

mysql_secure_installation --set-root-pass RoboShop@1
Status_Print $?

