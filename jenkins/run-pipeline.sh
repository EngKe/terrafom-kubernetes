install_jenkinscli(){



}

create_pipeline(){

java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:admin123 create-job pipeline < pipeline.xml

}

build_pipeline(){

java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:admin123 build pipeline

}
install_jenkinscli
create_pipeline
build_pipeline