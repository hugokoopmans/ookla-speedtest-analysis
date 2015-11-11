DELETE FROM ookla_all_data
WHERE connection_type2=2;


select count(*) FROM ookla_all_data_clean
WHERE connection_type2=2;

-- test wifi type 2 in data
select count(*) FROM PI_OOKLA_ANDROID_DATA
WHERE connection_type=2;

select count(*) FROM PI_OOKLA_IPHONE_DATA
WHERE connection_type=2;

select count(*) FROM PI_OOKLA_WP_DATA
WHERE connection_type=2;

-- delete connection type 2 wifi from database
DELETE FROM PI_OOKLA_ANDROID_DATA
WHERE connection_type=2;

DELETE FROM PI_OOKLA_IPHONE_DATA
WHERE connection_type=2;

DELETE FROM PI_OOKLA_WP_DATA
WHERE connection_type=2;

select count(*) from OOKLA_ALL_DATA;
