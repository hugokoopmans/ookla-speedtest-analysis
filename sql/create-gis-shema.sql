REVOKE SELECT ON spatial_ref_sys, geometry_columns FROM hugo; 
DROP schema nldot cascade;
DROP schema nlstaging cascade; 
--DROP USER nydot; 
--CREATE USER nydot PASSWORD 'nydot'; 
CREATE SCHEMA nldot authorization hugo; 
CREATE SCHEMA nlstaging authorization hugo; 
GRANT SELECT ON spatial_ref_sys, geometry_columns TO hugo;