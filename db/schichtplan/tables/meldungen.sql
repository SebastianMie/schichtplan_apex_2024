-- exported with dbms_metadata.get_ddl
create table meldungen 
   (	meldung_id number(4,0), 
	kategorie varchar2(50), 
	beschreibung varchar2(250)
   ) ;