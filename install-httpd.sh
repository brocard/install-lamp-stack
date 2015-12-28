#!/bin/bash

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

#install httpd for Centos 6.x
sudo yum -y install httpd httpd-devel php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml
