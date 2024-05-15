#!/bin/sh
echo "setting up web application"

#for installing Nginx
sudo apt -y update
sudo apt -y install nginx

# remove file from /var/www/html
sudo rm -rf /var/www/html/*

# clone the repository
git clone https://github.com/DivyaTech29/Lms-Project-Repo.git

#copy files from repo to /var/www/html
sudo cp Lms-Project-Repo/* /var/www/html/

echo"setting up application completed"
