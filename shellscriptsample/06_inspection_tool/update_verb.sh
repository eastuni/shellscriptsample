#!/bin/sh
if [ -f MethodVerbs.txt ];then
 rm MethodVerbs.txt
fi
wget http://redmine.bankware/projects/cbp/wiki/MethodVerbs.txt
grep '|[a-z]' MethodVerbs.txt |awk '{split($1,a,"|");print a[2]}' > verb.txt
