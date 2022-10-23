#!/bin/sh

install_wget(){

sudo apt-get update
sudo apt-get install wget

}

install_vagrant(){

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant

sudo mkdir /etc/vbox/
sudo touch /etc/vbox/networks.conf
echo "* 0.0.0.0/0 ::/0" | sudo tee -a /etc/vbox/networks.conf

echo '**********vagrant installed*********'

}

install_virtualbox(){

sudo apt install -y virtualbox

}

vagrant_up(){

vagrant up
vagrant ssh node-1

}

install_wget
install_vagrant
install_virtualbox
vagrant_up