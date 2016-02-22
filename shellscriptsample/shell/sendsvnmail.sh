#!/bin/sh

while IFS='' read -r line || [[ -n "$line" ]]; do
	echo "$line"

arr=(`echo $line|cut -d "=" --output-delimiter=" " -f 1-`)
name=${arr[0]}
passwd=${arr[1]}
TO="$name@bankwareglobal.com"

mutt -s "CBP SVN ID" $TO <<EOF 
안녕하세요.

CBP SVN 계정 입니다.
 
ID: $name
PW: $passwd
 
감사합니다.
EOF
done < $1

