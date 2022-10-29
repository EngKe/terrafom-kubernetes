To start all system run the setup.sh file with './setup.sh'

When you run setup.sh script, wget, virtualbox and vagrant started to install and with the command 'vagrant up' runs, start to setup all system

Explanations for files:

Vagrantfile: This file contains configuration of Vm and files to copy to vm and shell scipts to run

install-requirements.sh -> This script includes installtions of these: 
wget, kubectl, helm, kind, terraform, postgresql-cli, docker, redis

database folder:

    backup.sh -> this script backups postgresl data

    database-infrastructures.sh -> this script makes backup.sh, redis-test.sh and postgresql.sh executable, and provides to run backup.sh every day 

    port-forward.sh -> this script allows to users connect PostgreSQL and Redis outside Kubernetes with port-forward after all pods are ready

    port-forward.service -> this file includes service configuration for script port-foward.sh

    connect-outside-k8s.sh -> this script enables port-forward.service

    postgresql-test.sh -> this script checks wheter accepting connections from 127.0.0.1:5432

    redis-test.sh -> this script checks whether the Redis server is running or not

jenkins folder:

    jenkins-setup.sh -> this script includes installation and configuration and jenkins

    create-password.sh -> this script creates random ten digits password for the jenkins user admin

    groovy scripts:
        01-unlock-jenkins.groovy -> the scirpt unlocks jenkins
        02-create-admin.groovy   -> the script creates admin user(username:admin, and the password generated from create-password.sh script)
        03-install-plugins.groovy-> the script installs suggested plugins
    
    pipeline.xml -> pipeline for deployment of postgresql and redis applications

    run-pipeline.sh -> this script creates job from pipeline.xml and builds job by jenkins cli

terrafrom folder:

    kind-cluster.tf -> This file configuration of k8s cluster, the clusert contains one control-plane and one worker node.

    create-cluster.sh -> This script includes local k8s cluster installation via terraform and copies config file to make config accesible by vagrant user