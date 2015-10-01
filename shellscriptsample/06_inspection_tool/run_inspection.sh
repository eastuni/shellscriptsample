#!/bin/sh

java -Dcbb.method.inspection.path=/home/jenkins/06_inspection_tool -jar CbbMethodInspectionExctractor.jar  

echo "Package,Class Name,Modifier,Mehtod Name,Cause" > methodinspection.csv
cat methodinspection.txt >> methodinspection.csv
rm methodinspaction.txt
./set_bom.sh methodinspection.csv
