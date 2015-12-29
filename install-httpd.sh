#!/bin/bash

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

if [ ! -x /usr/bin/wget ] ; then
    yum install wget -y
fi

wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

echo -e "\e[31m\e[1mEnabled repo php56\e[0m\n"
sed -i '/\[remi-php56\]/,/enabled=0/ { s/enabled=0/enabled=1/ }' /etc/yum.repos.d/remi.repo

#install httpd for Centos 6.x
yum install httpd httpd-devel php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml \
  php-opcache php-intl -y

yum update -y

#install git [version control system]
yum install git -y

#Only first time to install
echo -e "\e[31m\e[1mStar httpd service\e[0m"
service httpd start

#to enable service
chkconfig httpd on

#sed -i '/\#ServerName\swww\.example\.com\:80/ { s/enabled=0/ServerName\swww.example.com:80/ }' /etc/httpd/conf/httpd.conf
#ServerName www.example.com:80

# PHP5 - Composer package system installation
echo "Installing composer\n"
if [ ! -x /usr/local/bin/composer ] ; 
then
    curl -s https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    echo -e "\e[32mDone!\e[0m"
else
    echo "Composer is installed"
fi
