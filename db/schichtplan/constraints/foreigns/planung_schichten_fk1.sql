-- exported with dbms_metadata.get_ddl
alter table planung_schichten add constraint planung_schichten_fk1 foreign key (vorgabe_code_id)
	  references vorgabe_codes (vorgabe_code_id) enable;