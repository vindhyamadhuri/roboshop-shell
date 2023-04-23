yum install maven -y
useradd roboshop
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
rm -rf /app
cd /app
unzip /tmp/shipping.zip
mvn clean package
mv target/shipping-1.0.jar shipping.jar
cp shipping.service /etc/systemd/system/shipping.service
yum install mysql -y
mysql -h mysql-dev.vin95.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping