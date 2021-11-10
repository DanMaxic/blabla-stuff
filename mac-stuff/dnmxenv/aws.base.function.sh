#!/usr/bin/env bash

o_aws_ls(){ cat ~/.okta-aws | grep "^\[" | sed 's/\[//g; s/\]//g;' | tr " " "\n" ;}


o_aws_connect(){  
  eval $($(which okta-awscli) --profile $@ --okta-profile $@);
  export AWS_DEFAULT_PROFILE="$@" ;
  aws iam list-account-aliases --output table;
  aws sts  get-caller-identity --output table;
}

o_aws(){ 
  if [[ $# -eq 0 ]] ; then
    local _dia_OPTIONS=$(cat ~/.okta-aws | grep "^.*\[" | sed 's/\[//g; s/\]//g;' | xargs -n 1 -I {} echo {} {} );
    local _dia_RESULTS=$(dialog --clear --backtitle "SRE AWS Selector" --title "Okta AWS Selector" --menu "Select AWS Account:" 15 40 4 ${_dia_OPTIONS[@]} 2>&1 >/dev/tty);
    o_aws_connect $_dia_RESULTS;
  else
    o_aws_connect $@
  fi
  
}


ec2_details(){ 
  eval $(aws ec2 describe-instances --instance-id $@ );
}

ec2_ls(){ 
#	aws ec2 describe-instances \
#	--query 'Reservations[*].Instances[*].[PrivateIpAddress,join(``,?!not_null(Tags[?Key==`Name`].Value)),InstanceId,State.Name ]' \
#	--output=text; 
	aws ec2 describe-instances --no-paginate --output json | jq -rc '.Reservations[].Instances[] |[.LaunchTime,.InstanceId,(.Tags[]?|select(.Key=="Name")|.Value),(.Tags[]?|select(.Key=="Type")|.Value), (.Tags[]?|select(.Key=="Env")|.Value), (.Platform // "linux" ) ] | @csv'



#	aws ec2 describe-instances \
#	--query 'Reservations[*].Instances[*].{PrivateIpAddress: PrivateIpAddress,Name: Tags[?Key==`Name`].Value,InstanceId: InstanceId,State: State.Name }' 
#	--output=table; 
}

ec2_is_win(){
  aws ec2 describe-instances \
	  --instance-ids "$@" \
    --query 'Reservations[*].Instances[*].[Platform]' \
    --output=text;
}

rdp(){ ssm_rdp "$@";}
ssm(){ aws ssm start-session --target "$@"; }

ssm_port(){
  aws ssm start-session \
  --target "$1" \
  --document-name AWS-StartPortForwardingSession \
  --parameters "{\"portNumber\":[\"$2\"], \"localPortNumber\":[\"$3\"]}"

}

ssm_rdp(){  
  echo "aws ssm start-session \
    --target "$1" \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["3389"], "localPortNumber":["13389"]}'"

  aws ssm start-session \
    --target "$1" \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["3389"], "localPortNumber":["13389"]}'
}

ec2(){
  echo "TBD"
}

ec2_attr(){ 
	aws ec2 describe-instances \
	--query 'Reservations[*].Instances[*].[PrivateIpAddress,join(``,Tags[?Key==`Name`].Value),InstanceId,State.Name ]' \
	--output=text;
}

ssm_poc(){ aws ssm start-session --target "$@"; }

# cf_ls(){
#   aws cloudformation describe-stacks \
#   --query 'Stacks[*].[StackName,DriftInformation.StackDriftStatus,DriftInformation.LastCheckTimestamp ]' \
#   --output=text;
# }


### aws get object by tag
