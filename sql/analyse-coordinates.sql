select gemeente,operator, count(*), avg(download_kbps) 
from
ookla_all_data_clean c inner join ookla_gemeente g on c.test_id=g.test_id and c.os=g.os
where test_date>='01-OCT-2014' and test_date<='01-JAN-2015'
and operator in ('KPN NL','Vodafone NL','T-Mobile NL')
and technology='4G'
and client_latitude||'-'||client_longitude in ('52.5-5.75','52.3667-4.9','52.35-4.9167','51.9167-4.5','51.8059-4.5634','52.0666-4.3209')
group by gemeente,operator
order by 3 desc;