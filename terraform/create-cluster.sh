create_cluster(){

    terraform init
    terraform plan
    terraform apply -auto-approve
    echo -e "\e[1;31m**********k8s cluster created*********\033[0m"

}

access_cluster_vagrant(){

    sudo mkdir /home/vagrant/.kube
    sudo cp /root/.kube/config /home/vagrant/.kube/config
    sudo chown vagrant /home/vagrant/.kube/config

}

create_cluster
access_cluster_vagrant