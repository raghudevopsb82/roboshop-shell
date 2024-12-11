dir_path=$(pwd)
log_file=/tmp/roboshop.log


SYSTEMD_SETUP() {
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service >$log_file
  systemctl daemon-reload >$log_file
  systemctl enable $app_name >$log_file
  systemctl restart $app_name >$log_file
}

APP_PREREQ() {
  useradd roboshop >$log_file
  rm -rf /app >$log_file
  mkdir /app >$log_file
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip >$log_file
  cd /app >$log_file
  unzip /tmp/$app_name.zip >$log_file
}

NODEJS() {
  echo Disable Default NodeJS Version
  dnf module disable nodejs -y >$log_file
  dnf module enable nodejs:20 -y >$log_file
  dnf install nodejs -y >$log_file

  APP_PREREQ

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