#!/usr/bin/env bash



function ssm_linux2(){
  echo "install AMZN"
  sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  sudo systemctl enable amazon-ssm-agent
  sudo systemctl start amazon-ssm-agent
}

function install_aws_inspector(){
  curl -O https://inspector-agent.amazonaws.com/linux/latest/install
  sudo bash install
}



