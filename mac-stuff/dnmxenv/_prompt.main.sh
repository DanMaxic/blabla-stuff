#!/usr/bin/env bash



# _KENV_


k_env_env(){
 echo "TDB"
}

git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# TERMINAL PROMPT




k_env_env_set_prompt(){

   PS1="\[\e[0;93m\]\u\[\e[m\]"    # username
   PS1+=" "    # space
   PS1+="\[\e[0;95m\]\W\[\e[m\]"    # current directory
   PS1+="\[\e[0;92m\]\$(git_branch)\[\e[m\]"    # current branch
   PS1+=" "    # space
   PS1+=">> "    # end prompt
   export PS1;
   export CLICOLOR=1
   export LSCOLORS=ExFxBxDxCxegedabagacad
}

PS1="\[\e[0;93m\]\u\[\e[m\]"    # username


k_env_env_set_prompt