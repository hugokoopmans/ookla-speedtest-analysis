-- create top 20 gemeentes
drop table if exists top20layer;
create table top20layer as
SELECT 
a.gm_code,
a.gm_naam,
a.geom,
a.aant_inw as aantal_inwoners
FROM nlstaging.gem_2013 a
where a.gm_naam IN ('Amsterdam' , 'Rotterdam' , '''s-Gravenhage' , 'Utrecht' , 'Eindhoven' , 'Tilburg' , 'Groningen' , 'Almere' , 'Breda' , 'Nijmegen' , 'Enschede' , 'Apeldoorn' , 'Haarlem' , 'Amersfoort' , 'Arnhem' , 'Zaanstad' , 'Haarlemmermeer' , '''s-Hertogenbosch' , 'Zoetermeer' , 'Maastricht' , 'Leiden' , 'Dordrecht' , 'Alphen A/d Rijn' , 'Westland' , 'Delft' , 'Alkmaar' , 'Hilversum' , 'Amstelveen')
order by aantal_inwoners Desc
limit 20;


