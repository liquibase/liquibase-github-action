#!/bin/bash

OPERATION=$1
CLASSPATH=$2
CHANGELOGFILE=$3
USERNAME=$4
PASSWORD=$5
URL=$6
COUNT=$7
TAG=$8
DATE=$9
REFERENCEURL=$10
PARAMS=()

. $PWD/common.sh

check_required_param $OPERATION username $USERNAME
check_required_param $OPERATION password $PASSWORD
validate_operation

docker-entrypoint.sh "${PARAMS[@]}" $OPERATION
