# TeamCity on Docker

## Description

Docker setup for a teamcity-server with postgres, and two teamcity agents. One of the agents is customized to be able to build .net core 2.2 projects.

* The containers run in their own docker network '**teamcity-net**'.
* All containers uses Docker Volumes for storage.

## Images

- docker.io/postgres:12-alpine
- docker.io/jetbrains/teamcity-server:latest
- docker.io/jetbrains/teamcity-agent:latest

## Volumes

Docker recommends using volumes to persist data beyond a containers lifetime.

- Persistent storage
- Uses the --mount flag to mount the volume tc-postgres.
- Docker will create the volume if it does not exist.
- Volumes are located in /var/lib/docker/volumes/\<volume-name\>
- It does not depend on the hosts directory structure.
- It works on both Linux and Windows.
- Docker cli can manage the volumes.

## User defined bridge network

Create the network 'teamcity-net':

```
docker network create teamcity-net
```

- Containers connected to the network can resolve eachother by container name or ip.
- Containers connected to the network can resolve containers in the default 'bridge' network by container ip.

# Postgres 

```
sudo docker run --name postgres-teamcity --restart always --network teamcity-net \
        -e POSTGRES_PASSWORD=passwd123 \
        -e POSTGRES_DB=teamcity \
        --mount src=teamcity-postgres,target=/var/lib/postgresql/data \
        -d postgres:12-alpine
```

## Psql client(Optional)

Start a container with the psql client.

```
docker run -it --rm --network teamcity-net postgres psql -h postgres-teamcity -U postgres
```

# Teamcity Server

Start the Teamcity server container.

- Uses docker volumes **'teamcity-data'** and **'teamcity-logs'**
- Connected to the network **'teamcity-net'**
- Passes in some environment variables for tuning the performance.

```
sudo docker run -d --name teamcity --restart always --network teamcity-net \
    -e TEAMCITY_SERVER_MEM_OPTS="-Xmx2g -XX:MaxPermSize=270m -XX:ReservedCodeCacheSize=350m" \
    --mount src=teamcity-data,target=/data/teamcity_server/datadir \
    --mount src=teamcity-logs,target=/opt/teamcity/logs \
    -p 8111:8111 \
    jetbrains/teamcity-server
```

# Teamcity Agents

Teamcity needs an agent to build for it. You can have both Linux and Windows agents. Here we start the default agent from the image docker.io/jetbrains/teamcity-agent and a customized agent capable of building .net core 2.2 projects. These agents are capable of 'Docker in Docker' and is therefore --priveleged.

## jetbrains/teamcity-agent

Start the default linux agent from JetBrains. 

```
sudo docker run -d -e SERVER_URL="teamcity:8111" --restart always --network teamcity-net \
    -e AGENT_NAME=itchy \
    --mount src=itchy-conf,target=/data/teamcity_agent/conf \
    --privileged -e DOCKER_IN_DOCKER=start \
    jetbrains/teamcity-agent
```

## .net core 3.0 linux agent

The default build agent don't always support the latest versions of .net core so we need to create a dockerfile and install the newest SDK.

### Dockerfile

```
FROM jetbrains/teamcity-agent:latest

RUN apt-get update \
&& apt-get install -y --no-install-recommends wget \
&& wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& add-apt-repository universe \
&& apt-get install apt-transport-https \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
dotnet-sdk-2.2 dotnet-sdk-3.0 \
&& rm -rf /var/lib/apt/lists/* \
&& rm packages-microsoft-prod.deb
```

### Build the image teamcity-agent2_2:latest 

Run the following command in the directory where you placed the Dockerfile.

```
docker build -t teamcity-agent2_2:latest .
```

### Start the agent

```
sudo docker run -d -e SERVER_URL="teamcity:8111" --name agent-scratchy --restart always --network teamcity-net \
    -e AGENT_NAME=scratchy \
    --mount src=scratchy-conf,target=/data/teamcity_agent/conf \
    --privileged -e DOCKER_IN_DOCKER=start \
    jetbrains/teamcity-agent:latest
```

Upgrade Teamcity 
```
docker stop agent-scratchy teamcity
docker pull jetbrains/teamcity-server 
docker pull jetbrains/teamcity-agent 
docker start teamcity agent-scratchy
```