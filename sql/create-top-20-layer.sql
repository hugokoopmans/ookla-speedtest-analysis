drop table if exists top20layer;
create table top20layer as
select
gm_code,
gm_naam,
aant_inw,
opp_land,
geom
from nlstaging.gem_2014 
order by aant_inw desc limit 20;

drop table if exists top21layer;
create table top21layer as
select
gm_code,
gm_naam,
aant_inw,
opp_land,
geom
from nlstaging.gem_2014 
order by aant_inw desc limit 21;

drop table if exists top25layer;
create table top25layer as
select
gm_code,
gm_naam,
aant_inw,
opp_land,
geom
from nlstaging.gem_2014 
order by aant_inw desc limit 25;
