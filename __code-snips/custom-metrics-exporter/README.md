# Prometheus bash exporter

Simple & minimalistic Prometheus exporter for Selenium Grid Hub .


## Installation
Use [Docker image](https://hub.docker.com/repository/docker/danmaxic/selenium-metrics-exporter) 
base binary file from [releases](https://github.com/gree-gorey/bash-exporter/releases).

## Docker quick start

```console
docker run --net=host -p 9300:9300 tst:latest 
```


Build docker 
```bash
docker  build  -t danmaxic/selenium-metrics-exporter:latest .
```

Push Image
```bash
docker push danmaxic/selenium-metrics-exporter:latest
```

sha256:dddc05fffa87e4d16afba5aae17e57bad633ccf2f9c5db47dafb0c38dd5eaa2a
sha256:c61ec63c6881e356ab830265bca4e1d3dbccc1c8c7a5e44cd57dbfef483e78d6
sha256:66b3c9fcba86856ce2e9c73bd112bec53662ae32c6fd3839b2cbfb99a2378140
sha256:1625668c70572cfe36fb64672a93fd7908365718053ec1b0246d49b72f9613ea