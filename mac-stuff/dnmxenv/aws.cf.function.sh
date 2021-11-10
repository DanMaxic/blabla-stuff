#!/usr/bin/env bash
aws_cf_ls_ver(){
  echo "0.0.0.1"
  printenv
}

aws_cf_ls_show_help() {
  cat << EOF
Usage: ${0##*/} [-hv] [-f OUTFILE] [FILE]...
Do stuff with FILE and write the result to standard output. With no FILE
or when FILE is -, read standard input.
    -h      displays this message
    -d      display drifts Only
    -v      display comp-version
    -f      output format, options: wide
EOF
}


cf_ls(){
  [[ $# -eq 0 ]] && aws_cf_get_stacks
  while getopts h:d:v: flag
   do
      case "${flag}" in
         h) aws_cf_ls_show_help;;
         d) aws_cf_get_drifted_stacks;;
         v) aws_cf_ls_ver;;
      esac
   done
}



aws_cf_get_stacks(){
  aws cloudformation describe-stacks \
    --no-paginate \
    --query 'Stacks[*].{StackName:StackName,StackStatus:StackStatus,CreationTime:CreationTime,LastUpdatedTime:LastUpdatedTime,StackDriftStatus: DriftInformation.StackDriftStatus,LastCheckTimestamp:DriftInformation.LastCheckTimestamp}' \
    --output=table;
}
aws_cf_get_drifted_stacks(){
  aws cloudformation describe-stacks \
    --no-paginate \
    --query 'Stacks[?DriftInformation.StackDriftStatus==`DRIFTED`].{_StackName:StackName,_StackStatus:StackStatus,CreationTime:CreationTime,LastUpdatedTime:LastUpdatedTime,StackDriftStatus: DriftInformation.StackDriftStatus,LastCheckTimestamp:DriftInformation.LastCheckTimestamp}' \
    --output=table;
}

getFullCFdetails(){
  aws cloudformation describe-stacks \
    --no-paginate \
    --query 'Stacks[*].{StackName:StackName,StackStatus:StackStatus,CreationTime:CreationTime,LastUpdatedTime:LastUpdatedTime,StackDriftStatus: DriftInformation.StackDriftStatus,LastCheckTimestamp:DriftInformation.LastCheckTimestamp}' \
    --output=table;
}
cf_ls2(){
  aws cloudformation list-stacks \
    --no-paginate \
    --query 'StackSummaries[*].{StackName:StackName,StackStatus:StackStatus,CreationTime:CreationTime,LastUpdatedTime:LastUpdatedTime,StackDriftStatus: DriftInformation.StackDriftStatus,LastCheckTimestamp:DriftInformation.LastCheckTimestamp}' \
    --output=table;
}
### aws get object by tag
# aws cloudwatch describe-alarms | jq -r '.MetricAlarms[ ] | .AlarmName+" " +.Namespace+" "+.StateValue'
