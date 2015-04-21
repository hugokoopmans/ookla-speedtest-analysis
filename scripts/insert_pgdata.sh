rm ../loadscripts/*.log
psql -U hugo -d 4Gdb -v schema=nlstaging,public -f ../loadscripts/insert_gem_2014.sql -L ../loadscripts/insert_gem_2014.log 


