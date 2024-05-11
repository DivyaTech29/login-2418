#!/bin/sh
echo "setting up web application"

#for installing Nginx
sudo apt -y update
sudo apt -y install nginx

# remove file from /var/www/html
sudo rm -rf /var/www/html

# clone the repository
git clone https://github.com/username/repository.git

#copy files from repo to /var/www/html
sudo cp /path/to/repository/files/* /var/www/html/

echo"setting up application completed"
