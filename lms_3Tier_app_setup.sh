#!/bin/sh
echo"Setting up 3 Tier web application"

echo"Database Layer for LMS"

#Install Postgres
sudo install postgresql
sudo  ss -ntpl

#set password
sudo su - postgres
psql
\password

#To show table structure
\dt

echo"Applicatio layer for LMS"

#install nodejs
node -v
npm -v
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt-get install -y nodejs
node -v
npm -v

#Build API for LMS
git clone https://github.com/DivyaTech29/lms.git
ls
cd lms
cd lms/api
ls
vi .env

#update values
MODE=production
PORT=8080
DATABASE_URL=postgresql://postgres:your-password@localhost:5432/postgres

#To get dependencies
npm install

#for sql file
ls 
ls prisma
ls prisma/migrations
ls prisma/migrations/20221110085013_init
cat prisma/migrations/20221110085013_init/migration.sql

#To get table structure in postgresql
sudo npx db generate

#To generate prisma to postgresql and database is in sync
sudo npx prisma generate
sudo npx prisma db push

#To run the build
npm run build
ls
ls build

# to start an application
node build/index.js

echo"Frontend layer for LMS application"

#To connect backend to frontend
ls
ls lms/webapp
vi .env

#update values
VITE_API_URL=http://public-ip:8080/api

#To get dependencies
npm install
ls

#To run build
npm run build
ls
ls dist

#to run the application need NGINX
sudo apt -y install nginx
sudo ss -ntpl
ls /var/www/html
sudo rm --rf /var/www/html/index.nginx-debian.html
sudo cp -r dist/* /var/www/html

echo"LMS application is deployed succesfully using shell script"


