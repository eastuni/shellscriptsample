#!/bin/sh

echo "send mail."

TO="hyungman.kang@bankwareglobal.com;kijeong.lee@bankwareglobal.com;inbae.kim@bankwareglobal.com;yoonoh.roh@bankwareglobal.com;yongsoon.park@bankwareglobal.com;hongun.song@bankwareglobal.com;youngki.sim@bankwareglobal.com;wooyung.jung@bankwareglobal.com;namkyu.cho@bankwareglobal.com;donghyun.cho@bankwareglobal.com"
#TO="donghyun.cho@bankwareglobal.com"

mutt -s "CBP Method Naming inspection Result" $TO -a methodinspection.csv <<EOF 
시스템에서 보내는 메일입니다.

첨부 파일은 Method명에 대해서 Inspection한 결과 입니다.
엑셀로 확인하실 수 있습니다.

확인 후 
동사나 약어 또는 영문명을 등록하시거나, 
 Method 명을 수정하시기 바랍니다.

메소드표준동사 wiki입니다
http://redmine.bankware/projects/cbp/wiki/MethodVerbs

감사합니다.
EOF

