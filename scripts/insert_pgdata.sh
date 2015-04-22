rm ../loadscripts/*.log
psql -U hugo -d 4Gdb -v schema=nlstaging,public -f ../loadscripts/insert_gem_2013_v1.sql -L ../loadscripts/insert_gem_2013_v1.log 


