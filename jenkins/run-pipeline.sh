install_jenkinscli(){

    wget http://localhost:8080/jnlpJars/jenkins-cli.jar

}

create_pipeline(){

    sudo systemctl restart jenkins
    export PASSWORD=$(kubectl get secret jenkinsadmin -o jsonpath='{.data.password}' | base64 --decode)
    java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$PASSWORD create-job pipeline < pipeline.xml

}

build_pipeline(){

    export PASSWORD=$(kubectl get secret jenkinsadmin -o jsonpath='{.data.password}' | base64 --decode)
j   ava -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$PASSWORD build pipeline

}
install_jenkinscli
create_pipeline
build_pipeline