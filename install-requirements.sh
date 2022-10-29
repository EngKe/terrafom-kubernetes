#!/bin/sh

############ wrapper over apt-get to download files (retries if download fails) and then perform action.  
############ usage example:  aptgethelper install "nethogs rar -y -qq --force-yes"
aptgethelper(){
    local __cmd=$1
    shift
    local __args=$@
    local retry=10 count=0
    set +x
    # retry at most $retry times, waiting 1 minute between each try
        while true; do

        # Tell apt-get to only download packages for upgrade, and send 
        # signal 15 (SIGTERM) if it takes more than 10 minutes
            if timeout --kill-after=60 60 apt-get -d $__cmd --assume-yes $__args; then
                break
            fi
            if (( count++ == retry )); then
                printf "apt-get download failed for $__cmd ,  $__args\n" >&2
                return 1
            fi
            sleep 60
        done

    # At this point there should be no more packages to download, so 
    # install them.
    apt-get $__cmd --assume-yes $__args
}

fix_dns(){
    sudo rm -f /etc/resolv.conf
    echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
}

install_kind(){
    curl -fsSLo ./kind https://kind.sigs.k8s.io/dl/v0.16.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    echo -e "\e[1;31m**********kind installed*********\033[0m"
}

add_repositories(){
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
    curl -fsSL https://baltocdn.com/helm/signing.asc | sudo gpg --dearmor -o /usr/share/keyrings/helm.gpg
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /usr/share/keyrings/postgresql.gpg
    curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial \
        main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all \
        main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) \
        main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    echo "deb [signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg \
        main" | sudo tee /etc/apt/sources.list.d/postgresql.list
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) \
        main" | sudo tee /etc/apt/sources.list.d/redis.list

    sudo apt-get update
}

install_packages(){
    PACKAGE_LIST="kubectl helm terraform postgresql-client docker-ce docker-ce-cli containerd.io docker-compose-plugin redis"
    #aptgethelper install $PACKAGE_LIST

    for i in $PACKAGE_LIST
    do
    aptgethelper install $i
    echo -e "\e[1;31m**********$i installed*********\033[0m"
    done
}


fix_dns
install_kind
add_repositories
install_packages