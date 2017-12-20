#!/bin/sh

function cpt () {
  echo $1;
	sudo cp -f ~cbpdev/ui/$1 $1
}

LI=`find . -name *.csv`
for TF in $LI
do
	if [[ $TF =~ "messages" ]];then
		cpt $TF
	fi
done

