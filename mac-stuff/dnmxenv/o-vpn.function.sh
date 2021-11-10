#!/usr/bin/env bash

export PATH="$PATH:/Applications/Pritunl.app/Contents/Resources/"
source <(/Applications/Pritunl.app/Contents/Resources/pritunl-client completion bash)


export KENV_OVPN_CON=~/.kaltenv/.enc/OVPN-PEMS


# OVP Commandline
# find ~/.kaltenv/.enc -type f -iname "*.ovpn" -print 
ovp(){
  local _dia_OPTIONS=$(find ~/.kaltenv/.enc -type f -iname "*.ovpn" -print | xargs -n 1 -I {} basename {} {} );
  local _dia_RESULTS=$(dialog --clear --backtitle "OPEN VPN CONNECT Selector" \
                              --title "OPEN VPN CONNECT Selector" \
                              --menu "Select OPEN VPN PROFILE:" 15 40 4 \
                              ${_dia_OPTIONS[@]} 2>&1 >/dev/tty); 
  ovpn_connect $_dia_RESULTS;
}

ovpn_connect(){ 
  eval $($(which openvpn) --config $@ );
  
}

# o_aws_ls(){ cat ~/.okta-aws | grep "^\[" | sed 's/\[//g; s/\]//g;' | tr " " "\n" ;}
