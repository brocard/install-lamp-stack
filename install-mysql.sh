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