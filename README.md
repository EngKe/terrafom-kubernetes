To start the system run the setup.sh file with './setup.sh'

When you run setup.sh script, wget, virtualbox and vagrant started to install and with and the command 'vagrant up' runs, VM starts to set up the system
It may take time for the system to be ready.

Explanations for files:

Vagrantfile: This file contains the configuration of the VM and files to copy to the VM and shell scripts to run.

install-requirements.sh -> This script includes installations of these: 
wget, kubectl, helm, kind, terraform, postgresql-cli, docker, redis

wait-for-system-ready.sh -> This script show status of pods ready or not.

database folder:

    backup.sh -> This script backups postgresql data

    database-infrastructures.sh -> This script makes backup.sh, redis-test.sh and postgresql.sh executable and provides to run backup.sh every day 

    port-forward.sh -> This script allows to users connect PostgreSQL and Redis outside Kubernetes with port-forward after all pods are ready

    port-forward.service -> This file includes service configuration for script port-foward.sh

    connect-outside-k8s.sh -> This script enables port-forward.service

    postgresql-test.sh -> This script checks postgresql wheter accepting connections from 127.0.0.1:5432 or not

    redis-test.sh -> This script checks whether the Redis server is running or not

jenkins folder:

    jenkins-setup.sh -> This script includes installation and configuration and jenkins.

    create-password.sh -> This script creates random ten digits password for the jenkins user admin.

    groovy scripts:
        01-unlock-jenkins.groovy -> The scirpt unlocks jenkins.
        02-create-admin.groovy   -> The script creates admin user(username:admin, and the password generated from create-password.sh script)
        03-install-plugins.groovy-> The script installs the workflow-aggregator plugin.
    
    pipeline.xml -> Pipeline configuration file for the deployment of postgresql and redis applications.

    run-pipeline.sh -> This script installs jenkins-cli.jar, creates job from pipeline.xml and builds job by jenkins-cli.jar

terrafrom folder:

    kind-cluster.tf -> This file configuration of k8s cluster, the cluster contains one control-plane and one worker node.

    create-cluster.sh -> This script includes local k8s cluster installation via terraform and copies config file to make config accessible by the vagrant user
