postgresql(){

mkdir -p $HOME/backup
touch $HOME/backup/backup.log
echo "*/30 * * * * $HOME/backup.sh && echo  "backup done at `date`" >> $HOME/backup/backup.log" | sudo tee -a /etc/crontab
echo "@reboot kubectl port-forward --namespace default svc/postgresql 5432:5432 &" | sudo tee -a /etc/crontab #!!!!!!!!!!!!!

}

postgresql