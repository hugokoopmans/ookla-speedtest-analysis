-- convert gm code to gid
ALTER TABLE tm4gcoverage ADD COLUMN gid int;
UPDATE tm4gcoverage SET gid = CAST(SUBSTRING(gm_code from 3 for 4) AS integer);

-- create t-mobile 4g coverage dataset
drop table if exists datatm4gcoverage;

create table datatm4gcoverage as
select
o.os,
o.device_id,
o.download_kbps,
o.upload_kbps,
o.latency,
o.client_longitude,
o.client_latitude,
o.operator,
f.gm_code,
o.client_city,
o.test_date,
f.gm_naam
--ST_Transform(ST_SetSRID(ST_MakePoint(o.client_longitude, o.client_latitude),4326),28992) as test_point
from
ookla_all_data_clean o, 
(
select
g.gm_code,
g.gm_naam,
g.geom
from
tm4gcoverage t, nlstaging.gem_2013 g
where
g.gm_code = t.gm_code
AND
t.tmnl_had_4g_q4_2014 = 1
) f
where
o.technology = '4G' 
AND
st_contains(f.geom, ST_Transform(ST_SetSRID(ST_MakePoint(o.client_longitude, o.client_latitude),4326),28992))
AND
o.operator IN ('T-Mobile NL','Vodafone NL','KPN NL')
;

select operator,count(*) from datatm4gcoverage group by operator order by count desc;

-- test
select
g.gid,
g.gm_naam,
t.gm_naam
--g.geom
from
tm4gcoverage t, nlstaging.gem_2013 g
where
g.gid = t.gid
AND
t.tmnl_had_4g_q4_2014 = 1
;

-- filter on 4g =1
select count(*) from tm4gcoverage t where t.tmnl_had_4g_q4_2014 = 1


