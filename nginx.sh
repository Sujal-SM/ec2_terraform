#!/bin/bash

# Update package list and install Nginx
sudo apt update -y
sudo apt install nginx -y

# Enable and start Nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# Create a simple HTML page with Spider-Man message
echo "<!DOCTYPE html>
<html>
<head>
    <title>Spider-Man</title>
</head>
<body>
    <h1>THIS IS YOUR FRIENDLY NEIGHBOURHOOD SPIDER-MAN!</h1>
</body>
</html>" | sudo tee /var/www/html/index.html