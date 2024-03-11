-- exported with dbms_metadata.get_ddl
create table kommentare 
   (	datum date, 
	kommentar varchar2(20), 
	mitarbeiter_id varchar2(20), 
	kommentar_id number
   ) ;