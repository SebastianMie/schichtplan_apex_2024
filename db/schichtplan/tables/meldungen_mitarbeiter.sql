-- exported with dbms_metadata.get_ddl
create table meldungen_mitarbeiter 
   (	meldung_mitarbeiter_id number not null enable, 
	meldung_id number(4,0), 
	mitarbeiter_id varchar2(20), 
	datum date
   ) ;