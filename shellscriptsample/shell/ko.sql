select 'namespace,cbb_items' val from dual union all
select val from (select concat(trnsfr_origin_key_val,',',trnsfr_rslt_val) val
from cm_mlt_lng_trnsltn_d
where lng_cd = 'ko'
order by val) tmp;

