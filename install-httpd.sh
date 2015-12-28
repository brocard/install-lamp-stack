#!/bin/bash

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

if [ ! -x /usr/bin/wget ] ; then
    yum -y install wget
fi

wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

echo "Enabled repo php56"\n
sed -i '/\[remi-php56\]/,/enabled=0/ { s/enabled=0/enabled=1/ }' /etc/yum.repos.d/remi.repo

#install httpd for Centos 6.x
sudo yum -y install httpd httpd-devel php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml

sudo yum update -y

#Only first time to install
echo "star httpd service"
sudo service httpd start

#to enable service
sudo chkconfig httpd on

# PHP5 - Composer package system installation
echo "Installing composer"
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer.phar
ln -s /usr/bin/composer.phar /usr/bin/composer
