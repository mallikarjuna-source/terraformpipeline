#!/bin/bash
sudo apt-get update
sudo apt-get install openjdk-11-jre-headless -y
sudo java --version
sudo JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64 >> ~/.bash_profile
sudo PATH=$PATH:$JAVA_HOME >> ~/.bash_profile
sudo apt-get install wget -y
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y 
sudo apt-get install jenkins -y
sudo systemctl start jenkins
