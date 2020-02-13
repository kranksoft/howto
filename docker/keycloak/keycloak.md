# Keycloak

```
#!/bin/bash

docker run -d --name keycloak \
    --restart always \
    --net postgres-network \    
    -e DB_USER=postgres \
    -e DB_PASSWORD=uK8bzeWk \
    -p 8181:8080 carwebkeycloak
```

docker run -d --name keycloak 
    --net keycloak-network \
    -e KEYCLOAK_USER=admin \
    -e KEYCLOAK_PASSWORD=keycloak \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=uK8bzeWk \
    -e DB_ADDR=postgres \
    -p 8080:8080 jboss/keycloak
w