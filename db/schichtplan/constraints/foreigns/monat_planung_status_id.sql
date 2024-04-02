-- exported with dbms_metadata.get_ddl
alter table monat_planung add constraint monat_planung_status_id foreign key (status_id)
	  references status (status_id) enable;