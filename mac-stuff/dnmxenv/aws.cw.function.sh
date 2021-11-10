#!/usr/bin/env bash


cw_aws_show_help() {
  cat << EOF
Usage: ${0##*/} [-hv] [-f OUTFILE] [FILE]...
Do stuff with FILE and write the result to standard output. With no FILE
or when FILE is -, read standard input.

    -h          display this help and exit
    -f OUTFILE  write the result to OUTFILE instead of standard output.
    -v          verbose mode. Can be used multiple times for increased
                verbosity.
    -o          output format, options: wide
EOF
}


cwa_ls(){
  [[ $# -eq 0 ]] && getFullCFdetails

}



getFullCWdetails(){
  aws cloudwatch describe-alarms \
    --no-paginate \
    --query 'MetricAlarms[*].[AlarmName,ActionsEnabled,CreationTime,LastUpdatedTime,StateValue]' \
    --output=text;
}

### aws get object by tag
# aws cloudwatch describe-alarms | jq -r ‘.MetricAlarms[ ] | .AlarmName+” “+.Namespace+” “+.StateValue’
# aws cloudwatch describe-alarms | jq -r '.MetricAlarms[ ] | .AlarmName+" " +.Namespace+" "+.StateValue'
