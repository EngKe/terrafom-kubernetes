 backup_postgresql(){
    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 -d) 
    PGPASSWORD="$POSTGRES_PASSWORD" pg_dumpall -U postgres -h 127.0.0.1 -p 5432 > /home/vagrant/backup/alldbdump.sql
 }

 backup_postgresql