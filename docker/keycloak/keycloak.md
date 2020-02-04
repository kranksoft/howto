# Keycloak



```
docker run -d --name keycloak --net keycloak-network \
 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=keycloak \
 -e DB_USER=postgres -e DB_PASSWORD=uK8bzeWk -e POSTGRES_DB=keycloak -e DB_ADDR=postgres \
 -p 8080:8080 jboss/keycloak
```

docker run -d --name keycloak --net keycloak-network -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=keycloak -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=uK8bzeWk POSTGRES_DB=keycloak -e DB_ADDR=postgres -p 8080:8080 jboss/keycloak
w