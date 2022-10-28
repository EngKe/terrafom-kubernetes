firstly, with command 'chmod 750 setup.sh' make the setup.sh file executable and to start all system run the setup.sh file with './setup.sh'
when you run setup.sh script, wget, virtualbox and vagrant started to install and with the command 'vagrant up' runs, start to setup all system

explanations for files:

Vagrantfile: This file contains configuration of Vm and files to copy to vm and shell scipts to run

install-requirements.sh -> This script includes installtions of these: 
wget, kubectl, helm, kind, terraform, postgresql, docker, redis

kind-cluster.tf -> this file configuration of k8s cluster, the clusert contains one control-plane and one worker node.

create-cluster.sh -> This script includes local k8s cluster installation via terraform

jenkins folder:

    jenkins-setup.sh

    create-password.sh ->  

    pipeline.xml ->

    groovy scripts:
        01-unlock-jenkins.groovy -> the scirpt unlocks jenkins
        02-create-admin.groovy   -> the script creates admin user(username:admin, and the password generated from create-password.sh script)
        03-install-plugins.groovy-> the script installs suggested plugins 
