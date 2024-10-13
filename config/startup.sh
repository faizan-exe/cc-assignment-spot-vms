#!/bin/bash

FLAG_FILE="/var/log/startup-script-ran"

# Check if the script has already been executed previously
if [ -f "$FLAG_FILE" ]; then
  echo "Startup script has already been executed previously. Exiting."
  exit 0
fi

# Update the system
apt-get update -y && apt-get upgrade -y

# Install necessary packages
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add Docker repository
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package index
apt-get update -y

# Install Docker
apt-get install -y docker-ce

# Download and install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Add the current user to the docker group
usermod -aG docker ${USER}

#Fixing Docker Config
newgrp docker

# Verify Docker and Docker Compose installation
docker --version
docker-compose --version

#Pulling image from GCR Registry and runing it
gcloud auth configure-docker gcr.io
docker pull \
    gcr.io/cc-assignment-1-437714/gcp-thumbnail-generator:latest
docker run gcr.io/cc-assignment-1-437714/gcp-thumbnail-generator:latest

# Create flag file to indicate that the script has been executed
touch "$FLAG_FILE"
echo "Startup script executed and configurations applied successfully."