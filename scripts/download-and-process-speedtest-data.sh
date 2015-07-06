#!/bin/sh
#-----------------------------------------------------------

# DEFAULT PARAMETERS
YEAR=2015
START_M=04
STOP_M=06
USER=tmobile_netherlands_bv
PASSWORD=xxx

# clear database
# we presume we are in data directory
rm -r android/*
rm -r iphone/*
rm -r wp/*

# first we download all data for three platforms
# android
cd android
echo "start downloading android files"
wget --user=$USER --password=$PASSWORD  http://files.speedtest.ookla.com/tmobile_netherlands_bv/android_$YEAR-{$START_M..$STOP_M}-{00..31}.psv
cd ..
#iphone
cd iphone
echo "start downloading iphone files"
wget --user=$USER --password=$PASSWORD  http://files.speedtest.ookla.com/tmobile_netherlands_bv/iphone_$YEAR-{$START_M..$STOP_M}-{00..31}.psv
cd ..
# windows
cd wp
echo "start downloading windows mobile files"
wget --user=$USER --password=$PASSWORD  http://files.speedtest.ookla.com/tmobile_netherlands_bv/wp_$YEAR-{$START_M..$STOP_M}-{00..31}.psv
cd ..
echo "done downloading files"

mkdir /tmp/tm

echo "process android files"
# put all daily files in one big file to upload in db
# take header of first file and save it seperatly
sed -n 1p ./android/android_$YEAR-$START_M-01.psv > android-header.csv
# delete the header of each file
sed -i 1d ./android/android_$YEAR-*.psv
# dump all files in one big one
cat ./android/* > ./android.psv
# filter out wifi measurements CONNECTION_TYPE != 2
awk -F'|' '{ if ($23!=2) {print} }' android.psv > android-no-wifi.psv  
# add header
cat android-header.csv android-no-wifi.psv > android_h.psv
# convert 2 UTF-*
iconv -f ISO-8859-15 -t UTF-8  android_h.psv > android-utf-8.psv
# copy to lacation so database can read it
cp android-utf-8.psv /tmp/tm/android.psv

echo "process iphone files"

sed -n 1p ./iphone/iphone_$YEAR-$START_M-01.psv > iphone-header.csv
sed -i 1d ./iphone/*.psv
cat ./iphone/* > ./iphone.psv
# filter out wifi measurements CONNECTION_TYPE != 2 
# LETOP COLUMN 22 <-----
awk -F'|' '{ if ($22!=2) {print} }' iphone.psv > iphone-no-wifi.psv  
cat iphone-header.csv iphone-no-wifi.psv > iphone-w-h.psv
iconv -f ISO-8859-15 -t UTF-8  iphone-w-h.psv > iphone-utf-8.psv
cp iphone-utf-8.psv /tmp/tm/iphone.psv

echo "process windows mobile files"

sed -n 1p ./wp/wp_$YEAR-$START_M-01.psv > wp-header.csv
sed -i 1d ./wp/*.psv
cat ./wp/* > ./wp.psv
cat wp-header.csv wp.psv > wp-w-h.psv
iconv -f ISO-8859-15 -t UTF-8  wp-w-h.psv > wp-utf-8.psv
cp wp-utf-8.psv /tmp/tm/wp.psv

