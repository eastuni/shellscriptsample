#!/bin/sh
# add_bom.sh

FILE=$1

check() {
  if (( e = "$1" )); then
    echo "ERROR: $ACTION failed!!"
    exit $e
  else
    echo "INFO: $ACTION Success!!"
  fi
}

set_bom() {
    ACTION="Setting utf-8 BOM"
    # Detect if BOM already exists
    BOM=`sed -n '1{/^\xEF\xBB\xBF/p}' $FILE`
    if [ -z $BOM ]; then
        [ -f "$FILE" ] && /usr/bin/vim -e -s +"set bomb|set encoding=utf-8|wq" $FILE
        check $?
    fi
}

set_bom
