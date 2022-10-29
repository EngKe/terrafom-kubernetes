#!/bin/sh

create_password(){

    export PASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
    kubectl create secret generic jenkinsadmin --from-literal=password=$PASSWORD
    sed 's@changemepls@'"$PASSWORD"'@' -i 02-create-admin.groovy

}

create_password