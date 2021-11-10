#!/usr/bin/env bash


function ssm_linux2(){
  echo "install AMZN"
  sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  sudo systemctl enable --now amazon-ssm-agent
  sudo systemctl start amazon-ssm-agent
}

function ssm_ubuntu(){
  echo "install ubuntu"
  mkdir /tmp/ssm
  cd /tmp/ssm
  wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
  sudo dpkg -i amazon-ssm-agent.deb
  sudo systemctl enable --now amazon-ssm-agent
  exit 0;
}


LINUX_DIST=`cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g'`
[[ $LINUX_DIST == "Ubuntu 18.04.4 LTS" ]] && ssm_ubuntu;
[[ $LINUX_DIST == "Amazon Linux 2" ]] && ssm_linux2;


echo $"Usage: $0 no support for dist: ${LINUX_DIST}"
exit 1