#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1>Hello world from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
