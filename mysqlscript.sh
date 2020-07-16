#!/bin/bash

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server mysql-server/root_password password pwd" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password pwd" | sudo debconf-set-selections
apt-get -y install mysql-server
service mysql restart
sudo update-rc.d mysql defaults
cp /FootGo/src/main/resources/application.properties.example /FootGo/src/main/resources/application.properties
mysql --user=root --password=pwd --execute="CREATE DATABASE footgo;"
