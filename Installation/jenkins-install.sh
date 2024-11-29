#!/bin/bash

# Set timezone
sudo timedatectl set-timezone America/New_York

# Set hostname
sudo hostnamectl set-hostname jenkins

# Install required packages
sudo yum install wget tree vim git nano unzip -y

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y

# Install Java and Jenkins
sudo yum install fontconfig java-17-openjdk -y
sudo yum install jenkins -y

# Enable and start Jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Display Jenkins status
sudo systemctl status jenkins

# Switch back to the ec2-user
sudo su - ec2-user

# Print completion message
echo "Jenkins installation completed. Access it via http://<YOUR_EC2_PUBLIC_IP>:8080"
