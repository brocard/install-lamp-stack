#!/bin/sh

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

echo -e "\e[31m\e[1mInstall Mysql Server\e[0m\n"
yum install mysql-server


echo -e "\e[31m\e[1mRestart Mysql Service\e[0m\n"
service mysqld start
