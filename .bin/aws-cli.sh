#!/bin/sh
COMMAND="--version"
PROFILE="default"

while getopts c:p OPT
do
  case $OPT in
    c ) COMMAND=$OPTARG;;
    p ) PROFILE=$OPTARG;;
    *) echo "Usage: .bin/aws-cil.sh -c \"The aws command here.\""; exit 1;;
  esac
done

docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli "$COMMAND" --profile "$PROFILE"
