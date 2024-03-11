-- exported with dbms_metadata.get_ddl
create table mitarbeiter_seite_sperre 
   (	mitarbeiter_seite_sperre_id number not null enable, 
	mitarbeiter_id varchar2(20) not null enable, 
	gesperrt_bis date
   ) ;