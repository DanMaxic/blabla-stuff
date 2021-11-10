#!/bin/sh



install_req(){
    apt update -y
    apt upgrade -y
    apt-get update -y 
    PACKAGES="openjdk-11-jre-headless net-tools nano wget unzip bash-completion git git-lfs awscli ansible apt-transport-https ca-certificates curl gnupg-agent software-properties-common maven allure gradle xvfb groovy ansible scala python-all-dev htop nodejs npm"
    apt install -y $PACKAGES
    apt-get install -qqy apt-utils
    apt-get -qqy update
    echo "after update"
    PREREQ_PACKAGE="sudo ssh wget curl supervisor jq \
    python2.7 git libpq-dev python-dev libffi-dev \
    nginx libcairo2 libpango1.0-0 g++ libyaml-cpp-dev \
    htop gettext libgettextpo-dev libsm6 nginx-extras \
    libxml2-dev libxslt1-dev libkrb5-dev build-essential \
    libssl-dev libxmlsec1-dev pkg-config"
    apt-get -qqy install ${PREREQ_PACKAGE}
    curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
    python2 get-pip.py
}
install_amazon_stack(){
    snap install -y amazon-ssm-agent
    curl -O https://inspector-agent.amazonaws.com/linux/latest/install
    chmod +x ./install
    ./install
    rm ./install
}

install_Docker(){
    apt-key fingerprint 0EBFCD88
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt-get update -y 
    local PACKAGES=" curl gnupg-agent software-properties-common docker-ce docker-ce-cli containerd.io"
    apt install -y $PACKAGES
    groupadd docker
    usermod -aG docker $USER
    usermod -aG docker ubuntu
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    mv ./kubectl /usr/local/bin/kubectl
}

install_opstools(){
    #rabbitmq, pgSQL client, 
    wget -q -O - https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
    sudo sh -c 'echo "deb http://www.apache.org/dist/cassandra/debian 311x main" > /etc/apt/sources.list.d/cassandra.list'
    
    sudo apt update
    apt install -y amqp-tools rabbitmq-server cassandra-tools redis-server
}

install_buildTools(){
    #dependency-check location: /usr/share/dependency-check/
    pip install dependency-check 
}

install_devTools(){
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    install minikube-linux-amd64 /usr/local/bin/minikube
    curl -sfL https://get.k3s.io | sh -
    sudo sh -c 'rabbitmqadmin --bash-completion > /etc/bash_completion.d/rabbitmqadmin'
    sudo sh -c 'rabbitmqadmin --bash-completion > /etc/bash_completion.d/rabbitmqadmin'
    complete -C '/usr/local/bin/aws_completer' aws
}
install_mlTools(){
    pip install --upgrade TensorFlow
}


main(){
    install_req
    install_amazon_stack
    install_Docker
    install_buildTools
    install_opstools
    install_buildTools
    install_devTools
    install_mlTools
}

main