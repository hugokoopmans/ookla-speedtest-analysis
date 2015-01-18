-- create top20 dataset
drop table if exists dataset4gtop20;
create table dataset4gtop20 as
select
o.os,
o.device_id,
o.download_kbps,
o.upload_kbps,
o.latency,
o.client_longitude,
o.client_latitude,
o.operator,
t.gm_code,
o.client_city,
t.gm_naam,
ST_Transform(ST_SetSRID(ST_MakePoint(o.client_longitude, o.client_latitude),4326),28992) as test_point
from
ookla_all_data_clean o, top20layer t
where
o.technology = '4G' AND
st_contains(t.geom, ST_Transform(ST_SetSRID(ST_MakePoint(o.client_longitude, o.client_latitude),4326),28992))
AND
o.operator IN ('T-Mobile NL','Vodafone NL','KPN NL')
;

select operator,count(*) from dataset4gtop20 group by operator order by count desc;

select * from top20layer;