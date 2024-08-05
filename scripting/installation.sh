#!/bin/bash

# Script to install all the necessary packages

# VARIABLES
MAIL=mail@mail.com
# User
USER=$(whoami)



# UPDATE
# Update machine
sudo apt update -y && sudo apt upgrade -y

# INSTALLATION

# Install docker, docker-compose, git, curl, wget, nvim
sudo apt install git curl wget neovim uidmap dbus-user-session slirp4netns -y





#SECURITY


# Disable SSH on root
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
# Disable password authentication
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
# Restart SSH
sudo systemctl restart ssh.service

# Install Fail2Ban
sudo apt-get install fail2ban -y
# Copy fail2ban config from repository
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# Restart Fail2Ban
sudo systemctl restart fail2ban


############################################




