-- exported with dbms_metadata.get_ddl
create table vorgabe_codes 
   (	bezeichnung_kuerzel varchar2(50), 
	dauer_h number(2,0), 
	kuerzel_rb varchar2(50), 
	beschreibung varchar2(250), 
	kuerzel_planung varchar2(50), 
	startzeit_h number(2,0), 
	endzeit_h number(2,0), 
	service_team_id number(4,0), 
	farbcode_hex varchar2(50), 
	vorgabe_code_id varchar2(20)
   ) ;