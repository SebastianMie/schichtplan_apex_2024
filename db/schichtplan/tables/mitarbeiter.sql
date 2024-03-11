-- exported with dbms_metadata.get_ddl
create table mitarbeiter 
   (	vorname varchar2(50), 
	nachname varchar2(50), 
	handynummer varchar2(50), 
	service_team_id number(4,0) not null enable, 
	mitarbeiter_id varchar2(20) not null enable, 
	reihenfolge number(3,0), 
	aktiv varchar2(1), 
	email_adresse varchar2(100), 
	password_hash varchar2(128), 
	salt varchar2(64), 
	rolle_id varchar2(5), 
	land_id varchar2(8 char)
   ) ;