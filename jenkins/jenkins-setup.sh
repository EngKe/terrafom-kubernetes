#! /bin/bash

install_jenkins(){

sudo apt update
sudo apt install -y openjdk-11-jdk

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins

sudo mkdir /etc/systemd/system/jenkins.service.d
echo -e "[Service]\nTimeoutStartSec=300" | sudo tee /etc/systemd/system/jenkins.service.d/startup-timeout.conf

sudo systemctl daemon-reload
sudo systemctl restart jenkins
sudo systemctl enable jenkins
echo '**********jenkins installed**********'
}

configure_jenkins(){

sudo mkdir /var/lib/jenkins/init.groovy.d
sudo cp 02-create-admin.groovy /var/lib/jenkins/init.groovy.d/
sudo cp 03-install-plugins.groovy /var/lib/jenkins/init.groovy.d/
sudo cp 01-unlock-jenkins.groovy /var/lib/jenkins/init.groovy.d/

sudo systemctl restart jenkins

}


install_jenkins
configure_jenkins