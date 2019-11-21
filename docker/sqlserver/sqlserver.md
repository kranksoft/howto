# Microsoft Sql Server

## Linux:
```
docker run --name sqlserver --network keycloak-net \
      -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=uK8bzeWk*' \
      -e 'MSSQL_PID=Express' -p 1433:1433 -d \
      mcr.microsoft.com/mssql/server:2017-latest-ubuntu
```

## Windows:
```
docker run --name sqlserver `
      -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=uK8bzeWk*' `
      -e 'MSSQL_PID=Express' -p 1433:1433 -d `
      mcr.microsoft.com/mssql/server:2017-latest-ubuntu
```

## SqlCmd tool

```
docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P uK8bzeWk*
```