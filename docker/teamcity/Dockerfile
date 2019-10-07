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