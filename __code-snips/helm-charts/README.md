# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

templating output
```bash
kube
```

## Basic Stacks

### metric server
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml
```




## Login to eks
```bash
assr user-aws-prd-us 
aws eks update-kubeconfig --name is-visual-detection-eks --region us-west-2 --profile az
```


## selenoid

### defualt actions to perform on each and every k8s node
```bash
docker pull selenoid/chrome:87.0
docker pull registry.hub.docker.com/selenoid/chrome:87.0
docker network create -d bridge selenoid
```
OPERTING

```bash
helm template -f ./chart-values/selenoid-prd.yaml is-selenoid ./charts/selenoid/ > ./outputs/is-selenoid-prd-deployment.yaml
helm install -f ./chart-values/selenoid-prd.yaml is-selenoid  ./charts/selenoid/
helm upgrade -f ./chart-values/selenoid-prd.yaml is-selenoid  ./charts/selenoid/
helm uninstall is-selenoid
```




## SONAR QUBE
OPERTING

```bash
kubectl create namespace secops

helm template -f ./chart-values/sonarqube-backops.yaml sonarqube-backops -n secops ./charts/sonarqube/ > ./outputs/sonarqube-backops-backops-deployment.yaml
helm install -f ./chart-values/sonarqube-backops.yaml sonarqube-backops  -n secops ./charts/sonarqube/
helm upgrade -f ./chart-values/sonarqube-backops.yaml sonarqube-backops  -n secops ./charts/sonarqube/
helm uninstall sonarqube-backops -n secops


kubectl get pod -n secops -o wide

```
# guacamole-backops
```bash
helm template -f ./chart-values/guacamole-poc-backops.yaml guacamole-backops  -n secops ./charts/apache-guacamole/ > ./outputs/guacamole-backops-prd-deployment.yaml
helm install -f ./chart-values/guacamole-poc-backops.yaml guacamole-backops  -n secops ./charts/apache-guacamole/
helm upgrade -f ./chart-values/guacamole-poc-backops.yaml guacamole-backops  -n secops ./charts/apache-guacamole/
helm uninstall guacamole-backops  -n secops
```

# kubeapps
```bash
kubectl create namespace kubeapps

helm template kubeapps-poc -n kubeapps -f ./chart-values/kubeapps-poc_prd.yaml ./charts/kubeapps/  > ./outputs/kubeapps-poc-prd-deployment.yaml
helm install kubeapps-poc -n kubeapps -f ./chart-values/kubeapps-poc_prd.yaml ./charts/kubeapps/
helm upgrade kubeapps-poc -n kubeapps -f ./chart-values/kubeapps-poc_prd.yaml ./charts/kubeapps/
helm uninstall kubeapps-poc

```

# crossplain
```bash
kubectl create namespace crossplane-system

helm template crossplane-poc -n crossplane-system -f ./chart-values/crossplane-poc_prd.yaml ./charts/crossplane/  > ./outputs/crossplane-poc-prd-deployment.yaml
helm install crossplane-poc -n crossplane-system -f ./chart-values/crossplane-poc_prd.yaml ./charts/crossplane/ 
helm upgrade crossplane-poc -n crossplane-system -f ./chart-values/crossplane-poc_prd.yaml ./charts/crossplane/ 
helm uninstall crossplane-poc


curl -sL https://raw.githubusercontent.com/crossplane/crossplane/release-1.0/install.sh | sh
kubectl crossplane install provider crossplane/provider-aws:v0.16.0

```
## IS-Selenium grid: 3.151
```bash

helm template -f ./chart-values/is-selenium-prd-values.yaml is-selenium ./charts/is-selenium/ > ./outputs/is-selenium-prd-deployment.yaml
helm install -f ./chart-values/is-selenium-prd-values.yaml is-selenium ./charts/is-selenium/
helm upgrade -f ./chart-values/is-selenium-prd-values.yaml is-selenium ./charts/is-selenium/
```
## Portainer
```bash

helm template -f ./chart-values/portainer-poc-prd-values.yaml portainer-poc ./charts/portainer/ > ./outputs/portainer-poc-prd.yaml 
helm install -f ./chart-values/portainer-poc-prd-values.yaml portainer-poc ./charts/portainer/
helm upgrade -f ./chart-values/portainer-poc-prd-values.yaml portainer-poc ./charts/is-selenium/
```
# prometheus-adapter
```bash
helm template  prometheus-adapter stable/prometheus-adapter -n prometheus -f ./chart-values/prometheus-adapter-prd-values.yaml > ./outputs/prometheus-adapter-prd-deployment.yaml

helm install  prometheus-adapter stable/prometheus-adapter -n prometheus -f ./chart-values/prometheus-adapter-prd-values.yaml

helm upgrade  prometheus-adapter stable/prometheus-adapter -n prometheus -f ./chart-values/prometheus-adapter-prd-values.yaml
helm uninstall prometheus-adapter stable/prometheus-adapter -n prometheus
```


# Grafana
```bash
# helm repo add grafana https://grafana.github.io/helm-charts
helm template  is-grafana ./charts/grafana -n prometheus -f ./chart-values/is-grafana-prd-values.yaml > ./outputs/is-grafana-prd-deployment.yaml

helm install  is-grafana ./charts/grafana -n prometheus -f ./chart-values/is-grafana-prd-values.yaml
helm upgrade  is-grafana ./charts/grafana -n prometheus -f ./chart-values/is-grafana-prd-values.yaml
helm uninstall is-grafana ./charts/grafana -n prometheus
```

# Prometheus
```bash
helm template is-prom stable/prometheus -n prometheus -f ./chart-values/prometheus-prd-values.yaml > ./outputs/is-prometheus-prd-deployment.yaml
helm install is-prom stable/prometheus -n prometheus -f ./chart-values/prometheus-prd-values.yaml
helm upgrade is-prom stable/prometheus -n prometheus -f ./chart-values/prometheus-prd-values.yaml
helm uninstall is-prom -n prometheus
```


# Grafana
```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm template  is-grafana grafana/grafana -n prometheus -f ./chart-values/is-grafana-prd-values.yaml > ./outputs/is-grafana-prd-deployment.yaml

helm install  is-grafana grafana/grafana -n prometheus -f ./chart-values/is-grafana-prd-values.yaml
helm upgrade  is-grafana grafana/grafana -n prometheus -f ./chart-values/is-grafana-prd-values.yaml
helm uninstall is-grafana grafana/grafana -n prometheus
```

## password:
```
   kubectl get secret --namespace prometheus is-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

# JenkinsCI
```bash
helm repo add jenkins https://charts.jenkins.io
helm search repo jenkins



helm template  is-jenkins jenkins/jenkins -n default -f ./chart-values/jenkins-poc.yaml > ./outputs/is-jenkins-poc-deployment.yaml

helm install  is-jenkins jenkins/jenkins -n default -f ./chart-values/jenkins-poc.yaml
helm upgrade  is-jenkins jenkins/jenkins -n default -f ./chart-values/jenkins-poc.yaml
helm uninstall is-jenkins -n devops
```



workers security groups: sg-????

```bash
kubectl port-forward --namespace default \
  $(kubectl get pods --namespace default \
    -l app=is-selenium-selenium-hub \
    -o jsonpath='{ .items[0].metadata.name }') 4444
```



```bash
kubectl port-forward --namespace default \
  $(kubectl get pods --namespace default \
    -l app=is-selenium-selenium-chrome \
    -o jsonpath='{ .items[0].metadata.name }') 5555
```
```bash 
kubectl exec -i -t --namespace default \
  $(kubectl get pods --namespace default \
    -l app=is-selenium-selenium-chrome \
    -o jsonpath='{.items[0].metadata.name}') /bin/bash
```


```bash 
kubectl logs --namespace default \
  $(kubectl get pods --namespace default \
    -l app=is-selenium-selenium-chrome \
    -o jsonpath='{.items[0].metadata.name}') 
```

# Deploy FlouentD for CloudWatch
```bash
kubectl create configmap cluster-info \
--from-literal=cluster.name=is-visual-detection-eks \
--from-literal=logs.region=us-west-2 -n amazon-cloudwatch
```


```bash


kubectl logs -l app=is-selenium-selenium-chrome --all-containers -f

```



```bash

kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml



```