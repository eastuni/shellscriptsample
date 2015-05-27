#!/bin/sh
echo "ok"

lang=$1
target=$2

mysql -sN -ucbb -pcbb cbb < "$lang.sql" > "./$lang.csv" 
cp $lang.csv $target

