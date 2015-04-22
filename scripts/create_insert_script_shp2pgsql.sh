rmdir --ignore-fail-on-non-empty ../loadscripts
mkdir ../loadscripts
shp2pgsql -s 28992 -d -I -g geom -W "LATIN1" ./shape-2013-versie-1.0/gem_2013_v1.shp nlstaging.gem_2013 > ../loadscripts/insert_gem_2013_v1.sql
shp2pgsql -s 28992 -d -I -g geom -W "LATIN1" ./shape-2013-versie-1.0/buurt_2013_v1.shp nlstaging.gem_2013 > ../loadscripts/insert_buurt_2013_v1.sql
shp2pgsql -s 28992 -d -I -g geom -W "LATIN1" ./shape-2013-versie-1.0/wijk_2013_v1.shp nlstaging.gem_2013 > ../loadscripts/insert_wijk_2013_v1.sql

