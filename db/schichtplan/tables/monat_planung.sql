-- exported with dbms_metadata.get_ddl
create table monat_planung 
   (	monat_planung_id number not null enable, 
	monat_jahr varchar2(50), 
	ref_status_id varchar2(3)
   ) ;