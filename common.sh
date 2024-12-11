dir_path=$(pwd)
log_file=/tmp/roboshop.log


SYSTEMD_SETUP() {
  echo Copy Application Service File
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service >$log_file

  echo Start Application
  systemctl daemon-reload >$log_file
  systemctl enable $app_name >$log_file
  systemctl restart $app_name >$log_file
}

APP_PREREQ() {

  echo Create Application User
  useradd roboshop >$log_file

  echo Remove Application Directory
  rm -rf /app >$log_file

  echo Create Application Directory
  mkdir /app >$log_file

  echo Download Application Code
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip >$log_file

  cd /app >$log_file

  echo Extract Application Code
  unzip /tmp/$app_name.zip >$log_file
}

NODEJS() {
  echo Disable Default NodeJS Version
  dnf module disable nodejs -y >$log_file

  echo Enable NodeJS 20 Version
  dnf module enable nodejs:20 -y >$log_file

  echo Install NodeJS
  dnf install nodejs -y >$log_file

  APP_PREREQ

  echo Install NodeJS Dependencies
  npm install >$log_file

  SYSTEMD_SETUP

}

JAVA() {
  dnf install maven -y

  APP_PREREQ
  mvn clean package
  mv target/$app_name-1.0.jar $app_name.jar

  SYSTEMD_SETUP
}

PYTHON() {
  dnf install python3 gcc python3-devel -y

  APP_PREREQ
  pip3 install -r requirements.txt

  SYSTEMD_SETUP
}