# Dotnet Core S2I builder images
Install the S2I builder imagestreams to be able to build dotnet core 2.2 projects from source.

### Login as system:admin
```
oc login -u system:admin
oc project openshift
```


### Create secret for docker registry
```
oc create secret docker-registry redhat-registry `
  --docker-server=registry.redhat.io `
  --docker-username=terje.innerdal@gmail.com `
  --docker-password=t6V6Iou#44pt `
  --docker-email=unused
oc secrets link default redhat-registry --for=pull
oc secrets link builder redhat-registry
```

### Create/replace imagestreams
```
oc create -f https://raw.githubusercontent.com/redhat-developer/s2i-dotnetcore/master/dotnet_imagestreams.json
oc replace -f https://raw.githubusercontent.com/redhat-developer/s2i-dotnetcore/master/dotnet_imagestreams.json
```
