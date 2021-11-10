



```
version: '3.7'
services:
  consul:
    image: consul:latest
    network_mode: "host"
    environment:
      - CONSUL_ALLOW_PRIVILEGED_PORTS=
    volumes:
      - /etc/consul.d:/consul/config
    command: consul agent -client "127.0.0.1 10.104.58.181" -bind "10.104.58.181" -config-dir /consul/config -data-dir=/var/tmp -retry-join "provider=aws tag_key=Type tag_value=consul" -dns-port 53 -recursor 10.104.58.181
```
### 
```
cat <<EOT >> /etc/consul.d/config.json
{
  "dns_config": {
    "service_ttl": {
      "*": "10s"
  }
  }
}
EOT


cat <<EOT >> /etc/consul.d/config.json
{
  "service": {
    "id": "elasticsearch-master",
    "name": "elasticsearch-master",
    "tags": ["elasticsearch-master"],
    "meta": {
      "meta": "elasticsearch-master"
    },
    "port": 9200,
    "check": {
        "id": "elasticsearch-master",
        "name": "OTT Elasticsearch",
        "http": "http://localhost:9200/_cluster/health?pretty=true",
        "tls_skip_verify": false,
        "method": "GET",
        "interval": "15s",
        "timeout": "5s"
        }
  }
}
EOT
mkdir -p /etc/kaltura/consul/
cat <<EOT >> /etc/kaltura/consul/docker-compose.yaml
version: '3.7'
services:
  consul:
    image: consul:latest
    network_mode: "host"
    environment:
      - CONSUL_ALLOW_PRIVILEGED_PORTS=
    volumes:
      - /etc/consul.d:/consul/config
    command: consul agent -client "127.0.0.1 ${IP}" -bind ${IP} -config-dir /consul/config -data-dir=/var/tmp -retry-join "provider=aws tag_key=Type tag_value=consul" -dns-port 53 -recursor 10.104.0.2
EOT
IP=$(wget -qO- http://169.254.169.254/latest/meta-data/local-ipv4) /usr/local/bin/docker-compose up -d -f /etc/kaltura/consul/docker-compose.yaml

```

elasticsearch-client.service.consul
consul.service.consul
prometheus.service.consul

```dotnetcli
docker run -d --cap-add=NET_ADMIN \
  --sysctl net.ipv4.ip_forward=1 --device /dev/net/tun --restart=always \
   --log-opt max-size=1g \
   -e Secret= \
   adanite/odo_connector:eu_v3
```


