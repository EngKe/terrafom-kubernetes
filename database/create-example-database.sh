create_postgresql_table(){

export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432 -c "DROP TABLE IF EXISTS "myTable";

CREATE TABLE "myTable" (
  id SERIAL PRIMARY KEY,
  name varchar(255) default NULL,
  phone varchar(100) default NULL,
  email varchar(255) default NULL
);

INSERT INTO myTable (name,phone,email)
VALUES
  ('Tyrone Dixon','1-824-592-5458','facilisis.facilisis.magna@aol.couk'),
  ('Larissa Rosales','1-564-177-6618','scelerisque@yahoo.edu'),
  ('Norman Wong','(567) 735-4065','suspendisse.non.leo@icloud.com'),
  ('Lareina Young','(926) 862-8228','pharetra.sed.hendrerit@google.edu'),
  ('Cole Hobbs','1-540-987-2412','metus.urna@hotmail.org');"


}

redis_set(){

export REDIS_PASSWORD=$(kubectl get secret --namespace default redis -o jsonpath="{.data.redis-password}" | base64 -d)
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379 -n 0 SET testkey testvalue


}

until  kubectl -n default get pod -o jsonpath='{range .items[*]}{.status.containerStatuses[*].ready.true}{.metadata.name}{ "\n"}{end}' | grep redis-replicas-2
    do
    echo 'pods are not running yet'
    sleep 10
    done

echo "\e[1;31m**********creating test database and table in postgresql and setting test key in redis*********\033[0m"
sleep 5
create_postgresql_table
redis_set