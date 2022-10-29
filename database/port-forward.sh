port_forward(){

    until  kubectl -n default get pod -o jsonpath='{range .items[*]}{.status.containerStatuses[*].ready.true}{.metadata.name}{ "\n"}{end}' | grep redis-replicas-2
        do
        echo 'pods are not ready yet'
        sleep 10
        done
    echo 'port fowarding'
    sleep 5
    sudo systemctl stop redis-server.service
    kubectl port-forward --namespace default svc/postgresql 5432:5432 &
    kubectl port-forward --namespace default svc/redis-master 6379:6379 &

}

while true
do
    port_forward
done