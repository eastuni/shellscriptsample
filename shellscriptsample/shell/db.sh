#!/bin/sh

if [ -z "$INST_CD" ]; then
	INST_CD=001
fi

if [ -z "$BATCH_JOB_INSTNC_ID" ]; then
	BATCH_JOB_INSTNC_ID=ClassTestJob_002
fi

BATCH_SQL='SELECT jm.`BATCH_APLCTN_NM`,jm.`BATCH_JOB_ID`, jid.`LOG_LVL_CD`, jid.`RE_EXCTN_ABLE_YN` FROM `sv_inst_batch_job_instnc_d` jid 
JOIN `sv_inst_batch_job_d` jd ON jd.`INST_CD` = jid.`INST_CD` AND jd.`BATCH_JOB_ID` = jid.`BATCH_JOB_ID`
JOIN `sv_batch_job_m` jm ON jm.`BATCH_JOB_ID` = jd.`BATCH_JOB_ID`  
WHERE jid.`INST_CD` = "'$INST_CD'"
AND   jid.`BATCH_JOB_INSTNC_ID` = "'$BATCH_JOB_INSTNC_ID'"
AND   jd.`DEL_YN` = "N";'

PARAM_SQL='SELECT concat(PARM_ATRBT_NM,"=\"",PARM_VAL,"\"") FROM sv_inst_batch_job_instnc_p WHERE INST_CD = "'$INST_CD'" AND   BATCH_JOB_INSTNC_ID = "'$BATCH_JOB_INSTNC_ID'";'

BATCH_DATA=(`echo $BATCH_SQL|mysql -sN -ucbb -pcbb cbb`)
echo ${BATCH_DATA[1]}
if [ -z ${BATCH_DATA} ]; then
	echo "no such job instance id : INST_CD=${INST_CD} JOB_INSTANCE_ID=${BATCH_JOB_INSTNC_ID}"
	exit 1
fi
PARAM_LIST=`echo $PARAM_SQL|mysql -sN -ucbb -pcbb cbb`
echo ${PARAM_LIST}
