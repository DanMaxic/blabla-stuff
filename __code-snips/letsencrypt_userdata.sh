#!/bin/sh

DOMAINS='[
 
]'

install_req() {
  apt update -y
  apt upgrade -y
  apt-get update -y
  PACKAGES="jq nginx"
  apt install -y $PACKAGES
  curl -o- https://raw.githubusercontent.com/vinyll/certbot-install/master/install.sh | bash
}

configure_nginx() {
  local domains_list=""
  domains_list=$(echo $DOMAINS | jq 'reduce .[] as $item (""; . + " *." + $item)')
  domains_list=$(echo "$domains_list" | sed -r 's/^"|"$//g')
  cat /dev/null >> sudo tee /etc/nginx/sites-available/default
  cat <<EOF | sudo tee /etc/nginx/sites-available/default
upstream webapp_upstream {
  server 10.0.1.113:80;
  server 10.0.2.188:80;
}
  
server {
  listen 443 ssl;

  server_name ${domains_list};

  location / {
    proxy_set_header http_x_forwarded_proto https;
    proxy_pass http://webapp_upstream;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Scheme \$scheme;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_read_timeout 10s;
    proxy_redirect off;
    access_log /var/log/nginx/access.log;
  }
}
EOF
}

configure_initial_certs() {
    domains_list=$(echo $DOMAINS | jq 'reduce .[] as $item (""; . + " -d *." + $item)')
  domains_list=$(echo "$domains_list" | sed -r 's/^"|"$//g')
  mkdir /etc/nginx/certs
  cmd="certbot --nginx ${domains_list} -w /etc/nginx/certs --no-redirect --hsts --duplicate --agree-tos -m support@????.com -n --deploy-hook 'systemctl reload nginx'"
  sudo bash -c "$cmd"
}

configure_crontab() {
  crontab -l >tempcron 2>/dev/null
  task="certbot renew --post-hook 'systemctl reload nginx'"
  echo "@monthly sudo bash -c \"${task}\"" >> tempcron
  crontab tempcron
  rm tempcron
}

install_amazon_stack() {
  snap install -y amazon-ssm-agent
  curl -O https://inspector-agent.amazonaws.com/linux/latest/install
  chmod +x ./install
  ./install
  rm ./install
}

main() {
  install_req
  install_amazon_stack
  configure_nginx
  # configure_initial_certs
  configure_crontab
}

main
