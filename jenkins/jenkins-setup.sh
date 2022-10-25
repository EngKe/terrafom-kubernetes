#! /bin/bash

install_jenkins(){

sudo apt update
sudo apt install -y openjdk-11-jdk

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins
}

configure_jenkins(){

sudo mkdir /var/lib/jenkins/init.groovy.d
sudo cp create-admin.groovy /var/lib/jenkins/init.groovy.d/
sudo cp install-plugins.groovy /var/lib/jenkins/init.groovy.d/
sudo cp unlock-jenkins.groovy /var/lib/jenkins/init.groovy.d/

sudo systemctl restart jenkins

}


install_jenkins
configure_jenkins