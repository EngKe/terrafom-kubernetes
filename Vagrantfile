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
    config.vm.provision "file", source: "terraform/kind-cluster.tf", destination: "$HOME/"
    config.vm.provision "file", source: "database/backup.sh", destination: "$HOME/"
    config.vm.provision "file", source: "jenkins/01-unlock-jenkins.groovy", destination: "$HOME/"
    config.vm.provision "file", source: "jenkins/02-create-admin.groovy", destination: "$HOME/"
    config.vm.provision "file", source: "jenkins/03-install-plugins.groovy", destination: "$HOME/"
    config.vm.provision "file", source: "jenkins/pipeline.xml", destination: "$HOME/"
    config.vm.provision "file", source: "database/postgresql-test.sh", destination: "$HOME/"
    config.vm.provision "file", source: "database/redis-test.sh", destination: "$HOME/"
    config.vm.provision "file", source: "database/port-forward.service", destination: "/etc/systemd/system"
    config.vm.provision "file", source: "database/port-forward.sh", destination: "$HOME/"

    config.vm.provision "shell", path: "install-requirements.sh"
    config.vm.provision "shell", path: "terraform/create-cluster.sh"
    config.vm.provision "shell", path: "jenkins/create-password.sh"
    config.vm.provision "shell", path: "jenkins/jenkins-setup.sh"
    config.vm.provision "shell", path: "jenkins/run-pipeline.sh"
    config.vm.provision "shell", path: "database/database-infrastructures.sh"
    config.vm.provision "shell", path: "database/connect-outside-k8s.sh"
    config.vm.provision "shell", path: "database/create-example-database.sh"

end