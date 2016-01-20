#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

echo -e "\e[32m\e[1m	Update and Clean with yum command\e[0m"
yum update -y && yum clean all

echo -e "\n\e[31m\e[1m	Install Mysql Server\e[0m\n"
yum install mysql-server -y


echo -e "\n\e[31m\e[1m	Restart Mysql Service\e[0m\n"
service mysqld start

yum install expect -y

echo -e "\n\e[31m\e[1m	Set Secure Configuration\e[0m\n"

MYSQL_ROOT_PASSWORD=abcd1234

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

yum -y purge expect