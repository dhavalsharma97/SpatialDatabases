DROP TABLE port_info;
DROP TYPE imports_exports_type;
DROP TYPE import_export_type;
DROP TYPE location_type;


CREATE TYPE import_export_type AS OBJECT (
	name varchar2(120), 
	volume_export NUMBER, 
	volume_import NUMBER);
/


 CREATE TYPE location_type AS OBJECT (
    city VARCHAR2 (20),
    latitude NUMBER,
    longitude NUMBER,
    member function longitude_function RETURN VARCHAR2,
    pragma restrict_references(longitude_function,WNDS)
	);
/


CREATE TYPE imports_exports_type AS VARRAY (5) OF import_export_type;
/


CREATE TABLE port_info
   (
    port_name VARCHAR2(100),
    location location_type,
    populaion NUMBER,
    visits_tanker NUMBER,
    visits_dry_good_ships NUMBER,
    imports_exports imports_exports_type);
/


CREATE OR REPLACE TYPE BODY location_type AS
    member function longitude_function return VARCHAR2 IS
    st port_info.location.longitude%type;
    result VARCHAR2(20);
    BEGIN
      SELECT p.location.longitude INTO st FROM port_info p
      WHERE p.location.longitude= self.longitude;
      If (st < 0) then
		result:= REPLACE(CONCAT(to_char(st),'W'),'-',''); 
      else
		result:= CONCAT(to_char(st),'E'); 
      End if;
   RETURN result;
   END;
   END;
/


INSERT INTO port_info VALUES (
'Port of Los Angeles',
location_type('Los Angeles', 33.729167,118.261944 ),
91000,200,100,
imports_exports_type ( 
import_export_type ('furniture',4,1))
);


INSERT INTO port_info VALUES ( 
'Port of Hamburg',
location_type('Hamburg',54.5461,9.9661 ),
33000,100,8,
imports_exports_type ( 
import_export_type ('automobile_parts',0,0.9))
);


INSERT INTO port_info VALUES (
'Port of Durban',
location_type('Durban',29.8731,31.0245 ),
33400,500,8,
imports_exports_type ( 
import_export_type ('footwear',0,3.9))
);


INSERT INTO port_info VALUES (
'Port of Shanghai',
location_type('Shanghai',30.626539,122.064958),
13000,10,8,
imports_exports_type ( 
import_export_type ('electronics',0,8.6))
);


INSERT INTO port_info VALUES (
'Port of Belize',
location_type('Belize',17.483,-88.183 ),
83000,19,7,
imports_exports_type ( 
import_export_type ('cotton',0,8.4))
);


INSERT INTO port_info VALUES (
'Port of Jackson',
location_type('Sydney',-33.85833,151.23333 ),
73700,70,4,
imports_exports_type ( 
import_export_type ('scrap metal',6.9,0))
);


INSERT INTO port_info VALUES (
'Port of London',
location_type('London',51.5,0.05 ), 
38000,76,8,
imports_exports_type ( 
import_export_type ('apparel',2.6,0))
);


INSERT INTO port_info VALUES (
'Port of Laem Chabang',
location_type('Laem Chabang',13.01041,100.9150 ),
35000,53,5,
imports_exports_type ( 
import_export_type ('wastepaper',2.5,0))
);


INSERT INTO port_info VALUES (
'Port of Montreal',
location_type('Montreal',45.547,-73.530 ),
36000,17,8,
imports_exports_type ( 
import_export_type ('apparel',0,7.3))
);


INSERT INTO port_info VALUES (
'Port of Vishakapatnam',
location_type('Vishakaptnam',17.69833,83.278611 ),
33078,60,3,
imports_exports_type ( 
import_export_type ('iron ore',0,5.5))
);