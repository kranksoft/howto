# Minishift
Running a local openshift cluster with Minishift under a Hyper-V NAT.

- Hyper-V NAT: 192.168.10.0/24

## Start
To start minishift after downloading the binary:
``` 
minishift start`
  --network-ipaddress 192.168.10.98 `
  --network-gateway 192.168.10.1 `
  --network-nameserver 8.8.8.8
```

## Builder images .net core 2.2

In order to build .net core 2.2 and 3.0 sourcecode in Minishift,  
update the Source to Image builder images. 

```
oc login -u system:admin

oc project openshift

oc create secret docker-registry redhat-registry `
  --docker-server=registry.redhat.io `
  --docker-username=terje.innerdal@gmail.com `
  --docker-password=t6V6Iou#44pt `
  --docker-email=unused
oc secrets link default redhat-registry --for=pull
oc secrets link builder redhat-registry

oc create -f https://raw.githubusercontent.com/redhat-developer/s2i-dotnetcore/master/dotnet_imagestreams.json
oc replace -f https://raw.githubusercontent.com/redhat-developer/s2i-dotnetcore/master/dotnet_imagestreams.json

oc describe is dotnet
```