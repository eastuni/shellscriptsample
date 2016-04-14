#!/bin/sh

basearray=()
svcarray=()
batarray=()
for prj in  /var/lib/jenkins/sharedspace/CBP_SVN/*
do

#echo $prj
prjname=`basename $prj`
echo $prjname
#echo ${#prjname}
if [ ${#prjname} -eq 2 ];then
	if [ "${prjname}" == "UI" ];then
		continue	
	fi
	basearray+=($prjname)
elif [ ${#prjname} -eq 5 ];then
	if [[ ${prjname} =~ "Svc" ]];then
		svcarray[${#svcarray[*]}]=$prjname
	elif [[ ${prjname} =~ "Bat" ]];then
		batarray[${#batarray[*]}]=$prjname
	fi
fi

done

prjtxt="prj.txt"
svnprj="prjsvn.txt"
baseset=""
svcset=""
cnt=1
echo "* Base Project" > $prjtxt
echo "" > $svnprj
for base in ${basearray[@]}
do
	echo "|$cnt|$base||" >> $prjtxt
	baseset="${baseset},${base}"
	lower=`echo $base | tr '[:upper:]' '[:lower:]'`
	echo "cbb-${lower}.jar svn://cbp.bankware/cbb/trunk/${base}/dist/cbb-${lower}.jar" >> $svnprj
    cnt=$(($cnt + 1))
	echo "[/trunk/${base}]"
    echo "* = r"
	echo "@cbp_all = rw"
	echo "[/trunk/${base}/src]"
	echo "* ="
	echo "@cbp_all = rw"
	echo "[/trunk/${base}/src-gen]"
	echo "* ="
	echo "@cbp_all = rw"
done

echo "" >> $prjtxt
cnt=1
echo "* Service Project" >> $prjtxt
for svc in ${svcarray[@]}
do
	echo "|$cnt|$svc||" >> $prjtxt
	svcset="${svcset},${svc}"
	lower=`echo $svc | tr '[:upper:]' '[:lower:]'`
	echo "cbb-${lower}.jar svn://cbp.bankware/cbb/trunk/${svc}/dist/cbb-${lower}.jar" >> $svnprj
    cnt=$(($cnt + 1))
	echo "[/trunk/${svc}]"
    echo "* = rw"
    echo "@cbp_all = rw"

done

echo "" >> $prjtxt
cnt=1
echo "* Batch Project" >> $prjtxt
for bat in ${batarray[@]}
do
	echo "|$cnt|$bat||" >> $prjtxt
    cnt=$(($cnt + 1))
	echo "[/trunk/${bat}]"
    echo "* = rw"
    echo "@cbp_all = rw"
done

echo "" >> $prjtxt
echo $baseset >> $prjtxt
echo $svcset >> $prjtxt

echo "* Ant" > $prjtxt
echo "" > $svnprj
for base in ${basearray[@]}
do
	echo '<fileset dir="${workspace}/'$base'/src">' >> $prjtxt
	echo "    <patternset refid=\"sources.java\"/>" >> $prjtxt
	echo "</fileset>" >> $prjtxt
	echo '<fileset dir="${workspace}/'$base'/src-gen">' >> $prjtxt
	echo "    <patternset refid=\"sources.java\"/>" >> $prjtxt
	echo "</fileset>" >> $prjtxt
done
cnt=1
for svc in ${svcarray[@]}
do
	echo '<fileset dir="${workspace}/'$svc'/src">' >> $prjtxt
	echo "    <patternset refid=\"sources.java\"/>" >> $prjtxt
	echo "</fileset>" >> $prjtxt
	echo '<fileset dir="${workspace}/'$svc'/src-gen">' >> $prjtxt
	echo "    <patternset refid=\"sources.java\"/>" >> $prjtxt
	echo "</fileset>" >> $prjtxt
done
