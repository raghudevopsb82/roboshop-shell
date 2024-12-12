echo Install MySQL Server
dnf install mysql-server -y
Status_Print $?

echo Start MySQL Service
systemctl enable mysqld
systemctl restart mysqld
Status_Print $?

echo Set MySQL Password
mysql_secure_installation --set-root-pass RoboShop@1
Status_Print $?

