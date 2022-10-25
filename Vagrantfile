IMAGE_NAME = "generic/ubuntu2204"
CPU = 2
MEMORY = 3
Vagrant.configure("2") do |config|
    config.vm.box = IMAGE_NAME
    config.vm.provider "virtualbox"
    config.vm.provider "virtualbox" do |v|
        v.memory = 1024 * MEMORY
        v.cpus = CPU
    end
    config.vm.provision "file", source: "/terraform/kind-cluster.tf", destination: "$HOME/"
    config.vm.provision "file", source: "backup.sh", destination: "$HOME/"
    config.vm.provision "file", source: "redis-test.sh", destination: "$HOME/"
    config.vm.provision "file", source: "/jenkins/unlock-jenkins.groovy", destination: "$HOME/"
    config.vm.provision "file", source: "/jenkins/create-admin.groovy", destination: "$HOME/"
    config.vm.provision "file", source: "/jenkins/install-plugins.groovy", destination: "$HOME/"
    config.vm.provision "file", source: "/jenkins/pipeline.xml", destination: "$HOME/"


    config.vm.provision "shell", path: "install-requirements.sh"
    config.vm.provision "shell", path: "create-cluster.sh"
    config.vm.provision "shell", path: "jenkins-setup.sh"
    config.vm.provision "shell", path: "run-pipeline.sh"
    config.vm.provision "shell", path: "database-infrastructures.sh"

end
