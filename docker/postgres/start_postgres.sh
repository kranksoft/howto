#!/bin/bash

NAME="postgres"
PASSWORD="uK8bzeWk"
PORT="5432"
TAG="12.1-alpine"

if [ "$1" != "" ]; then
  NAME=$1
fi
if [ "$2" != "" ]; then
  PASSWORD=$2
fi
if [ "$3" != "" ]; then
  PORT=$3
fi
if [ "$4" != "" ]; then
  TAG=$2
fi

docker run --name $NAME --restart always \
  --network postgres-network \
  -e POSTGRES_PASSWORD=$PASSWORD \
  --mount src=$NAME,target=/var/lib/postgresql/data \
  -p $PORT:5432 \
  -d postgres:$TAG
