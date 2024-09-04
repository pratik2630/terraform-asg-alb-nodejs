#!/bin/sh
echo 'Hello from the remote instance'
sudo yum update -y
sudo curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# Obtain a metadata token
TOKEN=$(curl -X PUT http://169.254.169.254/latest/api/token -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch the instance ID using the token
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)

# Create server.js file
cat <<EOT > /home/ec2-user/server.js
const http = require('http');

const hostname = '0.0.0.0';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('<h1>Hello World $INSTANCE_ID</h1>\\n');
});

server.listen(port, hostname, () => {
  console.log('Server running at http://0.0.0.0:3000/');
});
EOT

echo "server.js created"
# Run the server in the background
node /home/ec2-user/server.js > /home/ec2-user/server.log 2>&1 &


