-- exported with dbms_metadata.get_ddl
create table feiertage
   (	feiertag_id number, 
	datum date, 
	bezeichnung varchar2(100), 
	land varchar2(50)
   ) ;