#!/bin/bash

function check_required_param() {
    local OP=$1
    local KEY=$2
    local VAL=$3
    if [ -z "$VAL" ]
    then
        echo "$OP requires $KEY to not be empty"
        exit 1
    fi
    PARAMS+=(--$KEY=$VAL)
}

function validate_operation() {
    case $OPERATION in
    update)
        check_required_param update changeLogFile $CHANGELOGFILE
        check_required_param update url $URL
        ;;

    updateCount)
        check_required_param updateCount changeLogFile $CHANGELOGFILE
        check_required_param updateCount url $URL
        check_required_param updateCount count $COUNT
        ;;

    tag)
        check_required_param tag url $URL
        check_required_param tag tag $TAG
        ;;

    updateToTag)
        check_required_param updateToTag changeLogFile $CHANGELOGFILE
        check_required_param updateToTag url $URL
        check_required_param updateToTag tag $TAG
        ;;

    rollback)
        check_required_param rollback changeLogFile $CHANGELOGFILE
        check_required_param rollback url $URL
        check_required_param rollback tag $TAG
        ;;

    rollbackCount)
        check_required_param rollbackCount changeLogFile $CHANGELOGFILE
        check_required_param rollbackCount url $URL
        check_required_param rollbackCount count $COUNT
        ;;

    rollbackToDate)
        check_required_param rollbackToDate changeLogFile $CHANGELOGFILE
        check_required_param rollbackToDate url $URL
        check_required_param rollbackToDate date $DATE
        ;;

    updateSQL)
        check_required_param updateSQL changeLogFile $CHANGELOGFILE
        check_required_param updateSQL url $URL
        ;;

    futureRollbackSQL)
        check_required_param futureRollbackSQL changeLogFile $CHANGELOGFILE
        check_required_param futureRollbackSQL url $URL
        ;;

    status)
        check_required_param status url $URL
        ;;

    history)
        check_required_param history url $URL
        ;;

    diff)
        check_required_param diff url $URL
        check_required_param diff referenceUrl $REFERENCEURL
        ;;

    *)
        echo "$OPERATION is not a valid operation"
        exit 1
        ;;
    esac
}
