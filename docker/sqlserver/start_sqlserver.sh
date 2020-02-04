#!/bin/bash

docker run --name sqlserver --network sqlserver-net \
      -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=uK8bzeWk*' \
      -e 'MSSQL_PID=Express' -p 1433:1433 -d \
      mcr.microsoft.com/mssql/server:2019-latest-ubuntu