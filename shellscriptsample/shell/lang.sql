WHENEVER SQLERROR EXIT 1
SET LINES 32000
SET TERMOUT OFF ECHO OFF NEWP 0 SPA 0 PAGES 0 FEED OFF HEAD OFF TRIMS ON TAB OFF
SET SERVEROUTPUT OFF

spool &1

select trnsfr_origin_key_val||','||trnsfr_rslt_val from cm_mlt_lng_trnsltn_d where lng_cd = '&2';

spool off
exit

