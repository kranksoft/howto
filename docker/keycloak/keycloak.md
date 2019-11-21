# Keycloak

```
docker run -d --name keycloak --net keycloak-network -e DB_USER=keycloak -e DB_PASSWORD=postgres -e DB_ADDR=postgres -p 8080:8080 jboss/keycloak
```