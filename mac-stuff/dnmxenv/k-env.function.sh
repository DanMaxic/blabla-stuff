#!/usr/bin/env bash



# _KENV_


k_env(){
 echo "TDB"
}


k_env_printEnv(){
   local _k8s_context=$(kubectl config current-context);
   local _aws_context=$(printenv AWS_DEFAULT_PROFILE || echo "<null>");
   local _ovpn_context="<null>"; 
   local _odo_context="<null>"; 

   local _kenv_context="<null>"; 
   local term_header="K ZIRA || K_ENV=${_kenv_context} | K_AWS= ${_aws_context} |K_K8S=${_k8s_context} "
   # echo "$term_header"
#  export PROMPT_COMMAND="echo -ne K ZIRA |K_ENV=\*${_kenv_context}\* |K_AWS=\*${_aws_context}\* |K_K8S=\*${_k8s_context}\* "
#  PROMPT_COMMAND=echo -ne "SOME "
   echo -ne "\033]0;${term_header}\007"
}
function setTitle(){
   echo -e "\033]0;$@\007"
}


k_env_printEnv
