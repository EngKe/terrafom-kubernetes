postgresql(){

mkdir -p backup
touch backup/backup.log
echo "*/30 * * * * /home/vagrant/backup.sh" | sudo tee -a /etc/crontab

chmod 750 postgresql-test.sh
chmod 750 redis-test.sh
chmod 750 backup.sh

}

postgresql


