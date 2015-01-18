-- coverage oppervlak en aantal inwonders

select sum(ST_Area(geom)) from top20layer;

select sum(ST_Area(geom)) from nlstaging.gem_2013;

select sum(aantal) from top20layer;

select sum(aantal)
from(
select sum(aant_inw) as aantal
from nlstaging.gem_2013
where aant_inw >0
group by aant_inw
order by aant_inw desc
) as foo;