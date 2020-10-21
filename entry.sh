#!/bin/bash

OPERATION=$1
CHANGELOGFILE=$2
USERNAME=$3
PASSWORD=$4
URL=$5
COUNT=$6
TAG=$7
DATE=$8
PARAMS=()

. common.sh

check_required_param $OPERATION username $USERNAME
check_required_param $OPERATION password $PASSWORD
validate_operation

docker-entrypoint.sh "${PARAMS[@]}" $OPERATION
