cat << EOF >>  /etc/security/limits.conf
user - memlock unlimited
user - nofile 65535
user - nproc 510693
user - as unlimited
EOF


sed -i -e "s/minfds=1024/minfds=4096/g"  /etc/supervisord.conf