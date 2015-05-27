#!/bin/sh 

if [ $# -ne 2 ]; then
	echo "Usage: $0 batchJobInstanceId instCd"
	exit 1
fi
INST_CD=$2
BATCH_JOB_INSTNC_ID=$1
PARAM_LIST=''
BATCH_DATA=''

BXM_HOME=$HOME/bxm 
BAT_HOME=$BXM_HOME/batch 
APP_HOME=$BAT_HOME/app_home 
CLASSPATH=$BAT_HOME/config

#EXECUTE SQL TO GET BATCH INFO
. $BAT_HOME/db.sh

for f in `find $BXM_HOME/lib -type f -name "*.jar"`
do
   CLASSPATH=$CLASSPATH:$f
done
for f in `find $BXM_HOME/deps -type f -name "*.jar"`
do
   CLASSPATH=$CLASSPATH:$f
done

for f in `find $BAT_HOME/lib -type l -name "*.jar"`
do
   CLASSPATH=$CLASSPATH:$f
done
for f in `find $BAT_HOME/deps -type l -name "*.jar"`
do
   CLASSPATH=$CLASSPATH:$f
done

LOGFILE=$BAT_HOME/logs/${BATCH_DATA[0]}/${BATCH_DATA[1]}/${BATCH_JOB_INSTNC_ID}_`date "+%Y%m%d%H%M%S"`.log
JAVA_BIN=$JAVA_HOME/bin/java
OPT="-Xms64m -Xmx64m -Dlogfile=${LOGFILE} -Dconfig-location=file:///$BAT_HOME/config/bxm-batch.xml -Dbatch.extend=false -Dbatch.default.param=true -classpath $CLASSPATH "
#OPT="-Xms64m -Xmx64m -Dconfig-location=file:///$BAT_HOME/config/bxm-batch.xml -classpath $CLASSPATH "

echo "***************************************************************"
echo "  - JAVA_BIN          : ${JAVA_BIN}                            "
echo "  - OPT               : ${OPT}                                 "
echo "***************************************************************"

start=`date "+%H %M %S"`
NOW=`date +%s.%N`
if [ "${BATCH_DATA[3]}" = "Y" ]; then
	BAT_OPT='jobDt="'`date "+%Y%m%d"`'" time="'`date "+%H%M%S"`'"'
else
	BAT_OPT='jobDt="'`date "+%Y%m%d"`'"'
fi
RET= $JAVA_BIN $OPT bxm.batch.core.launch.support.CommandLineJobRunner "$APP_HOME/${BATCH_DATA[0]}" "${BATCH_DATA[0]}" "${BATCH_DATA[1]}" $BAT_OPT jobDt="$DAY" time="" $PARAM_LIST

end=`date "+%H %M %S"`

echo $RET

echo "$end $start" | awk ' {
                sec = ($1*3600 + $2*60 + $3) - ($4*3600 + $5*60 + $6);
            };
            END { printf "elapsed time : %s sec.\n", sec}'
            
#END=`date +%s.%N`
#DIFF=`echo "$END - $NOW" | bc`
#echo "elapsed time : ${DIFF}"
