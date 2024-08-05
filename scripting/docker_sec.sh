#!/bin/bash

# Script to enhance security

# VARIABLES
MAIL=mail@mail.com
# User
USER=$(whoami)

#INSTALL DOCKER
#Add docker repo and GPG key
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

#Add docker repo to apt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

#Install docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


#SETUP DOCKER ROOTLESS
sudo systemctl disable --now docker.service docker.socket
sudo rm /var/run/docker.sock


dockerd-rootless-setuptool.sh install

# Exports
export PATH=/usr/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock

# Enable docker service
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)



