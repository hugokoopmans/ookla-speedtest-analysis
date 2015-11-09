-- create t-mobile 4g coverage gemeentes
-- make sure you use latest data from CBS
drop table if exists tm4gcoveragelayer;
create table tm4gcoveragelayer as
select
g.gm_code,
g.gm_naam,
--t.gm_naam,
g.geom
from
tm4gcoverage t, nlstaging.gem_2014 g
where
g.gm_code = t.gm_code
AND
t.tmnl_had_4g_q3_2015 = 1
;