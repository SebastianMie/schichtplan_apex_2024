-- exported with dbms_metadata.get_ddl
create table planung_schichten 
   (	planung_schichten_id number(10,0), 
	datum date, 
	wochentag varchar2(2), 
	service_team_id number(4,0), 
	startzeit date, 
	endzeit date, 
	vorgabe_code_id varchar2(20), 
	mitarbeiter_id varchar2(3)
   ) ;