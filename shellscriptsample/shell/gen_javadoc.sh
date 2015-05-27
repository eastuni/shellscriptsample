#!/bin/sh

if test $# -eq 3; then
        SHOME=$1
	JDHOME=$2
	TCLASSPATH=$3
else
	exit 2;
fi

if [ ! -d $JDHOME ]; then
	mkdir $JDHOME
fi

DOCLET="-doclet org.jboss.apiviz.APIviz -docletpath /home/jenkins/javadoc_lib/apiviz-1.3.1.GA/jar/apiviz-1.3.1.GA.jar"

CLASSPATH2="-classpath /opt/jdk1.6.0_41/jre/lib/*:/opt/jdk1.6.0_41/lib/*:/home/cbpdev/bxm/lib/*:/home/cbpdev/bxm/3rds/*:/home/cbpdev/bxm/deps/*:$TCLASSPATH"

OPTIONS="-use -quiet -splitindex"
SUBPKG="-subpackages bankware.corebanking"
/opt/jdk1.6.0_41/bin/javadoc -d $JDHOME $OPTIONS $CLASSPATH2 -sourcepath $SHOME $SUBPKG -tag Description:a:"OMM Description:" -tag file:a:"file:" -tag filetype:a:"file type:" -tag brief:a:"brief:" -tag history:a:"history:" -tag author:a:"author:"  
