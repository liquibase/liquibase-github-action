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
REFERENCEURL=${10}
CHECKSSETTINGSFILE=${11}
PROLICENSEKEY=${12}
HUBAPIKEY=${13}
LICENSEKEY=${14}
DATABASECHANGELOGTABLENAME=${15}
DATABASECHANGELOGLOCKTABLENAME=${16}

PARAMS=()
VALUES=()
# Liquibase requires some parameters to come after the command name, those parameters should be added to this list.
SECONDPARAMS=()

function check_required_param() {
    local OP=$1
    local KEY=$2
    local VAL=$3
    local IsVALUE=${4:-false}
    local IsSecondParam=${5:-false}
    if [ -z "$VAL" ]
    then
        echo "$OP requires $KEY to not be empty"
        exit 1
    fi
    check_optional_param "$OP" "$KEY" "$VAL" "$IsVALUE" "$IsSecondParam"
}

function check_optional_param() {
    local OP=$1
    local KEY=$2
    local VAL=$3
    local IsVALUE=${4:-false}
    local IsSecondParam=${5:-false}

    if [ -z "$VAL" ]
    then
        echo "$KEY is empty"
    else
        if [ "$IsVALUE" = true ]
        then
            VALUES+=($VAL)
        else
            if [ "$IsSecondParam" = true ]
            then
                SECONDPARAMS+=(--$KEY=$VAL)
            else
                PARAMS+=(--$KEY=$VAL)
            fi
        fi
    fi
}


function validate_operation() {
    case $OPERATION in
    update)
        check_required_param update username $USERNAME
        check_required_param update password $PASSWORD
        check_required_param update classpath $CLASSPATH
        check_required_param update changeLogFile $CHANGELOGFILE
        check_required_param update url $URL
        check_optional_param update databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param update databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    updateCount)
        check_required_param updateCount username $USERNAME
        check_required_param updateCount password $PASSWORD
        check_required_param updateCount classpath $CLASSPATH
        check_required_param updateCount changeLogFile $CHANGELOGFILE
        check_required_param updateCount url $URL
        check_required_param updateCount count $COUNT true
        check_optional_param updateCount databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param updateCount databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    tag)
        check_required_param tag username $USERNAME
        check_required_param tag password $PASSWORD
        check_required_param tag url $URL
        check_required_param tag tag $TAG true
        check_optional_param tag databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param tag databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    updateToTag)
        check_required_param updateToTag username $USERNAME
        check_required_param updateToTag password $PASSWORD
        check_required_param updateToTag classpath $CLASSPATH
        check_required_param updateToTag changeLogFile $CHANGELOGFILE
        check_required_param updateToTag url $URL
        check_required_param updateToTag tag $TAG true
        check_optional_param updateToTag databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param updateToTag databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    rollback)
        check_required_param rollback username $USERNAME
        check_required_param rollback password $PASSWORD
        check_required_param rollback classpath $CLASSPATH
        check_required_param rollback changeLogFile $CHANGELOGFILE
        check_required_param rollback url $URL
        check_required_param rollback tag $TAG true
        check_optional_param rollback databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param rollback databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    rollbackCount)
        check_required_param rollbackCount username $USERNAME
        check_required_param rollbackCount password $PASSWORD
        check_required_param rollbackCount classpath $CLASSPATH
        check_required_param rollbackCount changeLogFile $CHANGELOGFILE
        check_required_param rollbackCount url $URL
        check_required_param rollbackCount count $COUNT true
        check_optional_param rollbackCount databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param rollbackCount databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    rollbackToDate)
        check_required_param rollbackToDate username $USERNAME
        check_required_param rollbackToDate password $PASSWORD
        check_required_param rollbackToDate classpath $CLASSPATH
        check_required_param rollbackToDate changeLogFile $CHANGELOGFILE
        check_required_param rollbackToDate url $URL
        check_required_param rollbackToDate date $DATE true
        check_optional_param rollbackToDate databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param rollbackToDate databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    updateSQL)
        check_required_param updateSQL username $USERNAME
        check_required_param updateSQL password $PASSWORD
        check_required_param updateSQL classpath $CLASSPATH
        check_required_param updateSQL changeLogFile $CHANGELOGFILE
        check_required_param updateSQL url $URL
        check_optional_param updateSQL databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param updateSQL databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    futureRollbackSQL)
        check_required_param futureRollbackSQL username $USERNAME
        check_required_param futureRollbackSQL password $PASSWORD
        check_required_param futureRollbackSQL classpath $CLASSPATH
        check_required_param futureRollbackSQL changeLogFile $CHANGELOGFILE
        check_required_param futureRollbackSQL url $URL true
        check_optional_param futureRollbackSQL databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param futureRollbackSQL databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    status)
        check_required_param status username $USERNAME
        check_required_param status password $PASSWORD
        check_required_param status classpath $CLASSPATH
        check_required_param status changeLogFile $CHANGELOGFILE
        check_required_param status url $URL
        check_optional_param status databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param status databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    history)
        check_required_param history username $USERNAME
        check_required_param history password $PASSWORD
        check_required_param history url $URL
        check_optional_param history databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param history databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    diff)
        check_required_param diff username $USERNAME
        check_required_param diff password $PASSWORD
        check_required_param diff url $URL
        check_required_param diff referenceUrl $REFERENCEURL true
        check_optional_param diff databaseChangeLogTableName $DATABASECHANGELOGTABLENAME
        check_optional_param diff databaseChangeLogLockTableName $DATABASECHANGELOGLOCKTABLENAME
        ;;

    validate)
        check_required_param validate username $USERNAME
        check_required_param validate password $PASSWORD
        check_required_param validate url $URL
        check_required_param validate changeLogFile $CHANGELOGFILE
        ;;

    "checks run")
        check_required_param "checks run" changeLogFile $CHANGELOGFILE
        check_required_param "checks run" checksSettingsFile $CHECKSSETTINGSFILE false true
        ;;

    *)
        echo "$OPERATION is not a valid operation"
        exit 1
        ;;
    esac
}

check_optional_param "$OPERATION" proLicenseKey $PROLICENSEKEY
check_optional_param "$OPERATION" hubApiKey $HUBAPIKEY
check_optional_param "$OPERATION" licenseKey $LICENSEKEY
validate_operation

docker-entrypoint.sh "${PARAMS[@]}" $OPERATION "${VALUES[@]}" "${SECONDPARAMS[@]}"
