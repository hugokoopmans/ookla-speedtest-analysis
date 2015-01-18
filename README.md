# Ookla-speedtest-analysis
Open sourced analysis of ookla speedtest data for 4G network in Netherlands 

## Why
This analysis is conducted on behave of T-mobile Netherlands by DIKW Consulting. DIKW Consulting acts as an independent consulting firm specialised in datascience and statistics. Goal of this analysis is to proof that there is a significant difference between network speeds for the 4G network.

## Approach
We use sample data that can be downloaded from the Ookla metrics website to set up the analysis. All analyisis and data manipulation will be done with opensource tools in such a way that the data analaysis is transparent and reproducable.

The final report is done in R-Studio combining R and markdown.

## Data loading
Ookla delivers testresults in three flavours, iphone, android and windowsmobile files. Each file is loaded into the postgres database using the load script in the sql directory. ookla sample data can be found [here](http://www.ookla.com/netmetrics)

Create a new database named "4Gdb".
Create the Ookla tables for each flavor.
Load the datafiles into each specific table.

## Coverage 
To make a fare comparison we looked at areas in which the top 3 operators claimed to have 4G during the test period (Q4 2014).

## 4G
We are only interested in tests that were performed over 4G network technology.

## Data Cleaning
We have looked at unique devices, frequent coordinates, time and dates and have cleaned the data a we came along some minor issues.

### Suspicious devices
In the real data there are some devices that are performing a test very often, so often we call these devices suspicious in the sence that these devices are used by proffesionals in the telecom space. If a specific device is performing 30 tests or more per month these are marked as suspicious and will be excluded from the test.

### Frequent coordinates
Some coordinates were very frequent, this was explained bij ookla as related to GPS coordinates not always available the GEO-IP service was used.

## Cities
Our client has asked to diversify the analysis for the 20 major Dutch cities. Unfortunatly the city_id provided by Ookla is not very accurate. So we have to create our own mapping of latitude and longitude coordinates onto cities. We use CBS data for that, that can be found [here](http://www.cbs.nl/nl-NL/menu/themas/dossiers/nederland-regionaal/publicaties/geografische-data/archief/2014/2013-wijk-en-buurtkaart-art.htm).

For that to work we need our posgres database to become GIS enabled. We load the PostGIS extension into postgres. Detail can be found [here](http://postgis.net/)

We transform the CBS shape files for "Gemeentes" into sql insert statements using shp2pgsql.
Scripts to run this transformation and load the data into the database can be found in the scripts direcctory.

## Analysis
Now we have created a dataset to perform our analysis in R.