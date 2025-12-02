#!/bin/bash
#COMPLETED WORKSTATION BUILD WITH DOCKER|KUBERNETES|EKSCTL
#**********************************************************
# Docker download and installation
#----------------------------------
sudo dnf -y install dnf-plugins-core 
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo 
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker 
sudo systemctl enable docker 
sudo usermod -aG docker ec2-user
#========================================================
#eksctl Install commands:
#-------------------------------
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl 
#=======================================================
#Kubernetes Install commands: 
#--------------------------------
#1. Download 
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.34.2/2025-11-13/bin/linux/amd64/kubectl
#2. Apply execute permissions 
chmod +x ./kubectl 
#3. Copy the binary to a folder in your PATH 
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
#====================================================================
# Install kubens with kubectx
#-------------------------------------
# sudo apt install kubectx

#If Linux doesnt have default repo follow below for kubens
git clone https://github.com/ahmetb/kubectx.git ~/.kubectx
sudo ln -s ~/.kubectx/kubens   /usr/local/bin/kubens
mkdir -p ~/.bash_completion.d
cp ~/.kubectx/completion/kubens.bash ~/.bash_completion.d/
source ~/.bashrc

