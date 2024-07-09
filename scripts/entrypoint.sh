#!/bin/bash

sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
echo 'unattended-upgrades unattended-upgrades/enable_auto_updates boolean true' | sudo debconf-set-selections
sudo apt-get install python3-pip -y
pip install -r /home/ubuntu/todo-project/requirements.txt
sudo apt-get install -y docker.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker ubuntu

sudo curl -L "https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
sudo chmod 666 /var/run/docker.sock

sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

mkdir -p /home/ubuntu/todo-project/todo_project
cd /home/ubuntu/todo-project/todo_project
docker pull elmoghany/todo_app:v1.8-django

#echo "version: '3.8'
#services:
#  todo_service:
#    image: elmoghany/todo_app:v1.1-django-docker-compose
#    ports:
#      - '8001:8000'
#    container_name: todo_django_container
#" > docker-compose.yml
