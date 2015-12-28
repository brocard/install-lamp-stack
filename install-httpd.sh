#!/bin/bash

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

if [ ! -x /usr/bin/wget ] ; then
    yum install wget
fi

wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

#install httpd for Centos 6.x
sudo yum -y install httpd httpd-devel php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml

sudo yum update

#only firt time install
sudo service httpd start

#to enable service
sudo chkconfig httpd on
