#!/bin/sh

usage(){
    echo "Usage: $0 version"
    exit 1
}

[[ $# -eq 0 ]] && usage

VERSION=$1

echo "${VERSION}"

TARNAME=cbbcustom${VERSION}.tar

tar -cvf ${TARNAME} svncommit.log

while IFS='' read -r line || [[ -n "$line" ]]; do

target=cbb-custom/src/${line}

tar -uf ${TARNAME} $target

done < ./svncommit.log
