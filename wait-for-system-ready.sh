until  kubectl -n default get pod -o jsonpath='{range .items[*]}{.status.containerStatuses[*].ready.true}{.metadata.name}{ "\n"}{end}' | grep redis-replicas-2
    do
    echo 'pods are not running yet'
    sleep 10
    done

echo "\e[1;31m*********all pods are ready you can run test now***********\033[0m"
sleep 5
 
