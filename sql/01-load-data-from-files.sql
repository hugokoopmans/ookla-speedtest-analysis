-- data loaded from tmp
COPY PI_OOKLA_IPHONE_DATA
FROM '/tmp/tm/iphone.psv'
WITH DELIMITER '|'
CSV HEADER;

-- trema in data
-- type windows1258
COPY PI_OOKLA_ANDROID_DATA
FROM '/tmp/tm/android.psv'
WITH DELIMITER '|'
--ENCODING 'WIN1258'
CSV HEADER;

COPY PI_OOKLA_WP_DATA
FROM '/tmp/tm/wp.psv'
WITH DELIMITER '|'
CSV HEADER;

-- file krijg ik van Dejan overzicht 4G gemeentes
COPY tm4gcoverage
FROM '/tmp/tm/4G_Gemeente_TMNL_2015_Q3.csv'
WITH DELIMITER ','
ENCODING 'WIN1258'
CSV HEADER;