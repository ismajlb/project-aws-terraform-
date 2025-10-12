#!/bin/bash
yum update -y
yum install -y httpd wget unzip
systemctl start httpd
systemctl enable httpd
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip -o 2117_infinite_loop.zip
cp -r 2117_infinite_loop/* /var/www/html/
systemctl restart httpd
