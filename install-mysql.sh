#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

echo -e "\e[32m\e[1m	Update and Clean with yum command\e[0m"
yum update -y && yum clean all

clear

rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

echo -e "\n\e[32m\e[1m	Install Mysql\e[0m\n"
yum install mysql.`uname -i` yum-plugin-replace -y

echo -e "\n\e[32m\e[1m	Replace Mysql55\e[0m\n"
yum replace mysql --replace-with mysql55w -y

echo -e "\n\e[32m\e[1m	Install Mysql Server\e[0m\n"
yum install mysql55w mysql55w-server -y

echo -e "\n\e[32m\e[1m	Restart Mysql Service\e[0m\n"
service mysqld start