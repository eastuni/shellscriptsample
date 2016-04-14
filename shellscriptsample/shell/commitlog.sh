#!/bin/sh

usage(){
    echo "Usage: $0 start_revision"
    exit 1
}

[[ $# -eq 0 ]] && usage

START_REPOS=$1
echo "${START_REPOS}"

# Last revision number
END_REPOS=`svnlook youngest /usr/local/svn/repos/cbb` 
END_REPOS=`expr ${END_REPOS} + 1`
echo "$END_REPOS"

# log file clear
cp /dev/null svncommit.log

# svn change history 
while [ "${START_REPOS}" -lt "${END_REPOS}" ]
do
#	echo "[${START_REPOS}]"
	echo `svnlook changed /usr/local/svn/repos/cbb -r ${START_REPOS}|grep cbb-custom` >> svncommit.log
	START_REPOS=`expr ${START_REPOS} + 1`
done

# Last revision write
echo "${END_REPOS}" >> revision.txt

