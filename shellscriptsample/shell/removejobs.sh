#!/bin/bash

containsnotElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 1; done
  return 0
}

arr=()
while IFS='' read -r line || [[ -n "$line" ]]; do
  
  echo "$line"
  arr+=($line)
done < ./jobname.txt

for job in ./jobs/* ;do
  job2=$(basename $job)
	echo $job2
  if containsnotElement $job2 "${arr[@]}" ;then
		echo ">>> rm $job"
		rm -rf $job
	fi
	
done
