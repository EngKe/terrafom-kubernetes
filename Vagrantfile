IMAGE_NAME = "generic/ubuntu2204"
CPU = 2
MEMORY = 3
NODE = 1
Vagrant.configure("2") do |config|
    (1..NODE).each do |i|
    config.vm.define "node-#{i}" do |node|
        node.vm.box = IMAGE_NAME
        node.vm.network "private_network", ip: "10.100.50.1#{i}"
        node.vm.hostname = "node-#{i}"
            config.vm.provider "virtualbox" do |virtualbox|
            virtualbox.cpus = CPU
            virtualbox.memory = MEMORY * 1024
    config.vm.provision "shell", path: "install-requirements.sh"
    config.vm.provision "file", source: "kind-cluster.tf", destination: "$HOME/"
    config.vm.provision "shell", path: "create-cluster.sh"
        end
    end
end
end