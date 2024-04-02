-- exported with dbms_metadata.get_ddl
create table laender_monat_limit 
   (	land_monat_limit_id varchar2(20) not null enable, 
	monat_planung_id number, 
	land_id varchar2(20), 
	limit_h number
   ) ;