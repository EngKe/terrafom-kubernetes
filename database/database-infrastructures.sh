postgresql(){

    mkdir -p backup
    sudo chown vagrant backup
    (crontab -l 2>/dev/null; echo "*/5 * * * * /home/vagrant/backup.sh") | crontab -
    
    chmod 750 postgresql-test.sh
    chmod 750 redis-test.sh
    chmod 750 backup.sh

}

postgresql


