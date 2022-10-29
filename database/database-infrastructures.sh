#!/bin/sh

postgresql(){

    mkdir -p backup
    sudo chown vagrant backup
    sudo su vagrant -c '(crontab -l 2>/dev/null; echo "0 1 * * * /home/vagrant/backup.sh") | crontab -'
    chmod 750 postgresql-test.sh
    chmod 750 redis-test.sh
    chmod 750 backup.sh

}

postgresql


