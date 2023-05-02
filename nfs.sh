#!/bin/bash

#Install NFS client

sudo yum install nfs-utils nfs4-acl-tools -y


#Mount /var/www/ and target the NFS server’s export for apps

sudo mkdir /var/www

sudo mount -t nfs -o rw,nosuid 172.31.9.84:/mnt/apps /var/www

#Verify that NFS was mounted successfully by running df -h. Make sure that the changes will persist on Web Server after reboot:

sudo echo "172.31.9.84:/mnt/apps    /var/www    nfs defaults    0 0" >> /etc/fstab



#Install Remi’s repository, Apache and PHP

sudo yum install httpd -y

sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

sudo dnf module reset php -y

sudo dnf module enable php:remi-7.4 -y

sudo dnf install php php-opcache php-gd php-curl php-mysqlnd -y

sudo systemctl start php-fpm -y

sudo systemctl enable php-fpm -y

setsebool -P httpd_execmem 1


