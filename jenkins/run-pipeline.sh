#!/bin/sh
install_jenkinscli(){

    wget http://localhost:8080/jnlpJars/jenkins-cli.jar

}

create_pipeline(){

    echo -e "\e[1;31m**********creating jenkins job*********\033[0m"
    sudo systemctl restart jenkins
    export PASSWORD=$(kubectl get secret jenkinsadmin -o jsonpath='{.data.password}' | base64 --decode)
    java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$PASSWORD create-job pipeline < pipeline.xml
    echo -e "\e[1;31m**********jenkins job created*********\033[0m"

}

build_pipeline(){

    export PASSWORD=$(kubectl get secret jenkinsadmin -o jsonpath='{.data.password}' | base64 --decode)
    java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$PASSWORD build pipeline

}
install_jenkinscli
create_pipeline
build_pipeline