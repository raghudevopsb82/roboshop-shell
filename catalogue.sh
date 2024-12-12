source ./common.sh
app_name=catalogue

NODEJS

cp $dir_path/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.azdevopsb82.online </app/db/master-data.js

