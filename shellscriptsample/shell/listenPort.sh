#/bin/sh

PORTLIST=(`netstat -tnlp|awk '{split($(4),a,":");print a[length(a)];}'`)
PIDLIST=(`netstat -tnlp|awk '{split($(NF),a,"/");print a[1];}'`)
echo $PORTLIST

for i in "${!PIDLIST[@]}"
do 
  echo "=======    ${PIDLIST[$i]} ,  ${PORTLIST[$i]}  =============="
  echo "ps -ef|grep ${PIDLIST[$i]}";
  #echo `ps -ef|grep ${PIDLIST[$i]}`;
  echo
done

