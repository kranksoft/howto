# Postgres

Create the file start_postgres.sh with the following contents:

```
#!/bin/bash

NAME=$1
PASSWORD=$2
PORT=$3
TAG=$4

if [ "$1" != "" ]; then
    echo 'Usage: ./start_postgres.sh <containername> <dbpassword> <port> <tag>'
    echo 'Example: ./start_postgres.sh postgres very_strong_postgres_password latest'
    fi
    
sudo docker run --name $NAME --restart always \
  -e POSTGRES_PASSWORD=$PASSWORD \
  --mount src=$NAME,target=/var/lib/postgresql/data \
  -p $PORT:5432 \
  -d postgres:$TAG
```
