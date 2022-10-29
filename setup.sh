#!/bin/sh

install_wget(){

    sudo apt-get update
    sudo apt-get install -y wget

}

install_vagrant(){

    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install vagrant

    sudo mkdir /etc/vbox/
    sudo touch /etc/vbox/networks.conf
    echo "* 0.0.0.0/0 ::/0" | sudo tee -a /etc/vbox/networks.conf
    echo -e "\e[1;31m**********vagrant installed*********\033[0m"

}

install_virtualbox(){

    sudo apt install -y virtualbox
    echo -e "\e[1;31m**********virtualbox installed*********\033[0m"

}

vagrant_up(){

    vagrant up
    vagrant ssh

}

install_wget
install_virtualbox
install_vagrant
vagrant_up