echo "Postgres password setup completed successfully!"

# Install Node.js
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt-get install -y nodejs
node -v
npm -v
echo "Node.js and npm Installed successfully!"

# Clone the code
git clone https://github.com/DivyaTech29/lms.git
# Build backend

echo "Backend deployment started"

cd ~/lms/api

cat <<EOF | sudo tee .env
MODE=production
PORT=8080
DATABASE_URL=postgresql://postgres:Qwerty123@localhost:5432/postgres
EOF
sudo npm install
sudo npm install -g pm2
sudo npx prisma db push
sudo npm run build

echo "Backend build completed"

pm2 start -f build/index.js
sudo ss -ntpl

# Get public IP address dynamically
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

# Build frontend

echo "frontend deployment started"
cd ~/lms/webapp/
cat <<EOF | sudo tee .env
VITE_API_URL=http://${PUBLIC_IP}:8080/api
EOF
npm install
npm run build

echo "Frontend build completed"

sudo apt -y update
sudo apt -y install nginx
sudo rm -rf /var/www/html/*
sudo cp -r /home/ubuntu/lms/webapp/dist/* /var/www/html
sudo systemctl restart nginx

echo "Deployment completed successfully!"
                                                            
