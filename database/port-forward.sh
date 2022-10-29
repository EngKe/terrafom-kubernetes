#!/bin/sh

port_forward(){

    until  kubectl -n default get pod -o jsonpath='{range .items[*]}{.status.containerStatuses[*].ready.true}{.metadata.name}{ "\n"}{end}' | grep redis-replicas-2
        do
        echo -e "\e[1;31mpods are not ready yet\033[0m"
        sleep 10
        done
    echo 'port forwarding'
    sleep 5
    sudo systemctl stop redis-server.service
    sudo systemctl disable redis-server.service
    kubectl port-forward --namespace default svc/postgresql 5432:5432 &
    kubectl port-forward --namespace default svc/redis-master 6379:6379 &

}

while true
do
    port_forward
done