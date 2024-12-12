dir_path=$(pwd)
log_file=/tmp/roboshop.log
rm -f $log_file

Status_Print() {
  if [ $1 -eq 0 ]; then
    echo -e " \e[32mSUCCESS\e[0m"
  else
    echo -e " \e[31mFAILURE\e[0m"
    exit 1
  fi
}

SYSTEMD_SETUP() {
  echo Copy Application Service File
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file
  Status_Print $?

  echo Start Application
  systemctl daemon-reload &>>$log_file
  systemctl enable $app_name &>>$log_file
  systemctl restart $app_name &>>$log_file
  Status_Print $?
}

APP_PREREQ() {

  echo Create Application User
  id roboshop &>>$log_file
  if [ $? -eq 1 ]; then
    useradd roboshop &>>$log_file
  fi
  Status_Print $?

  echo Remove Application Directory
  rm -rf /app &>>$log_file
  Status_Print $?

  echo Create Application Directory
  mkdir /app &>>$log_file
  Status_Print $?

  echo Download Application Code
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  Status_Print $?

  cd /app &>>$log_file

  echo Extract Application Code
  unzip /tmp/$app_name.zip &>>$log_file
  Status_Print $?
}

NODEJS() {
  echo Disable Default NodeJS Version
  dnf module disable nodejs -y &>>$log_file
  Status_Print $?

  echo Enable NodeJS 20 Version
  dnf module enable nodejs:20 -y &>>$log_file
  Status_Print $?

  echo Install NodeJS
  dnf install nodejs -y &>>$log_file
  Status_Print $?

  APP_PREREQ

  echo Install NodeJS Dependencies
  npm install &>>$log_file
  Status_Print $?

  SYSTEMD_SETUP

}

JAVA() {
  echo Install Maven
  dnf install maven -y &>>$log_file
  Status_Print $?

  APP_PREREQ

  echo Install Maven Dependencies
  mvn clean package &>>$log_file
  mv target/$app_name-1.0.jar $app_name.jar &>>$log_file
  Status_Print $?

  SYSTEMD_SETUP
}

PYTHON() {
  echo Install Python
  dnf install python3 gcc python3-devel -y &>>$log_file
  Status_Print $?

  APP_PREREQ

  echo Install Python Dependencies
  pip3 install -r requirements.txt &>>$log_file
  Status_Print $?

  SYSTEMD_SETUP
}