echo -e "\e[36m>>>>>>>configuring Node.js repos<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>Install Nodejs<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>Add Application user<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>create application directory<<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>>Download app content<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo -e "\e[36m>>>>>>>unzip app content<<<<<<<<\e[0m"
cd /app
unzip /tmp/user.zip

echo -e "\e[36m>>>>>>>Install nodejs dependencies<<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>copy user systemd file<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>Start user service<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[36m>>>>>>>copy mongodb repos<<<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>install mongodb client<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>> Load Schema <<<<<<<<\e[0m"
mongo --host mongodb-dev.vin95.online </app/schema/user.js