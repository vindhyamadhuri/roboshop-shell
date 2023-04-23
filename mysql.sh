dnf module disable mysql -y
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
yum install mysql-community-server -y
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[36m>>>>>>>Reset mysql password<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1